import 'package:flutter/material.dart';

/// Base class for all navigation items
abstract class NavItem<T> {
  const NavItem();

  /// Whether this item can be selected
  bool get isSelectable => false;

  /// Get the value if it's a selectable item, null otherwise
  T? get itemValue => null;

  /// Whether this item has children
  bool get hasChildren => false;

  /// Get children items if any
  List<NavItem<T>> get children => const [];
}

/// A standard navigation item with icon and label
class StandardNavItem<T> extends NavItem<T> {
  const StandardNavItem({
    required this.value,
    required this.label,
    required this.icon,
    this.selectedIcon,
    this.badge,
    this.subtitle,
    this.trailing,
    this.enabled = true,
    this.tooltipText,
  });

  final T value;
  final String label;
  final IconData icon;
  final IconData? selectedIcon;
  final Widget? badge;
  final Widget? subtitle;
  final Widget? trailing;
  final bool enabled;
  final String? tooltipText;

  @override
  bool get isSelectable => true;

  @override
  T get itemValue => value;
}

/// A custom widget item that can be inserted into the navigation
class CustomNavItem<T> extends NavItem<T> {
  const CustomNavItem({
    required this.child,
    this.maintainState = true,
    this.showDividers = false,
  });

  final Widget child;
  final bool maintainState;
  final bool showDividers;

  @override
  T? get itemValue => null;
}

/// A collapsible navigation item that can contain child items
class CollapsibleNavItem<T> extends NavItem<T> {
  const CollapsibleNavItem({
    required this.label,
    required this.icon,
    required this.childItems,
    this.initiallyExpanded = false,
    this.enabled = true,
  });

  final String label;
  final IconData icon;
  final List<StandardNavItem<T>> childItems;
  final bool initiallyExpanded;
  final bool enabled;

  @override
  bool get hasChildren => true;

  @override
  List<NavItem<T>> get children => childItems;
}

/// Configuration for text styles in different states
class NavArtisanTextStyle {
  const NavArtisanTextStyle({
    this.selectedStyle,
    this.unselectedStyle,
    this.disabledStyle,
    this.collapsibleHeaderStyle,
    this.childItemStyle,
  });

  final TextStyle? selectedStyle;
  final TextStyle? unselectedStyle;
  final TextStyle? disabledStyle;
  final TextStyle? collapsibleHeaderStyle;
  final TextStyle? childItemStyle;

  NavArtisanTextStyle copyWith({
    TextStyle? selectedStyle,
    TextStyle? unselectedStyle,
    TextStyle? disabledStyle,
    TextStyle? collapsibleHeaderStyle,
    TextStyle? childItemStyle,
  }) {
    return NavArtisanTextStyle(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      unselectedStyle: unselectedStyle ?? this.unselectedStyle,
      disabledStyle: disabledStyle ?? this.disabledStyle,
      collapsibleHeaderStyle: collapsibleHeaderStyle ?? this.collapsibleHeaderStyle,
      childItemStyle: childItemStyle ?? this.childItemStyle,
    );
  }

  NavArtisanTextStyle merge(NavArtisanTextStyle? other) {
    if (other == null) return this;
    return copyWith(
      selectedStyle: other.selectedStyle,
      unselectedStyle: other.unselectedStyle,
      disabledStyle: other.disabledStyle,
      collapsibleHeaderStyle: other.collapsibleHeaderStyle,
      childItemStyle: other.childItemStyle,
    );
  }
}

/// Configuration for the navigation drawer's appearance
class NavArtisanTheme {
  /// Default indentation for child items in collapsible groups
  static const double defaultChildIndentation = 24.0;
  const NavArtisanTheme({
    this.childIndentation = defaultChildIndentation,
    Color? backgroundColor,
    Color? selectedTileColor,
    Color? selectedTextColor,
    Color? unselectedTextColor,
    Color? disabledTextColor,
    Color? selectedIconColor,
    Color? unselectedIconColor,
    Color? disabledIconColor,
    Color? dividerColor,
    double? borderRadius,
    double? elevation,
    double? itemSpacing,
    EdgeInsets? itemPadding,
    EdgeInsets? contentPadding,
    DividerThemeData? dividerTheme,
    Color? expansionIconColor,
    this.textStyle,
  })  : backgroundColor = backgroundColor,
        expansionIconColor = expansionIconColor,
        selectedTileColor = selectedTileColor,
        selectedTextColor = selectedTextColor,
        unselectedTextColor = unselectedTextColor,
        disabledTextColor = disabledTextColor,
        selectedIconColor = selectedIconColor,
        unselectedIconColor = unselectedIconColor,
        disabledIconColor = disabledIconColor,
        dividerColor = dividerColor,
        borderRadius = borderRadius ?? 4.0,
        elevation = elevation ?? 1.0,
        itemSpacing = itemSpacing ?? 4.0,
        itemPadding = itemPadding ?? const EdgeInsets.symmetric(horizontal: 16.0),
        contentPadding = contentPadding ?? const EdgeInsets.all(8.0),
        dividerTheme = dividerTheme ?? const DividerThemeData();

