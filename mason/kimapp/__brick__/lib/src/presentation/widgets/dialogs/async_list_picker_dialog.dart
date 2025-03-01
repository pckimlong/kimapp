import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dartx/dartx_io.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/helpers/build_context_helper.dart';
import '../../app/app_style.dart';
import '../app_widgets.dart';
import '../feedback/async_value_widget.dart';
import '../forms/search_field.dart';
import 'base_dialog.dart';

typedef DefaultAsyncListPickerItemBuilder<T> = Widget Function(
  BuildContext context,
  ({T item, bool isSelected}) state,
);

typedef AsyncListPickerItemBuilder<T> = Widget Function(
  BuildContext context,
  WidgetRef ref,
  ({
    T item,
    bool isSelected,
    int index,
    VoidCallback? onTap,
  }) others,
);

class AsyncListPickerDialog<T, I> extends HookConsumerWidget {
  const AsyncListPickerDialog({
    super.key,
    required this.title,
    required this.multiSelect,
    required this.fetchItems,
    required this.idSelector,
    this.displaySelector,
    this.selectedId = const [],
    this.filter,
    this.onSearch,
    this.onEmptyBuilder,
    this.onRefresh,
    this.itemBuilder,
    this.itemLeadingBuilder,
    this.itemSubtitleBuilder,
    this.itemTitleBuilder,
    this.autofocusTextField = false,
    this.onAddNewPressed,
  }) : assert(
          displaySelector != null || itemBuilder != null || itemTitleBuilder != null,
          'One of displaySelector, itemBuilder, or itemTitleBuilder must be provided',
        );

  final bool autofocusTextField;
  final bool Function(T item, String query)? onSearch;
  final List<I> selectedId;
  final I Function(T item) idSelector;
  final String Function(T item)? displaySelector;
  final bool Function(T item)? filter;
  final AsyncValue<Iterable<T>> Function(BuildContext context, WidgetRef ref) fetchItems;
  final bool multiSelect;
  final Widget Function(String query)? onEmptyBuilder;
  final Widget title;
  final Future<void> Function()? onRefresh;
  final AsyncListPickerItemBuilder<T>? itemBuilder;
  final DefaultAsyncListPickerItemBuilder<T>? itemTitleBuilder;
  final DefaultAsyncListPickerItemBuilder<T>? itemLeadingBuilder;
  final DefaultAsyncListPickerItemBuilder<T>? itemSubtitleBuilder;
  final VoidCallback? onAddNewPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = fetchItems(context, ref);
    final searchString = useState('');
    final selectedState = useState<IList<I>>(selectedId.lock);
    final listContent = listAsync.onData(
      (data) {
        final filteredItems = data.where((e) {
          if (filter != null && !filter!(e)) return false;
          if (searchString.value.isBlank) return true;
          if (onSearch == null) return true;

          final search = searchString.value.toLowerCase();
          return onSearch!(e, search);
        }).toList();

        if (filteredItems.isEmpty) {
          return onEmptyBuilder?.call(searchString.value) ??
              const Center(
                child: Text('No Item'),
              );
        }

        return ListView.separated(
          separatorBuilder: (context, index) => Divider(height: 1, thickness: 0.5),
          itemCount: filteredItems.length,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemBuilder: (context, index) {
            final item = filteredItems[index];
            final isSelected = selectedState.value.contains(idSelector(item));

            if (itemBuilder != null) {
              return itemBuilder!(
                context,
                ref,
                (
                  item: item,
                  isSelected: isSelected,
                  index: index,
                  onTap: () {
                    _onItemPressed(isSelected, selectedState, item, context);
                  }
                ),
              );
            }

            final state = (item: item, isSelected: isSelected);

            return DefaultAsyncListItem(
              onTap: () => _onItemPressed(isSelected, selectedState, item, context),
              isSelected: isSelected,
              multiSelect: multiSelect,
              title: itemTitleBuilder?.call(context, state) ?? Text(displaySelector!(item)),
              subtitle: itemSubtitleBuilder?.call(context, state),
              leading: itemLeadingBuilder?.call(context, state),
            );
          },
        );
      },
    );

    final multiSelectButton = FilledButton(
      child: Text('Select (${selectedState.value.length})'),
      onPressed: () async {
        final items = listAsync.requireValue;
        final selectedItems = items.where((e) => selectedState.value.contains(idSelector(e)));
        context.maybePop(selectedItems.toList());
      },
    );

    return BaseDialog(
      title: title,
      showDivider: onSearch == null,
      content: Column(
        children: [
          if (onSearch != null) ...[
            SearchField(
              onChanged: (value) => searchString.value = value,
              autofocus: autofocusTextField,
            ),
            AS.hGap16,
          ],
          if (multiSelect) ...[
            MultiListSelectionDivider(
              label: 'Selected',
              selectedCount: selectedState.value.length,
              onClearAllPressed: () {
                selectedState.value = selectedState.value.clear();
              },
            ),
            AS.hGap4,
          ],
          Expanded(
            child: onRefresh != null
                ? RefreshIndicator(
                    onRefresh: onRefresh!,
                    child: listContent,
                  )
                : listContent,
          ),
        ],
      ),
      actions: [
        if (onAddNewPressed != null && !multiSelect)
          SizedBox(
            width: AS.mobileBreakpoint,
            child: FilledButton(
              onPressed: onAddNewPressed!,
              child: const Text('Add New'),
            ),
          ),
        if (multiSelect)
          SizedBox(
            width: AS.mobileBreakpoint,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (onAddNewPressed != null) ...[
                  OutlinedButton(
                    onPressed: onAddNewPressed!,
                    child: const Text('Add New'),
                  ),
                  AS.wGap12,
                ],
                Expanded(child: multiSelectButton),
              ],
            ),
          ),
      ],
    );
  }

  void _onItemPressed(
    bool isSelected,
    ValueNotifier<IList<dynamic>> selectedState,
    item,
    BuildContext context,
  ) {
    if (multiSelect) {
      if (isSelected) {
        selectedState.value = selectedState.value.remove(idSelector(item));
      } else {
        selectedState.value = selectedState.value.add(idSelector(item));
      }
    } else {
      context.maybePop(item);
    }
  }
}

class DefaultAsyncListItem extends StatelessWidget {
  const DefaultAsyncListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
    this.isSelected = false,
    this.multiSelect = false,
    this.leading,
  });

  final Widget? leading;

  final bool multiSelect;
  final Widget title;
  final Widget? subtitle;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      sidePadding: 8,
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: multiSelect
          ? Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              color: context.theme.colorScheme.primary,
            )
          : isSelected
              ? Icon(Icons.check, color: context.theme.colorScheme.primary)
              : null,
      onTap: onTap,
      selected: isSelected && !multiSelect,
    );
  }
}
