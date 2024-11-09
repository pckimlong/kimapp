// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'dart:developer';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod/src/async_notifier.dart';
import 'package:riverpod/src/notifier.dart';

import 'object/failure.dart';

part "riverpod_helper.freezed.dart";

// Helper for pagination with riverpod

@freezed
class PaginatedItem<T> with _$PaginatedItem<T> {
  const PaginatedItem._();

  const factory PaginatedItem.data(T item) = _Data;
  const factory PaginatedItem.loading({@Default(true) bool isFirstItem}) = _Loading;
  const factory PaginatedItem.error(Failure failure) = _Error;

  /// Build pagination item
  ///
  /// Example usage:
  /// ```
  /// @riverpod
  /// PaginatedItem<User>? paginatedUserAtIndex(PaginatedUserAtIndexRef ref, int index) {
  ///   final itemPage = index ~/ _pageTranLimit;
  ///
  ///   final baseList = ref.watch(pageListProvider(page: itemPage));
  ///   return PaginatedItem.build(
  ///     pageItems: baseList.whenData((value) => value.items.lock),
  ///     limit: _pageTranLimit,
  ///     index: index,
  ///   );
  /// }
  ///
  /// ```
  static PaginatedItem<T>? build<T>({
    required AsyncValue<IList<T>> pageItems,
    required int limit,
    required int index,

    /// If false, only first item in the page will show loading state, otherwise just return null
    /// If true meaning that wether the item in any position will show loading state when it is loading
    bool showLoadingInAllItem = false,
  }) {
    final itemIndexInPage = index % limit;
    final itemOfIndexAsync = pageItems.whenData((value) => value.getOrNull(itemIndexInPage));
    return itemOfIndexAsync.when(
      data: (data) {
        if (data != null) return PaginatedItem.data(data);
        return null;
      },
      error: (err, str) {
        if (itemIndexInPage == 0) {
          return PaginatedItem.error(
            Failure(FailureInfo(stackTrace: str, debugMessage: err.toString(), errorObject: err)),
          );
        }
        return null;
      },
      loading: () {
        if (itemIndexInPage == 0 && !showLoadingInAllItem) {
          return const PaginatedItem.loading(isFirstItem: true);
        }

        if (showLoadingInAllItem) return const PaginatedItem.loading(isFirstItem: false);

        return null;
      },
    );
  }
}

// Use for perform action with different status state
@freezed
class ProviderStatus<T> with _$ProviderStatus<T> {
  const factory ProviderStatus.initial() = _Initial<T>;
  const factory ProviderStatus.inProgress() = _InProgress<T>;
  const factory ProviderStatus.failure(Failure failure) = _Failure<T>;
  const factory ProviderStatus.success(T success) = _Success<T>;

  factory ProviderStatus.fromAsyncValue(AsyncValue<T> asyncValue, {bool initial = false}) {
    return asyncValue.when(
      data: (value) => ProviderStatus.success(value),
      error: (err, str) {
        if (err is Failure) return ProviderStatus.failure(err);
        return ProviderStatus.failure(
          Failure.exception(
            FailureInfo(
              stackTrace: str,
              debugMessage: err.toString(),
            ),
          ),
        );
      },
      loading: () => const ProviderStatus.inProgress(),
    );
  }

  /// Safety run callback inside provider status, handle try-cache
  /// return appropriate state.
  static Future<ProviderStatus<T>> guard<T>(Future<T> Function() callback) async {
    try {
      return ProviderStatus.success(await callback());
    } catch (err, stack) {
      return ProviderStatus.failure(
        err is Failure
            ? err
            : err is String
                ? Failure.fromString(err)
                : Failure(FailureInfo(stackTrace: stack, debugMessage: err.toString())),
      );
    }
  }
}

extension ProviderStatusX<T> on ProviderStatus<T> {
  bool get isInitial => whenOrNull(initial: () => true) == true;
  bool get isInProgress => whenOrNull(inProgress: () => true) == true;
  bool get isSuccess => whenOrNull(success: (_) => true) == true;
  bool get isFailure => whenOrNull(failure: (_) => true) == true;

