import 'package:riverpod/riverpod.dart';

extension AsyncValueIterableHelper<T> on AsyncValue<Iterable<T>> {
  /// Returns the count of the iterable. Short for `whenData((value) => value.length)`
  AsyncValue<int> countAsync() => whenData((value) => value.length);
}
