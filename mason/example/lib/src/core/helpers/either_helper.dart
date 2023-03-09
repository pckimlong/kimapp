import '../../../exports.dart';

extension EitherX<T> on Either<Failure, T> {
  T getOrThrow() => getOrElse((l) => throw l);
  T? getOrNull() => fold((l) => null, id);
  N mapOrThrow<N>(N Function(T r) map) => fold((l) => throw l, map);
}
