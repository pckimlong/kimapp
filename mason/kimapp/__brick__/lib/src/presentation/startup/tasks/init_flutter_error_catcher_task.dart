import '../../../../exports.dart';
import '../startup.dart';
import 'init_error_reporter_task.dart';

class InitFlutterErrorCatcherTask extends StartUpTask with LoggerMixin {
  const InitFlutterErrorCatcherTask();

  @override
  Future<void> initialize(LaunchContext context) async {
    FlutterError.onError = (details) {
      log.e('Uncaught flutter error', error: details.exception, stackTrace: details.stack);

      if (context.env.isRelease) {
        Zone.current.handleUncaughtError(details.exception, details.stack!);
        reportError(details.exception, details.stack);
        return;
      }

      // In dev mode, simply print to console
      FlutterError.dumpErrorToConsole(details);
    };

    // Override error widget in release mode
    if (context.env.isRelease) {
      ErrorWidget.builder = (details) => const SizedBox();
    }
  }
}
