import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';

import '../service.dart';

part 'failure.freezed.dart';

/// Equivalent to [Either<Failure, T>]
typedef FailureOr<T> = Either<Failure, T>;

/// Equivalent to [AsyncFailureOr<T>]
///
/// In VSCode, you can search/replace to use this type by searching for `Future<Either<Failure,\s*([^>]+)>>`
/// and replace with `AsyncFailureOr<$1>`
typedef AsyncFailureOr<T> = Future<FailureOr<T>>;

class FailureMessage {
  final String alreadyRegistered = "Already Registered";
  final String authError = "Authentication Error";
  final String databaseError = "Database Error";
  final String exception = "Something went wrong!";
  final String forbidden = "Forbidden";
  final String incorrectLoginCredential = "Incorrect username or password";
  final String networkFailure = "Network connection error!";
  final String notFoundError = "Not Found";
  final String serverError = "Internal Server Error";
  final String uniqueConstraintError = "Violence data input";
}

extension FailureX on Failure {
  AsyncError<T> toAsyncError<T>() => AsyncError<T>(message(), stackTrace);

  StackTrace get stackTrace {
    return switch (this) {
      _Failure(:final info) => info.stackTrace,
      ExceptionFailure(:final info) => info.stackTrace,
      NetworkFailure(:final info) => info.stackTrace,
      ServerError(:final info) => info.stackTrace,
      DatabaseFailure(failures: final f) => switch (f) {
          _DatabaseFailures(:final info) => info.stackTrace,
          _UniqueConstraint(:final info) => info.stackTrace,
          _NotFound(:final info) => info.stackTrace,
        },
      AuthFailure(failures: final f) => switch (f) {
          _AuthFailures(:final info) => info.stackTrace,
          _IncorrectLoginCredential(:final info) => info.stackTrace,
          _Forbidden(:final info) => info.stackTrace,
          _UserAlreadyRegistered(:final info) => info.stackTrace,
        },
    };
  }

  bool get isNotFoundFailure {
    return switch (this) {
      DatabaseFailure(failures: _NotFound()) => true,
      _ => false,
    };
  }

  bool get isUniqueConstraintFailure {
    return switch (this) {
      DatabaseFailure(failures: _UniqueConstraint()) => true,
      _ => false,
    };
  }

  bool get isNetworkFailure {
    return switch (this) {
      NetworkFailure() => true,
      _ => false,
    };
  }

  /// Message from failure object This function required to initialize [Kimapp] instance before use. should initialized in main like
  /// ```dart
  /// void main(){
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await Kimapp.initialize(); // Initialize here...
  /// }
  /// ```
  /// By default in release mode default failure message or custom message provided in [Kimapp] service
  /// will be use, but in the debug mode the debug message will be use, you can use the release mode message
  /// even in debug mode by make [debugMessageEnable] to false
  /// If [alwaysUseDebugMessage] is true, the debug message will be use regardless of the debug mode
  String message([bool debugMessageEnable = true, bool alwaysUseDebugMessage = false]) {
    final kimapp = Kimapp.instance;
    final mgs = kimapp.failureMessage;
    final useDebugMessage = (kimapp.debugMode && debugMessageEnable) || alwaysUseDebugMessage;

    return switch (this) {
      _Failure(:final info) =>
        useDebugMessage ? info.debugMessage : info.message ?? "Something went wrong!",
      ExceptionFailure(:final info) => info.errorObject is String
          ? info.errorObject as String
          : (useDebugMessage ? info.debugMessage : info.message ?? mgs.exception),
      NetworkFailure(:final info) =>
        useDebugMessage ? info.debugMessage : info.message ?? mgs.networkFailure,
      ServerError(:final info) =>
        useDebugMessage ? info.debugMessage : info.message ?? mgs.serverError,
      DatabaseFailure(failures: final f) => switch (f) {
          _DatabaseFailures(:final info) =>
            useDebugMessage ? info.debugMessage : info.message ?? mgs.databaseError,
          _UniqueConstraint(:final info) =>
            useDebugMessage ? info.debugMessage : info.message ?? mgs.uniqueConstraintError,
          _NotFound(:final info) =>
            useDebugMessage ? info.debugMessage : info.message ?? mgs.notFoundError,
        },
      AuthFailure(failures: final f) => switch (f) {
          _AuthFailures(:final info) =>
            useDebugMessage ? info.debugMessage : info.message ?? mgs.authError,
          _IncorrectLoginCredential(:final info) =>
            useDebugMessage ? info.debugMessage : info.message ?? mgs.incorrectLoginCredential,
          _Forbidden(:final info) =>
            useDebugMessage ? info.debugMessage : info.message ?? mgs.forbidden,
          _UserAlreadyRegistered(:final info) =>
            useDebugMessage ? info.debugMessage : info.message ?? mgs.alreadyRegistered,
        },
    };
  }
}

