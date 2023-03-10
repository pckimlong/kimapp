import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:kimapp/kimapp.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final logger = Logger();

void _logError(String title, String message, StackTrace stackTrace, Object e) {
  final loggerCallback = Kimapp.instance.logger;
  if (loggerCallback != null) {
    loggerCallback(
      type: LoggerType.error,
      title: title,
      message: message,
      stackTrace: stackTrace,
      errorObject: e,
    );
  }
}

Future<Either<Failure, T>> errorHandler<T>(FutureOr<Either<Failure, T>> Function() callback) async {
  try {
    return await callback();
  } on Failure catch (e) {
    _logError('Failure', e.message(), e.stackTrace, e);
    return left(e);
  } on AuthException catch (e, str) {
    _logError('Supabase.AuthException', e.message, str, e);

    if (e.message == "Invalid login credentials") {
      return left(Failure.authFailure(AuthFailures.incorrectLoginCredential(
          FailureInfo(stackTrace: str, debugMessage: e.message, errorObject: e))));
    }

    if (e.message == "A user with this email address has already been registered") {
      return left(Failure.authFailure(AuthFailures.alreadyRegistered(
          FailureInfo(stackTrace: str, debugMessage: e.message, errorObject: e))));
    }

    return left(Failure.authFailure(
        AuthFailures(FailureInfo(stackTrace: str, debugMessage: e.message, errorObject: e))));
  } on StorageException catch (e, str) {
    _logError('Supabase.StorageException', e.message, str, e);

    return left(
      Failure.databaseFailure(
        DatabaseFailures(
          FailureInfo(stackTrace: str, debugMessage: e.message, errorObject: e),
        ),
      ),
    );
  } on PostgrestException catch (e, str) {
    _logError('Supabase.StorageException', e.message, str, e);

    if (e.code == "23505") {
      return left(Failure.databaseFailure(DatabaseFailures.uniqueConstraint(
          FailureInfo(stackTrace: str, debugMessage: e.message, errorObject: e))));
    }

    if (e.code == "42P01") {
      return left(Failure.databaseFailure(DatabaseFailures.notFound(
          FailureInfo(stackTrace: str, debugMessage: e.message, errorObject: e))));
    }

    if (e.code == "42501") {
      return left(Failure.authFailure(AuthFailures.forbidden(
          FailureInfo(stackTrace: str, debugMessage: e.message, errorObject: e))));
    }

    if (e.code == '502' && e.details == "Bad Gateway") {
      return left(Failure.serverError(
          FailureInfo(stackTrace: str, debugMessage: e.message, errorObject: e)));
    }

    return left(Failure.databaseFailure(
        DatabaseFailures(FailureInfo(stackTrace: str, debugMessage: e.message, errorObject: e))));
  } on Exception catch (e, str) {
    _logError('Exception', e.toString(), str, e);

    // No internet
    if (e.toString().contains('Failed host lookup')) {
      return left(Failure.networkFailure(
          FailureInfo(stackTrace: str, debugMessage: e.toString(), errorObject: e)));
    }

    return left(
      Failure.exception(FailureInfo(stackTrace: str, debugMessage: e.toString(), errorObject: e)),
    );
  } catch (e, str) {
    _logError('Error Catch', e.toString(), str, e);

    return left(
      Failure.exception(FailureInfo(stackTrace: str, debugMessage: e.toString(), errorObject: e)),
    );
  }
}
