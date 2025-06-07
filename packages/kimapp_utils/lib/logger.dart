import 'package:kimapp/kimapp.dart';

class LogEvent {
  final LoggerType level;
  final String message;
  final Object? object;
  final Object? error;
  final StackTrace? stackTrace;
  final DateTime timestamp;

  LogEvent({
    required this.level,
    required this.message,
    this.object,
    this.error,
    this.stackTrace,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

typedef LogListener = void Function(LogEvent event);

abstract class Logger {
  void debug(String message, {Object? object, StackTrace? stackTrace});
  void info(String message, {Object? object, StackTrace? stackTrace});
  void warning(String message, {Object? object, StackTrace? stackTrace});
  void error(String message, {required Object? error, required StackTrace? stackTrace});

  void addListener(LogListener listener);
  void removeListener(LogListener listener);
  void clearListeners();
}
