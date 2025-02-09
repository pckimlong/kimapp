import 'package:flutter/foundation.dart';

import '../startup.dart';

class InitPlatformErrorCatcherTask extends StartUpTask {
  const InitPlatformErrorCatcherTask();

  @override
  Future<void> initialize(LaunchContext context) async {
    if (context.env.isRelease) {
      PlatformDispatcher.instance.onError = (error, stack) {
        context.talker.error('Uncaught platform error', error, stack);
        return true;
      };
    }
  }
}
