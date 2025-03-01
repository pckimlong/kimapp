import 'package:flutter/material.dart';

import '../theme/base_widget.dart';

/// Defines the style options for chip components
enum AppChipStyle {
  filled,
  outlined,
  tonal,
}

/// Defines the size options for chip components
enum AppChipSize {
  small,
  medium,
  large,
}

/// A customizable chip component that adapts to the application theme
/// and provides consistent styling across the app.
class AppChip extends AppBaseWidget {
  const AppChip({
    super.key,
    required this.label,
    this.icon,
    this.avatar,
    this.onTap,
    this.onDeleted,
    this.style = AppChipStyle.filled,
    this.size = AppChipSize.medium,
    this.selected = false,
    this.enabled = true,
    this.color,
    this.selectedColor,
    this.textColor,
    this.selectedTextColor,
    this.borderRadius,
    this.deleteIcon,
    this.deleteIconColor,
    this.padding,
  });

  /// The text label of the chip
  final String label;

  /// Optional icon to display before the label
  final IconData? icon;

  /// Optional avatar widget to display before the label
  final Widget? avatar;

  /// Callback when the chip is tapped
  final VoidCallback? onTap;

  /// Callback when the delete icon is tapped
  final VoidCallback? onDeleted;

  /// Visual style of the chip
  final AppChipStyle style;

  /// Size of the chip
  final AppChipSize size;

  /// Whether the chip is in a selected state
  final bool selected;

  /// Whether the chip is interactive
  final bool enabled;

  /// Background color of the chip (uses theme based on style if null)
  final Color? color;

  /// Background color when selected (uses theme primary if null)
  final Color? selectedColor;

  /// Text color of the chip (uses theme based on style if null)
  final Color? textColor;

  /// Text color when selected (uses theme onPrimary if null)
  final Color? selectedTextColor;

  /// Custom border radius for the chip
  final double? borderRadius;

  /// Custom delete icon
  final IconData? deleteIcon;

  /// Color of the delete icon
  final Color? deleteIconColor;

  /// Custom padding for the chip
  final EdgeInsetsGeometry? padding;

  @override
  Widget buildWithTheme(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // Determine chip size
    final height = switch (size) {
      AppChipSize.small => 28.0,
      AppChipSize.medium => 32.0,
      AppChipSize.large => 40.0,
    };

    // Determine font size based on chip size
    final fontSize = switch (size) {
      AppChipSize.small => 12.0,
      AppChipSize.medium => 14.0,
      AppChipSize.large => 16.0,
    };

    // Determine icon size based on chip size
    final iconSize = switch (size) {
      AppChipSize.small => 16.0,
      AppChipSize.medium => 18.0,
      AppChipSize.large => 20.0,
    };

    // Determine delete icon size based on chip size
    final deleteIconSize = switch (size) {
      AppChipSize.small => 16.0,
      AppChipSize.medium => 18.0,
      AppChipSize.large => 20.0,
    };

    // Determine border radius
    final radius = borderRadius ?? height / 2;

    // Determine background color based on style and state
    Color backgroundColor;
    if (selected) {
      backgroundColor = selectedColor ?? colors.primary;
    } else {
      backgroundColor = color ??
          switch (style) {
            AppChipStyle.filled => colors.surfaceContainerHighest,
            AppChipStyle.outlined => Colors.transparent,
            AppChipStyle.tonal => colors.secondaryContainer,
          };
    }

    // Determine text color based on style and state
    Color labelColor;
    if (selected) {
      labelColor = selectedTextColor ?? colors.onPrimary;
    } else {
      labelColor = textColor ??
          switch (style) {
            AppChipStyle.filled => colors.onSurfaceVariant,
            AppChipStyle.outlined => colors.onSurface,
            AppChipStyle.tonal => colors.onSecondaryContainer,
          };
    }

    // Apply disabled state
    if (!enabled) {
      backgroundColor = theme.disabledColor.withOpacity(0.12);
      labelColor = theme.disabledColor;
    }

    // Determine border color and width
    Color borderColor = Colors.transparent;
    double borderWidth = 0;

    if (style == AppChipStyle.outlined && !selected) {
      borderColor = colors.outline;
      borderWidth = 1;
    }

    // Determine padding
    final defaultPadding = padding ??
        switch (size) {
          AppChipSize.small => const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          AppChipSize.medium => const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          AppChipSize.large => const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        };

    // Create the chip content
    final List<Widget> chipContent = [];

    // Add avatar if provided
    if (avatar != null) {
      chipContent.add(
        SizedBox(
          width: iconSize,
          height: iconSize,
          child: avatar,
        ),
      );
      chipContent.add(const SizedBox(width: 6));
    }
    // Add icon if provided
    else if (icon != null) {
      chipContent.add(
        Icon(
          icon,
          size: iconSize,
          color: labelColor,
        ),
      );
      chipContent.add(const SizedBox(width: 6));
    }

    // Add label
    chipContent.add(
      Text(
        label,
        style: TextStyle(
          color: labelColor,
          fontSize: fontSize,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );

    // Add delete icon if onDeleted is provided
    if (onDeleted != null) {
      chipContent.add(const SizedBox(width: 4));
      chipContent.add(
        GestureDetector(
          onTap: enabled ? onDeleted : null,
          child: Icon(
            deleteIcon ?? Icons.cancel,
            size: deleteIconSize,
            color: deleteIconColor ?? labelColor.withOpacity(0.7),
          ),
        ),
      );
    }

    // Create the chip widget
    Widget chipWidget = Container(
      height: height,
      padding: defaultPadding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: borderWidth > 0
            ? Border.all(
                color: borderColor,
                width: borderWidth,
              )
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: chipContent,
      ),
    );

    // Add tap functionality if provided
    if (onTap != null && enabled) {
      chipWidget = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: chipWidget,
      );
    }

    return chipWidget;
  }
}
