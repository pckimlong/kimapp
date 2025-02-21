import 'package:sentry_flutter/sentry_flutter.dart';

import '../startup.dart';

const _kSentryDns = '';

class InitErrorReporterTask extends StartUpTask {
  const InitErrorReporterTask();

  @override
  Future<void> initialize(LaunchContext context) async {
    // Read from local storage if needed
    // Make sure this task is run after InitLocationStorageTask
    const isAllowSendErrorReport = true;

    // Only enable in release mode
    if (context.env.isRelease && isAllowSendErrorReport) {
      _reportErrorEnabled = true;
      await SentryFlutter.init((options) => options.dsn = _kSentryDns);
    }
  }
}

bool _reportErrorEnabled = false;
Future<void> reportErrorToCrashlyticsService(dynamic error, dynamic stackTrace) async {
  if (!_reportErrorEnabled) return;

  await Sentry.captureException(error, stackTrace: stackTrace);
}
