import 'package:kimapp/kimapp.dart';
import 'package:kimapp_supabase_helper/supabase_storage.dart';

import '../startup.dart';
import 'init_error_reporter_task.dart';

class InitKimappTask extends StartUpTask {
  const InitKimappTask();

  @override
  Future<void> initialize(LaunchContext context) async {
    await Kimapp.initialize(
      debugMode: context.env.isDevelop,
      logger: (type, message, [title, stackTrace, object]) {
        // Only report error to crashlytics in release mode
        if (context.env.isRelease && type == LoggerType.error) {
          reportErrorToCrashlyticsService(object, stackTrace);
        }

        switch (type) {
          case LoggerType.debug:
            context.talker.debug(message, stackTrace);
          case LoggerType.info:
            context.talker.info(message, object, stackTrace);
          case LoggerType.warning:
            context.talker.warning(message, object, stackTrace);
          case LoggerType.error:
            context.talker.error(message, object, stackTrace);
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
