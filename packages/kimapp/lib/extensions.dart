import 'package:fpdart/fpdart.dart';

import 'kimapp.dart';

extension EitherX<T> on Either<Failure, T> {
  T getOrThrow() => getOrElse((l) => Error.throwWithStackTrace(l, l.stackTrace));
  T? getOrNull() => fold((l) => null, (r) => r);
  N mapOrThrow<N>(N Function(T r) map) =>
      fold((l) => Error.throwWithStackTrace(l, l.stackTrace), map);
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

extension FutureEitherX<T> on Future<Either<Failure, T>> {
  Future<T> getOrThrow() async => (await this).getOrThrow();

  Future<T?> getOrNull() async => (await this).getOrNull();

  Future<N> mapOrThrow<N>(N Function(T r) map) async => (await this).mapOrThrow(map);
}