  /// Creates a copy of this theme but with the given fields replaced with the new values.
  NavArtisanTheme copyWith({
    Color? backgroundColor,
    Color? selectedTileColor,
    Color? selectedTextColor,
    Color? unselectedTextColor,
    Color? disabledTextColor,
    Color? selectedIconColor,
    Color? unselectedIconColor,
    Color? disabledIconColor,
    Color? dividerColor,
    double? borderRadius,
    double? elevation,
    double? itemSpacing,
    EdgeInsets? itemPadding,
    EdgeInsets? contentPadding,
    DividerThemeData? dividerTheme,
    Color? expansionIconColor,
    NavArtisanTextStyle? textStyle,
  }) {
    return NavArtisanTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedTileColor: selectedTileColor ?? this.selectedTileColor,
      selectedTextColor: selectedTextColor ?? this.selectedTextColor,
      unselectedTextColor: unselectedTextColor ?? this.unselectedTextColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      selectedIconColor: selectedIconColor ?? this.selectedIconColor,
      unselectedIconColor: unselectedIconColor ?? this.unselectedIconColor,
      disabledIconColor: disabledIconColor ?? this.disabledIconColor,
      dividerColor: dividerColor ?? this.dividerColor,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      itemPadding: itemPadding ?? this.itemPadding,
      contentPadding: contentPadding ?? this.contentPadding,
      dividerTheme: dividerTheme ?? this.dividerTheme,
      expansionIconColor: expansionIconColor ?? this.expansionIconColor,
      textStyle: textStyle ?? this.textStyle,
      childIndentation: childIndentation,
    );
  }

  /// Creates a new [NavArtisanTheme] where the non-null fields in the given theme
  /// override the corresponding fields in this theme.
  NavArtisanTheme merge(NavArtisanTheme? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other.backgroundColor,
      selectedTileColor: other.selectedTileColor,
      selectedTextColor: other.selectedTextColor,
      unselectedTextColor: other.unselectedTextColor,
      disabledTextColor: other.disabledTextColor,
      selectedIconColor: other.selectedIconColor,
      unselectedIconColor: other.unselectedIconColor,
      disabledIconColor: other.disabledIconColor,
      dividerColor: other.dividerColor,
      borderRadius: other.borderRadius,
      elevation: other.elevation,
      itemSpacing: other.itemSpacing,
      itemPadding: other.itemPadding,
      contentPadding: other.contentPadding,
      dividerTheme: other.dividerTheme,
    );
  }

  factory NavArtisanTheme.defaultTheme(BuildContext context) {
    final theme = Theme.of(context);
    final baseTextStyle = theme.textTheme.bodyMedium!.copyWith(
      fontWeight: FontWeight.w500,
    );

    return NavArtisanTheme(
      backgroundColor: theme.scaffoldBackgroundColor,
      selectedTileColor: theme.colorScheme.primary.withValues(alpha: 0.1),
      selectedTextColor: theme.colorScheme.primary,
      selectedIconColor: theme.colorScheme.primary,
      unselectedTextColor: theme.colorScheme.onSurface.withValues(alpha: 0.8),
      unselectedIconColor: theme.colorScheme.onSurface.withValues(alpha: 0.8),
      textStyle: NavArtisanTextStyle(
        selectedStyle: baseTextStyle.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
        unselectedStyle: baseTextStyle.copyWith(
          color: theme.colorScheme.onSurface,
        ),
        disabledStyle: baseTextStyle.copyWith(
          color: theme.colorScheme.onSurface.withOpacity(0.38),
        ),
        collapsibleHeaderStyle: baseTextStyle.copyWith(
          fontWeight: FontWeight.w600,
        ),
        childItemStyle: baseTextStyle.copyWith(
          fontSize: baseTextStyle.fontSize! * 0.95,
        ),
      ),
    );
  }

  final Color? backgroundColor;
  final Color? selectedTileColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final Color? disabledTextColor;
  final Color? selectedIconColor;
  final Color? unselectedIconColor;
  final Color? disabledIconColor;
  final Color? dividerColor;
  final double borderRadius;
  final double elevation;
  final double itemSpacing;
  final EdgeInsets itemPadding;
  final EdgeInsets contentPadding;
  final DividerThemeData dividerTheme;
  final Color? expansionIconColor;
  final double childIndentation;
  final NavArtisanTextStyle? textStyle;
}

