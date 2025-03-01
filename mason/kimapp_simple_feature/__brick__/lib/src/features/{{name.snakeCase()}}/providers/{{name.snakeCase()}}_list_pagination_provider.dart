import 'package:book_swap/src/core/helpers/logger.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../i_{{name.snakeCase()}}_repo.dart';
import '../params/{{name.snakeCase()}}_list_param.dart';
import '../{{name.snakeCase()}}_schema.schema.dart';

part '{{name.snakeCase()}}_list_pagination_provider.g.dart';

const int _page{{name.pascalCase()}}Limit = 25;

@riverpod
class {{name.pascalCase()}}ListPagination extends _${{name.pascalCase()}}ListPagination with LoggerMixin {
  @override
  FutureOr<IList<{{name.pascalCase()}}Model>> build({
    required int page,
    required {{name.pascalCase()}}ListParam param,
  }) async {
    _log('Building page $page with params: $param');

    ref.onDispose(() {
      _log('Disposing page $page');
      {{name.pascalCase()}}PaginationTracker.instance.untrackPage(page, param);
    });

    const limit = _page{{name.pascalCase()}}Limit;
    final offset = page * limit;

    try {
      await Future.delayed(const Duration(milliseconds: 250));
      final result = await ref
          .watch({{name.camelCase()}}RepoProvider)
          .findPagination(limit: limit, offset: offset, param: param);

      return result.fold(
        (error) {
          _log('Error loading page $page: $error');
          return result.getOrThrow();
        },
        (list) {
          ref.cacheTime(const Duration(minutes: 5));

          {{name.pascalCase()}}PaginationTracker.instance.trackMultiple{{name.pascalCase()}}s(
            list.map((e) => e.id).toList(),
            page,
            param,
          );

          _log('Loaded ${list.length} {{name.camelCase()}}s for page $page');
          return list;
        },
      );
    } catch (e) {
      _log('Unexpected error loading page $page: $e');
      throw Exception('Failed to load {{name.camelCase()}}s: $e');
    }
  }

  void _log(String message) {
    logDebug('[{{name.pascalCase()}}ListPagination] $message');
  }

  void _updateItem({{name.pascalCase()}}Model item) {
    state = state.whenData((value) => value.updateById([item], (e) => e.id == item.id));
  }

  void _addItem({{name.pascalCase()}}Model item) {
    state = state.whenData((value) => value.add(item));
  }

  void _removeItem({{name.pascalCase()}}Id id) {
    state = state.whenData((value) => value.removeWhere((e) => e.id == id));
  }

  void _removeAt(int index) {
    state = state.whenData((value) => value.removeAt(index));
  }
}

@riverpod
PaginatedItem<{{name.pascalCase()}}Model>? {{name.camelCase()}}PaginatedAtIndex(
  Ref ref,
  int index, {
  required {{name.pascalCase()}}ListParam param,
}) {
  const limit = _page{{name.pascalCase()}}Limit;
  final page = index ~/ limit;
  final pageItems = ref.watch({{name.camelCase()}}ListPaginationProvider(page: page, param: param));
  final hasNextPage = ref.exists({{name.camelCase()}}ListPaginationProvider(page: page + 1, param: param));
  return PaginatedItem.build(
    pageItems: pageItems,
    limit: limit,
    index: index,
    showLoadingInAllItem: hasNextPage,
  );
}

/// Tracks paginated items, we can't use with add, because it might has issue with param filter
class {{name.pascalCase()}}PaginationTracker {
  static final {{name.pascalCase()}}PaginationTracker instance = {{name.pascalCase()}}PaginationTracker._();
  {{name.pascalCase()}}PaginationTracker._();

  final _items = <{{name.pascalCase()}}Id, Set<(int page, {{name.pascalCase()}}ListParam param)>>{};

  void track{{name.pascalCase()}}({{name.pascalCase()}}Id id, int page, {{name.pascalCase()}}ListParam param) {
    _items.putIfAbsent(id, () => {}).add((page, param));
  }

  void trackMultiple{{name.pascalCase()}}s(List<{{name.pascalCase()}}Id> ids, int page, {{name.pascalCase()}}ListParam param) {
    for (final id in ids) {
      track{{name.pascalCase()}}(id, page, param);
    }
  }

  void untrackPage(int page, {{name.pascalCase()}}ListParam param) {
    for (final entries in _items.values) {
      entries.remove((page, param));
    }
    _items.removeWhere((_, entries) => entries.isEmpty);
  }

