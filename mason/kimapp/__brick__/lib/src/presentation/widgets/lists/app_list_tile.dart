import 'package:flutter/material.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.height,
    this.absorbGestures = false,
    this.selected = false,
    this.selectedColor,
    this.contentPadding,
    this.sidePadding,
  });

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final double? height;
  final bool absorbGestures;
  final EdgeInsets? contentPadding;
  final bool selected;
  final Color? selectedColor;
  final double? sidePadding;

  Widget? _selectionOverride(BuildContext context, Widget? child) {
    if (child == null) return null;
    return DefaultTextStyle.merge(
      style: TextStyle(
        color: selected ? selectedColor ?? Theme.of(context).primaryColor : null,
        fontWeight: selected ? FontWeight.bold : null,
      ),
      child: IconTheme(
        data: IconThemeData(
          color: selected ? selectedColor ?? Theme.of(context).primaryColor : null,
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: AbsorbPointer(
        absorbing: absorbGestures,
        child: ListTile(
          title: _selectionOverride(context, title),
          subtitle: subtitle != null ? _selectionOverride(context, subtitle) : null,
          leading: leading != null ? _selectionOverride(context, leading) : null,
          trailing: trailing != null ? _selectionOverride(context, trailing) : null,
          onTap: onTap,
          selected: selected,
          selectedColor: selectedColor,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(
                horizontal: sidePadding ?? 16.0,
                vertical: 4.0,
              ),
        ),
      ),
    );
  }
}
