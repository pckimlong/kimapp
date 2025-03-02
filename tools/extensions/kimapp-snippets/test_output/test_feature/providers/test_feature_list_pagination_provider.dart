import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/helpers/logger.dart';
import '../i_test_feature_repo.dart';
import '../params/test_feature_list_param.dart';
import '../test_feature_schema.schema.dart';

part 'test_feature_list_pagination_provider.g.dart';

const int _pageTestFeatureLimit = 25;

@riverpod
class TestFeatureListPagination extends _$TestFeatureListPagination with LoggerMixin {
  @override
  FutureOr<IList<TestFeatureModel>> build({
    required int page,
    required TestFeatureListParam param,
  }) async {
    _log('Building page $page with params: $param');

    ref.onDispose(() {
      _log('Disposing page $page');
      TestFeaturePaginationTracker.instance.untrackPage(page, param);
    });

    const limit = _pageTestFeatureLimit;
    final offset = page * limit;

    try {
      await Future.delayed(const Duration(milliseconds: 250));
      final result = await ref
          .watch(testFeatureRepoProvider)
          .findPagination(limit: limit, offset: offset, param: param);

      return result.fold(
        (error) {
          _log('Error loading page $page: $error');
          return result.getOrThrow();
        },
        (items) {
          ref.cacheTime(const Duration(minutes: 5));

          TestFeaturePaginationTracker.instance.trackMultipleTestFeatures(
            items.map((e) => e.id).toList(),
            page,
            param,
          );

          _log('Loaded ${items.length} testFeatures for page $page');
          return items;
        },
      );
    } catch (e) {
      _log('Unexpected error loading page $page: $e');
      throw Exception('Failed to load testFeatures: $e');
    }
  }

  void _log(String message) {
    logDebug('[TestFeatureListPagination] $message');
  }

  void _updateItem(TestFeatureModel item) {
    state = state.whenData((value) => value.updateById([item], (e) => e.id == item.id));
  }

  void _addItem(TestFeatureModel item) {
    state = state.whenData((value) => value.add(item));
  }

  void _removeItem(TestFeatureId id) {
    state = state.whenData((value) => value.removeWhere((e) => e.id == id));
  }

  void _removeAt(int index) {
    state = state.whenData((value) => value.removeAt(index));
  }
}

@riverpod
PaginatedItem<TestFeatureModel>? testFeaturePaginatedAtIndex(
  Ref ref,
  int index, {
  required TestFeatureListParam param,
}) {
  const limit = _pageTestFeatureLimit;
  final page = index ~/ limit;
  final pageItems = ref.watch(testFeatureListPaginationProvider(page: page, param: param));
  final hasNextPage = ref.exists(testFeatureListPaginationProvider(page: page + 1, param: param));
  return PaginatedItem.build(
    pageItems: pageItems,
    limit: limit,
    index: index,
    showLoadingInAllItem: hasNextPage,
  );
}

/// Tracks paginated items, we can't use with add, because it might has issue with param filter
class TestFeaturePaginationTracker {
  static final TestFeaturePaginationTracker instance = TestFeaturePaginationTracker._();
  TestFeaturePaginationTracker._();

  final _items = <TestFeatureId, Set<(int page, TestFeatureListParam param)>>{};

  void trackTestFeature(TestFeatureId id, int page, TestFeatureListParam param) {
    _items.putIfAbsent(id, () => {}).add((page, param));
  }

  void trackMultipleTestFeatures(List<TestFeatureId> ids, int page, TestFeatureListParam param) {
    for (final id in ids) {
      trackTestFeature(id, page, param);
    }
  }

  void untrackPage(int page, TestFeatureListParam param) {
    for (final entries in _items.values) {
      entries.remove((page, param));
    }
    _items.removeWhere((_, entries) => entries.isEmpty);
  }

  List<(int page, TestFeatureListParam param)> getEntriesForTestFeature(TestFeatureId id) {
    return _items[id]?.toList() ?? [];
  }

