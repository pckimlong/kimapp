const fs = require('fs-extra');
const path = require('path');
const { toPascalCase, toCamelCase } = require('../../utils/helpers');

/**
 * Generate a list pagination provider file for a feature
 * @param {string} providersPath - The path to the providers directory
 * @param {string} name - The feature name in snake_case
 * @returns {Promise<void>}
 */
async function generateListPaginationProviderFile(providersPath, name) {
  const pascalCaseName = toPascalCase(name);
  const camelCaseName = toCamelCase(name);
  const snakeCaseName = name; // Already in snake case
  
  const content = `import 'package:autoverpod/autoverpod.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kimapp_utils/kimapp_utils.dart';

import '../i_${snakeCaseName}_repo.dart';
import '../params/${snakeCaseName}_list_param.dart';
import '../${snakeCaseName}_schema.schema.dart';

part '${snakeCaseName}_list_pagination_provider.g.dart';

@stateWidget
@riverpod
class ${pascalCaseName}ListPagination extends _$${pascalCaseName}ListPagination {
  static const int _limit = 20;

  @override
  FutureOr<PaginationState<${pascalCaseName}Model>> build(${pascalCaseName}ListParam param) {
    return _fetchPage(0, param);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchPage(0, param));
  }

  Future<void> fetchNextPage() async {
    final currentState = state.valueOrNull;
    if (currentState == null || !currentState.canLoadMore) return;

    state = AsyncData(currentState.copyWith(isLoadingMore: true));

    final nextPageState = await _fetchPage(currentState.items.length, param);

    state = AsyncData(
      currentState.copyWith(
        items: currentState.items.addAll(nextPageState.items),
        isLoadingMore: false,
        canLoadMore: nextPageState.canLoadMore,
      ),
    );
  }

  Future<PaginationState<${pascalCaseName}Model>> _fetchPage(
    int offset,
    ${pascalCaseName}ListParam param,
  ) async {
    final result = await ref.read(${camelCaseName}RepoProvider).findPagination(
          limit: _limit,
          offset: offset,
          param: param,
        );

    return result.fold(
      (failure) => throw failure,
      (items) => PaginationState(
        items: items,
        canLoadMore: items.length >= _limit,
        isLoadingMore: false,
      ),
    );
  }
}

@stateWidget
@riverpod
class ${pascalCaseName}ListPaginationController extends _$${pascalCaseName}ListPaginationController {
  @override
  ${pascalCaseName}ListParam build() {
    return const ${pascalCaseName}ListParam();
  }

  void updateParam(${pascalCaseName}ListParam param) {
    state = param;
  }
}

class ${pascalCaseName}PaginationListView extends HookConsumerWidget {
  const ${pascalCaseName}PaginationListView({
    super.key,
    this.controller,
    this.emptyBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.itemBuilder,
    this.separatorBuilder,
    this.param = const ${pascalCaseName}ListParam(),
    this.onRefresh,
    this.physics,
    this.padding,
    this.shrinkWrap = false,
  });

  final ScrollController? controller;
  final Widget Function(BuildContext context)? emptyBuilder;
  final Widget Function(BuildContext context, Object error, StackTrace stackTrace)?
      errorBuilder;
  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context, ${pascalCaseName}Model item, int index)? itemBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final ${pascalCaseName}ListParam param;
  final Future<void> Function()? onRefresh;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Update param
    ref.read(${pascalCaseName}ListPaginationControllerProvider.notifier).updateParam(param);

    final paramState = ref.watch(${pascalCaseName}ListPaginationControllerProvider);
    final paginationState = ref.watch(${pascalCaseName}ListPaginationProvider(paramState));

    ref.listen(${pascalCaseName}ListPaginationProvider(paramState), (previous, next) {
      if (previous?.valueOrNull != null &&
          next.valueOrNull != null &&
          previous!.valueOrNull!.items.length != next.valueOrNull!.items.length) {
        // Items changed, scroll to top
        controller?.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    return paginationState.when(
      data: (data) {
        if (data.items.isEmpty) {
          return emptyBuilder?.call(context) ??
              const Center(child: Text('No items found'));
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollEndNotification) {
              if (notification.metrics.pixels >= notification.metrics.maxScrollExtent - 200) {
                ref
                    .read(${pascalCaseName}ListPaginationProvider(paramState).notifier)
                    .fetchNextPage();
              }
            }
            return false;
          },
          child: RefreshIndicator.adaptive(
            onRefresh: () async {
              await ref
                  .read(${pascalCaseName}ListPaginationProvider(paramState).notifier)
                  .refresh();
              await onRefresh?.call();
            },
            child: ListView.separated(
              controller: controller,
              physics: physics,
              padding: padding,
              shrinkWrap: shrinkWrap,
              itemCount: data.items.length + (data.isLoadingMore ? 1 : 0),
              separatorBuilder: separatorBuilder ?? (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                if (index >= data.items.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                }

                final item = data.items[index];
                return itemBuilder?.call(context, item, index) ??
                    ListTile(title: Text(item.toString()));
              },
            ),
          ),
        );
      },
      loading: () => loadingBuilder?.call(context) ??
          const Center(child: CircularProgressIndicator.adaptive()),
      error: (error, stack) => errorBuilder?.call(context, error, stack) ??
          Center(child: Text(\`Error: \${error}\`)),
    );
  }
}

class PaginationState<T> {
  final IList<T> items;
  final bool canLoadMore;
  final bool isLoadingMore;

  const PaginationState({
    required this.items,
    required this.canLoadMore,
    required this.isLoadingMore,
  });

  PaginationState<T> copyWith({
    IList<T>? items,
    bool? canLoadMore,
    bool? isLoadingMore,
  }) {
    return PaginationState<T>(
      items: items ?? this.items,
      canLoadMore: canLoadMore ?? this.canLoadMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}`;

  await fs.writeFile(path.join(providersPath, `${snakeCaseName}_list_pagination_provider.dart`), content);
}

module.exports = {
  generateListPaginationProviderFile,
}; 