import 'package:flutter/material.dart';

import '../theme/base_widget.dart';

/// Defines the size options for avatar components
enum AppAvatarSize {
  xsmall, // 24.0
  small, // 32.0
  medium, // 48.0
  large, // 64.0
  xlarge, // 80.0
}

/// Avatar display style
enum AppAvatarStyle {
  circle,
  rounded,
  square,
}

/// A customizable avatar component that adapts to the application theme
/// and provides consistent styling across the app.
class AppAvatar extends AppBaseWidget {
  const AppAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.size = AppAvatarSize.medium,
    this.style = AppAvatarStyle.circle,
    this.borderWidth = 0.0,
    this.borderColor,
    this.onTap,
  }) : assert(
          (imageUrl != null) || (initials != null) || (icon != null),
          'At least one of imageUrl, initials, or icon must be provided',
        );

  /// URL for the avatar image
  final String? imageUrl;

  /// Initials to display when no image is available
  final String? initials;

  /// Icon to display when no image or initials are available
  final IconData? icon;

  /// Background color for initials or icon
  final Color? backgroundColor;

  /// Text/Icon color for initials or icon
  final Color? foregroundColor;

  /// Size of the avatar
  final AppAvatarSize size;

  /// Shape style of the avatar
  final AppAvatarStyle style;

  /// Width of the border around the avatar
  final double borderWidth;

  /// Color of the border (uses theme primary if null)
  final Color? borderColor;

  /// Optional callback when avatar is tapped
  final VoidCallback? onTap;

  @override
  Widget buildWithTheme(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // Determine avatar size
    final dimension = switch (size) {
      AppAvatarSize.xsmall => 24.0,
      AppAvatarSize.small => 32.0,
      AppAvatarSize.medium => 48.0,
      AppAvatarSize.large => 64.0,
      AppAvatarSize.xlarge => 80.0,
    };

    // Determine font size based on avatar size
    final fontSize = switch (size) {
      AppAvatarSize.xsmall => 10.0,
      AppAvatarSize.small => 14.0,
      AppAvatarSize.medium => 18.0,
      AppAvatarSize.large => 24.0,
      AppAvatarSize.xlarge => 32.0,
    };

    // Determine icon size based on avatar size
    final iconSize = switch (size) {
      AppAvatarSize.xsmall => 12.0,
      AppAvatarSize.small => 16.0,
      AppAvatarSize.medium => 24.0,
      AppAvatarSize.large => 32.0,
      AppAvatarSize.xlarge => 40.0,
    };

    // Determine border radius based on style
    final borderRadius = switch (style) {
      AppAvatarStyle.circle => dimension / 2,
      AppAvatarStyle.rounded => 8.0,
      AppAvatarStyle.square => 0.0,
    };

    // Default background color
    final bgColor = backgroundColor ?? colors.primaryContainer;

    // Default foreground color
    final fgColor = foregroundColor ?? colors.onPrimaryContainer;

    // Default border color
    final actualBorderColor = borderColor ?? colors.primary;

    // Build widget content based on provided data
    Widget content;

    if (imageUrl != null) {
      // Image avatar
      content = Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        width: dimension,
        height: dimension,
        errorBuilder: (context, error, stackTrace) {
          // Fallback to initials or icon if image fails to load
          if (initials != null) {
            return Center(
              child: Text(
                initials!,
                style: TextStyle(
                  color: fgColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else if (icon != null) {
            return Icon(
              icon,
              size: iconSize,
              color: fgColor,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );
    } else if (initials != null) {
      // Initials avatar
      content = Center(
        child: Text(
          initials!,
          style: TextStyle(
            color: fgColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      // Icon avatar
      content = Center(
        child: Icon(
          icon,
          size: iconSize,
          color: fgColor,
        ),
      );
    }

    // Create container with styling
    Widget avatar = Container(
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(
        color: imageUrl != null ? null : bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderWidth > 0
            ? Border.all(
                color: actualBorderColor,
                width: borderWidth,
              )
            : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: content,
    );

    // Add tap functionality if provided
    if (onTap != null) {
      avatar = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: avatar,
      );
    }

    return avatar;
  }
}
