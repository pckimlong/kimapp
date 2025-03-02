import 'package:autoverpod/autoverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod/riverpod.dart';

extension AsyncValueAutoverpodExtension<T> on AsyncValue<T>? {
  Failure? get failure =>
      this == null
          ? null
          : this!.isError == true
          ? this!.error is Failure
              ? this!.error as Failure
              : Failure(
                FailureInfo(
                  stackTrace: this!.stackTrace ?? StackTrace.current,
                  debugMessage: this!.error.toString(),
                  errorObject: this!.error,
                ),
              )
          : null;
}