  AsyncValue<T> toAsyncValue({T Function()? onInitial}) {
    return when(
      initial: () => onInitial == null ? const AsyncValue.loading() : AsyncValue.data(onInitial()),
      inProgress: () => const AsyncValue.loading(),
      failure: (failure) => failure.toAsyncError(),
      success: (value) => AsyncValue.data(value),
    );
  }

  /// Retrieve success value, return null if state is not [ProviderStatus.success]
  T? get successOrNull => whenOrNull<T>(success: (value) => value);

  Failure? get failure => whenOrNull(failure: (value) => value);
}

extension ProviderStatusProviderX<T> on NotifierProviderRef<ProviderStatus<T>> {
  void onSuccessSelf(Function(T success) onSuccess) {
    listenSelf(
      (previous, next) {
        if (previous != next && next.isSuccess) {
          onSuccess(next.successOrNull as T);
        }
      },
    );
  }
}

/// Mixin for add provider status state ot given class
/// [SubClass] is the class which extends this mixin
/// [Result] is the provider status success value
///
/// ```
/// class A with ProviderStatusClass<A, int> {
///   final int properties;
///   @override
///   final ProviderStatus<int> status;
///
///   @override
///   Test updateStatus(ProviderStatus<int> status) {
///     return Test.copyWith(...);
///   }
/// }
/// ```
mixin ProviderStatusClassMixin<SubClass, Result> {
  ProviderStatus<Result> get status;

  /// Update status state of class. Must override this in order to allow provider status getting update
  ///
  /// copyWith method of immutable object should be use here
  /// ```
  /// @override
  /// SubClass updateStatus(ProviderStatus<Result> newStatus) {
  ///   return this.copyWith(status: newStatus);
  /// }
  /// ```
  @visibleForOverriding
  SubClass updateStatus(ProviderStatus<Result> newStatus);
}

/// Mixin for add functional to provider status class which allow to perform fetching initial load
/// for updating data by generate helpful widget to support
mixin UpdateFormMixin {
  /// Wether initial data for updating form has loaded or not. This allow it to bind fresh data to provider field
  bool get initialLoaded;
}

extension RiverpodRefExtension on Ref {
  /// Auto invalidate self after given duration
  void autoInvalidateSelf(Duration duration) {
    final timer = Timer(duration, invalidateSelf);
    onDispose(timer.cancel);
  }

  /// Debounce object to prevent multiple call in a given duration
  Future<T> debounceObject<T>(
    FutureOr<T> object, {
    /// Duration to debounce
    Duration duration = const Duration(milliseconds: 300),

    /// Function to call when object need to be dispose, e.g. cancel http request
    /// This tell the riverpod how to dispose given object
    FutureOr<void> Function(T value)? disposeObject,
  }) async {
    var didDispose = false;
    onDispose(() => didDispose = true);

    await Future<void>.delayed(duration);

    if (didDispose) {
      throw Exception('Cancelled');
    }

    final result = await object;
    onDispose(() => disposeObject?.call(result));

    return result;
  }

  void cacheTime(Duration duration) {
    final cancel = keepAlive();
    final timer = Timer(duration, cancel.close);
    onDispose(timer.cancel);
  }
}

extension RiverpodCacheExtension on AutoDisposeRef {
  /// Prevent provider from being disposed in a given duration
  void cacheTime(Duration duration) {
    final cancel = keepAlive();
    final timer = Timer(duration, cancel.close);
    onDispose(timer.cancel);
  }
}

extension ProviderStatusClassProviderX<B, T>
    on NotifierProviderRef<ProviderStatusClassMixin<B, T>> {
  void onSuccessSelf(Function(T success) onSuccess) {
    listenSelf(
      (previous, next) {
        if (previous?.status != next.status && next.status.isSuccess) {
          onSuccess(next.status.successOrNull as T);
        }
      },
    );
  }
}

