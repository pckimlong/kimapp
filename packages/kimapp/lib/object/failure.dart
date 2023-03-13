import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';

import '../service.dart';

part 'failure.freezed.dart';

class FailureMessage {
  final String exception = "Something went wrong!";
  final String networkFailure = "Network connection error!";
  final String serverError = "Internal Server Error";
  final String databaseError = "Database Error";
  final String uniqueConstraintError = "Violence data input";
  final String notFoundError = "Not Found";
  final String authError = "Authentication Error";
  final String incorrectLoginCredential = "Incorrect username or password";
  final String forbidden = "Forbidden";
  final String alreadyRegistered = "Already Registered";
}

extension FailureX on Failure {
  AsyncError<T> toAsyncError<T>() => AsyncError<T>(message(), stackTrace);

  StackTrace get stackTrace {
    return when(
      (info) => info.stackTrace,
      exception: (info) => info.stackTrace,
      networkFailure: (info) => info.stackTrace,
      serverError: (info) => info.stackTrace,
      databaseFailure: (info) => info.when(
        (info) => info.stackTrace,
        uniqueConstraint: (info) => info.stackTrace,
        notFound: (info) => info.stackTrace,
      ),
      authFailure: (info) => info.when(
        (info) => info.stackTrace,
        incorrectLoginCredential: (info) => info.stackTrace,
        forbidden: (info) => info.stackTrace,
        alreadyRegistered: (info) => info.stackTrace,
      ),
    );
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
  String message([bool debugMessageEnable = true]) {
    final kimapp = Kimapp.instance;
    final mgs = kimapp.failureMessage;
    final useDebugMessage = kimapp.debugMode && debugMessageEnable;

    return when(
      (info) => useDebugMessage ? info.debugMessage : info.message ?? "Something when wrong!",
      exception: (info) {
        return useDebugMessage ? info.debugMessage : info.message ?? mgs.exception;
      },
      networkFailure: (info) {
        return useDebugMessage ? info.debugMessage : info.message ?? mgs.networkFailure;
      },
      serverError: (info) {
        return useDebugMessage ? info.debugMessage : info.message ?? mgs.serverError;
      },
      databaseFailure: (info) {
        return info.when(
          (info) {
            return useDebugMessage ? info.debugMessage : info.message ?? mgs.databaseError;
          },
          uniqueConstraint: (info) {
            return useDebugMessage ? info.debugMessage : info.message ?? mgs.uniqueConstraintError;
          },
          notFound: (info) {
            return useDebugMessage ? info.debugMessage : info.message ?? mgs.notFoundError;
          },
        );
      },
      authFailure: (info) {
        return info.when(
          (info) {
            return useDebugMessage ? info.debugMessage : info.message ?? mgs.authError;
          },
          incorrectLoginCredential: (info) {
            return useDebugMessage
                ? info.debugMessage
                : info.message ?? mgs.incorrectLoginCredential;
          },
          forbidden: (info) {
            return useDebugMessage ? info.debugMessage : info.message ?? mgs.forbidden;
          },
          alreadyRegistered: (info) {
            return useDebugMessage ? info.debugMessage : info.message ?? mgs.alreadyRegistered;
          },
        );
      },
    );
  }
}

@freezed
class FailureInfo with _$FailureInfo {
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
class Failure with _$Failure, Exception {
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
}

@freezed
class DatabaseFailures with _$DatabaseFailures {
  /// Not specific, just a failure from database
  const factory DatabaseFailures(FailureInfo info) = _DatabaseFailures;

  /// Throw from database that the input is not follow constraint rule in database
  const factory DatabaseFailures.uniqueConstraint(FailureInfo info) = _UniqueConstraint;

  /// Cannot find any data in database with given argument
  const factory DatabaseFailures.notFound(FailureInfo info) = _NotFound;
}

@freezed
class AuthFailures with _$AuthFailures {
  /// Not specific, just a failure from auth
  const factory AuthFailures(FailureInfo info) = _AuthFailures;

  /// Any provider use for authentication is incorrect, eg username or password
  const factory AuthFailures.incorrectLoginCredential(FailureInfo info) = _IncorrectLoginCredential;

  /// Tried to access something that has protected
  const factory AuthFailures.forbidden(FailureInfo info) = _Forbidden;

  /// Information use to register or signed up might have been use by other user
  const factory AuthFailures.alreadyRegistered(FailureInfo info) = _UserAlreadyRegistered;
}

// /// Copied from flutter foundation
// String exceptionAsString(Object exception) {
//   String? longMessage;
//   if (exception is AssertionError) {
//     final Object? message = (exception).message;
//     final String fullMessage = exception.toString();
//     if (message is String && message != fullMessage) {
//       if (fullMessage.length > message.length) {
//         final int position = fullMessage.lastIndexOf(message);
//         if (position == fullMessage.length - message.length &&
//             position > 2 &&
//             fullMessage.substring(position - 2, position) == ': ') {
//           // Add a line break so that the filename at the start of the
//           // assertion message is always on its own line.
//           String body = fullMessage.substring(0, position - 2);
//           final int splitPoint = body.indexOf(' Failed assertion:');
//           if (splitPoint >= 0) {
//             body = '${body.substring(0, splitPoint)}\n${body.substring(splitPoint + 1)}';
//           }
//           longMessage = '${message.trimRight()}\n$body';
//         }
//       }
//     }
//     longMessage ??= fullMessage;
//   } else if (exception is String) {
//     longMessage = exception;
//   } else if (exception is Error || exception is Exception) {
//     longMessage = exception.toString();
//   } else {
//     longMessage = '  $exception';
//   }
//   longMessage = longMessage.trimRight();
//   if (longMessage.isEmpty) {
//     longMessage = '  <no message available>';
//   }
//   return longMessage;
// }
