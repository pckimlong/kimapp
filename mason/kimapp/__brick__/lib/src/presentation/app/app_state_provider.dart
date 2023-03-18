import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:{{{project_name.snakeCase()}}}/src/presentation/router/app_router.dart';
import '../../../exports.dart';
import '../../features/auth/auth.dart';

import 'app_theme.dart';

part 'app_state_provider.g.dart';

enum ApplicationState { uninitialized, initialized }

@Riverpod(keepAlive: true)
class AppState extends _$AppState with LoggerMixin {
  Future<ApplicationState> initialize() async {
    log.i('Initializing app...');

    await Future.wait([
      // Initialize future provider which are required for app
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
