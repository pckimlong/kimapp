abstract class Logger {
  void debug(String message, {Object? object, StackTrace? stackTrace});
  void info(String message, {Object? object, StackTrace? stackTrace});
  void warning(String message, {Object? object, StackTrace? stackTrace});
  void error(String message, {required Object? error, required StackTrace? stackTrace});
}