  List<(int page, {{name.pascalCase()}}ListParam param)> getEntriesFor{{name.pascalCase()}}({{name.pascalCase()}}Id id) {
    return _items[id]?.toList() ?? [];
  }

  void clear() {
    _items.clear();
  }

  void invalidateVisibleItems(Ref ref, {required {{name.pascalCase()}}ListParam param, int visibleItemCount = 50}) {
    final visiblePages = (visibleItemCount / _page{{name.pascalCase()}}Limit).ceil();

    for (int page = 0; page < visiblePages; page++) {
      if (ref.exists({{name.camelCase()}}ListPaginationProvider(page: page, param: param))) {
        ref.invalidate({{name.camelCase()}}ListPaginationProvider(page: page, param: param));
      }
    }
  }

  void updatePaginatedItem(Ref ref, {{name.pascalCase()}}Model item) {
    for (final entry in getEntriesFor{{name.pascalCase()}}(item.id)) {
      ref
          .read({{name.camelCase()}}ListPaginationProvider(page: entry.$1, param: entry.$2).notifier)
          ._updateItem(item);
    }
  }

  void deletePaginatedItem(Ref ref, {{name.pascalCase()}}Id id, {int invalidateOnLength = 1}) {
    final entries = getEntriesFor{{name.pascalCase()}}(id);
    if (entries.isEmpty) return;

    if (entries.length == invalidateOnLength) {
      ref.invalidate({{name.camelCase()}}ListPaginationProvider);
      return;
    }

    final sortedEntries = entries.toList()..sort((a, b) => a.$1.compareTo(b.$1));

    final entriesByParam = <{{name.pascalCase()}}ListParam, List<int>>{};
    for (final entry in sortedEntries) {
      entriesByParam.putIfAbsent(entry.$2, () => []).add(entry.$1);
    }

    for (final param in entriesByParam.keys) {
      final pages = entriesByParam[param]!..sort();

      for (final page in pages) {
        ref.read({{name.camelCase()}}ListPaginationProvider(page: page, param: param).notifier)._removeItem(id);
      }

      final highestPage = pages.last;

      _shiftItemsAfterDeletion(ref, highestPage, param);
    }
  }

  void _shiftItemsAfterDeletion(Ref ref, int startPage, {{name.pascalCase()}}ListParam param) {
    for (var page = startPage + 1;
        ref.exists({{name.camelCase()}}ListPaginationProvider(page: page, param: param));
        page++) {
      final nextPageItems =
          ref.read({{name.camelCase()}}ListPaginationProvider(page: page, param: param)).valueOrNull;

      if (nextPageItems == null || nextPageItems.isEmpty) break;

      final firstItem = nextPageItems.first;
      ref.read({{name.camelCase()}}ListPaginationProvider(page: page, param: param).notifier)._removeAt(0);

      if (ref.exists({{name.camelCase()}}ListPaginationProvider(page: page - 1, param: param))) {
        ref
            .read({{name.camelCase()}}ListPaginationProvider(page: page - 1, param: param).notifier)
            ._addItem(firstItem);
      }

      if (nextPageItems.length <= 1) break;
    }
  }

  void updateMultiplePaginatedItems(Ref ref, List<{{name.pascalCase()}}Model> items) {
    final updatesByPage = <(int, {{name.pascalCase()}}ListParam), List<{{name.pascalCase()}}Model>>{};

    for (final item in items) {
      final entries = getEntriesFor{{name.pascalCase()}}(item.id);
      for (final entry in entries) {
        updatesByPage.putIfAbsent(entry, () => []).add(item);
      }
    }

    for (final entry in updatesByPage.entries) {
      final (page, param) = entry.key;
      final updates = entry.value;

      if (updates.length > _page{{name.pascalCase()}}Limit / 2) {
        ref.invalidate({{name.camelCase()}}ListPaginationProvider(page: page, param: param));
      } else {
        for (final item in updates) {
          ref.read({{name.camelCase()}}ListPaginationProvider(page: page, param: param).notifier)._updateItem(item);
        }
      }
    }
  }
}

@riverpod
class {{name.pascalCase()}}PaginationState extends _${{name.pascalCase()}}PaginationState {
  @override
  ({bool isLoading, int totalPages, int currentPage}) build({required {{name.pascalCase()}}ListParam param}) {
    bool isLoading = false;
    int highestLoadedPage = 0;

    for (int i = 0; i < 10; i++) {
      final pageState = ref.watch({{name.camelCase()}}ListPaginationProvider(page: i, param: param));
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
}
