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
  static Future<Kimapp> initialize({
    FailureMessage? customFailureMessage,
    LoggerCallback? logger,
  }) async {
    assert(!_instance._initialized, 'Kimapp instance is already initialized');
    _instance._initService(
      failureMessage: customFailureMessage,
      logger: logger,
    );
    return _instance;
  }

  bool _initialized = false;
  void _initService({
    FailureMessage? failureMessage,
    LoggerCallback? logger,
  }) {
    if (failureMessage != null) {
      _failureMessage = failureMessage;
    }
    _logger = logger;

    _initialized = true;
  }

  FailureMessage get failureMessage => _failureMessage;
  FailureMessage _failureMessage = FailureMessage();

  LoggerCallback? _logger;
  LoggerCallback? get logger => _logger;
}

typedef LoggerCallback = void Function({
  required LoggerType type,
  String title,
  required String message,
  StackTrace? stackTrace,
  Object? errorObject,
});

enum LoggerType { debug, info, warning, error }
