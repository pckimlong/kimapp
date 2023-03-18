import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../exports.dart';
import '../../features/auth/auth.dart';
import 'app_theme.dart';
import '../../providers/device/device_info_provider.dart';

import '../../core/helpers/logger_observers.dart';

part 'app_state_provider.g.dart';

enum ApplicationState { uninitialized, initialized }

@Riverpod(keepAlive: true)
class AppState extends _$AppState with LoggerMixin {
  @override
  ApplicationState build() => ApplicationState.uninitialized;

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
        // await ref.read(signOutProvider.notifier).call();
      },
      unauthenticated: () {
        log.i('Unauthenticated. Redirecting to sign page...');
      },
    );

    state = ApplicationState.initialized;
    log.i('Application initialized');
    return state;
  }
}