class NavArtisan<T> extends StatefulWidget {
  const NavArtisan({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onSelectionChanged,
    this.width = 256,
    this.header,
    this.footer,
    this.theme,
    this.showSelectedItemBadge = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
    this.physics,
    this.clipBehavior = Clip.none,
    this.isCompact = false,
  });

  final List<NavItem<T>> items;
  final T selectedValue;
  final void Function(T value, int index) onSelectionChanged;
  final double width;
  final bool isCompact;
  final Widget? header;
  final Widget? footer;
  final NavArtisanTheme? theme;
  final bool showSelectedItemBadge;
  final Duration animationDuration;
  final Curve animationCurve;
  final ScrollPhysics? physics;
  final Clip clipBehavior;

  /// Helper method to get selectable items with their indices
  List<(StandardNavItem<T>, int)> get selectableItemsWithIndices {
    final result = <(StandardNavItem<T>, int)>[];
    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      if (item is StandardNavItem<T>) {
        result.add((item, result.length));
      }
    }
    return result;
  }

  /// Helper method to get selectable items only
  List<StandardNavItem<T>> get selectableItems {
    return selectableItemsWithIndices.map((e) => e.$1).toList();
  }

  /// Helper method to get the index of a selectable item
  int getSelectableIndex(StandardNavItem<T> item) {
    return selectableItemsWithIndices.firstWhere((element) => element.$1.value == item.value).$2;
  }

  @override
  State<NavArtisan<T>> createState() => _NavArtisanState<T>();
}

class _NavArtisanState<T> extends State<NavArtisan<T>> {
  final Set<String> _expandedItems = {};

  void _toggleExpanded(CollapsibleNavItem<T> item) {
    final itemKey = '${item.label}_${item.icon.codePoint}';
    setState(() {
      if (_expandedItems.contains(itemKey)) {
        _expandedItems.remove(itemKey);
      } else {
        _expandedItems.add(itemKey);
      }
    });
  }

  bool _isExpanded(CollapsibleNavItem<T> item) {
    final itemKey = '${item.label}_${item.icon.codePoint}';
    return _expandedItems.contains(itemKey);
  }

