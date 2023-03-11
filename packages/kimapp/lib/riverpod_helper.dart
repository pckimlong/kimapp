// ignore_for_file: invalid_use_of_protected_member

import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';

import 'object/failure.dart';

part "riverpod_helper.freezed.dart";

@freezed
class ProviderStatus<T> with _$ProviderStatus<T> {
  const factory ProviderStatus.initial() = _Initial;
  const factory ProviderStatus.inProgress() = _InProgress;
  const factory ProviderStatus.failure(Failure failure) = _Failure;
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
}

mixin ProviderStatusClassMixin<T> {
  ProviderStatus<T> get status;
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

extension ProviderStatusClassProviderX<T> on NotifierProviderRef<ProviderStatusClassMixin<T>> {
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

extension ProviderStatusNotifierX<T> on AutoDisposeNotifier<ProviderStatus<T>> {
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
  }) async {
    if (state.isInProgress || state.isSuccess) return state;
    state = const ProviderStatus.inProgress();
    state = await ProviderStatus.guard(() => callback(state));
    if (state.isFailure && onFailure != null) onFailure(state.whenOrNull(failure: id)!);
    return state;
  }
}
