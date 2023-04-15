import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../exports.dart';
import '../../features/auth/auth.dart';

import '../router/app_router_provider.dart';
import 'app_theme_provider.dart';

part 'app_state_provider.g.dart';

enum ApplicationState { uninitialized, initialized }

@Riverpod(keepAlive: true)
class AppState extends _$AppState with LoggerMixin {
  Future<ApplicationState> initialize({void Function(String error)? onError}) async {
    log.i('Initializing app...');
    try {
      await _initialize();
      return ApplicationState.initialized;
    } catch (e, stack) {
      String message = e.toString();

      // Error when switch from debug and release mode, should call to sign out in this case
      if (message.contains('JWSError JWSInvalidSignature')) {
        await ref.read(signOutProvider.notifier).call();
      }

      if (e is Failure) {
        message = e.message();
      }

      onError?.call(message);
      log.e('Error while initializing app', e, stack);
      return ApplicationState.uninitialized;
    }
  }

  Future<ApplicationState> _initialize() async {
    await Future.wait([
      ...[
        localStorageProvider,
        deviceInfoProvider,
        themeModeProvider,
      ].map((provider) => ref.read(provider.future)),

      // Initialize authentication state
      ref.read(authStateProvider.notifier).initialize(),
    ]);

    final authState = ref.read(authStateProvider);
    await authState.when(
      authenticated: (uuid) async {
        log.i('Authenticated');
        // TODO - Initial user data
      },
      unauthenticated: () {
        log.i('Unauthenticated. Redirecting to sign page...');
      },
    );

    state = ApplicationState.initialized;
    log.i('Application initialized');
    return state;
  }

  void _watchAuthState() {
    ref.listen(
      authStateProvider,
      (previous, next) {
        if (previous?.isAuthenticated == true && next.isUnauthenticated) {
          ref.read(appRouterProvider).replace(SignInRoute());
        }
      },
    );
  }

  @override
  ApplicationState build() {
    _watchAuthState();
    return ApplicationState.uninitialized;
  }
}
