import 'dart:async';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:kimapp/kimapp.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Constants for error codes and messages
class ErrorCodes {
  static const String myError = 'MYERR';
  static const String notFound = 'PGRST116';
  static const String uniqueConstraint = '23505';
  static const String noTable = '42P01';
  static const String forbidden = '42501';
  static const String badGateway = '502';
}

class ErrorMessages {
  static const String invalidCredentials = 'Invalid login credentials';
  static const String emailAlreadyRegistered =
      'A user with this email address has already been registered';
  static const String noResults = 'Results contain 0 rows';
  static const String badGatewayDetails = 'Bad Gateway';
}

/// Internet connectivity error patterns
final List<String> internetErrorPatterns = [
  'failed host lookup',
  'socketexception',
  'connection failed',
  'network is unreachable',
];

/// Logger utility class
class ErrorLogger {
  final Logger _logger = Logger();

  void logError(String title, String message, StackTrace stackTrace, Object error) {
    final loggerCallback = Kimapp.instance.logger;
    if (loggerCallback != null) {
      loggerCallback(
        LoggerType.error,
        title,
        message,
        stackTrace,
        error,
      );
    }
    // Also log to default logger
    _logger.e('$title: $message', error: error, stackTrace: stackTrace);
  }
}

/// Main error handler function
Future<Either<Failure, T>> errorHandler<T>(
  FutureOr<Either<Failure, T>> Function() callback,
) async {
  final errorLogger = ErrorLogger();

  try {
    return await callback();
  } on Failure catch (e) {
    errorLogger.logError('Failure', e.message(), e.stackTrace, e);
    return left(e);
  } on AuthException catch (e, stackTrace) {
    errorLogger.logError('Supabase.AuthException', e.message, stackTrace, e);
    return _handleAuthException(e, stackTrace);
  } on StorageException catch (e, stackTrace) {
    errorLogger.logError('Supabase.StorageException', e.message, stackTrace, e);
    return _handleStorageException(e, stackTrace);
  } on PostgrestException catch (e, stackTrace) {
    errorLogger.logError('Supabase.PostgrestException', e.message, stackTrace, e);
    return _handlePostgrestException(e, stackTrace);
  } on Exception catch (e, stackTrace) {
    errorLogger.logError('Exception', e.toString(), stackTrace, e);
    return _handleGeneralException(e, stackTrace);
  } catch (e, stackTrace) {
    errorLogger.logError('Error Catch', e.toString(), stackTrace, e);
    return _handleUnknownError(e, stackTrace);
  }
}

/// Handle authentication-related exceptions
Either<Failure, T> _handleAuthException<T>(
  AuthException e,
  StackTrace stackTrace,
) {
  final info = FailureInfo(
    stackTrace: stackTrace,
    debugMessage: e.message,
    errorObject: e,
  );

  switch (e.message) {
    case ErrorMessages.invalidCredentials:
      return left(Failure.authFailure(
        AuthFailures.incorrectLoginCredential(info),
      ));
    case ErrorMessages.emailAlreadyRegistered:
      return left(Failure.authFailure(
        AuthFailures.alreadyRegistered(info),
      ));
    default:
      return left(Failure.authFailure(AuthFailures(info)));
  }
}

/// Handle storage-related exceptions
Either<Failure, T> _handleStorageException<T>(
  StorageException e,
  StackTrace stackTrace,
) {
  return left(
    Failure.databaseFailure(
      DatabaseFailures(
        FailureInfo(
          stackTrace: stackTrace,
          debugMessage: e.message,
          errorObject: e,
        ),
      ),
    ),
  );
}

/// Handle Postgres database exceptions
Either<Failure, T> _handlePostgrestException<T>(
  PostgrestException e,
  StackTrace stackTrace,
) {
  final info = FailureInfo(
    stackTrace: stackTrace,
    debugMessage: e.message,
    errorObject: e,
  );

  // Check for specific error codes
  switch (e.code) {
    case ErrorCodes.myError:
      return left(
        Failure.databaseFailure(
          DatabaseFailures(
            FailureInfo(
              stackTrace: stackTrace,
              debugMessage: e.message,
              message: e.message,
              errorObject: e,
            ),
          ),
        ),
      );
    case ErrorCodes.notFound:
    case ErrorCodes.noTable:
      return left(Failure.databaseFailure(
        DatabaseFailures.notFound(info),
      ));
    case ErrorCodes.uniqueConstraint:
      return left(Failure.databaseFailure(
        DatabaseFailures.uniqueConstraint(info),
      ));
    case ErrorCodes.forbidden:
      return left(Failure.authFailure(
        AuthFailures.forbidden(info),
      ));
    case ErrorCodes.badGateway:
      if (e.details == ErrorMessages.badGatewayDetails) {
        return left(Failure.serverError(info));
      }
      break;
    default:
      // Check for no results condition
      if (e.details.toString().contains(ErrorMessages.noResults) ||
          e.message.contains(ErrorCodes.notFound)) {
        return left(Failure.databaseFailure(
          DatabaseFailures.notFound(info),
        ));
      }
  }

  // Default database failure
  return left(Failure.databaseFailure(DatabaseFailures(info)));
}

/// Handle general exceptions
Either<Failure, T> _handleGeneralException<T>(
  Exception e,
  StackTrace stackTrace,
) {
  final message = e.toString().toLowerCase();
  final info = FailureInfo(
    stackTrace: stackTrace,
    debugMessage: e.toString(),
    errorObject: e,
  );

  // Check for internet connectivity issues
  if (e is SocketException || internetErrorPatterns.any((pattern) => message.contains(pattern))) {
    return left(Failure.networkFailure(info));
  }

  return left(Failure.exception(info));
}

/// Handle unknown errors
Either<Failure, T> _handleUnknownError<T>(
  Object e,
  StackTrace stackTrace,
) {
  return left(
    Failure.exception(
      FailureInfo(
        stackTrace: stackTrace,
        debugMessage: e.toString(),
        errorObject: e,
      ),
    ),
  );
}
