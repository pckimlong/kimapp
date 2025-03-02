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
  
  const content = `import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/helpers/logger.dart';
import '../i_${snakeCaseName}_repo.dart';
import '../params/${snakeCaseName}_list_param.dart';
import '../${snakeCaseName}_schema.schema.dart';

part '${snakeCaseName}_list_pagination_provider.g.dart';

const int _page${pascalCaseName}Limit = 25;

@riverpod
class ${pascalCaseName}ListPagination extends _$${pascalCaseName}ListPagination with LoggerMixin {
  @override
  FutureOr<IList<${pascalCaseName}Model>> build({
    required int page,
    required ${pascalCaseName}ListParam param,
  }) async {
    _log('Building page $page with params: $param');

    ref.onDispose(() {
      _log('Disposing page $page');
      ${pascalCaseName}PaginationTracker.instance.untrackPage(page, param);
    });

    const limit = _page${pascalCaseName}Limit;
    final offset = page * limit;

    try {
      await Future.delayed(const Duration(milliseconds: 250));
      final result = await ref
          .watch(${camelCaseName}RepoProvider)
          .findPagination(limit: limit, offset: offset, param: param);

      return result.fold(
        (error) {
          _log('Error loading page $page: $error');
          return result.getOrThrow();
        },
        (items) {
          ref.cacheTime(const Duration(minutes: 5));

          ${pascalCaseName}PaginationTracker.instance.trackMultiple${pascalCaseName}s(
            items.map((e) => e.id).toList(),
            page,
            param,
          );

          _log('Loaded \${items.length} ${camelCaseName}s for page $page');
          return items;
        },
      );
    } catch (e) {
      _log('Unexpected error loading page $page: $e');
      throw Exception('Failed to load ${camelCaseName}s: $e');
    }
  }

  void _log(String message) {
    logDebug('[${pascalCaseName}ListPagination] $message');
  }

  void _updateItem(${pascalCaseName}Model item) {
    state = state.whenData((value) => value.updateById([item], (e) => e.id == item.id));
  }

  void _addItem(${pascalCaseName}Model item) {
    state = state.whenData((value) => value.add(item));
  }

  void _removeItem(${pascalCaseName}Id id) {
    state = state.whenData((value) => value.removeWhere((e) => e.id == id));
  }

  void _removeAt(int index) {
    state = state.whenData((value) => value.removeAt(index));
  }
}

@riverpod
PaginatedItem<${pascalCaseName}Model>? ${camelCaseName}PaginatedAtIndex(
  Ref ref,
  int index, {
  required ${pascalCaseName}ListParam param,
}) {
  const limit = _page${pascalCaseName}Limit;
  final page = index ~/ limit;
  final pageItems = ref.watch(${camelCaseName}ListPaginationProvider(page: page, param: param));
  final hasNextPage = ref.exists(${camelCaseName}ListPaginationProvider(page: page + 1, param: param));
  return PaginatedItem.build(
    pageItems: pageItems,
    limit: limit,
    index: index,
    showLoadingInAllItem: hasNextPage,
  );
}

/// Tracks paginated items, we can't use with add, because it might has issue with param filter
class ${pascalCaseName}PaginationTracker {
  static final ${pascalCaseName}PaginationTracker instance = ${pascalCaseName}PaginationTracker._();
  ${pascalCaseName}PaginationTracker._();

  final _items = <${pascalCaseName}Id, Set<(int page, ${pascalCaseName}ListParam param)>>{};

  void track${pascalCaseName}(${pascalCaseName}Id id, int page, ${pascalCaseName}ListParam param) {
    _items.putIfAbsent(id, () => {}).add((page, param));
  }

  void trackMultiple${pascalCaseName}s(List<${pascalCaseName}Id> ids, int page, ${pascalCaseName}ListParam param) {
    for (final id in ids) {
      track${pascalCaseName}(id, page, param);
    }
  }

  void untrackPage(int page, ${pascalCaseName}ListParam param) {
    for (final entries in _items.values) {
      entries.remove((page, param));
    }
    _items.removeWhere((_, entries) => entries.isEmpty);
  }

  List<(int page, ${pascalCaseName}ListParam param)> getEntriesFor${pascalCaseName}(${pascalCaseName}Id id) {
    return _items[id]?.toList() ?? [];
  }

  void clear() {
    _items.clear();
  }

  void invalidateVisibleItems(Ref ref, {required ${pascalCaseName}ListParam param, int visibleItemCount = 50}) {
    final visiblePages = (visibleItemCount / _page${pascalCaseName}Limit).ceil();

    for (int page = 0; page < visiblePages; page++) {
      if (ref.exists(${camelCaseName}ListPaginationProvider(page: page, param: param))) {
        ref.invalidate(${camelCaseName}ListPaginationProvider(page: page, param: param));
      }
    }
  }

  void updatePaginatedItem(Ref ref, ${pascalCaseName}Model item) {
    for (final entry in getEntriesFor${pascalCaseName}(item.id)) {
      ref
          .read(${camelCaseName}ListPaginationProvider(page: entry.$1, param: entry.$2).notifier)
          ._updateItem(item);
    }
  }

  void deletePaginatedItem(Ref ref, ${pascalCaseName}Id id, {int invalidateOnLength = 1}) {
    final entries = getEntriesFor${pascalCaseName}(id);
    if (entries.isEmpty) return;

    if (entries.length == invalidateOnLength) {
      ref.invalidate(${camelCaseName}ListPaginationProvider);
      return;
    }

    final sortedEntries = entries.toList()..sort((a, b) => a.$1.compareTo(b.$1));

    final entriesByParam = <${pascalCaseName}ListParam, List<int>>{};
    for (final entry in sortedEntries) {
      entriesByParam.putIfAbsent(entry.$2, () => []).add(entry.$1);
    }

    for (final param in entriesByParam.keys) {
      final pages = entriesByParam[param]!..sort();

      for (final page in pages) {
        ref.read(${camelCaseName}ListPaginationProvider(page: page, param: param).notifier)._removeItem(id);
      }

      final highestPage = pages.last;

      _shiftItemsAfterDeletion(ref, highestPage, param);
    }
  }

  void _shiftItemsAfterDeletion(Ref ref, int startPage, ${pascalCaseName}ListParam param) {
    for (var page = startPage + 1;
        ref.exists(${camelCaseName}ListPaginationProvider(page: page, param: param));
        page++) {
      final nextPageItems =
          ref.read(${camelCaseName}ListPaginationProvider(page: page, param: param)).valueOrNull;

      if (nextPageItems == null || nextPageItems.isEmpty) break;

      final firstItem = nextPageItems.first;
      ref.read(${camelCaseName}ListPaginationProvider(page: page, param: param).notifier)._removeAt(0);

      if (ref.exists(${camelCaseName}ListPaginationProvider(page: page - 1, param: param))) {
        ref
            .read(${camelCaseName}ListPaginationProvider(page: page - 1, param: param).notifier)
            ._addItem(firstItem);
      }

      if (nextPageItems.length <= 1) break;
    }
  }

  void updateMultiplePaginatedItems(Ref ref, List<${pascalCaseName}Model> items) {
    final updatesByPage = <(int, ${pascalCaseName}ListParam), List<${pascalCaseName}Model>>{};

    for (final item in items) {
      final entries = getEntriesFor${pascalCaseName}(item.id);
      for (final entry in entries) {
        updatesByPage.putIfAbsent(entry, () => []).add(item);
      }
    }

    for (final entry in updatesByPage.entries) {
      final (page, param) = entry.key;
      final updates = entry.value;

      if (updates.length > _page${pascalCaseName}Limit / 2) {
        ref.invalidate(${camelCaseName}ListPaginationProvider(page: page, param: param));
      } else {
        for (final item in updates) {
          ref.read(${camelCaseName}ListPaginationProvider(page: page, param: param).notifier)._updateItem(item);
        }
      }
    }
  }
}

@riverpod
class ${pascalCaseName}PaginationState extends _$${pascalCaseName}PaginationState {
  @override
  ({bool isLoading, int totalPages, int currentPage}) build({required ${pascalCaseName}ListParam param}) {
    bool isLoading = false;
    int highestLoadedPage = 0;

    for (int i = 0; i < 10; i++) {
      final pageState = ref.watch(${camelCaseName}ListPaginationProvider(page: i, param: param));
      if (pageState.isLoading) {
        isLoading = true;
      }
      if (!pageState.hasError && pageState.hasValue) {
        highestLoadedPage = i;
      }
    }

    return (
      isLoading: isLoading,
      totalPages: highestLoadedPage + 1,
      currentPage: highestLoadedPage,
    );
  }
}`;

  await fs.writeFile(path.join(providersPath, `${snakeCaseName}_list_pagination_provider.dart`), content);
}

module.exports = {
  generateListPaginationProviderFile,
}; 