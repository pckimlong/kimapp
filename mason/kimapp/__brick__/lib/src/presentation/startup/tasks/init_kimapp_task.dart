import '../../../../exports.dart';
import '../startup.dart';
import 'init_error_reporter_task.dart';

class InitKimappTask extends LaunchTask with LoggerMixin {
  const InitKimappTask();

  @override
  Future<void> initialize(LaunchContext context) async {
    await Kimapp.initialize(
      debugMode: context.env.isDevelop,
      customFailureMessage: CustomFailureMessage(),
      logger: (type, message, [title, stackTrace, errorObject]) {
        if (context.env.isRelease) {
          reportError(errorObject, stackTrace);
        }

        switch (type) {
          case LoggerType.debug:
            log.d(message);
          case LoggerType.info:
            log.i(message);
          case LoggerType.warning:
            log.w(message);
          case LoggerType.error:
            log.e(message, error: errorObject, stackTrace: stackTrace);
        }
      },
    );
  }
}
