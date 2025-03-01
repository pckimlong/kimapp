import 'package:flutter/material.dart';

import '../../../core/helpers/build_context_helper.dart';

/// Base class for all themed widgets in the application
///
/// This class provides a consistent way to build widgets that adapt to the
/// application theme. All widgets that need to adapt to the theme should
/// extend this class and implement the [buildWithTheme] method.
abstract class AppBaseWidget extends StatelessWidget {
  /// Creates a base widget
  const AppBaseWidget({super.key});

  /// Builds the widget with the current theme
  ///
  /// This method is called by the [build] method and should be implemented
  /// by subclasses to build the widget with the current theme.
  Widget buildWithTheme(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return buildWithTheme(context);
  }
}

/// A widget that applies a theme to its child
///
/// This widget is useful for applying a specific theme to a subtree of the
/// widget tree. It can be used to override the theme for a specific part of
/// the UI.
class AppThemedWidget extends AppBaseWidget {
  /// Creates a themed widget
  const AppThemedWidget({
    super.key,
    required this.child,
    this.themeData,
    this.themeMode,
    this.darkTheme,
  });

  /// The widget to which the theme will be applied
  final Widget child;

  /// The theme data to apply
  final ThemeData? themeData;

  /// The theme mode to use
  final ThemeMode? themeMode;

  /// The dark theme data to apply
  final ThemeData? darkTheme;

  @override
  Widget buildWithTheme(BuildContext context) {
    // If no theme customization is provided, just return the child
    if (themeData == null && themeMode == null && darkTheme == null) {
      return child;
    }

    // Get the current theme
    final currentTheme = Theme.of(context);

    // Create a new theme with the provided customizations
    return Theme(
      data: themeData ?? currentTheme,
      child: themeMode != null || darkTheme != null
          ? Builder(
              builder: (context) {
                return child;
              },
            )
          : child,
    );
  }
}

/// Mixin for stateful widgets to provide theme access
mixin AppThemeMixin<T extends StatefulWidget> on State<T> {
  /// Access the current theme easily
  ThemeData get theme => context.theme;

  /// Access the color scheme easily
  ColorScheme get colors => theme.colorScheme;

  /// Access the text theme easily
  TextTheme get textTheme => theme.textTheme;
}

/// Theme configuration for application widgets
class AppThemeConfig {
  const AppThemeConfig._();

  // Default padding values
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;

  // Default border radius values
  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;

  // Animation durations
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationMedium = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
}
