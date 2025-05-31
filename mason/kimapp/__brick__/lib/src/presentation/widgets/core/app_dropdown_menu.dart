import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../app/app_style.dart';
import '../components/field_clear_button.dart';
import 'app_icon.dart';
import 'app_list_tile.dart';
import 'app_text_form_field.dart';

class AppDropdownMenu<T> extends StatefulWidget {
  const AppDropdownMenu({
    super.key,
    this.selected,
    required this.items,
    this.label,
    this.hintText,
    this.onSelected,
    this.itemToString,
    this.width,
    this.enabled = true,
    this.menuHeight,
    this.clearButton = false,
    this.leading,
    this.trailing,
    this.itemBuilder,
    this.itemLeadingBuilder,
    this.itemTrailingBuilder,
    this.itemSubtitleBuilder,
    this.helper,
  });

  final T? selected;
  final Iterable<T> items;
  final String? label;
  final String? hintText;
  final void Function(T? value)? onSelected;
  final String Function(T item)? itemToString;
  final double? width;
  final bool enabled;
  final double? menuHeight;
  final Widget? leading;
  final Widget? trailing;
  final Widget? helper;

  /// If true, there will be clear button when selected
  final bool clearButton;
  final Widget Function(BuildContext context, T item, bool selected, VoidCallback onTap)?
      itemBuilder;
  final Widget Function(BuildContext context, T item, bool selected)? itemLeadingBuilder;
  final Widget Function(BuildContext context, T item, bool selected)? itemTrailingBuilder;
  final Widget Function(BuildContext context, T item, bool selected)? itemSubtitleBuilder;

  @override
  State<AppDropdownMenu> createState() => _AppDropdownMenuState<T>();
}

class _AppDropdownMenuState<T> extends State<AppDropdownMenu<T>> {
  late final TextEditingController _controller;
  bool _show = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.selected != null
          ? widget.itemToString?.call(widget.selected as T) ?? widget.selected.toString()
          : null,
    );
  }

  @override
  void didUpdateWidget(covariant AppDropdownMenu<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected != oldWidget.selected) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (widget.selected != null) {
          _controller.text =
              widget.itemToString?.call(widget.selected as T) ?? widget.selected.toString();
        } else {
          _controller.clear();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showClearButton = widget.selected != null && widget.clearButton;

    return MoonDropdown(
      show: _show,
      constrainWidthToChild: true,
      borderRadius: context.moonBorders?.interactiveSm,
      onTapOutside: () => setState(() => _show = false),
      content: SingleChildScrollView(
        child: Column(
          children: widget.items.map(
            (item) {
              final selected = widget.selected == item;

              if (widget.itemBuilder != null) {
                return widget.itemBuilder!(context, item, selected, () {
                  _onItemTapped(item);
                });
              }

              return AppListTile(
                absorbGestures: false,
                selected: selected,
                height: widget.menuHeight,
                leading: widget.itemLeadingBuilder?.call(context, item, selected),
                trailing: widget.itemTrailingBuilder?.call(context, item, selected),
                subtitle: widget.itemSubtitleBuilder?.call(context, item, selected),
                title: Text(widget.itemToString?.call(item) ?? item.toString()),
                onTap: () {
                  _onItemTapped(item);
                },
              );
            },
          ).toList(),
        ),
      ),
      child: AppTextFormField(
        leading: widget.leading,
        enabled: widget.enabled,
        onTap: () => setState(() => _show = !_show),
        controller: _controller,
        width: widget.width,
        inactiveBorderColor: _show ? context.moonColors?.piccolo : null,
        canRequestFocus: false,
        readOnly: true,
        hintText: widget.hintText,
        mouseCursor: MouseCursor.defer,
        trailing: showClearButton
            ? FieldClearButton(
                onPressed: () {
                  widget.onSelected?.call(null);
                  _controller.clear();
                },
              )
            : widget.trailing ??
                Center(
                  child: AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: _show ? -0.5 : 0,
                    child: AppIcon(AS.fieldChevyDown),
                  ),
                ),
        helper: widget.helper,
      ),
    );
  }

  void _onItemTapped(item) {
    widget.onSelected?.call(item);
    _controller.text = widget.itemToString?.call(item) ?? item.toString();
    setState(() {
      _show = false;
    });
  }
}