extension ProviderStatusFamilyNotifierX<T> on BuildlessAutoDisposeNotifier<ProviderStatus<T>> {
  /// Perform call function of provider with continuously update the status and catch error
  ///
  /// If status is currently in progress or already success, no action will be perform and return current status
  ///
  /// Update current status to in progress then execute [callback] function which has current state inside
  /// this callback must return ProviderStatus success type [T]
  ///
  /// It is safe to run error prone function in it, since callback will be perform inside
  /// [ProviderStatus.guard] function which will update the status depend on the process
  ///
  /// [onFailure] callback will be trigger when provider is in error state and given callback is none null
  /// ```
  /// Future<ProviderStatus<T>> call(Parameters) async {
  ///   return perform((state) async {
  ///   final result = await ref.read(authRepoProvider).signIn(signInParam); // call to function
  ///   return result.getOrThrow();
  ///  });
  /// }
  /// ```
  Future<ProviderStatus<T>> perform(
    Future<T> Function(ProviderStatus<T> state) callback, {
    void Function(Failure failure)? onFailure,

    /// Trigger whenever success
    void Function(T success)? onSuccess,
  }) async {
    if (state.isInProgress || state.isSuccess) return state;
    state = ProviderStatus<T>.inProgress();
    state = await ProviderStatus.guard<T>(() async => await callback(state));
    final updatedState = state; // prevent if onsuccess or failure update current state
    if (state.isFailure && onFailure != null) {
      onFailure(state.whenOrNull(failure: (failure) => failure)!);
    }
    if (state.isSuccess && onSuccess != null) onSuccess(state.successOrNull as T);
    return updatedState;
  }
}

/// Make family provider(provider with params in builds) work
extension ProviderStatusClassFamilyNotifierX<A, Base extends ProviderStatusClassMixin<Base, A>>
    on BuildlessAutoDisposeNotifier<Base> {
  bool get isInProgress => state.status.isInProgress;
  bool get isFailure => state.status.isFailure;
  bool get isInitial => state.status.isInitial;
  bool get isSuccess => state.status.isSuccess;

  /// Perform callback update the provider status class and return class state
  Future<ProviderStatus<T>> perform<T extends A>(
    /// Main callback function which handle error event
    Future<T> Function(Base state) callback, {
    /// Trigger whenever there a failure in callback
    void Function(Failure failure)? onFailure,

    /// Trigger whenever success
    void Function(T success)? onSuccess,

    /// Function has no effect when current status is already a success state
    bool ignoreInSuccessState = true,
  }) async {
    if (isInProgress) return state.status as ProviderStatus<T>;
    if (ignoreInSuccessState && isSuccess) return state.status as ProviderStatus<T>;

    /// If current provider mixin with [UpdateFormMixin]. Ignore it action when initialLoaded flag is false
    if (state is UpdateFormMixin) {
      final updateForm = state as UpdateFormMixin;
      if (!updateForm.initialLoaded) {
        log('${state.runtimeType}.initialLoaded is false. So this call back will be ignore');

        /// TODO - Should I expose failure status instead of keep it silence like this?
        /// Actually error message should be handle in form widget.
        /// Keep it silent for now
        return state.status as ProviderStatus<T>;
      }
    }

    state = state.updateStatus(ProviderStatus<T>.inProgress());

    //! This approach cause problem, because state is outdate, when we use await on callback() we might update
    //! the provider, but use an outdate state
    // state = state.updateStatus(await ProviderStatus.guard<T>(() async => await callback(state)));

    //* New approach is to await for the progress first before update the state.
    final result = await ProviderStatus.guard(() async => await callback(state));
    state = state.updateStatus(result);
    final updatedStatus = state.status as ProviderStatus<T>;
    if (isFailure && onFailure != null) {
      onFailure(state.status.whenOrNull(failure: (failure) => failure)!);
    }
    if (isSuccess && onSuccess != null) {
      onSuccess(state.status.successOrNull as T);
    }
    return updatedStatus;
  }
}

