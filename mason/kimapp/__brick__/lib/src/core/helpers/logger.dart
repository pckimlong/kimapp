import 'package:flutter/material.dart';
import 'package:kimapp_utils/kimapp_utils.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import 'build_context_helper.dart';

late final Talker talker;

Talker initTalker(IntegrationMode integrationMode) {
  talker = TalkerFlutter.init(
    settings: TalkerSettings(
      enabled: !integrationMode.isRelease,
      useHistory: true,
      useConsoleLogs: true,
    ),
  );
  return talker;
}

mixin LoggerMixin {
  void logError(String mgs, Object? error, [StackTrace? stackTrace]) {
    talker.error(mgs, error, stackTrace);
  }

  void logWarning(String mgs, Object? warning, [StackTrace? stackTrace]) {
    talker.warning(mgs, warning, stackTrace);
  }

  void logInfo(String mgs, [Object? info, StackTrace? stackTrace]) {
    talker.info(mgs, info, stackTrace);
  }

  void logDebug(Object debug, [StackTrace? stackTrace]) {
    talker.debug(debug, stackTrace);
  }

  void logCritical(String msg) {
    talker.critical(msg);
  }
}

TalkerRiverpodObserver riverpodObserver(Talker talker) {
  return TalkerRiverpodObserver(
    talker: talker,
    settings: const TalkerRiverpodLoggerSettings(
      printStateFullData: false,
      printProviderFailed: true,
      printFailFullData: true,
      printProviderAdded: true,
      printProviderDisposed: true,
      printProviderUpdated: true,
    ),
  );
}

class TalkerLoggerScreen extends StatelessWidget {
  const TalkerLoggerScreen({super.key});

  static void show(BuildContext context) {
    context.pushTo((_) => TalkerLoggerScreen());
  }

  @override
  Widget build(BuildContext context) {
    return TalkerScreen(talker: talker);
  }
}
