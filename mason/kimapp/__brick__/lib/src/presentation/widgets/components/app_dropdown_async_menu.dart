import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/app_dropdown_menu.dart';

class AppDropdownAsyncMenu<T> extends StatelessWidget {
  const AppDropdownAsyncMenu({
    super.key,
    this.selected,
    required this.getItems,
    this.label,
    this.hintText,
    this.onSelected,
    this.itemToString,
    this.width,
    this.enabled = true,
    this.menuHeight,
    this.clearButton = true,
    this.leading,
  });

  final T? selected;
  final AsyncValue<Iterable<T>> Function() getItems;
  final String? label;
  final String? hintText;
  final void Function(T? value)? onSelected;
  final String Function(T item)? itemToString;
  final double? width;
  final bool enabled;
  final double? menuHeight;
  final bool clearButton;
  final Widget? leading;
  @override
  Widget build(BuildContext context) {
    final itemsAsync = getItems();

    return AppDropdownMenu<T>(
      selected: selected,
      leading: leading,
      enabled: itemsAsync.hasValue && enabled,
      items: itemsAsync.valueOrNull ?? [],
      trailing: !itemsAsync.hasValue ? Center(child: CircularProgressIndicator()) : null,
      itemToString: itemToString,
      onSelected: onSelected,
      width: width,
      menuHeight: menuHeight,
      hintText: hintText,
      clearButton: clearButton,
    );
  }
}
