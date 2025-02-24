import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_extension.freezed.dart';

/// A theme extension for Kimapp that provides utility functions and widgets for UI customization
///
/// This extension allows you to define and access common UI elements and behaviors across your app:
/// - Custom loading state widgets
/// - Error state widgets
/// - Other UI utility functions
///
/// To initialize this extension, add it to your theme data in your top level widget
/// (typically in the MaterialApp builder or root widget):
///
/// ```dart
/// MaterialApp(
///   theme: ThemeData(
///     extensions: [
///       KimappThemeExtension(
///         defaultLoadingStateWidget: (context, ref) => CircularProgressIndicator(),
///         defaultErrorStateWidget: (context, ref, error) => Text(error.toString()),
///       ),
///     ],
///   ),
/// )
/// ```
///
/// To access the extension and its properties from anywhere in your widget tree:
///
/// ```dart
/// final themeExtension = Theme.of(context).extension<KimappThemeExtension>();
/// if (themeExtension?.defaultLoadingStateWidget != null) {
///   return themeExtension!.defaultLoadingStateWidget!(context, ref);
/// }
/// ```
///
/// The extension supports theme inheritance and can be customized per-theme
/// (e.g. different implementations for light/dark modes).
class KimappThemeExtension extends ThemeExtension<KimappThemeExtension> {
  final Widget Function(BuildContext context, WidgetRef ref)? defaultLoadingStateWidget;
  final Widget Function(BuildContext context, WidgetRef ref, Object error)? defaultErrorStateWidget;

  const KimappThemeExtension({
    this.defaultLoadingStateWidget,
    this.defaultErrorStateWidget,
  });

  @override
  ThemeExtension<KimappThemeExtension> copyWith({
    Widget Function(BuildContext context, WidgetRef ref)? defaultLoadingStateWidget,
    Widget Function(BuildContext context, WidgetRef ref, Object error)? defaultErrorStateWidget,
  }) {
    return KimappThemeExtension(
      defaultLoadingStateWidget: defaultLoadingStateWidget ?? this.defaultLoadingStateWidget,
      defaultErrorStateWidget: defaultErrorStateWidget ?? this.defaultErrorStateWidget,
    );
  }

  @override
  ThemeExtension<KimappThemeExtension> lerp(
    covariant ThemeExtension<KimappThemeExtension>? other,
    double t,
  ) {
    if (other is! KimappThemeExtension) return this;
    return KimappThemeExtension(
      defaultLoadingStateWidget:
          t < 0.5 ? defaultLoadingStateWidget : other.defaultLoadingStateWidget,
      defaultErrorStateWidget: t < 0.5 ? defaultErrorStateWidget : other.defaultErrorStateWidget,
    );
  }
}
