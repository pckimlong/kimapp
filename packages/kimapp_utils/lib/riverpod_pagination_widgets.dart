import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimapp/kimapp.dart';

typedef PaginatedItemBuilder<T> = Widget Function(int index, T data);

/// A pagination-enabled ListView that integrates with Riverpod for data fetching and state management.
///
/// This widget extends ConsumerWidget to work with Riverpod and provides built-in support for:
/// - Loading states with customizable loading indicators
/// - External item injection at specific positions
/// - Index adjustment for data fetching
/// - Custom data fetching through Riverpod providers
///
/// Example usage:
/// ```dart
/// RiverpodPaginationListView<Product>(
///   loading: isLoading,
///   getData: (ref, index) => ref.watch(productProvider(index)),
///   loadingItemBuilder: (index, isFirstItem) => ProductLoadingTile(),
///   itemBuilder: (index, product) => ProductTile(product: product),
/// )
/// ```
class RiverpodPaginationListView<T> extends ConsumerWidget {
  /// Creates a RiverpodPaginationListView.
  const RiverpodPaginationListView({
    super.key,
    this.padding = const EdgeInsets.all(0),
    this.loading = false,
    this.loadingItemCount = 20,
    required this.getData,
    required this.loadingItemBuilder,
    required this.itemBuilder,
    this.physics,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.shrinkWrap = false,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.semanticChildCount,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.externalItems = const {},
    this.adjustDataIndex = true,
  });

  /// Whether the list is in a loading state.
  ///
  /// When true, the list will:
  /// - Display loading indicators instead of actual items
  /// - Show [loadingItemCount] number of loading indicators
  /// - Disable scrolling by applying [NeverScrollableScrollPhysics]
  final bool loading;

  /// The number of loading indicators to show when [loading] is true.
  ///
  /// Defaults to 20 items.
  final int loadingItemCount;

  /// Padding for the entire ListView.
  ///
  /// Defaults to EdgeInsets.all(0).
  final EdgeInsets padding;

  /// Builder function for loading indicator items.
  ///
  /// Parameters:
  /// - [index]: The position in the list
  /// - [isFirstItem]: Whether this is the first item in a loading batch
  ///
  /// This builder is called when:
  /// - [loading] is true
  /// - When waiting for data from [getData]
  final Widget Function(int index, bool isFirstItem) loadingItemBuilder;

  /// Builder function for list items.
  ///
  /// Parameters:
  /// - [index]: The position in the list (adjusted for external items if [adjustDataIndex] is true)
  /// - [data]: The data item of type T
  final PaginatedItemBuilder<T> itemBuilder;

  /// Function to fetch paginated data using Riverpod.
  ///
  /// Parameters:
  /// - [ref]: The WidgetRef for accessing providers
  /// - [index]: The current item index (adjusted for external items if [adjustDataIndex] is true)
  ///
  /// Should return a PaginatedItem<T> that represents the loading state or data.
  final PaginatedItem<T>? Function(WidgetRef ref, int index) getData;

  /// Map of indices to widget builders for injecting external items into the list.
  ///
  /// Use this to insert non-paginated items at specific positions in the list.
  /// The key is the position where the item should appear, and the value is a
  /// builder function that creates the widget.
  ///
  /// Example:
  /// ```dart
  /// externalItems: {
  ///   0: (context) => HeaderWidget(),
  ///   5: (context) => AdvertisementBanner(),
  /// }
  /// ```
  final Map<int, Widget Function(BuildContext context)> externalItems;

  /// Whether to adjust the data fetch index based on external items.
  ///
  /// When true, the index passed to [getData] will be adjusted to account for
  /// external items, ensuring consistent data fetching regardless of injected items.
  ///
  /// Example:
  /// If you have external items at positions 0 and 2:
  /// - Visual index 3 will fetch data index 1
  /// - Visual index 5 will fetch data index 3
  final bool adjustDataIndex;

