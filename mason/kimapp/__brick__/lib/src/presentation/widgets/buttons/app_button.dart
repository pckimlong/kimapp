import 'package:book_swap/src/core/helpers/build_context_helper.dart';
import 'package:flutter/material.dart';

import '../../app/app_style.dart';
import '../theme/base_widget.dart';

enum AppButtonVariant { primary, secondary, outline, text, neutral }

enum AppButtonSize { small, medium, large }

class AppButton extends AppBaseWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.backgroundColor,
    this.foregroundColor,
    this.size = AppButtonSize.medium,
    this.fullWidth = false,
    this.busy = false,
    this.disabled = false,
    this.borderRadius,
    this.leadingIcon = false,
  });

  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final AppButtonVariant variant;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final AppButtonSize size;
  final bool fullWidth;
  final bool busy;
  final bool disabled;
  final double? borderRadius;
  final bool leadingIcon;

  @override
  Widget buildWithTheme(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final isDisabled = disabled || busy || onPressed == null;

    ButtonStyle baseStyle = _getBaseButtonStyle(context);

    if (backgroundColor != null || foregroundColor != null) {
      baseStyle = baseStyle.copyWith(
        backgroundColor: backgroundColor != null ? WidgetStateProperty.all(backgroundColor) : null,
        foregroundColor: foregroundColor != null ? WidgetStateProperty.all(foregroundColor) : null,
      );
    }

    if (isDisabled) {
      baseStyle = baseStyle.copyWith(
        backgroundColor: WidgetStateProperty.all(theme.disabledColor),
        foregroundColor: WidgetStateProperty.all(colors.onSurface.withValues(alpha: 0.38)),
      );
    }

    final radius = borderRadius ?? AS.buttonRadius;
    baseStyle = baseStyle.copyWith(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: _getBorderSide(context),
        ),
      ),
    );

    baseStyle = _applySizeStyles(baseStyle, context);

    final Widget buttonContent = _createButtonContent(context, isDisabled);

    Widget button;
    switch (variant) {
      case AppButtonVariant.primary:
      case AppButtonVariant.secondary:
        button = ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: baseStyle,
          child: buttonContent,
        );
        break;
      case AppButtonVariant.neutral:
        button = FilledButton(
          onPressed: isDisabled ? null : onPressed,
          style: baseStyle,
          child: buttonContent,
        );
        break;
      case AppButtonVariant.outline:
        button = OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: baseStyle,
          child: buttonContent,
        );
        break;
      case AppButtonVariant.text:
        button = TextButton(
          onPressed: isDisabled ? null : onPressed,
          style: baseStyle,
          child: buttonContent,
        );
        break;
    }

    if (fullWidth) {
      button = SizedBox(width: double.infinity, child: button);
    }

    return button;
  }

  ButtonStyle _getBaseButtonStyle(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    switch (variant) {
      case AppButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          elevation: AS.buttonElevation,
        );
      case AppButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: colors.secondary,
          foregroundColor: colors.onSecondary,
          elevation: AS.buttonElevation,
        );
      case AppButtonVariant.outline:
        return OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          side: BorderSide(color: colors.primary, width: 1.5),
        );
      case AppButtonVariant.text:
        return TextButton.styleFrom(foregroundColor: colors.primary);
      case AppButtonVariant.neutral:
        return FilledButton.styleFrom(
          backgroundColor: colors.outlineVariant.withValues(alpha: 0.05),
          foregroundColor: context.colors.onSurfaceVariant,
        );
    }
  }

  BorderSide _getBorderSide(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    if (variant == AppButtonVariant.outline) {
      return BorderSide(color: foregroundColor ?? colors.primary, width: 1.5);
    }

    return BorderSide.none;
  }

  ButtonStyle _applySizeStyles(ButtonStyle baseStyle, BuildContext context) {
    final theme = Theme.of(context);

    EdgeInsetsGeometry padding;
    TextStyle textStyle;
    double? height;

    switch (size) {
      case AppButtonSize.small:
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
        textStyle = theme.textTheme.labelMedium!;
        height = AS.buttonHeightS;
        break;
      case AppButtonSize.medium:
        padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
        textStyle = theme.textTheme.labelLarge!;
        height = AS.buttonHeightM;
        break;
      case AppButtonSize.large:
        padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
        textStyle = theme.textTheme.titleMedium!;
        height = AS.buttonHeightL;
        break;
    }

    return baseStyle.copyWith(
      padding: WidgetStateProperty.all(padding),
      textStyle: WidgetStateProperty.all(textStyle),
      minimumSize: WidgetStateProperty.all(Size(0, height)),
    );
  }

  Widget _createButtonContent(BuildContext context, bool isDisabled) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final Color textIconColor =
        isDisabled
            ? colors.onSurface.withValues(alpha: 0.38)
            : (foregroundColor ??
                (variant == AppButtonVariant.primary
                    ? colors.onPrimary
                    : variant == AppButtonVariant.secondary
                    ? colors.onSecondary
                    : variant == AppButtonVariant.neutral
                    ? context.colors.outlineVariant
                    : colors.primary));

    double iconSize;
    switch (size) {
      case AppButtonSize.small:
        iconSize = 16;
        break;
      case AppButtonSize.medium:
        iconSize = 18;
        break;
      case AppButtonSize.large:
        iconSize = 20;
        break;
    }

    if (busy) {
      return SizedBox(
        height: iconSize,
        width: iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textIconColor),
        ),
      );
    }

    final textWidget = Text(label);

    if (icon != null) {
      final iconWidget = Icon(icon, color: textIconColor, size: iconSize);

      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            leadingIcon
                ? [iconWidget, const SizedBox(width: 8), textWidget]
                : [textWidget, const SizedBox(width: 8), iconWidget],
      );
    }

    return textWidget;
  }
}
