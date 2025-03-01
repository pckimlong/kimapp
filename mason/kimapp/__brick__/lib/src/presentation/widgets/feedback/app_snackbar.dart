import 'package:flutter/material.dart';

/// Defines the type of snackbar to display
enum AppSnackbarType {
  /// For general information messages
  info,

  /// For success messages
  success,

  /// For warning messages
  warning,

  /// For error messages
  error,
}

/// A customizable snackbar component that adapts to the application theme
class AppSnackbar {
  /// Shows a snackbar with the given message
  static void show({
    required BuildContext context,
    required String message,
    AppSnackbarType type = AppSnackbarType.info,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
    bool dismissible = true,
    EdgeInsetsGeometry? margin,
    double? width,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Determine colors based on type
    final Color backgroundColor;
    final Color foregroundColor;
    final IconData icon;

    switch (type) {
      case AppSnackbarType.info:
        backgroundColor = colorScheme.primary;
        foregroundColor = colorScheme.onPrimary;
        icon = Icons.info_outline;
      case AppSnackbarType.success:
        backgroundColor = Colors.green.shade700;
        foregroundColor = Colors.white;
        icon = Icons.check_circle_outline;
      case AppSnackbarType.warning:
        backgroundColor = Colors.orange.shade700;
        foregroundColor = Colors.white;
        icon = Icons.warning_amber_outlined;
      case AppSnackbarType.error:
        backgroundColor = Colors.red.shade700;
        foregroundColor = Colors.white;
        icon = Icons.error_outline;
    }

    // Create the snackbar
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            icon,
            color: foregroundColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: foregroundColor,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: behavior,
      margin: margin,
      width: width,
      dismissDirection: dismissible ? DismissDirection.horizontal : DismissDirection.none,
      action: actionLabel != null
          ? SnackBarAction(
              label: actionLabel,
              textColor: foregroundColor.withOpacity(0.9),
              onPressed: onAction ?? () {},
            )
          : null,
    );

    // Show the snackbar
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Shows an info snackbar
  static void showInfo({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
    bool dismissible = true,
    EdgeInsetsGeometry? margin,
    double? width,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    show(
      context: context,
      message: message,
      type: AppSnackbarType.info,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
      dismissible: dismissible,
      margin: margin,
      width: width,
      behavior: behavior,
    );
  }

  /// Shows a success snackbar
  static void showSuccess({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
    bool dismissible = true,
    EdgeInsetsGeometry? margin,
    double? width,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    show(
      context: context,
      message: message,
      type: AppSnackbarType.success,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
      dismissible: dismissible,
      margin: margin,
      width: width,
      behavior: behavior,
    );
  }

  /// Shows a warning snackbar
  static void showWarning({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
    bool dismissible = true,
    EdgeInsetsGeometry? margin,
    double? width,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    show(
      context: context,
      message: message,
      type: AppSnackbarType.warning,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
      dismissible: dismissible,
      margin: margin,
      width: width,
      behavior: behavior,
    );
  }

  /// Shows an error snackbar
  static void showError({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
    bool dismissible = true,
    EdgeInsetsGeometry? margin,
    double? width,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    show(
      context: context,
      message: message,
      type: AppSnackbarType.error,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
      dismissible: dismissible,
      margin: margin,
      width: width,
      behavior: behavior,
    );
  }
}

/// Extension method to easily show snackbars from a BuildContext
extension SnackbarContextExtension on BuildContext {
  /// Shows an info snackbar
  void showInfoSnackbar(
    String message, {
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
    bool dismissible = true,
    EdgeInsetsGeometry? margin,
    double? width,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    AppSnackbar.showInfo(
      context: this,
      message: message,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
      dismissible: dismissible,
      margin: margin,
      width: width,
      behavior: behavior,
    );
  }

  /// Shows a success snackbar
  void showSuccessSnackbar(
    String message, {
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
    bool dismissible = true,
    EdgeInsetsGeometry? margin,
    double? width,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    AppSnackbar.showSuccess(
      context: this,
      message: message,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
      dismissible: dismissible,
      margin: margin,
      width: width,
      behavior: behavior,
    );
  }

  /// Shows a warning snackbar
  void showWarningSnackbar(
    String message, {
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
    bool dismissible = true,
    EdgeInsetsGeometry? margin,
    double? width,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    AppSnackbar.showWarning(
      context: this,
      message: message,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
      dismissible: dismissible,
      margin: margin,
      width: width,
      behavior: behavior,
    );
  }

  /// Shows an error snackbar
  void showErrorSnackbar(
    String message, {
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
    bool dismissible = true,
    EdgeInsetsGeometry? margin,
    double? width,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    AppSnackbar.showError(
      context: this,
      message: message,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
      dismissible: dismissible,
      margin: margin,
      width: width,
      behavior: behavior,
    );
  }
}
