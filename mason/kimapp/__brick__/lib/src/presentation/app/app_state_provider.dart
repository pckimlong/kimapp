import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config.dart';
import '../../core/account/account.dart';
import '../../core/helpers/logger.dart';
import '../../features/auth/auth.dart';
import '../router/app_router.gr.dart';
import '../router/app_router_provider.dart';

part 'app_state_provider.g.dart';

enum ApplicationState { uninitialized, initialized }

@Riverpod(keepAlive: true)
class AppState extends _$AppState with LoggerMixin {
  /// Initialize the application state and handle all necessary startup processes
  Future<ApplicationState> initialize({void Function(String error)? onError}) async {
    logInfo(state == ApplicationState.initialized ? 'Reinitialize app...' : 'Initializing app...');

    try {
      return await _executeInitialization(onError);
    } catch (e, stack) {
      return _handleInitializationError(e, stack, onError);
    }
  }

  /// Execute the initialization process with proper timing
  Future<ApplicationState> _executeInitialization(void Function(String error)? onError) async {
    final startedAt = DateTime.now();
    await _initializeCore();

    // Ensure minimum splash screen duration
    final elapsedDuration = DateTime.now().difference(startedAt).inMilliseconds;
    final remainingDelay = Config.minSplashDurationInMs - elapsedDuration;

    if (remainingDelay > 0) {
      await Future.delayed(Duration(milliseconds: remainingDelay));
    }

    return ApplicationState.initialized;
  }

  /// Core initialization logic
  Future<void> _initializeCore() async {
    // Initialize auth state
    await ref.read(authStateProvider.notifier).initialize();

    // Handle auth-dependent initialization
    final authState = ref.read(authStateProvider);
    if (authState.isAuthenticated) {
      await _handleAuthenticatedState(authState.userId!);
    }
    if (authState.isUnauthenticated) {
      _handleUnauthenticatedState();
    }

    state = ApplicationState.initialized;
    logInfo('Application initialized');
  }

  /// Handle authenticated state initialization
  Future<void> _handleAuthenticatedState(UserId uuid) async {
    logInfo('Authenticated, initializing user data');
    await Future.wait([ref.refresh(currentAccountProvider.future)]);
  }

  /// Handle unauthenticated state
  void _handleUnauthenticatedState() {
    logInfo('Unauthenticated. Redirecting to sign page...');
    // eg refresh some provider which is dependent on auth state
  }

  /// Handle initialization errors
  ApplicationState _handleInitializationError(
    Object error,
    StackTrace stack,
    void Function(String error)? onError,
  ) {
    final errorMessage = _processErrorMessage(error);

    if (_isJWTSignatureError(errorMessage)) {
      _handleJWTError();
    }

    onError?.call(errorMessage);
    logError('Error while initializing app', error, stack);
    return ApplicationState.uninitialized;
  }

  /// Process error message based on error type
  String _processErrorMessage(Object error) {
    if (error is Failure) {
      return error.message();
    }
    return error.toString();
  }

  /// Check if error is JWT related
  bool _isJWTSignatureError(String message) {
    return message.contains('JWSError JWSInvalidSignature');
  }

  /// Handle JWT specific errors
  Future<void> _handleJWTError() async {
    await ref.read(signOutProvider.notifier).call();
  }

  /// Watch auth state changes and handle navigation
  void _watchAuthState() {
    ref.listen(authStateProvider, (previous, next) {
      // We just only replace the route to splash page, to allow it automatically handle where it should navigate to
      // I use to reinitialize the appstate, but I think by just replace it with splash, it will automatically reinitialize
      if (previous?.isAuthenticated == true && next.isUnauthenticated) {
        ref.read(appRouterProvider).replace(SplashRoute());
      }
    });
  }

  @override
  ApplicationState build() {
    _watchAuthState();
    return ApplicationState.uninitialized;
  }
}
