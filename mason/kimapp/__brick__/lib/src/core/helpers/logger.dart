import 'package:kimapp/kimapp.dart';

mixin LoggerMixin {
  void logError(String mgs, Object? error, [StackTrace? stackTrace]) {}

  void logWarning(String mgs, Object? warning, [StackTrace? stackTrace]) {
    Kimapp.instance.log(LoggerType.warning, message: mgs, object: warning, stackTrace: stackTrace);
  }

  void logInfo(String mgs, [Object? info, StackTrace? stackTrace]) {
    Kimapp.instance.log(LoggerType.info, message: mgs, object: info, stackTrace: stackTrace);
  }

  void logDebug(Object debug, [StackTrace? stackTrace]) {
    Kimapp.instance.log(LoggerType.debug, message: debug.toString(), stackTrace: stackTrace);
  }

  void logCritical(String msg) {
    Kimapp.instance.log(LoggerType.error, message: msg);
  }
}