  void clear() {
    _items.clear();
  }

  void invalidateVisibleItems(Ref ref, {required TestFeatureListParam param, int visibleItemCount = 50}) {
    final visiblePages = (visibleItemCount / _pageTestFeatureLimit).ceil();

    for (int page = 0; page < visiblePages; page++) {
      if (ref.exists(testFeatureListPaginationProvider(page: page, param: param))) {
        ref.invalidate(testFeatureListPaginationProvider(page: page, param: param));
      }
    }
  }

  void updatePaginatedItem(Ref ref, TestFeatureModel item) {
    for (final entry in getEntriesForTestFeature(item.id)) {
      ref
          .read(testFeatureListPaginationProvider(page: entry.$1, param: entry.$2).notifier)
          ._updateItem(item);
    }
  }

  void deletePaginatedItem(Ref ref, TestFeatureId id, {int invalidateOnLength = 1}) {
    final entries = getEntriesForTestFeature(id);
    if (entries.isEmpty) return;

    if (entries.length == invalidateOnLength) {
      ref.invalidate(testFeatureListPaginationProvider);
      return;
    }

    final sortedEntries = entries.toList()..sort((a, b) => a.$1.compareTo(b.$1));

    final entriesByParam = <TestFeatureListParam, List<int>>{};
    for (final entry in sortedEntries) {
      entriesByParam.putIfAbsent(entry.$2, () => []).add(entry.$1);
    }

    for (final param in entriesByParam.keys) {
      final pages = entriesByParam[param]!..sort();

      for (final page in pages) {
        ref.read(testFeatureListPaginationProvider(page: page, param: param).notifier)._removeItem(id);
      }

      final highestPage = pages.last;

      _shiftItemsAfterDeletion(ref, highestPage, param);
    }
  }

  void _shiftItemsAfterDeletion(Ref ref, int startPage, TestFeatureListParam param) {
    for (var page = startPage + 1;
        ref.exists(testFeatureListPaginationProvider(page: page, param: param));
        page++) {
      final nextPageItems =
          ref.read(testFeatureListPaginationProvider(page: page, param: param)).valueOrNull;

      if (nextPageItems == null || nextPageItems.isEmpty) break;

      final firstItem = nextPageItems.first;
      ref.read(testFeatureListPaginationProvider(page: page, param: param).notifier)._removeAt(0);

      if (ref.exists(testFeatureListPaginationProvider(page: page - 1, param: param))) {
        ref
            .read(testFeatureListPaginationProvider(page: page - 1, param: param).notifier)
            ._addItem(firstItem);
      }

      if (nextPageItems.length <= 1) break;
    }
  }

  void updateMultiplePaginatedItems(Ref ref, List<TestFeatureModel> items) {
    final updatesByPage = <(int, TestFeatureListParam), List<TestFeatureModel>>{};

    for (final item in items) {
      final entries = getEntriesForTestFeature(item.id);
      for (final entry in entries) {
        updatesByPage.putIfAbsent(entry, () => []).add(item);
      }
    }

    for (final entry in updatesByPage.entries) {
      final (page, param) = entry.key;
      final updates = entry.value;

      if (updates.length > _pageTestFeatureLimit / 2) {
        ref.invalidate(testFeatureListPaginationProvider(page: page, param: param));
      } else {
        for (final item in updates) {
          ref.read(testFeatureListPaginationProvider(page: page, param: param).notifier)._updateItem(item);
        }
      }
    }
  }
}

@riverpod
class TestFeaturePaginationState extends _$TestFeaturePaginationState {
  @override
  ({bool isLoading, int totalPages, int currentPage}) build({required TestFeatureListParam param}) {
    bool isLoading = false;
    int highestLoadedPage = 0;

    for (int i = 0; i < 10; i++) {
      final pageState = ref.watch(testFeatureListPaginationProvider(page: i, param: param));
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