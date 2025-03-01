import 'package:flutter/material.dart';

import '../buttons/app_button.dart';
import '../theme/base_widget.dart';
import '../typography/app_text.dart';

/// Defines the type of dialog
enum AppDialogType {
  info,
  success,
  warning,
  error,
  confirmation,
}

/// A customizable dialog component that adapts to the application theme
/// and provides consistent styling across the app.
class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    required this.message,
    this.type = AppDialogType.info,
    this.actions,
    this.closable = true,
    this.scrollable = false,
    this.insetPadding,
    this.titleIcon,
    this.customIcon,
    this.confirmButtonText,
    this.cancelButtonText,
    this.onConfirm,
    this.onCancel,
  });

  /// Dialog title
  final String title;

  /// Dialog message content
  final String message;

  /// Type of dialog which affects styling and icons
  final AppDialogType type;

  /// Optional custom action widgets
  final List<Widget>? actions;

  /// Whether dialog can be closed by clicking outside
  final bool closable;

  /// Whether dialog content is scrollable
  final bool scrollable;

  /// Custom inset padding
  final EdgeInsets? insetPadding;

  /// Whether to show an icon next to the title
  final bool? titleIcon;

  /// Custom icon to display
  final IconData? customIcon;

  /// Text for confirm button (if standard actions are used)
  final String? confirmButtonText;

  /// Text for cancel button (if standard actions are used)
  final String? cancelButtonText;

  /// Callback for confirm button (if standard actions are used)
  final VoidCallback? onConfirm;

  /// Callback for cancel button (if standard actions are used)
  final VoidCallback? onCancel;

  /// Show this dialog from anywhere in the app
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String message,
    AppDialogType type = AppDialogType.info,
    List<Widget>? actions,
    bool closable = true,
    bool scrollable = false,
    EdgeInsets? insetPadding,
    bool? titleIcon,
    IconData? customIcon,
    String? confirmButtonText,
    String? cancelButtonText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: closable,
      builder: (context) => AppDialog(
        title: title,
        message: message,
        type: type,
        actions: actions,
        closable: closable,
        scrollable: scrollable,
        insetPadding: insetPadding,
        titleIcon: titleIcon,
        customIcon: customIcon,
        confirmButtonText: confirmButtonText,
        cancelButtonText: cancelButtonText,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }

  /// Show a simple info dialog
  static Future<void> showInfo({
    required BuildContext context,
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onConfirm,
  }) {
    return show(
      context: context,
      title: title,
      message: message,
      type: AppDialogType.info,
      confirmButtonText: buttonText ?? 'OK',
      onConfirm: onConfirm,
    );
  }

  /// Show a success dialog
  static Future<void> showSuccess({
    required BuildContext context,
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onConfirm,
  }) {
    return show(
      context: context,
      title: title,
      message: message,
      type: AppDialogType.success,
      confirmButtonText: buttonText ?? 'OK',
      onConfirm: onConfirm,
    );
  }

  /// Show a warning dialog
  static Future<void> showWarning({
    required BuildContext context,
    required String title,
    required String message,
    String? confirmButtonText,
    String? cancelButtonText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return show(
      context: context,
      title: title,
      message: message,
      type: AppDialogType.warning,
      confirmButtonText: confirmButtonText ?? 'OK',
      cancelButtonText: cancelButtonText ?? 'Cancel',
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  /// Show an error dialog
  static Future<void> showError({
    required BuildContext context,
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onConfirm,
  }) {
    return show(
      context: context,
      title: title,
      message: message,
      type: AppDialogType.error,
      confirmButtonText: buttonText ?? 'OK',
      onConfirm: onConfirm,
    );
  }

  /// Show a confirmation dialog
  static Future<bool?> showConfirmation({
    required BuildContext context,
    required String title,
    required String message,
    String? confirmButtonText,
    String? cancelButtonText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return show<bool>(
      context: context,
      title: title,
      message: message,
      type: AppDialogType.confirmation,
      confirmButtonText: confirmButtonText ?? 'Yes',
      cancelButtonText: cancelButtonText ?? 'Cancel',
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // Determine icon based on type
    final IconData dialogIcon = customIcon ??
        switch (type) {
          AppDialogType.info => Icons.info_outline,
          AppDialogType.success => Icons.check_circle_outline,
          AppDialogType.warning => Icons.warning_amber_outlined,
          AppDialogType.error => Icons.error_outline,
          AppDialogType.confirmation => Icons.help_outline,
        };

    // Determine icon color based on type
    final Color iconColor = switch (type) {
      AppDialogType.info => colors.primary,
      AppDialogType.success => Colors.green,
      AppDialogType.warning => Colors.orange,
      AppDialogType.error => colors.error,
      AppDialogType.confirmation => colors.primary,
    };

    // Build dialog title with optional icon
    final Widget dialogTitle = Row(
      children: [
        if (titleIcon ?? true) ...[
          Icon(
            dialogIcon,
            color: iconColor,
            size: 24,
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: AppText.titleLarge(
            title,
            color: theme.colorScheme.onSurface,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );

    // Build dialog content
    final Widget dialogContent = Padding(
      padding: const EdgeInsets.only(top: 16),
      child: AppText.bodyMedium(
        message,
        color: theme.colorScheme.onSurface.withOpacity(0.8),
      ),
    );

    // Determine action buttons
    final List<Widget> actionButtons = actions ??
        [
          if (cancelButtonText != null || onCancel != null)
            AppButton(
              label: cancelButtonText ?? 'Cancel',
              variant: AppButtonVariant.text,
              onPressed: () {
                Navigator.of(context).pop(false);
                onCancel?.call();
              },
            ),
          AppButton(
            label: confirmButtonText ?? 'OK',
            variant: type == AppDialogType.error || type == AppDialogType.warning
                ? AppButtonVariant.primary
                : AppButtonVariant.primary,
            onPressed: () {
              Navigator.of(context).pop(true);
              onConfirm?.call();
            },
          ),
        ];

    return AlertDialog(
      title: dialogTitle,
      content: scrollable ? SingleChildScrollView(child: dialogContent) : dialogContent,
      actions: actionButtons,
      insetPadding: insetPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppThemeConfig.radiusM),
      ),
    );
  }
}
