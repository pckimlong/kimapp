import 'package:flutter/foundation.dart';

import '../../../core/helpers/logger.dart';
import '../startup.dart';
import 'init_error_reporter_task.dart';

class InitPlatformErrorCatcherTask extends StartUpTask with LoggerMixin {
  const InitPlatformErrorCatcherTask();

  @override
  Future<void> initialize(LaunchContext context) async {
    if (context.env.isRelease) {
      PlatformDispatcher.instance.onError = (error, stack) {
        logError('Uncaught platform error', error, stack);
        reportError(error, stack);
        return true;
      };
    }
  }
}
