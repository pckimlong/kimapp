// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_internal_member

import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';
// ignore: implementation_imports
import 'package:riverpod/src/notifier.dart';

import 'object/failure.dart';

part "riverpod_helper.freezed.dart";

// Helper for pagination with riverpod

@freezed
class PaginatedItem<T> with _$PaginatedItem<T> {
  const PaginatedItem._();

  const factory PaginatedItem.data(T item) = _Data;
  const factory PaginatedItem.loading() = _Loading;
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
        if (itemIndexInPage == 0) return const PaginatedItem.loading();
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
  T? get successOrNull => whenOrNull<T>(success: id);

  Failure? get failure => whenOrNull(failure: id);
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

extension CatchProvider on AutoDisposeRef {
  void catchTime(Duration duration) {
    final cancel = keepAlive();
    final timer = Timer(duration, cancel.close);
    onDispose(timer.cancel);
  }
}

extension AuthInvalidateX on Ref {
  void autoInvalidateSelf(Duration duration) {
    final timer = Timer(duration, invalidateSelf);
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
    if (state.isFailure && onFailure != null) onFailure(state.whenOrNull(failure: id)!);
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

    state = state.updateStatus(ProviderStatus<T>.inProgress());
    state = state.updateStatus(await ProviderStatus.guard<T>(() async => await callback(state)));
    final updatedStatus = state.status as ProviderStatus<T>;
    if (isFailure && onFailure != null) {
      onFailure(state.status.whenOrNull(failure: id)!);
    }
    if (isSuccess && onSuccess != null) {
      onSuccess(state.status.successOrNull as T);
    }
    return updatedStatus;
  }
}
