// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, implementation_imports

import 'dart:async';
import 'dart:developer';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';

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

        if (showLoadingInAllItem) {
          return const PaginatedItem.loading(isFirstItem: false);
        }

        return null;
      },
    );
  }

  // Due to removed whenOrNull of freezed, we need to port it here to avoid breaking change on pagination widget
  Return? whenOrNull<Return>({
    required Return Function(T) data,
    Return Function(bool isFirstItem)? loading,
    Return Function(Failure failure)? error,
  }) {
    // Use record pattern
    return switch (this) {
      _Data(:final item) => data(item),
      _Loading(:final isFirstItem) => loading?.call(isFirstItem),
      _Error(:final failure) => error?.call(failure),
      _ => null,
    };
  }
}

// Use for perform action with different status state
@freezed
sealed class ProviderStatus<T> with _$ProviderStatus<T> {
  const factory ProviderStatus.initial() = _Initial<T>;
  const factory ProviderStatus.inProgress() = _InProgress<T>;
  const factory ProviderStatus.failure(Failure failure) = _Failure<T>;
  const factory ProviderStatus.success(T success) = _Success<T>;

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
  bool get isInitial => switch (this) {
        _Initial<T>() => true,
        _ => false,
      };

  bool get isInProgress => switch (this) {
        _InProgress<T>() => true,
        _ => false,
      };

  bool get isSuccess => this is _Success<T>;

  bool get isFailure => this is _Failure<T>;

  AsyncValue<T> toAsyncValue({T Function()? onInitial}) {
    return switch (this) {
      _Initial<T>() =>
        onInitial == null ? const AsyncValue.loading() : AsyncValue.data(onInitial()),
      _InProgress<T>() => const AsyncValue.loading(),
      _Failure<T>(:final failure) => failure.toAsyncError(),
      _Success<T>(:final success) => AsyncValue.data(success),
    };
  }

  /// Retrieve success value, return null if state is not [ProviderStatus.success]
  T? get successOrNull => switch (this) {
        _Success<T>(:final success) => success,
        _ => null,
      };

  Failure? get failure => switch (this) {
        _Failure<T>(:final failure) => failure,
        _ => null,
      };
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

extension ProviderStatusFamilyNotifierX<T> on AsyncNotifier<ProviderStatus<T>> {
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
  Future<ProviderStatus<R>> perform<R>(
    Future<R> Function(ProviderStatus<T> state) callback, {
    void Function(Failure failure)? onFailure,
    void Function(R success)? onSuccess,
  }) async {
    final currentState = state.value;
    if (currentState == null) return ProviderStatus<R>.initial();

    if (currentState.isInProgress || currentState.isSuccess) {
      return currentState as ProviderStatus<R>;
    }

    final inProgressStatus = ProviderStatus<T>.inProgress();
    state = AsyncValue.data(inProgressStatus);

    final result = await ProviderStatus.guard<R>(() async => await callback(inProgressStatus));
    state = AsyncValue.data(result as ProviderStatus<T>);

    if (result.isFailure && onFailure != null) {
      final failure = result.failure;
      if (failure != null) onFailure(failure);
    }

    if (result.isSuccess && onSuccess != null) {
      final success = result.successOrNull;
      if (success != null) onSuccess(success as R);
    }

    return result;
  }
}

/// Make family provider(provider with params in builds) work
extension ProviderStatusClassFamilyNotifierX<A, Base extends ProviderStatusClassMixin<Base, A>>
    on AsyncNotifier<Base> {
  bool get isInProgress => state.value?.status.isInProgress ?? false;
  bool get isFailure => state.value?.status.isFailure ?? false;
  bool get isInitial => state.value?.status.isInitial ?? true;
  bool get isSuccess => state.value?.status.isSuccess ?? false;

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
    final currentState = state.value;
    if (currentState == null) return ProviderStatus<T>.initial();

    if (isInProgress) return currentState.status as ProviderStatus<T>;
    if (ignoreInSuccessState && isSuccess) {
      return currentState.status as ProviderStatus<T>;
    }

    /// If current provider mixin with [UpdateFormMixin]. Ignore it action when initialLoaded flag is false
    if (currentState is UpdateFormMixin) {
      final updateForm = currentState as UpdateFormMixin;
      if (!updateForm.initialLoaded) {
        log('${currentState.runtimeType}.initialLoaded is false. So this call back will be ignore');
        return currentState.status as ProviderStatus<T>;
      }
    }

    final updatedState = currentState.updateStatus(ProviderStatus<T>.inProgress());
    state = AsyncValue.data(updatedState);

    final result = await ProviderStatus.guard(() async => await callback(updatedState));
    final finalState = updatedState.updateStatus(result);
    state = AsyncValue.data(finalState);
    final updatedStatus = finalState.status as ProviderStatus<T>;

    if (isFailure && onFailure != null) {
      final failure = finalState.status.failure;
      if (failure != null) onFailure(failure);
    }

    if (isSuccess && onSuccess != null) {
      final success = finalState.status.successOrNull;
      if (success != null) onSuccess(success as T);
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
    final updatedState = state;

    if (state.isFailure && onFailure != null) {
      final failure = state.failure;
      if (failure != null) onFailure(failure);
    }

    if (state.isSuccess && onSuccess != null) {
      final success = state.successOrNull;
      if (success != null) onSuccess(success);
    }

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
    if (ignoreInSuccessState && isSuccess) {
      return state.status as ProviderStatus<T>;
    }

    /// If current provider mixin with [UpdateFormMixin]. Ignore it action when initialLoaded flag is false
    if (state is UpdateFormMixin) {
      final updateForm = state as UpdateFormMixin;
      if (!updateForm.initialLoaded) {
        log('${state.runtimeType}.initialLoaded is false. So this call back will be ignore');
        return state.status as ProviderStatus<T>;
      }
    }

    state = state.updateStatus(ProviderStatus<T>.inProgress());

    final result = await ProviderStatus.guard(() async => await callback(state));
    state = state.updateStatus(result);
    final updatedStatus = state.status as ProviderStatus<T>;

    if (isFailure && onFailure != null) {
      final failure = state.status.failure;
      if (failure != null) onFailure(failure);
    }

    if (isSuccess && onSuccess != null) {
      final success = state.status.successOrNull;
      if (success != null) onSuccess(success as T);
    }

    return updatedStatus;
  }
}
