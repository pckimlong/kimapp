import 'package:flutter/widgets.dart';
import 'package:moon_design/moon_design.dart';

import '../../../core/helpers/build_context_helper.dart';

/// Similar to list tile
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
        color: selected ? context.primaryColor : null,
        fontWeight: selected ? FontWeight.bold : null,
      ),
      child: IconTheme(
        data: context.theme.iconTheme.copyWith(
          color: selected ? context.primaryColor : null,
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final value = context.moonTheme?.menuItemTheme.properties.padding;

    return MoonMenuItem(
      height: height,
      onTap: onTap,
      label: _selectionOverride(context, title)!,
      content: subtitle,
      leading: _selectionOverride(context, leading),
      trailing: _selectionOverride(context, trailing),
      horizontalGap: value!.horizontal / 2,
      absorbGestures: absorbGestures,
      menuItemPadding: contentPadding ??
          EdgeInsets.symmetric(
            horizontal: sidePadding != null ? sidePadding! : value.horizontal / 2,
            vertical: value.vertical / 4,
          ),
    );
  }
}
