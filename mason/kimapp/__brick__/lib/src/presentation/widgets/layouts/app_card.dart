import 'package:flutter/material.dart';

import '../theme/base_widget.dart';

/// Defines the elevation levels for card components
enum AppCardElevation {
  none,
  low,
  medium,
  high,
}

/// Defines the border style for card components
enum AppCardBorderStyle {
  none,
  light,
  medium,
  accent,
}

/// A customizable card component that adapts to the application theme
/// and provides consistent styling across the app.
class AppCard extends AppBaseWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.elevation = AppCardElevation.low,
    this.color,
    this.borderStyle = AppCardBorderStyle.none,
    this.borderColor,
    this.clipBehavior = Clip.antiAlias,
    this.width,
    this.height,
    this.onTap,
  });

  /// The main content of the card
  final Widget child;

  /// Optional padding for the card content
  final EdgeInsetsGeometry? padding;

  /// Optional margin around the card
  final EdgeInsetsGeometry? margin;

  /// Custom border radius (uses theme default if null)
  final double? borderRadius;

  /// Elevation level of the card
  final AppCardElevation elevation;

  /// Background color (uses theme surface color if null)
  final Color? color;

  /// Border style for the card
  final AppCardBorderStyle borderStyle;

  /// Custom border color (uses theme outline if null)
  final Color? borderColor;

  /// How to clip the content of the card
  final Clip clipBehavior;

  /// Optional fixed width for the card
  final double? width;

  /// Optional fixed height for the card
  final double? height;

  /// Optional callback when card is tapped
  final VoidCallback? onTap;

  @override
  Widget buildWithTheme(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // Determine border radius
    final radius = borderRadius ?? AppThemeConfig.radiusM;

    // Determine padding (defaults based on elevation)
    final defaultPadding = padding ??
        switch (elevation) {
          AppCardElevation.none => const EdgeInsets.all(12),
          AppCardElevation.low => const EdgeInsets.all(16),
          AppCardElevation.medium => const EdgeInsets.all(16),
          AppCardElevation.high => const EdgeInsets.all(20),
        };

    // Determine card elevation
    final elevationValue = switch (elevation) {
      AppCardElevation.none => 0.0,
      AppCardElevation.low => 1.0,
      AppCardElevation.medium => 4.0,
      AppCardElevation.high => 8.0,
    };

    // Determine border width
    final borderWidth = switch (borderStyle) {
      AppCardBorderStyle.none => 0.0,
      AppCardBorderStyle.light => 0.5,
      AppCardBorderStyle.medium => 1.0,
      AppCardBorderStyle.accent => 2.0,
    };

    // Determine border color
    final actualBorderColor = switch (borderStyle) {
      AppCardBorderStyle.none => Colors.transparent,
      AppCardBorderStyle.accent => borderColor ?? colors.primary,
      _ => borderColor ?? colors.outline,
    };

    // Create the card widget
    Widget cardWidget = Material(
      color: color ?? colors.surface,
      elevation: elevationValue,
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: clipBehavior,
      child: Container(
        width: width,
        height: height,
        padding: defaultPadding,
        decoration: BoxDecoration(
          border: Border.all(
            color: actualBorderColor,
            width: borderWidth,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: child,
      ),
    );

    // Wrap with InkWell if onTap is provided
    if (onTap != null) {
      cardWidget = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: cardWidget,
      );
    }

    // Apply margin if provided
    if (margin != null) {
      cardWidget = Padding(
        padding: margin!,
        child: cardWidget,
      );
    }

    return cardWidget;
  }
}