  @override
  Widget build(BuildContext context) {
    const compactWith = 58.0;
    // Merge the provided theme with the default theme, allowing the provided theme to override defaults
    final effectiveTheme = NavArtisanTheme.defaultTheme(context).merge(widget.theme);
    final effectiveWidth = widget.isCompact ? compactWith : widget.width;

    return AnimatedContainer(
      duration: widget.animationDuration,
      curve: widget.animationCurve,
      width: effectiveWidth,
      child: Drawer(
        shape: const RoundedRectangleBorder(),
        backgroundColor: effectiveTheme.backgroundColor,
        elevation: effectiveTheme.elevation,
        clipBehavior: widget.clipBehavior,
        child: Padding(
          padding: effectiveTheme.contentPadding,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (widget.header != null) ...[
                    widget.header!,
                    SizedBox(height: effectiveTheme.itemSpacing),
                  ],
                  Expanded(
                    child: ListView.separated(
                      physics: widget.physics,
                      itemCount: widget.items.length,
                      separatorBuilder: (context, index) {
                        final currentItem = widget.items[index];
                        final nextItem =
                            index + 1 < widget.items.length ? widget.items[index + 1] : null;

                        final showCurrentDivider =
                            currentItem is CustomNavItem<T> && currentItem.showDividers;
                        final showNextDivider =
                            nextItem is CustomNavItem<T> && nextItem.showDividers;

                        if (showCurrentDivider || showNextDivider) {
                          return Divider(
                            color: effectiveTheme.dividerColor,
                            thickness: effectiveTheme.dividerTheme.thickness,
                            height: effectiveTheme.dividerTheme.space,
                            indent: effectiveTheme.dividerTheme.indent,
                            endIndent: effectiveTheme.dividerTheme.endIndent,
                          );
                        }

                        return SizedBox(height: effectiveTheme.itemSpacing);
                      },
                      itemBuilder: (context, index) {
                        final item = widget.items[index];

                        if (item is CustomNavItem<T>) {
                          return item.child;
                        }

                        if (item is StandardNavItem<T>) {
                          final selected = item.value == widget.selectedValue;

                          Widget? badgeWidget;
                          if (item.badge != null && (widget.showSelectedItemBadge || !selected)) {
                            badgeWidget = item.badge;
                          }

                          final showLabel = !widget.isCompact && maxWidth > compactWith + 4;
                          final tile = InkWell(
                            onTap: item.enabled
                                ? () => widget.onSelectionChanged(
                                      item.value,
                                      widget.getSelectableIndex(item),
                                    )
                                : null,
                            borderRadius: BorderRadius.circular(effectiveTheme.borderRadius),
                            child: Container(
                              width: double.infinity,
                              height: 38.0,
                              decoration: BoxDecoration(
                                color: selected ? effectiveTheme.selectedTileColor : null,
                                borderRadius: BorderRadius.circular(effectiveTheme.borderRadius),
                              ),
                              child: Padding(
                                padding: !showLabel ? EdgeInsets.zero : effectiveTheme.itemPadding,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      selected ? (item.selectedIcon ?? item.icon) : item.icon,
                                      color: selected
                                          ? effectiveTheme.selectedIconColor
                                          : item.enabled
                                              ? effectiveTheme.unselectedIconColor
                                              : effectiveTheme.disabledIconColor,
                                      size: 18.0,
                                    ),
                                    if (showLabel) ...[
                                      const SizedBox(width: 12.0),
                                      Expanded(
                                        child: DefaultTextStyle(
                                          style: Theme.of(context).textTheme.bodyMedium!,
                                          child: _buildItemText(
                                            context,
                                            item.label,
                                            selected,
                                            item.enabled,
                                            effectiveTheme,
                                          ),
                                        ),
                                      ),
                                      if (badgeWidget != null || item.trailing != null)
                                        Padding(
                                          padding: const EdgeInsets.only(left: 16.0),
                                          child: badgeWidget ?? item.trailing!,
                                        ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          );

                          final tooltipText = widget.isCompact ? item.label : item.tooltipText;
                          if (tooltipText != null) {
                            return Tooltip(
                              message: tooltipText,
                              child: tile,
                            );
                          }

                          return tile;
                        }

                        if (item is CollapsibleNavItem<T>) {
                          final isExpanded = _isExpanded(item);
                          final showLabel = !widget.isCompact && maxWidth > compactWith + 4;

                          final tile = InkWell(
                            onTap: item.enabled ? () => _toggleExpanded(item) : null,
                            borderRadius: BorderRadius.circular(effectiveTheme.borderRadius),
                            child: Container(
                              width: double.infinity,
                              height: 38.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(effectiveTheme.borderRadius),
                              ),
                              child: Padding(
                                padding: !showLabel ? EdgeInsets.zero : effectiveTheme.itemPadding,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      item.icon,
                                      color: item.enabled
                                          ? effectiveTheme.unselectedIconColor
                                          : effectiveTheme.disabledIconColor,
                                      size: 18.0,
                                    ),
                                    if (showLabel) ...[
                                      const SizedBox(width: 12.0),
                                      Expanded(
                                        child: DefaultTextStyle(
                                          style: Theme.of(context).textTheme.bodyMedium!,
                                          child: _buildItemText(
                                            context,
                                            item.label,
                                            false,
                                            item.enabled,
                                            effectiveTheme,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        isExpanded ? Icons.expand_less : Icons.expand_more,
                                        color: (effectiveTheme.expansionIconColor ??
                                                effectiveTheme.unselectedIconColor)
                                            ?.withValues(alpha: 0.6),
                                        size: 18.0,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          );

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              tile,
                              if (isExpanded && item.childItems.isNotEmpty)
                                AnimatedOpacity(
                                  duration: widget.animationDuration,
                                  curve: widget.animationCurve,
                                  opacity: isExpanded ? 1.0 : 0.0,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: effectiveTheme.childIndentation),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            color: (effectiveTheme.unselectedIconColor ??
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onSurface
                                                        .withValues(alpha: 0.2))
                                                .withValues(alpha: 0.2),
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        children: item.childItems.map((childItem) {
                                          final selected = childItem.value == widget.selectedValue;
                                          Widget? badgeWidget;
                                          if (childItem.badge != null &&
                                              (widget.showSelectedItemBadge || !selected)) {
                                            badgeWidget = childItem.badge;
                                          }

                                          return Container(
                                            margin: EdgeInsets.only(
                                              left: 4,
                                            ),
                                            padding:
                                                EdgeInsets.only(top: effectiveTheme.itemSpacing),
                                            child: InkWell(
                                              onTap: childItem.enabled
                                                  ? () => widget.onSelectionChanged(
                                                        childItem.value,
                                                        widget.getSelectableIndex(childItem),
                                                      )
                                                  : null,
                                              borderRadius: BorderRadius.circular(
                                                effectiveTheme.borderRadius,
                                              ),
                                              child: Container(
                                                width: double.infinity,
                                                height: 38.0,
                                                decoration: BoxDecoration(
                                                  color: selected
                                                      ? effectiveTheme.selectedTileColor
                                                      : null,
                                                  borderRadius: BorderRadius.circular(
                                                    effectiveTheme.borderRadius,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: !showLabel
                                                      ? EdgeInsets.zero
                                                      : effectiveTheme.itemPadding,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        selected
                                                            ? (childItem.selectedIcon ??
                                                                childItem.icon)
                                                            : childItem.icon,
                                                        color: selected
                                                            ? effectiveTheme.selectedIconColor
                                                            : childItem.enabled
                                                                ? effectiveTheme.unselectedIconColor
                                                                : effectiveTheme.disabledIconColor,
                                                        size: 18.0,
                                                      ),
                                                      if (showLabel) ...[
                                                        const SizedBox(width: 12.0),
                                                        Expanded(
                                                          child: DefaultTextStyle(
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!,
                                                            child: _buildItemText(
                                                              context,
                                                              childItem.label,
                                                              selected,
                                                              childItem.enabled,
                                                              effectiveTheme,
                                                              isChild: true,
                                                            ),
                                                          ),
                                                        ),
                                                        if (badgeWidget != null ||
                                                            childItem.trailing != null)
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets.only(left: 16.0),
                                                            child:
                                                                badgeWidget ?? childItem.trailing!,
                                                          ),
                                                      ],
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  if (widget.footer != null) ...[
                    SizedBox(height: effectiveTheme.itemSpacing),
                    widget.footer!,
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

Text _buildItemText(
  BuildContext context,
  String text,
  bool selected,
  bool enabled,
  NavArtisanTheme effectiveTheme, {
  bool isChild = false,
}) {
  final textStyle = effectiveTheme.textStyle;
  final defaultStyle = Theme.of(context).textTheme.bodyMedium!;

  TextStyle? style;
  if (selected) {
    style = textStyle?.selectedStyle?.copyWith(
          color: effectiveTheme.selectedTextColor,
        ) ??
        defaultStyle.copyWith(
          color: effectiveTheme.selectedTextColor,
          fontWeight: FontWeight.bold,
        );
  } else if (!enabled) {
    style = textStyle?.disabledStyle?.copyWith(
          color: effectiveTheme.disabledTextColor,
        ) ??
        defaultStyle.copyWith(
          color: effectiveTheme.disabledTextColor,
          fontWeight: FontWeight.bold,
        );
  } else if (isChild) {
    style = textStyle?.childItemStyle?.copyWith(
          color: effectiveTheme.unselectedTextColor,
        ) ??
        defaultStyle.copyWith(
          color: effectiveTheme.unselectedTextColor,
          fontSize: defaultStyle.fontSize! * 0.95,
          fontWeight: FontWeight.bold,
        );
  } else {
    style = textStyle?.unselectedStyle?.copyWith(
          color: effectiveTheme.unselectedTextColor,
        ) ??
        defaultStyle.copyWith(
          color: effectiveTheme.unselectedTextColor,
          fontWeight: FontWeight.bold,
        );
  }

  return Text(
    text,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: style,
  );
}
