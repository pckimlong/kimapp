import 'package:riverpod/riverpod.dart';

extension AsyncValueIterableHelper<T> on AsyncValue<Iterable<T>> {
  /// Returns the count of the iterable. Short for `whenData((value) => value.length)`
  AsyncValue<int> countAsync() => whenData((value) => value.length);
}

extension ProviderListenableAsyncValueIterableHelper<T>
    on ProviderListenable<AsyncValue<Iterable<T>>> {
  /// Selects the count of the iterable. Short for `select((value) => value.whenData((value) => value.length))`
  /// This can be used in pagination to get the total count of items with cleaner code.
  ProviderListenable<AsyncValue<int>> selectCountAsync() => select((value) => value.countAsync());
}

extension AsyncValueListenableHelper<T> on ProviderListenable<Iterable<T>> {
  /// Returns the count of the iterable. Short for `whenData((value) => value.length)`
  ProviderListenable<int> selectCount() => select((value) => value.length);
}
