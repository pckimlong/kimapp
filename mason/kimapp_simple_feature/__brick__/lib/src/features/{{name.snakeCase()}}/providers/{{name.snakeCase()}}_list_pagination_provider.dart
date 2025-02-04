import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../{{name.snakeCase()}}_schema.schema.dart';
import '../i_{{name.snakeCase()}}_repo.dart';

part '{{name.snakeCase()}}_list_pagination_provider.g.dart';

const int _page{{name.pascalCase()}}Limit = 25;

@riverpod
class {{name.pascalCase()}}ListPagination extends _${{name.pascalCase()}}ListPagination {
  @override
  FutureOr<IList<{{name.pascalCase()}}Model>> build({
    required int page,
    required {{name.pascalCase()}}ListParam param,
  }) async {
    ref.onDispose(() => {{name.pascalCase()}}PaginationTracker.instance.untrackPage(page, param));
    const limit = _page{{name.pascalCase()}}Limit;
    final offset = page * limit;

    await Future.delayed(const Duration(milliseconds: 250));
    final result = await ref
        .watch({{name.camelCase()}}RepoProvider)
        .findPagination(limit: limit, offset: offset, param: param);

    return result.fold(
      (_) => result.getOrThrow(),
      (list) {
        ref.cacheTime(const Duration(minutes: 1));
        {{name.pascalCase()}}PaginationTracker.instance.trackMultiple{{name.pascalCase()}}s(
          list.map((e) => e.id).toList(),
          page,
          param,
        );
        return list;
      },
    );
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
  // Likely scroll backward
  final hasNextPage = ref.exists({{name.camelCase()}}ListPaginationProvider(page: page + 1, param: param));
  return PaginatedItem.build(pageItems: pageItems, limit: limit, index: index, showLoadingInAllItem: hasNextPage,);
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
    // Cleanup empty entries
    _items.removeWhere((_, entries) => entries.isEmpty);
  }

  List<(int page, {{name.pascalCase()}}ListParam param)> getEntriesFor{{name.pascalCase()}}({{name.pascalCase()}}Id id) {
    return _items[id]?.toList() ?? [];
  }

  void clear() {
    _items.clear();
  }

  /// Invalidate only visible items, since we use cache, the cache pagination will be more that we need
  /// I will use some trick to invalidate only visible items base on [{{name.camelCase()}}PaginatedAtIndex] which is not cached
  void invalidateVisibleItems(Ref ref) {}

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

    // If there family param length is equal to the invalidate length, it will perform an invalidate instead of side-effect
    if (entries.length == invalidateOnLength) {
      ref.invalidate({{name.camelCase()}}ListPaginationProvider);
      return;
    }

    // Sort entries by page to find affected pages
    final sortedEntries = entries.toList()..sort((a, b) => a.$1.compareTo(b.$1));

    for (final entry in sortedEntries) {
      // Remove item from current page
      ref
          .read({{name.camelCase()}}ListPaginationProvider(page: entry.$1, param: entry.$2).notifier)
          ._removeItem(id);

      // Find and invalidate all subsequent pages with same param
      final currentPage = entry.$1;
      final param = entry.$2;

      // Invalidate all higher page numbers for this param
      for (var page = currentPage + 1;
          ref.exists({{name.camelCase()}}ListPaginationProvider(page: page, param: param));
          page++) {
        // shift item up
        final firstItem = ref
            .read({{name.camelCase()}}ListPaginationProvider(page: page, param: param))
            .valueOrNull
            ?.firstOrNull;

        if (firstItem == null) continue;

        ref
            .read({{name.camelCase()}}ListPaginationProvider(page: page, param: param).notifier)
            ._removeAt(0);

        if (ref.exists({{name.camelCase()}}ListPaginationProvider(page: page - 1, param: param))) {
          ref
              .read({{name.camelCase()}}ListPaginationProvider(page: page - 1, param: param).notifier)
              ._addItem(firstItem);
        }
      }
    }
  }
}

