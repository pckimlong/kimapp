import '../../../exports.dart';
import '../../features/auth/auth.dart';
import '../app/app_state_provider.dart';

class AuthGuard extends _AppStateRouteGuard {
  AuthGuard(this._ref);

  @override
  final Ref _ref;

  @override
  void onAppStateInitialized(NavigationResolver resolver, StackRouter router) {
    final authState = _ref.read(authStateProvider);

    authState.when(
      authenticated: (_) => resolver.next(true),
      unauthenticated: () {
        router.push(SignInRoute(onSuccess: () => resolver.next(true)));
      },
    );
  }
}

class LoginGuard extends _AppStateRouteGuard {
  LoginGuard(this._ref);

  @override
  final Ref _ref;

  @override
  void onAppStateInitialized(NavigationResolver resolver, StackRouter router) {
    final authState = _ref.read(authStateProvider);

    authState.when(
      authenticated: (_) => router.replace(const RootRoute()),
      unauthenticated: () => resolver.next(true),
    );
  }
}

// Wether to show splash screen before checking something else
abstract class _AppStateRouteGuard extends AutoRouteGuard with LoggerMixin {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final appState = _ref.read(appStateProvider);
    final accountState = _ref.read(currentAccountProvider);
    if (appState == ApplicationState.initialized && accountState.hasValue) {
      log.v('Call onAppStateInitialized');
      onAppStateInitialized(resolver, router);
    } else {
      log.v('uninitialized push to splash page');
      router.push(SplashRoute(onInitialized: () {
        log.v('Call onAppStateInitialized after initialize from splash page');
        onAppStateInitialized(resolver, router);
      }));
    }
  }

  /// Call to onNavigation after app state has been initialized
  void onAppStateInitialized(NavigationResolver resolver, StackRouter router);

  Ref get _ref;
}
