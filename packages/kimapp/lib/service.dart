import 'package:kimapp/object/failure.dart';

class Kimapp {
  Kimapp._();

  static Kimapp get instance {
    assert(
      _instance._initialized,
      "You must initialize the kimapp instance before calling Kimapp.instance",
    );

    return _instance;
  }

  static final Kimapp _instance = Kimapp._();

  /// Initialize singleton of kimapp service
  /// This should be call in main, To make sure it get instantiated before use
  /// other error will be thrown
  /// ```dart
  /// void main(){
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await Kimapp.initialize(); // Initialize here...
  /// }
  /// ```
  /// [CustomFailureMessage] is an object use to present failure message to user
  /// by default it will be use the default message, if you want to customize the message
  /// you can do by create a class extend [FailureMessage] then override any message you want
  ///
  /// [debugMode] will be use on failure message
  static Future<Kimapp> initialize({
    required bool debugMode,
    FailureMessage? customFailureMessage,
    LoggerCallback? logger,
  }) async {
    if (_instance._initialized) {
      if (logger != null) {
        logger(LoggerType.info,
            "You've trying to initialize Kimapp service which already initialize. Initialize it again will do nothing, and instance of initialized will be return");
      }
      return _instance;
    }
    _instance._initService(
      failureMessage: customFailureMessage,
      logger: logger,
      debugMode: debugMode,
    );
    return _instance;
  }

  bool _initialized = false;
  void _initService({
    required bool debugMode,
    FailureMessage? failureMessage,
    LoggerCallback? logger,
  }) {
    if (failureMessage != null) {
      _failureMessage = failureMessage;
    }
    _logger = logger;
    _debugMode = debugMode;

    // Mark as initialized
    _initialized = true;
  }

  FailureMessage get failureMessage => _failureMessage;
  FailureMessage _failureMessage = FailureMessage();

  LoggerCallback? _logger;
  LoggerCallback? get logger => _logger;

  late bool _debugMode;
  bool get debugMode => _debugMode;

  void log(
    LoggerType type, {
    required String message,
    String? title,
    Object? object,
    StackTrace? stackTrace,
  }) {
    if (logger != null) {
      logger!(
        LoggerType.error,
        message,
        title,
        stackTrace,
        object,
      );
    }
  }
}

typedef LoggerCallback = void Function(
  LoggerType type,
  String message, [
  String? title,
  StackTrace? stackTrace,
  Object? errorObject,
]);

enum LoggerType { debug, info, warning, error }