@freezed
sealed class FailureInfo with _$FailureInfo {
  factory FailureInfo({
    required StackTrace stackTrace,
    required String debugMessage,

    /// Readable message which will be display to user, If [message] is not provided or null
    /// The default message define in [Kimapp] service will be use instead when calling it from [Failure.message()] function
    String? message,
    Object? errorObject,
  }) = _FailureInfo;
}

@freezed
sealed class Failure with _$Failure {
  const Failure._();

  /// Create custom failure, both message and debug message will be the same
  factory Failure.fromString(String errorString) {
    return Failure(
      FailureInfo(
        stackTrace: StackTrace.current,
        debugMessage: errorString,
        message: errorString,
      ),
    );
  }

  // Default failure, Usually create by user
  const factory Failure(FailureInfo info) = _Failure;

  /// Error which not has specific type and cached by try-catch block
  const factory Failure.exception(FailureInfo info) = ExceptionFailure;

  /// Might lost connect to internet
  const factory Failure.networkFailure(FailureInfo info) = NetworkFailure;

  /// Cannot connect to backend server, This not cause by database
  const factory Failure.serverError(FailureInfo info) = ServerError;

  /// Error throw from database
  const factory Failure.databaseFailure(DatabaseFailures failures) = DatabaseFailure;

  /// Error relate to authentication or security staffs
  const factory Failure.authFailure(AuthFailures failures) = AuthFailure;

  // Override toString to make it easier to read when used in error logs.
  String logMessage() {
    return switch (this) {
      _Failure(:final info) => "Failure: ${info.debugMessage}",
      ExceptionFailure(:final info) => "ExceptionFailure: ${info.debugMessage}",
      NetworkFailure(:final info) => "NetworkFailure: ${info.debugMessage}",
      ServerError(:final info) => "ServerError: ${info.debugMessage}",
      DatabaseFailure(:final failures) => "DatabaseFailure -> ${failures.logMessage()}",
      AuthFailure(:final failures) => "AuthFailure -> ${failures.logMessage()}",
    };
  }
}

@freezed
sealed class DatabaseFailures with _$DatabaseFailures {
  const DatabaseFailures._();

  /// Not specific, just a failure from database
  const factory DatabaseFailures(FailureInfo info) = _DatabaseFailures;

  /// Throw from database that the input is not follow constraint rule in database
  const factory DatabaseFailures.uniqueConstraint(FailureInfo info) = _UniqueConstraint;

  /// Cannot find any data in database with given argument
  const factory DatabaseFailures.notFound(FailureInfo info) = _NotFound;

  String logMessage() {
    return switch (this) {
      _DatabaseFailures(:final info) => "DatabaseFailures: ${info.debugMessage}",
      _UniqueConstraint(:final info) => "UniqueConstraint: ${info.debugMessage}",
      _NotFound(:final info) => "NotFound: ${info.debugMessage}",
    };
  }
}

@freezed
sealed class AuthFailures with _$AuthFailures {
  const AuthFailures._();

  /// Not specific, just a failure from auth
  const factory AuthFailures(FailureInfo info) = _AuthFailures;

  /// Any provider use for authentication is incorrect, eg username or password
  const factory AuthFailures.incorrectLoginCredential(FailureInfo info) = _IncorrectLoginCredential;

  /// Tried to access something that has protected
  const factory AuthFailures.forbidden(FailureInfo info) = _Forbidden;

  /// Information use to register or signed up might have been use by other user
  const factory AuthFailures.alreadyRegistered(FailureInfo info) = _UserAlreadyRegistered;

  String logMessage() {
    return switch (this) {
      _AuthFailures(:final info) => "AuthFailures: ${info.debugMessage}",
      _IncorrectLoginCredential(:final info) => "IncorrectLoginCredential: ${info.debugMessage}",
      _Forbidden(:final info) => "Forbidden: ${info.debugMessage}",
      _UserAlreadyRegistered(:final info) => "UserAlreadyRegistered: ${info.debugMessage}",
    };
  }
}
