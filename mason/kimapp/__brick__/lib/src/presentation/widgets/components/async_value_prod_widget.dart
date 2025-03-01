import 'package:flutter/material.dart';
import 'package:kimapp_utils/kimapp_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../feedback/my_error_widget.dart';

// Similar to async value widget, but this for production, where sometime we might need to hide error
class AsyncValueProdWidget<T> extends StatelessWidget {
  const AsyncValueProdWidget({
    super.key,
    required this.value,
    required this.data,
    required this.loadingOrError,
    this.skipLoadingOnReload = false,
    this.skipLoadingOnRefresh = true,
  });

  final AsyncValue<T> value;
  final Widget Function(Object? error) loadingOrError;
  final Widget Function(T value) data;
  final bool skipLoadingOnReload;
  final bool skipLoadingOnRefresh;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (error, _) {
        if (integrationMode.isRelease) {
          return loadingOrError(error);
        }

        return Center(child: MyErrorWidget(error: error));
      },
      loading: () => loadingOrError(null),
      skipLoadingOnReload: skipLoadingOnReload,
      skipLoadingOnRefresh: skipLoadingOnRefresh,
    );
  }
}

extension AsyncUIProd<T> on AsyncValue<T> {
  Widget onDataProd({
    required Widget Function(T data) onData,
    required Widget Function(Object? error) loadingOrError,
    bool skipLoadingOnReload = false,
    bool skipLoadingOnRefresh = true,
  }) {
    return AsyncValueProdWidget(
      value: this,
      data: onData,
      loadingOrError: loadingOrError,
      skipLoadingOnRefresh: skipLoadingOnRefresh,
      skipLoadingOnReload: skipLoadingOnReload,
    );
  }
}
