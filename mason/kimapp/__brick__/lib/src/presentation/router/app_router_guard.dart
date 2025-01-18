import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/account/account.dart';
import '../../core/helpers/helpers.dart';
import '../../features/auth/auth.dart';
import '../app/app_state_provider.dart';
import 'app_router.gr.dart';

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
        resolver.redirect(SignInRoute(onSuccess: () => resolver.next(true)));
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
      log.i('Call onAppStateInitialized');
      onAppStateInitialized(resolver, router);
    } else {
      log.i('uninitialized push to splash page');
      resolver.redirect(
        SplashRoute(
          onInitialized: () {
            log.v('Call onAppStateInitialized after initialize from splash page');
            onAppStateInitialized(resolver, router);
          },
        ),
      );
    }
  }

  /// Call to onNavigation after app state has been initialized
  void onAppStateInitialized(NavigationResolver resolver, StackRouter router);

  Ref get _ref;
}