  // Standard ListView properties
  final ScrollPhysics? physics;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final bool shrinkWrap;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final int? semanticChildCount;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;

  /// Calculate the actual data index considering external items
  int _getDataIndex(int viewIndex) {
    if (!adjustDataIndex) return viewIndex;
    return viewIndex - externalItems.keys.where((position) => position <= viewIndex).length;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      padding: padding,
      itemCount: loading ? loadingItemCount : null,
      physics: loading ? const NeverScrollableScrollPhysics() : physics,
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
      primary: primary,
      shrinkWrap: shrinkWrap,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      keyboardDismissBehavior: keyboardDismissBehavior,
      restorationId: restorationId,
      clipBehavior: clipBehavior,
      itemBuilder: (context, index) {
        if (loading) {
          return loadingItemBuilder(index, false);
        }

        // Check if there's an external item at this index
        if (externalItems.containsKey(index)) {
          return externalItems[index]!(context);
        }

        // Adjust the index for data fetching if needed
        final dataIndex = _getDataIndex(index);
        final paginated = getData(ref, dataIndex);

        return paginated?.whenOrNull(
          loading: (isFirstItem) => loadingItemBuilder(dataIndex, isFirstItem),
          data: (data) => itemBuilder(dataIndex, data),
        );
      },
    );
  }
}

class RiverpodPaginationSliverList<T> extends ConsumerWidget {
  const RiverpodPaginationSliverList({
    super.key,
    this.loading = false,
    this.loadingItemCount = 20,
    required this.getData,
    required this.loadingItemBuilder,
    required this.itemBuilder,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.semanticIndexOffset = 0,
    this.externalItems = const {},
    this.adjustDataIndex = true,
  });

  final bool loading;
  final int loadingItemCount;
  final Widget Function(int index, bool isFirstItem) loadingItemBuilder;
  final PaginatedItemBuilder<T> itemBuilder;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final int semanticIndexOffset;
  final Map<int, Widget Function(BuildContext context)> externalItems;
  final bool adjustDataIndex;

  final PaginatedItem<T>? Function(WidgetRef ref, int index) getData;

  /// Calculate the actual data index considering external items
  int _getDataIndex(int viewIndex) {
    if (!adjustDataIndex) return viewIndex;
    return viewIndex - externalItems.keys.where((position) => position <= viewIndex).length;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (loading) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: loadingItemCount,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          itemBuilder: (context, index) => loadingItemBuilder(index, false),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          // Check if there's an external item at this index
          if (externalItems.containsKey(index)) {
            return externalItems[index]!(context);
          }

          // Adjust the index for data fetching if needed
          final dataIndex = _getDataIndex(index);
          final paginated = getData(ref, dataIndex);

          return paginated?.whenOrNull(
            loading: (isFirstItem) => loadingItemBuilder(dataIndex, isFirstItem),
            data: (data) => itemBuilder(index, data),
          );
        },
        childCount: loading ? loadingItemCount : null,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        semanticIndexOffset: semanticIndexOffset,
      ),
    );
  }
}

class RiverpodPaginationGrid<T> extends ConsumerWidget {
  const RiverpodPaginationGrid({
    super.key,
    this.padding = const EdgeInsets.all(0),
    this.loading = false,
    this.loadingItemCount = 20,
    required this.getData,
    required this.gridDelegate,
    required this.loadingItemBuilder,
    required this.itemBuilder,
    this.physics,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.shrinkWrap = false,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.semanticChildCount,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.externalItems = const {},
    this.adjustDataIndex = true,
  });

  final bool loading;
  final int loadingItemCount;
  final EdgeInsets padding;
  final Widget Function(int index, bool isFirstItem) loadingItemBuilder;
  final PaginatedItemBuilder<T> itemBuilder;
  final SliverGridDelegate gridDelegate;
  final ScrollPhysics? physics;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final bool shrinkWrap;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final int? semanticChildCount;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;
  final Map<int, Widget Function(BuildContext context)> externalItems;
  final bool adjustDataIndex;

