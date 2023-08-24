import 'package:fpdart/fpdart.dart';

import 'kimapp.dart';

extension EitherX<T> on Either<Failure, T> {
  T getOrThrow() => getOrElse((l) => throw l);
  T? getOrNull() => fold((l) => null, (r) => r);
  N mapOrThrow<N>(N Function(T r) map) => fold((l) => throw l, map);
}

extension OptionX<T> on Option<T> {
  T getOrCrash() {
    return getOrElse(
      () => throw Failure(
        FailureInfo(
          debugMessage: 'Try to get value from $runtimeType which is not some',
          stackTrace: StackTrace.current,
        ),
      ),
    );
  }
}
