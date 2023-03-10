import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:kimapp/kimapp.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final logger = Logger();


void _logError(String title, String message, StackTrace stackTrace){
  final loggerCallback = Kimapp.instance.logger;
  if(loggerCallback != null){
    loggerCallback(
      type: LoggerType.error,
      title: title,
      message: message,
      stackTrace: stackTrace,
    );
  }
}


Future<Either<Failure, T>> errorHandler<T>(FutureOr<Either<Failure, T>> Function() callback) async {
  try {
    return await callback();
  } on Failure catch (e) {
    _logError('Failure', e.message(), e.stackTrace);
    return left(e);
  } on AuthException catch (e, str) {
    _logError('Supabase.AuthException', e.message, str);

    if (e.message == "Invalid login credentials") {
      return left(
        Failure.authFailure(AuthFailures.incorrectLoginCredential(FailureInfo(stackTrace: str, debugMessage: e.message)))
      );
    }

    if (e.message == "A user with this email address has already been registered") {
       return left(
        Failure.authFailure(AuthFailures.alreadyRegistered(FailureInfo(stackTrace: str, debugMessage: e.message)))
      );
    }

    return left(Failure.authFailure(AuthFailures(FailureInfo(stackTrace: str, debugMessage: e.message))));

  } on StorageException catch (e, str) {
    logger.("PostgrestException:", error: e);
    _reportError(e, str);
    

    return left(Failure.databaseError(str, e.message));
  } on PostgrestException catch (e, str) {
    _reportError(e, str);
    
    logger.("PostgrestException:", error: e);

    if (e.code == "23505") {
      return left(Failure.uniqueConstraint(str, kDebugMode ? e.message : 'ទិន្នន័យស្ទួន'));
    }

    if (e.code == "42P01") {
      return left(Failure.notFound(str, e.message));
    }

    if (e.code == "42501") {
      return left(Failure.forbidden(str, kDebugMode ? e.message : 'គ្មានសិទ្ធអនុញ្ញាត'));
    }

    if (e.code == '502' && e.details == "Bad Gateway") {
      return left(Failure.serverDown(str, 'មិនអាចភ្ជាប់ទៅម៉ាសុីនមេ'));
    }

    if (e.code == "PGRST301" || e.message.contains('expired')) {
      Supabase.instance.client.auth.refreshSession();
    }

    return left(Failure.databaseError(str, e.message));
  } on Exception catch (e, str) {
    _reportError(e, str);
    
    logger.("Exception:", error: e);

    // No internet
    if (e.toString().contains('Failed host lookup')) {
      return left(Failure.noInternet(str, "មិនអាចភ្ជាប់ទៅបណ្ដាញអុីនធឺណេត"));
    }

    return left(Failure.exception(str, e.toString()));
  } catch (e, str) {
    _reportError(e, str);
    
    logger.("Error:", error: e);
    return left(Failure.exception(str, e.toString()));
    // rethrow;
  }
}