  final PaginatedItem<T>? Function(WidgetRef ref, int index) getData;

  /// Calculate the actual data index considering external items
  int _getDataIndex(int viewIndex) {
    if (!adjustDataIndex) return viewIndex;
    return viewIndex - externalItems.keys.where((position) => position <= viewIndex).length;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      padding: padding,
      gridDelegate: gridDelegate,
      itemCount: loading ? loadingItemCount : null,
      physics: loading ? const NeverScrollableScrollPhysics() : physics,
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
      primary: primary,
      shrinkWrap: shrinkWrap,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      keyboardDismissBehavior: keyboardDismissBehavior,
      restorationId: restorationId,
      clipBehavior: clipBehavior,
      itemBuilder: (context, index) {
        if (loading) {
          return loadingItemBuilder(index, false);
        }

        // Check if there's an external item at this index
        if (externalItems.containsKey(index)) {
          return externalItems[index]!(context);
        }

        // Adjust the index for data fetching if needed
        final dataIndex = _getDataIndex(index);
        final paginated = getData(ref, dataIndex);

        return paginated?.whenOrNull(
          loading: (isFirstItem) => loadingItemBuilder(dataIndex, isFirstItem),
          data: (category) => itemBuilder(dataIndex, category),
        );
      },
    );
  }
}

class RiverpodPaginationSliverGrid<T> extends ConsumerWidget {
  const RiverpodPaginationSliverGrid({
    super.key,
    this.loading = false,
    this.loadingItemCount = 20,
    required this.getData,
    required this.gridDelegate,
    required this.loadingItemBuilder,
    required this.itemBuilder,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.semanticIndexOffset = 0,
    this.externalItems = const {},
    this.adjustDataIndex = true,
  });

  final bool loading;
  final int loadingItemCount;
  final Widget Function(int index, bool isFirstItem) loadingItemBuilder;
  final PaginatedItemBuilder<T> itemBuilder;
  final SliverGridDelegate gridDelegate;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final int semanticIndexOffset;
  final Map<int, Widget Function(BuildContext context)> externalItems;
  final bool adjustDataIndex;

  final PaginatedItem<T>? Function(WidgetRef ref, int index) getData;

  /// Calculate the actual data index considering external items
  int _getDataIndex(int viewIndex) {
    if (!adjustDataIndex) return viewIndex;
    return viewIndex - externalItems.keys.where((position) => position <= viewIndex).length;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (loading) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          gridDelegate: gridDelegate,
          itemCount: loadingItemCount,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          itemBuilder: (context, index) => loadingItemBuilder(index, false),
        ),
      );
    }

    return SliverGrid(
      gridDelegate: gridDelegate,
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          // Check if there's an external item at this index
          if (externalItems.containsKey(index)) {
            return externalItems[index]!(context);
          }

          // Adjust the index for data fetching if needed
          final dataIndex = _getDataIndex(index);
          final paginated = getData(ref, dataIndex);

          return paginated?.whenOrNull(
            loading: (isFirstItem) => loadingItemBuilder(dataIndex, isFirstItem),
            data: (data) => itemBuilder(index, data),
          );
        },
        childCount: loading ? loadingItemCount : null,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        semanticIndexOffset: semanticIndexOffset,
      ),
    );
  }
}

class RiverpodPaginationCustomGrid<T> extends ConsumerWidget {
  const RiverpodPaginationCustomGrid({
    super.key,
    this.padding = const EdgeInsets.all(0),
    this.loading = false,
    this.loadingItemCount = 20,
    required this.getData,
    required this.gridDelegate,
    required this.loadingItemBuilder,
    required this.itemBuilder,
    this.physics,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.shrinkWrap = false,
    this.cacheExtent,
    this.semanticChildCount,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.externalItems = const {},
    this.adjustDataIndex = true,
  });

