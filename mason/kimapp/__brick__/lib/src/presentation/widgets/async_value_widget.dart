import '../../../exports.dart';
import 'my_error_widget.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.error,
    this.loading,
    this.useScaffold = false,
    this.useAnimation = true,
    this.skipLoadingOnReload = false,
    this.skipLoadingOnRefresh = false,
  });

  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Widget Function(Object, StackTrace?)? error;
  final Widget Function()? loading;
  final bool useAnimation;

  /// Display error or loading page as scaffold. Give background color...
  final bool useScaffold;

  final bool skipLoadingOnReload;
  final bool skipLoadingOnRefresh;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: (value) {
        final child = data(value);
        if (useAnimation) {
          return FadeIn(child: child);
        }
        return child;
      },
      error: error ?? (e, _) => MyErrorWidget(error: e),
      loading: loading ?? () => const Center(child: CircularProgressIndicator()),
      skipLoadingOnRefresh: skipLoadingOnRefresh,
      skipLoadingOnReload: skipLoadingOnReload,
    );
  }
}

extension AsyncUI<T> on AsyncValue<T> {
  Widget onData(
    Widget Function(T data) onData, {
    Widget Function()? loadingWidget,
    bool skipLoadingOnReload = false,
    bool skipLoadingOnRefresh = true,
  }) {
    return AsyncValueWidget(
      value: this,
      data: onData,
      loading: loadingWidget,
      skipLoadingOnRefresh: skipLoadingOnRefresh,
      skipLoadingOnReload: skipLoadingOnReload,
    );
  }
}
