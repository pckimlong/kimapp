import 'package:flutter/material.dart';

import '../theme/base_widget.dart';
import '../typography/app_text.dart';

/// Defines the style options for progress indicators
enum AppProgressStyle {
  circular,
  linear,
}

/// Defines the size options for circular progress indicators
enum AppProgressSize {
  small, // 24.0
  medium, // 36.0
  large, // 48.0
  xlarge, // 64.0
}

/// A customizable progress indicator component that adapts to the application theme
/// and provides consistent styling across the app.
class AppProgress extends AppBaseWidget {
  const AppProgress({
    super.key,
    this.value,
    this.style = AppProgressStyle.circular,
    this.size = AppProgressSize.medium,
    this.color,
    this.backgroundColor,
    this.strokeWidth,
    this.label,
    this.showPercentage = false,
    this.percentageStyle,
    this.minHeight,
    this.borderRadius,
    this.padding,
    this.alignment = Alignment.center,
  });

  /// The value of the progress indicator (null for indeterminate)
  final double? value;

  /// The style of the progress indicator
  final AppProgressStyle style;

  /// The size of the circular progress indicator
  final AppProgressSize size;

  /// The color of the progress indicator
  final Color? color;

  /// The background color of the progress indicator
  final Color? backgroundColor;

  /// The width of the progress indicator stroke
  final double? strokeWidth;

  /// Optional label to display with the progress indicator
  final String? label;

  /// Whether to show the percentage value
  final bool showPercentage;

  /// Custom style for the percentage text
  final TextStyle? percentageStyle;

  /// Minimum height for linear progress indicator
  final double? minHeight;

  /// Border radius for linear progress indicator
  final double? borderRadius;

  /// Padding around the progress indicator
  final EdgeInsetsGeometry? padding;

  /// Alignment of the progress indicator
  final Alignment alignment;

  @override
  Widget buildWithTheme(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // Determine progress color
    final progressColor = color ?? colors.primary;

    // Determine background color
    final progressBackgroundColor = backgroundColor ?? colors.surfaceContainerHighest;

    // Create the progress indicator based on style
    Widget progressIndicator;

    if (style == AppProgressStyle.circular) {
      // Determine size for circular progress
      final dimension = switch (size) {
        AppProgressSize.small => 24.0,
        AppProgressSize.medium => 36.0,
        AppProgressSize.large => 48.0,
        AppProgressSize.xlarge => 64.0,
      };

      // Determine stroke width based on size
      final actualStrokeWidth = strokeWidth ??
          switch (size) {
            AppProgressSize.small => 2.0,
            AppProgressSize.medium => 3.0,
            AppProgressSize.large => 4.0,
            AppProgressSize.xlarge => 5.0,
          };

      // Create circular progress indicator
      progressIndicator = SizedBox(
        width: dimension,
        height: dimension,
        child: value != null
            ? Stack(
                alignment: Alignment.center,
                children: [
                  // Progress indicator
                  CircularProgressIndicator(
                    value: value,
                    strokeWidth: actualStrokeWidth,
                    valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                    backgroundColor: progressBackgroundColor,
                  ),

                  // Percentage text if enabled
                  if (showPercentage)
                    AppText(
                      '${(value! * 100).toInt()}%',
                      style: percentageStyle ??
                          TextStyle(
                            fontSize: dimension / 4,
                            fontWeight: FontWeight.bold,
                            color: colors.onSurface,
                          ),
                    ),
                ],
              )
            : CircularProgressIndicator(
                strokeWidth: actualStrokeWidth,
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                backgroundColor: progressBackgroundColor,
              ),
      );
    } else {
      // Linear progress indicator
      final actualMinHeight = minHeight ?? 6.0;
      final actualBorderRadius = borderRadius ?? 4.0;

      // Create linear progress indicator
      progressIndicator = ClipRRect(
        borderRadius: BorderRadius.circular(actualBorderRadius),
        child: value != null
            ? LinearProgressIndicator(
                value: value,
                minHeight: actualMinHeight,
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                backgroundColor: progressBackgroundColor,
              )
            : LinearProgressIndicator(
                minHeight: actualMinHeight,
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                backgroundColor: progressBackgroundColor,
              ),
      );
    }

    // Add label if provided
    if (label != null) {
      final labelWidget = AppText(
        label!,
        color: colors.onSurface,
        variant: AppTextVariant.bodyMedium,
      );

      // Arrange label and progress indicator based on style
      if (style == AppProgressStyle.circular) {
        progressIndicator = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            progressIndicator,
            const SizedBox(height: 8),
            labelWidget,
            if (showPercentage && value != null && style == AppProgressStyle.linear)
              AppText(
                '${(value! * 100).toInt()}%',
                style: percentageStyle,
                variant: AppTextVariant.bodySmall,
                color: colors.onSurface.withOpacity(0.7),
              ),
          ],
        );
      } else {
        progressIndicator = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                labelWidget,
                if (showPercentage && value != null)
                  AppText(
                    '${(value! * 100).toInt()}%',
                    style: percentageStyle,
                    variant: AppTextVariant.bodySmall,
                    color: colors.onSurface.withOpacity(0.7),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            progressIndicator,
          ],
        );
      }
    } else if (showPercentage && value != null && style == AppProgressStyle.linear) {
      // Show percentage for linear progress without label
      progressIndicator = Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            '${(value! * 100).toInt()}%',
            style: percentageStyle,
            variant: AppTextVariant.bodySmall,
            color: colors.onSurface.withOpacity(0.7),
          ),
          const SizedBox(height: 4),
          progressIndicator,
        ],
      );
    }

    // Apply padding if provided
    if (padding != null) {
      progressIndicator = Padding(
        padding: padding!,
        child: progressIndicator,
      );
    }

    // Apply alignment
    return Align(
      alignment: alignment,
      child: progressIndicator,
    );
  }
}
