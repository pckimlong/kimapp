// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:riverpod/riverpod.dart';
// ignore: implementation_imports
import 'package:riverpod/src/async_notifier.dart';

extension PersistRiverpodAsyncNotifier<T> on AsyncNotifierBase<T> {
  /// Persists the state of the notifier by fetching fresh data and persisting it if necessary.
  /// This callback should be called inside build to make it taking effect
  ///
  /// [fetchFreshData] is the main callback function to get fresh data from a remote server.
  ///
  /// [fetchPersistedData] is a callback function to get persisted data from local storage.
  ///
  /// [persistData] is a callback function to persist state whenever fresh data is fetched.
  ///
  /// [shouldFetchFreshData] is a callback function that determines whether fresh data should be fetched instead of persisted data.
  /// Note that this function will be called after [persistData] called in order to provide that data to check
  ///
  /// [shouldPersistFreshData] is callback function that determines whether the result of fresh data should be persist or not
  /// if it null, then it will be persist without any doubt.
  ///
  /// [enableCache] is an additional condition to determine whether to get data from cache or not.
  ///
  /// [refetchOnRefresh] is a boolean value that determines whether to call the `fetchFreshData` callback whenever the provider is refreshed.
  ///
  /// [silentlyFetchFreshForLaterUse] is a boolean value that determines whether to refresh the state after the first load of cached data.
  /// keep in mind that this will not update the state immediately, but it will update the state next time the state is read.
  ///
  /// [onError] is a callback function that is called whenever there is an error in fetching persisted data or saving it.
  FutureOr<T> persistState({
    required Future<T> Function() fetchFreshData,
    required Future<T?> Function() fetchPersistedData,
    required Future<void> Function(T freshData) persistData,
    required FutureOr<bool> Function(T persistedData) shouldFetchFreshData,
    bool Function(T freshData)? shouldPersistFreshData,
    bool enableCache = true,
    bool refetchOnRefresh = true,
    bool silentlyFetchFreshForLaterUse = false,
    void Function(Object error)? onError,
  }) async {
    // Only get persisted data when [enableCache] is true and state is not refreshing
    // or [refetchOnRefresh] is false which mean, it still use persisted data even the state is refreshing
    if (enableCache && (!state.isRefreshing || !refetchOnRefresh)) {
      try {
        final persistedData = await fetchPersistedData();
        // Check if should get fresh data instead
        // if not, use the persistedData
        if (persistedData != null &&
            await shouldFetchFreshData(persistedData) == false) {
          if (silentlyFetchFreshForLaterUse) {
            // Get fresh data and persist it silently
            unawaited(
              () async {
                var value = await fetchFreshData();
                await persistData(value);
              }(),
            );
          }
          return persistedData;
        }
      } catch (e) {
        onError?.call(e);
        rethrow;
      }
    }
    // Get fresh data and update state
    final freshData = await fetchFreshData();

    if (!enableCache || shouldPersistFreshData?.call(freshData) == false) {
      return freshData;
    }

    // Persist fresh data to cached
    try {
      await persistData(freshData);
    } catch (e) {
      onError?.call(e);
    }
    return freshData;
  }
}

extension RefPersist on Ref {
  Future<T> persist<T>(
    AsyncValue state, {
    required Future<T> Function() fetchFreshData,
    required Future<T?> Function() fetchPersistedData,
    required Future<void> Function(T freshData) persistData,

    /// Callback to determine whether persisted data is valid or not, if null, then it will be valid
    /// if it return false, it will ignore the persisted data and fetch fresh data instead
    bool Function(T persistedData)? validPersistedData,
    Duration refreshIn = const Duration(seconds: 3),
  }) async {
    if (!state.isRefreshing) {
      final cached = await fetchPersistedData();
      if (cached != null && (validPersistedData?.call(cached) ?? true)) {
        Future.delayed(refreshIn).then((_) => invalidateSelf());
        return cached;
      }
    }

    final freshed = await fetchFreshData();
    await persistData(freshed);
    return freshed;
  }
}
