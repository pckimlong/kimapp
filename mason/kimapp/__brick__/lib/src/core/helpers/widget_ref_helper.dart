import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';

extension ProviderStatusRefX on WidgetRef {
  void listenStatus<T>(
    ProviderListenable<ProviderStatus<T>> provider, {
    void Function(T value)? onSuccess,
    void Function(Failure failure)? onError,
    void Function()? onProgressing,
    bool useAlerter = true,
    bool showLoading = true,
  }) {
    listen<ProviderStatus<T>>(
      provider,
      (previous, next) {
        if (next.isSuccess) {}
      },
    );
  }

  void listenStatusClass<C, T>(
    ProviderListenable<ProviderStatusClassMixin<C, T>> provider, {
    void Function(T value)? onSuccess,
    void Function(Failure failure)? onError,
    void Function()? onProgressing,
    bool useAlerter = true,
    bool showLoading = true,
  }) {
    listen<ProviderStatusClassMixin<C, T>>(
      provider,
      (previous, next) {},
    );
  }
}