extension ProviderStatusFamilyNotifierXX<T> on Notifier<ProviderStatus<T>> {
  /// Perform call function of provider with continuously update the status and catch error
  ///
  /// If status is currently in progress or already success, no action will be perform and return current status
  ///
  /// Update current status to in progress then execute [callback] function which has current state inside
  /// this callback must return ProviderStatus success type [T]
  ///
  /// It is safe to run error prone function in it, since callback will be perform inside
  /// [ProviderStatus.guard] function which will update the status depend on the process
  ///
  /// [onFailure] callback will be trigger when provider is in error state and given callback is none null
  /// ```
  /// Future<ProviderStatus<T>> call(Parameters) async {
  ///   return perform((state) async {
  ///   final result = await ref.read(authRepoProvider).signIn(signInParam); // call to function
  ///   return result.getOrThrow();
  ///  });
  /// }
  /// ```
  Future<ProviderStatus<T>> perform(
    Future<T> Function(ProviderStatus<T> state) callback, {
    void Function(Failure failure)? onFailure,

    /// Trigger whenever success
    void Function(T success)? onSuccess,
  }) async {
    if (state.isInProgress || state.isSuccess) return state;
    state = ProviderStatus<T>.inProgress();
    state = await ProviderStatus.guard<T>(() async => await callback(state));
    final updatedState = state; // prevent if onsuccess or failure update current state
    if (state.isFailure && onFailure != null) {
      onFailure(state.whenOrNull(failure: (failure) => failure)!);
    }
    if (state.isSuccess && onSuccess != null) onSuccess(state.successOrNull as T);
    return updatedState;
  }
}

/// Make family provider(provider with params in builds) work
extension ProviderStatusClassFamilyNotifierXX<A, Base extends ProviderStatusClassMixin<Base, A>>
    on Notifier<Base> {
  bool get isInProgress => state.status.isInProgress;
  bool get isFailure => state.status.isFailure;
  bool get isInitial => state.status.isInitial;
  bool get isSuccess => state.status.isSuccess;

  /// Perform callback update the provider status class and return class state
  Future<ProviderStatus<T>> perform<T extends A>(
    /// Main callback function which handle error event
    Future<T> Function(Base state) callback, {
    /// Trigger whenever there a failure in callback
    void Function(Failure failure)? onFailure,

    /// Trigger whenever success
    void Function(T success)? onSuccess,

    /// Function has no effect when current status is already a success state
    bool ignoreInSuccessState = true,
  }) async {
    if (isInProgress) return state.status as ProviderStatus<T>;
    if (ignoreInSuccessState && isSuccess) return state.status as ProviderStatus<T>;

    /// If current provider mixin with [UpdateFormMixin]. Ignore it action when initialLoaded flag is false
    if (state is UpdateFormMixin) {
      final updateForm = state as UpdateFormMixin;
      if (!updateForm.initialLoaded) {
        log('${state.runtimeType}.initialLoaded is false. So this call back will be ignore');

        /// TODO - Should I expose failure status instead of keep it silence like this?
        /// Actually error message should be handle in form widget.
        /// Keep it silent for now
        return state.status as ProviderStatus<T>;
      }
    }

    state = state.updateStatus(ProviderStatus<T>.inProgress());

    //! This approach cause problem, because state is outdate, when we use await on callback() we might update
    //! the provider, but use an outdate state
    // state = state.updateStatus(await ProviderStatus.guard<T>(() async => await callback(state)));

    //* New approach is to await for the progress first before update the state.
    final result = await ProviderStatus.guard(() async => await callback(state));
    state = state.updateStatus(result);
    final updatedStatus = state.status as ProviderStatus<T>;
    if (isFailure && onFailure != null) {
      onFailure(state.status.whenOrNull(failure: (failure) => failure)!);
    }
    if (isSuccess && onSuccess != null) {
      onSuccess(state.status.successOrNull as T);
    }
    return updatedStatus;
  }
}

extension PersistRiverpodAsyncNotifier<T> on BuildlessAutoDisposeAsyncNotifier<T> {
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
        if (persistedData != null && await shouldFetchFreshData(persistedData) == false) {
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
