import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';

extension AsyncValueStatus<T> on AsyncValue<T>? {
  ProviderStatus<T> toProviderStatus() {
    if (this == null) return ProviderStatus.initial();

    return this!.when(
      data: (data) => ProviderStatus.success(data),
      error: (error, stack) {
        Failure failure;
        if (error is Failure) {
          failure = error;
        } else {
          failure = Failure.exception(
            FailureInfo(stackTrace: stack, debugMessage: error.toString()),
          );
        }
        return ProviderStatus.failure(failure);
      },
      loading: () => ProviderStatus.inProgress(),
    );
  }
}
