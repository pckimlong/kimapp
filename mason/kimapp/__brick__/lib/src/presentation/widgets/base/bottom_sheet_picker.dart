import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moon_design/moon_design.dart';

import '../../app/app_style.dart';

class BottomSheetPicker<T> extends HookConsumerWidget {
  const BottomSheetPicker({
    super.key,
    this.selected,
    required this.items,
    this.title,
    this.itemBuilder,
    this.itemToString,
  });

  final T? selected;
  final List<T> items;
  final String? title;
  final Widget Function(BuildContext context, T item)? itemBuilder;
  final String Function(T item)? itemToString;

  static Future<T?> show<T>(
    BuildContext context, {
    required List<T> items,
    String? title,
    T? selected,
    Widget Function(BuildContext context, T item)? itemBuilder,
    String Function(T item)? itemToString,
  }) async {
    final result = await showMoonModalBottomSheet<T>(
      context: context,
      builder: (context) => BottomSheetPicker<T>(
        title: title,
        selected: selected,
        items: items,
        itemBuilder: itemBuilder,
        itemToString: itemToString,
      ),
    );
    return result;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag indicator
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          if (title != null) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
              child: Text(
                title!,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Divider(
              height: 1,
              color: theme.colorScheme.outlineVariant,
            ),
          ],
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 400, // Limit max height
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.only(
                top: title != null ? 8 : 16,
                bottom: 16,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isSelected = item == selected;

                return itemBuilder?.call(context, item) ??
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 4,
                      ),
                      title: Text(
                        itemToString?.call(item) ?? item.toString(),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color:
                              isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                          fontWeight: isSelected ? FontWeight.w500 : null,
                        ),
                      ),
                      trailing: isSelected
                          ? Icon(
                              Icons.check,
                              color: theme.colorScheme.primary,
                              size: 20,
                            )
                          : null,
                      onTap: () => Navigator.of(context).pop(item),
                    );
              },
            ),
          ),
          AS.hGap16, // Bottom padding
        ],
      ),
    );
  }
}