  final bool loading;
  final int loadingItemCount;
  final EdgeInsets padding;
  final Widget Function(int index, bool isFirstItem) loadingItemBuilder;
  final PaginatedItemBuilder<T> itemBuilder;
  final SliverGridDelegate gridDelegate;
  final ScrollPhysics? physics;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final bool shrinkWrap;
  final double? cacheExtent;
  final int? semanticChildCount;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;
  final Map<int, Widget Function(BuildContext context)> externalItems;
  final bool adjustDataIndex;

  final PaginatedItem<T>? Function(WidgetRef ref, int index) getData;

  /// Calculate the actual data index considering external items
  int _getDataIndex(int viewIndex) {
    if (!adjustDataIndex) return viewIndex;
    return viewIndex - externalItems.keys.where((position) => position <= viewIndex).length;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (loading) {
      return GridView.custom(
        padding: padding,
        gridDelegate: gridDelegate,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => loadingItemBuilder(index, false),
          childCount: loadingItemCount,
          addAutomaticKeepAlives: true,
          addRepaintBoundaries: true,
          addSemanticIndexes: true,
        ),
      );
    }

    return GridView.custom(
      padding: padding,
      gridDelegate: gridDelegate,
      childrenDelegate: SliverChildBuilderDelegate(
        childCount: loading ? loadingItemCount : null,
        (context, index) {
          // Check if there's an external item at this index
          if (externalItems.containsKey(index)) {
            return externalItems[index]!(context);
          }

          // Adjust the index for data fetching if needed
          final dataIndex = _getDataIndex(index);
          final paginated = getData(ref, dataIndex);

          return paginated?.whenOrNull(
            loading: (isFirstItem) => loadingItemBuilder(dataIndex, isFirstItem),
            data: (data) => itemBuilder(index, data),
          );
        },
      ),
      physics: loading ? const NeverScrollableScrollPhysics() : physics,
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
      primary: primary,
      shrinkWrap: shrinkWrap,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      keyboardDismissBehavior: keyboardDismissBehavior,
      restorationId: restorationId,
      clipBehavior: clipBehavior,
    );
  }
}

class RiverpodPaginationCustom<T> extends ConsumerWidget {
  const RiverpodPaginationCustom({
    super.key,
    this.loading = false,
    this.loadingItemCount = 20,
    required this.getData,
    required this.loadingItemBuilder,
    required this.itemBuilder,
    this.externalItems = const {},
    this.adjustDataIndex = true,
    required this.builder,
  });

  final bool loading;
  final int loadingItemCount;
  final Widget Function(int index, bool isFirstItem) loadingItemBuilder;
  final PaginatedItemBuilder<T> itemBuilder;
  final Map<int, Widget Function(BuildContext context)> externalItems;
  final bool adjustDataIndex;
  final PaginatedItem<T>? Function(WidgetRef ref, int index) getData;

  /// Calculate the actual data index considering external items
  int _getDataIndex(int viewIndex) {
    if (!adjustDataIndex) return viewIndex;
    return viewIndex - externalItems.keys.where((position) => position <= viewIndex).length;
  }

  final Widget Function(
    BuildContext context,
    bool loading,
    int? itemCount,
    Widget? Function(int index) getItem,
  ) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemCount = loading ? loadingItemCount : null;

    return builder(
      context,
      loading,
      itemCount,
      (index) {
        if (loading) {
          return loadingItemBuilder(index, false);
        }
        // Check if there's an external item at this index
        if (externalItems.containsKey(index)) {
          return externalItems[index]!(context);
        }

        // Adjust the index for data fetching if needed
        final dataIndex = _getDataIndex(index);
        final paginated = getData(ref, dataIndex);

        return paginated?.whenOrNull(
          loading: (isFirstItem) => loadingItemBuilder(dataIndex, isFirstItem),
          data: (data) => itemBuilder(index, data),
        );
      },
    );
  }
}
