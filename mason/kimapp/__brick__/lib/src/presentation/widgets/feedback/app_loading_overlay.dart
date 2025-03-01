import 'package:flutter/material.dart';

import '../theme/base_widget.dart';
import 'app_progress.dart';

/// A loading overlay that can be displayed over any widget to indicate loading state
class AppLoadingOverlay extends AppBaseWidget {
  const AppLoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.opacity = 0.7,
    this.color,
    this.progressSize = AppProgressSize.medium,
    this.progressColor,
    this.message,
    this.dismissible = false,
    this.onDismiss,
  });

  /// The widget to display behind the loading overlay
  final Widget child;

  /// Whether the loading overlay is visible
  final bool isLoading;

  /// The opacity of the overlay background
  final double opacity;

  /// The color of the overlay background
  final Color? color;

  /// The size of the progress indicator
  final AppProgressSize progressSize;

  /// The color of the progress indicator
  final Color? progressColor;

  /// Optional message to display below the progress indicator
  final String? message;

  /// Whether the overlay can be dismissed by tapping
  final bool dismissible;

  /// Callback when the overlay is dismissed
  final VoidCallback? onDismiss;

  @override
  Widget buildWithTheme(BuildContext context) {
    return Stack(
      children: [
        // The main content
        child,

        // The loading overlay
        if (isLoading)
          Positioned.fill(
            child: _buildOverlay(context),
          ),
      ],
    );
  }

  Widget _buildOverlay(BuildContext context) {
    final theme = Theme.of(context);
    final overlayColor = color ?? theme.colorScheme.surface;

    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: dismissible ? onDismiss : null,
        child: Container(
          color: overlayColor.withOpacity(opacity),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Progress indicator
                AppProgress(
                  size: progressSize,
                  color: progressColor,
                ),

                // Optional message
                if (message != null) ...[
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      message!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Extension method to easily wrap any widget with a loading overlay
extension LoadingOverlayExtension on Widget {
  /// Wraps this widget with an [AppLoadingOverlay]
  Widget withLoadingOverlay({
    required bool isLoading,
    double opacity = 0.7,
    Color? color,
    AppProgressSize progressSize = AppProgressSize.medium,
    Color? progressColor,
    String? message,
    bool dismissible = false,
    VoidCallback? onDismiss,
  }) {
    return AppLoadingOverlay(
      isLoading: isLoading,
      opacity: opacity,
      color: color,
      progressSize: progressSize,
      progressColor: progressColor,
      message: message,
      dismissible: dismissible,
      onDismiss: onDismiss,
      child: this,
    );
  }
}
