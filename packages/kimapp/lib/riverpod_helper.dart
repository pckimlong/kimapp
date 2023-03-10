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
}

extension ProviderStatusX on ProviderStatus {
  bool get isInitial => whenOrNull(initial: () => true) == true;
  bool get isInProgress => whenOrNull(inProgress: () => true) == true;
  bool get isSuccess => whenOrNull(success: (_) => true) == true;
  bool get isFailure => whenOrNull(failure: (_) => true) == true;

  AsyncValue<T> toAsyncValue<T>({T Function()? onInitial}) {
    return when(
      initial: () => onInitial == null ? const AsyncValue.loading() : AsyncValue.data(onInitial()),
      inProgress: () => const AsyncValue.loading(),
      failure: (failure) => failure.toAsyncError(),
      success: (value) => AsyncValue.data(value),
    );
  }
}

mixin ProviderStatusClassMixin<T> {
  ProviderStatus<T> get status;
}
