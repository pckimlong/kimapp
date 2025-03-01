import 'package:flutter/material.dart';

import '../theme/base_widget.dart';

/// Defines the size options for badge components
enum AppBadgeSize {
  small, // 16.0
  medium, // 20.0
  large, // 24.0
}

/// Defines the position options for badge components
enum AppBadgePosition {
  topRight,
  topLeft,
  bottomRight,
  bottomLeft,
}

/// A customizable badge component that adapts to the application theme
/// and provides consistent styling across the app.
class AppBadge extends AppBaseWidget {
  const AppBadge({
    super.key,
    required this.child,
    this.count,
    this.label,
    this.icon,
    this.size = AppBadgeSize.medium,
    this.position = AppBadgePosition.topRight,
    this.color,
    this.textColor,
    this.showZero = false,
    this.maxCount = 99,
    this.offset,
    this.borderColor,
    this.borderWidth = 1.5,
    this.visible = true,
    this.shape,
  }) : assert(
          count != null || label != null || icon != null,
          'At least one of count, label, or icon must be provided',
        );

  /// The widget to which the badge will be attached
  final Widget child;

  /// Optional count to display in the badge
  final int? count;

  /// Optional text label to display in the badge
  final String? label;

  /// Optional icon to display in the badge
  final IconData? icon;

  /// Size of the badge
  final AppBadgeSize size;

  /// Position of the badge relative to the child
  final AppBadgePosition position;

  /// Background color of the badge (uses theme primary if null)
  final Color? color;

  /// Text color of the badge (uses theme onPrimary if null)
  final Color? textColor;

  /// Whether to show the badge when count is zero
  final bool showZero;

  /// Maximum count to display before showing "maxCount+"
  final int maxCount;

  /// Custom offset for the badge position
  final Offset? offset;

  /// Border color of the badge (uses theme background if null)
  final Color? borderColor;

  /// Width of the border around the badge
  final double borderWidth;

  /// Whether the badge is visible
  final bool visible;

  /// Custom shape for the badge
  final ShapeBorder? shape;

  @override
  Widget buildWithTheme(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // If not visible, just return the child
    if (!visible) {
      return child;
    }

    // If count is 0 and showZero is false, just return the child
    if (count == 0 && !showZero && label == null && icon == null) {
      return child;
    }

    // Determine badge size
    final badgeSize = switch (size) {
      AppBadgeSize.small => 16.0,
      AppBadgeSize.medium => 20.0,
      AppBadgeSize.large => 24.0,
    };

    // Determine font size based on badge size
    final fontSize = switch (size) {
      AppBadgeSize.small => 10.0,
      AppBadgeSize.medium => 12.0,
      AppBadgeSize.large => 14.0,
    };

    // Determine icon size based on badge size
    final iconSize = switch (size) {
      AppBadgeSize.small => 10.0,
      AppBadgeSize.medium => 12.0,
      AppBadgeSize.large => 14.0,
    };

    // Determine badge content
    Widget badgeContent;

    if (icon != null) {
      // Icon badge
      badgeContent = Icon(
        icon,
        size: iconSize,
        color: textColor ?? colors.onPrimary,
      );
    } else if (label != null) {
      // Text label badge
      badgeContent = Text(
        label!,
        style: TextStyle(
          color: textColor ?? colors.onPrimary,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      // Count badge
      final displayCount = count! > maxCount ? '$maxCount+' : count.toString();
      badgeContent = Text(
        displayCount,
        style: TextStyle(
          color: textColor ?? colors.onPrimary,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    // Create the badge
    final badge = Container(
      constraints: BoxConstraints(
        minWidth: badgeSize,
        minHeight: badgeSize,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: label != null || (count != null && count! > 9) ? 6.0 : 4.0,
        vertical: 2.0,
      ),
      decoration: ShapeDecoration(
        color: color ?? colors.primary,
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(badgeSize / 2),
              side: BorderSide(
                color: borderColor ?? theme.scaffoldBackgroundColor,
                width: borderWidth,
              ),
            ),
      ),
      child: Center(child: badgeContent),
    );

    // Determine badge position
    final defaultOffset = switch (position) {
      AppBadgePosition.topRight => const Offset(-8, -8),
      AppBadgePosition.topLeft => const Offset(8, -8),
      AppBadgePosition.bottomRight => const Offset(-8, 8),
      AppBadgePosition.bottomLeft => const Offset(8, 8),
    };

    final actualOffset = offset ?? defaultOffset;

    // Position the badge relative to the child
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          right: position == AppBadgePosition.topRight || position == AppBadgePosition.bottomRight
              ? actualOffset.dx
              : null,
          left: position == AppBadgePosition.topLeft || position == AppBadgePosition.bottomLeft
              ? actualOffset.dx
              : null,
          top: position == AppBadgePosition.topRight || position == AppBadgePosition.topLeft
              ? actualOffset.dy
              : null,
          bottom:
              position == AppBadgePosition.bottomRight || position == AppBadgePosition.bottomLeft
                  ? actualOffset.dy
                  : null,
          child: badge,
        ),
      ],
    );
  }
}
