import 'package:flutter/material.dart';

/// Defines the position of the toast on the screen
enum AppToastPosition {
  top,
  center,
  bottom,
}

/// Defines the type of toast to display
enum AppToastType {
  /// For general information messages
  info,

  /// For success messages
  success,

  /// For warning messages
  warning,

  /// For error messages
  error,
}

/// A customizable toast component that displays short-lived messages
class AppToast {
  /// Shows a toast with the given message
  static void show({
    required BuildContext context,
    required String message,
    AppToastType type = AppToastType.info,
    AppToastPosition position = AppToastPosition.bottom,
    Duration duration = const Duration(seconds: 2),
    EdgeInsetsGeometry? margin,
    double? width,
    bool dismissible = true,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Determine colors based on type
    final Color backgroundColor;
    final Color foregroundColor;
    final IconData icon;

    switch (type) {
      case AppToastType.info:
        backgroundColor = colorScheme.primary;
        foregroundColor = colorScheme.onPrimary;
        icon = Icons.info_outline;
      case AppToastType.success:
        backgroundColor = Colors.green.shade700;
        foregroundColor = Colors.white;
        icon = Icons.check_circle_outline;
      case AppToastType.warning:
        backgroundColor = Colors.orange.shade700;
        foregroundColor = Colors.white;
        icon = Icons.warning_amber_outlined;
      case AppToastType.error:
        backgroundColor = Colors.red.shade700;
        foregroundColor = Colors.white;
        icon = Icons.error_outline;
    }

    // Determine position
    final Alignment alignment;
    final double topOffset;
    final double bottomOffset;

    switch (position) {
      case AppToastPosition.top:
        alignment = Alignment.topCenter;
        topOffset = 50.0;
        bottomOffset = 0.0;
      case AppToastPosition.center:
        alignment = Alignment.center;
        topOffset = 0.0;
        bottomOffset = 0.0;
      case AppToastPosition.bottom:
        alignment = Alignment.bottomCenter;
        topOffset = 0.0;
        bottomOffset = 50.0;
    }

    // Create the overlay entry
    final overlayState = Overlay.of(context);
    late final OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: topOffset > 0 ? topOffset : null,
          bottom: bottomOffset > 0 ? bottomOffset : null,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Align(
              alignment: alignment,
              child: _ToastWidget(
                message: message,
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                icon: icon,
                margin: margin,
                width: width,
                dismissible: dismissible,
                onDismiss: () {
                  overlayEntry.remove();
                },
              ),
            ),
          ),
        );
      },
    );

    // Show the overlay
    overlayState.insert(overlayEntry);

    // Remove after duration
    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  /// Shows an info toast
  static void showInfo({
    required BuildContext context,
    required String message,
    AppToastPosition position = AppToastPosition.bottom,
    Duration duration = const Duration(seconds: 2),
    EdgeInsetsGeometry? margin,
    double? width,
    bool dismissible = true,
  }) {
    show(
      context: context,
      message: message,
      type: AppToastType.info,
      position: position,
      duration: duration,
      margin: margin,
      width: width,
      dismissible: dismissible,
    );
  }

  /// Shows a success toast
  static void showSuccess({
    required BuildContext context,
    required String message,
    AppToastPosition position = AppToastPosition.bottom,
    Duration duration = const Duration(seconds: 2),
    EdgeInsetsGeometry? margin,
    double? width,
    bool dismissible = true,
  }) {
    show(
      context: context,
      message: message,
      type: AppToastType.success,
      position: position,
      duration: duration,
      margin: margin,
      width: width,
      dismissible: dismissible,
    );
  }

  /// Shows a warning toast
  static void showWarning({
    required BuildContext context,
    required String message,
    AppToastPosition position = AppToastPosition.bottom,
    Duration duration = const Duration(seconds: 2),
    EdgeInsetsGeometry? margin,
    double? width,
    bool dismissible = true,
  }) {
    show(
      context: context,
      message: message,
      type: AppToastType.warning,
      position: position,
      duration: duration,
      margin: margin,
      width: width,
      dismissible: dismissible,
    );
  }

  /// Shows an error toast
  static void showError({
    required BuildContext context,
    required String message,
    AppToastPosition position = AppToastPosition.bottom,
    Duration duration = const Duration(seconds: 2),
    EdgeInsetsGeometry? margin,
    double? width,
    bool dismissible = true,
  }) {
    show(
      context: context,
      message: message,
      type: AppToastType.error,
      position: position,
      duration: duration,
      margin: margin,
      width: width,
      dismissible: dismissible,
    );
  }
}

/// The widget that displays the toast
class _ToastWidget extends StatefulWidget {
  const _ToastWidget({
    required this.message,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    this.margin,
    this.width,
    this.dismissible = true,
    this.onDismiss,
  });

  final String message;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final bool dismissible;
  final VoidCallback? onDismiss;

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final actualMargin = widget.margin ?? const EdgeInsets.symmetric(horizontal: 16.0);
    final actualWidth = widget.width ?? 300.0;

    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(_animation),
        child: GestureDetector(
          onTap: widget.dismissible ? widget.onDismiss : null,
          child: Container(
            margin: actualMargin,
            width: actualWidth,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Row(
                children: [
                  Icon(
                    widget.icon,
                    color: widget.foregroundColor,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: TextStyle(
                        color: widget.foregroundColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  if (widget.dismissible)
                    GestureDetector(
                      onTap: widget.onDismiss,
                      child: Icon(
                        Icons.close,
                        color: widget.foregroundColor.withOpacity(0.7),
                        size: 20,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Extension method to easily show toasts from a BuildContext
extension ToastContextExtension on BuildContext {
  /// Shows an info toast
  void showInfoToast(
    String message, {
    AppToastPosition position = AppToastPosition.bottom,
    Duration duration = const Duration(seconds: 2),
    EdgeInsetsGeometry? margin,
    double? width,
    bool dismissible = true,
  }) {
    AppToast.showInfo(
      context: this,
      message: message,
      position: position,
      duration: duration,
      margin: margin,
      width: width,
      dismissible: dismissible,
    );
  }

  /// Shows a success toast
  void showSuccessToast(
    String message, {
    AppToastPosition position = AppToastPosition.bottom,
    Duration duration = const Duration(seconds: 2),
    EdgeInsetsGeometry? margin,
    double? width,
    bool dismissible = true,
  }) {
    AppToast.showSuccess(
      context: this,
      message: message,
      position: position,
      duration: duration,
      margin: margin,
      width: width,
      dismissible: dismissible,
    );
  }

  /// Shows a warning toast
  void showWarningToast(
    String message, {
    AppToastPosition position = AppToastPosition.bottom,
    Duration duration = const Duration(seconds: 2),
    EdgeInsetsGeometry? margin,
    double? width,
    bool dismissible = true,
  }) {
    AppToast.showWarning(
      context: this,
      message: message,
      position: position,
      duration: duration,
      margin: margin,
      width: width,
      dismissible: dismissible,
    );
  }

  /// Shows an error toast
  void showErrorToast(
    String message, {
    AppToastPosition position = AppToastPosition.bottom,
    Duration duration = const Duration(seconds: 2),
    EdgeInsetsGeometry? margin,
    double? width,
    bool dismissible = true,
  }) {
    AppToast.showError(
      context: this,
      message: message,
      position: position,
      duration: duration,
      margin: margin,
      width: width,
      dismissible: dismissible,
    );
  }
}
