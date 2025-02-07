import 'package:kimapp/kimapp.dart';
import 'package:kimapp_supabase_helper/supabase_storage.dart';

import '../../../core/helpers/logger.dart';
import '../startup.dart';
import 'init_error_reporter_task.dart';

class InitKimappTask extends StartUpTask with LoggerMixin {
  const InitKimappTask();

  @override
  Future<void> initialize(LaunchContext context) async {
    await Kimapp.initialize(
      debugMode: context.env.isDevelop,
      logger: (type, message, [title, stackTrace, errorObject]) {
        if (context.env.isRelease) {
          reportError(errorObject, stackTrace);
        }

        switch (type) {
          case LoggerType.debug:
            logDebug(message, stackTrace);
          case LoggerType.info:
            logInfo(message, errorObject, stackTrace);
          case LoggerType.warning:
            logWarning(message, errorObject, stackTrace);
          case LoggerType.error:
            logError(message, errorObject, stackTrace);
        }
      },
    );

    StorageManager.initialize(
      config: const StorageConfig(
        bucketFileTypes: {
          'files': [FileType.image],
        },
        maxFileSizeBytes: 10 * 1024 * 1024,
        typeSpecificMaxSizes: {
          FileType.image: 5 * 1024 * 1024,
        },
      ),
    );
  }
}
