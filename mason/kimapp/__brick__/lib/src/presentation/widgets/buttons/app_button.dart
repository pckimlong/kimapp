import 'package:flutter/material.dart';

import '../theme/base_widget.dart';

/// Button variant types to control appearance
enum AppButtonVariant {
  primary,
  secondary,
  outline,
  text,
}

/// Button size options
enum AppButtonSize {
  small,
  medium,
  large,
}

/// A customizable button component that adapts to the application theme
/// and provides consistent styling across the app.
class AppButton extends AppBaseWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.fullWidth = false,
    this.busy = false,
    this.disabled = false,
    this.borderRadius,
    this.leadingIcon = false,
  });

  /// The callback when button is pressed
  final VoidCallback? onPressed;

  /// The button label text
  final String label;

  /// Optional icon to display
  final IconData? icon;

  /// Button style variant
  final AppButtonVariant variant;

  /// Button size
  final AppButtonSize size;

  /// Whether the button should take full width
  final bool fullWidth;

  /// Loading/busy state
  final bool busy;

  /// Disabled state
  final bool disabled;

  /// Custom border radius (uses theme default if null)
  final double? borderRadius;

  /// Whether icon should appear before the label
  final bool leadingIcon;

  @override
  Widget buildWithTheme(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // Determine button colors based on variant
    Color backgroundColor;
    Color textColor;
    Color borderColor;

    switch (variant) {
      case AppButtonVariant.primary:
        backgroundColor = colors.primary;
        textColor = colors.onPrimary;
        borderColor = Colors.transparent;
        break;
      case AppButtonVariant.secondary:
        backgroundColor = colors.secondary;
        textColor = colors.onSecondary;
        borderColor = Colors.transparent;
        break;
      case AppButtonVariant.outline:
        backgroundColor = Colors.transparent;
        textColor = colors.primary;
        borderColor = colors.primary;
        break;
      case AppButtonVariant.text:
        backgroundColor = Colors.transparent;
        textColor = colors.primary;
        borderColor = Colors.transparent;
        break;
    }

    // Determine padding and text style based on size
    EdgeInsets padding;
    TextStyle textStyle;
    double iconSize;

    switch (size) {
      case AppButtonSize.small:
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
        textStyle = theme.textTheme.labelMedium!;
        iconSize = 16;
        break;
      case AppButtonSize.medium:
        padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
        textStyle = theme.textTheme.labelLarge!;
        iconSize = 18;
        break;
      case AppButtonSize.large:
        padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
        textStyle = theme.textTheme.titleMedium!;
        iconSize = 20;
        break;
    }

    // Handle disabled state
    final isDisabled = disabled || busy || onPressed == null;
    if (isDisabled) {
      backgroundColor = theme.disabledColor;
      textColor = colors.onSurface.withOpacity(0.38);
      borderColor = Colors.transparent;
    }

    // Create button content
    Widget buttonContent;

    if (busy) {
      // Show loading indicator when busy
      buttonContent = SizedBox(
        height: iconSize,
        width: iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    } else if (icon != null) {
      // Show icon and text
      final iconWidget = Icon(
        icon,
        color: textColor,
        size: iconSize,
      );

      final textWidget = Text(
        label,
        style: textStyle.copyWith(color: textColor),
      );

      buttonContent = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: leadingIcon
            ? [
                iconWidget,
                const SizedBox(width: 8),
                textWidget,
              ]
            : [
                textWidget,
                const SizedBox(width: 8),
                iconWidget,
              ],
      );
    } else {
      // Text only
      buttonContent = Text(
        label,
        style: textStyle.copyWith(color: textColor),
      );
    }

    // Apply border radius
    final radius = borderRadius ?? AppThemeConfig.radiusM;

    // Build the button with Material
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isDisabled ? null : onPressed,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          width: fullWidth ? double.infinity : null,
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: borderColor,
              width: variant == AppButtonVariant.outline ? 1.5 : 0,
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Center(child: buttonContent),
        ),
      ),
    );
  }
}
