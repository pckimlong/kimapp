import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const Failure._();

  const factory Failure.exception(StackTrace stackTrace, [String? message]) = ExceptionFailure;
  const factory Failure.noInternet(StackTrace stackTrace, [String? message]) = NoInternetFailure;
  const factory Failure.serverDown(StackTrace stackTrace, [String? message]) = ServerDownFailure;
  const factory Failure.incorrectLoginCredential(StackTrace stackTrace, [String? message]) =
      IncorrectLoginCredential;
  const factory Failure.authException(StackTrace stackTrace, [String? message]) =
      AuthExceptionFailure;
  const factory Failure.databaseError(StackTrace stackTrace, [String? message]) =
      DatabaseErrorFailure;
  const factory Failure.forbidden(StackTrace stackTrace, [String? message]) = ForbiddenFailure;
  const factory Failure.uniqueConstraint(StackTrace stackTrace, [String? message]) =
      UniqueConstraintFailure;
  const factory Failure.notFound(StackTrace stackTrace, [String? message]) = NotFoundFailure;
  const factory Failure.userAlreadyRegistered(StackTrace stackTrace, [String? message]) =
      _UserAlreadyRegistered;
}

Future<Either<Failure, T>> errorHandler<T>(FutureOr<Either<Failure, T>> Function() callback,
    {void Function(Object e)? onError}) async {
  try {
    return await callback();
  } on Failure catch (e) {
    return left(e);
  } on Exception catch (e, str) {
    _reportError(e, str);
    if (onError != null) onError(e);
    log("Exception:", error: e);

    // No internet
    if (e.toString().contains('Failed host lookup')) {
      return left(Failure.noInternet(str, "មិនអាចភ្ជាប់ទៅបណ្ដាញអុីនធឺណេត"));
    }

    return left(Failure.exception(str, e.toString()));
  } catch (e, str) {
    _reportError(e, str);
    if (onError != null) onError(e);
    log("Error:", error: e);
    return left(Failure.exception(str, e.toString()));
    // rethrow;
  }
}

void _reportError(Object e, StackTrace str) {}

class FailureMessage {
  const FailureMessage._();

  static const String incorrectLoginCredential =
      "ឈ្មោះគណនីឬពាក្យសម្ងាត់ដែលលោកអ្នកបានបញ្ជូលគឺមិនត្រឹមត្រូវទេ!";
  static const String noInternet = "មិនអាចភ្ជាប់ទៅបណ្តាញអុីនធើណេត!";
  static const String serverDown = "មិនអាចភ្ជាប់ទៅម៉ាសុីនមេ!";
  static const String authError = "កំហុសពាក់ព័ន្ធនឹងគណនី!";
  static const String databaseError = "កំហុសម៉ាសុីនរក្សារទុកទិន្នន៏យ!";
  static const String forbidden = "គ្មានសិទ្ធអនុញ្ញាតិ!";
  static const String uniqueConstraint = "អ្នកបានបញ្ជូលទិន្នន័យស្ទួន!";
  static const String notFound = "រកពុំឃើញ!";
  static const String userAlreadyRegistered = "ឈ្មោះត្រូវបានប្រើប្រាស់រួចហើយជាមួយគណនីផ្សេង!";
  static const String base = "មានកំហុសបច្ចេកទេស!";
}

extension FailureX on Failure {
  String get errorMessageKhmer {
    return map(
      exception: (exception) {
        return FailureMessage.base;
      },
      noInternet: (noInternet) {
        return FailureMessage.noInternet;
      },
      serverDown: (serverDown) {
        return FailureMessage.serverDown;
      },
      incorrectLoginCredential: (incorrectLoginCredential) {
        return FailureMessage.incorrectLoginCredential;
      },
      authException: (authException) {
        return FailureMessage.authError;
      },
      databaseError: (databaseError) {
        return FailureMessage.databaseError;
      },
      forbidden: (forbidden) {
        return FailureMessage.forbidden;
      },
      uniqueConstraint: (uniqueConstraint) {
        return FailureMessage.uniqueConstraint;
      },
      notFound: (notFound) {
        return FailureMessage.notFound;
      },
      userAlreadyRegistered: (userAlreadyRegistered) {
        return FailureMessage.userAlreadyRegistered;
      },
    );
  }
}
