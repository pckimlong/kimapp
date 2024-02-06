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
    if (state == ApplicationState.initialized) {
      log.i('Reinitialize app...');
    } else {
      log.i('Initializing app...');
    }

    try {
      final startedAt = DateTime.now();
      await _initialize();
      final finishedAt = DateTime.now();

      // Delay a bit if it too fast, this allow to show splash page
      // Calculate the actual duration of the initialization process
      final duration = finishedAt.difference(startedAt).inMilliseconds;

      // Calculate the delay needed to meet the minimum splash duration
      final delay = duration < 1150 ? 1150 - duration : 0;

      // Delay if needed
      await Future.delayed(Duration(milliseconds: delay));

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
      log.e('Error while initializing app', error: e, stackTrace: stack);
      return ApplicationState.uninitialized;
    }
  }

  Future<ApplicationState> _initialize() async {
    await Future.wait([
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
      (previous, next) async {
        if (previous != next && state == ApplicationState.initialized) {
          log.i('Auth state changed from $previous to $next');
          // Reinitialize app to refresh data which depend on auth state
          await initialize();
        }

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
