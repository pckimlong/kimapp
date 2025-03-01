import 'package:flutter/material.dart';

import '../theme/base_widget.dart';

/// Defines the variant of text to display
enum AppTextVariant {
  /// Display large text (typically 57px)
  displayLarge,

  /// Display medium text (typically 45px)
  displayMedium,

  /// Display small text (typically 36px)
  displaySmall,

  /// Headline large text (typically 32px)
  headlineLarge,

  /// Headline medium text (typically 28px)
  headlineMedium,

  /// Headline small text (typically 24px)
  headlineSmall,

  /// Title large text (typically 22px)
  titleLarge,

  /// Title medium text (typically 16px)
  titleMedium,

  /// Title small text (typically 14px)
  titleSmall,

  /// Body large text (typically 16px)
  bodyLarge,

  /// Body medium text (typically 14px)
  bodyMedium,

  /// Body small text (typically 12px)
  bodySmall,

  /// Label large text (typically 14px)
  labelLarge,

  /// Label medium text (typically 12px)
  labelMedium,

  /// Label small text (typically 11px)
  labelSmall,
}

/// A customizable text component that adapts to the application theme
/// and provides consistent typography across the app.
class AppText extends AppBaseWidget {
  const AppText(
    this.text, {
    super.key,
    this.variant,
    this.style,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
    this.height,
    this.leadingDistribution,
    this.locale,
    this.foreground,
    this.background,
    this.shadows,
    this.fontFeatures,
    this.fontVariations,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.debugLabel,
    this.fontFamily,
    this.fontFamilyFallback,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.strutStyle,
    this.textScaler,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  });

  /// Factory constructors for common text styles
  const factory AppText.displayLarge(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    TextStyle? style,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    FontStyle? fontStyle,
  }) = _DisplayLargeText;

  const factory AppText.displayMedium(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    TextStyle? style,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    FontStyle? fontStyle,
  }) = _DisplayMediumText;

  const factory AppText.displaySmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    TextStyle? style,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    FontStyle? fontStyle,
  }) = _DisplaySmallText;

  const factory AppText.headlineLarge(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    TextStyle? style,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    FontStyle? fontStyle,
  }) = _HeadlineLargeText;

  const factory AppText.headlineMedium(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    TextStyle? style,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    FontStyle? fontStyle,
  }) = _HeadlineMediumText;

  const factory AppText.headlineSmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    TextStyle? style,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    FontStyle? fontStyle,
  }) = _HeadlineSmallText;

  const factory AppText.titleLarge(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    TextStyle? style,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    FontStyle? fontStyle,
  }) = _TitleLargeText;

  const factory AppText.titleMedium(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    TextStyle? style,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    FontStyle? fontStyle,
  }) = _TitleMediumText;

  const factory AppText.titleSmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    TextStyle? style,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    FontStyle? fontStyle,
  }) = _TitleSmallText;

  const factory AppText.bodyLarge(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    TextStyle? style,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    FontStyle? fontStyle,
  }) = _BodyLargeText;

  const factory AppText.bodyMedium(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    TextStyle? style,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    FontStyle? fontStyle,
  }) = _BodyMediumText;

  const factory AppText.bodySmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    TextStyle? style,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    FontStyle? fontStyle,
  }) = _BodySmallText;

  const factory AppText.labelLarge(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    TextStyle? style,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    FontStyle? fontStyle,
  }) = _LabelLargeText;

  const factory AppText.labelMedium(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    TextStyle? style,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    FontStyle? fontStyle,
  }) = _LabelMediumText;

  const factory AppText.labelSmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    TextStyle? style,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    FontStyle? fontStyle,
  }) = _LabelSmallText;

  /// The text to display
  final String text;

  /// The variant of text to display
  final AppTextVariant? variant;

  /// The style of the text
  final TextStyle? style;

  /// The color of the text
  final Color? color;

  /// The weight of the font
  final FontWeight? fontWeight;

  /// The size of the font
  final double? fontSize;

  /// The style of the font
  final FontStyle? fontStyle;

  /// The letter spacing of the text
  final double? letterSpacing;

  /// The word spacing of the text
  final double? wordSpacing;

  /// The text baseline to use
  final TextBaseline? textBaseline;

  /// The height of the text
  final double? height;

  /// The leading distribution of the text
  final TextLeadingDistribution? leadingDistribution;

  /// The locale of the text
  final Locale? locale;

  /// The foreground paint of the text
  final Paint? foreground;

  /// The background paint of the text
  final Paint? background;

  /// The shadows of the text
  final List<Shadow>? shadows;

  /// The font features of the text
  final List<FontFeature>? fontFeatures;

  /// The font variations of the text
  final List<FontVariation>? fontVariations;

  /// The decoration of the text
  final TextDecoration? decoration;

  /// The color of the decoration
  final Color? decorationColor;

  /// The style of the decoration
  final TextDecorationStyle? decorationStyle;

  /// The thickness of the decoration
  final double? decorationThickness;

  /// The debug label of the text
  final String? debugLabel;

  /// The font family of the text
  final String? fontFamily;

  /// The font family fallback of the text
  final List<String>? fontFamilyFallback;

  /// How to handle text overflow
  final TextOverflow? overflow;

  /// The maximum number of lines to display
  final int? maxLines;

  /// The alignment of the text
  final TextAlign? textAlign;

  /// The direction of the text
  final TextDirection? textDirection;

  /// Whether to wrap text at soft line breaks
  final bool? softWrap;

  /// The strut style of the text
  final StrutStyle? strutStyle;

  /// The text scaler of the text
  final TextScaler? textScaler;

  /// The text width basis of the text
  final TextWidthBasis? textWidthBasis;

  /// The text height behavior of the text
  final TextHeightBehavior? textHeightBehavior;

  /// The selection color of the text
  final Color? selectionColor;

  @override
  Widget buildWithTheme(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    // Determine the base text style based on the variant
    TextStyle baseStyle = style ?? const TextStyle();

    if (variant != null) {
      baseStyle = switch (variant!) {
        AppTextVariant.displayLarge => textTheme.displayLarge!,
        AppTextVariant.displayMedium => textTheme.displayMedium!,
        AppTextVariant.displaySmall => textTheme.displaySmall!,
        AppTextVariant.headlineLarge => textTheme.headlineLarge!,
        AppTextVariant.headlineMedium => textTheme.headlineMedium!,
        AppTextVariant.headlineSmall => textTheme.headlineSmall!,
        AppTextVariant.titleLarge => textTheme.titleLarge!,
        AppTextVariant.titleMedium => textTheme.titleMedium!,
        AppTextVariant.titleSmall => textTheme.titleSmall!,
        AppTextVariant.bodyLarge => textTheme.bodyLarge!,
        AppTextVariant.bodyMedium => textTheme.bodyMedium!,
        AppTextVariant.bodySmall => textTheme.bodySmall!,
        AppTextVariant.labelLarge => textTheme.labelLarge!,
        AppTextVariant.labelMedium => textTheme.labelMedium!,
        AppTextVariant.labelSmall => textTheme.labelSmall!,
      };
    }

    // Apply custom styling on top of the base style
    final effectiveStyle = baseStyle.copyWith(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      leadingDistribution: leadingDistribution,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      fontVariations: fontVariations,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );

    // Create the text widget with the effective style
    return Text(
      text,
      style: effectiveStyle,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      strutStyle: strutStyle,
      textScaler: textScaler,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}

// Factory implementation classes for named constructors
class _DisplayLargeText extends AppText {
  const _DisplayLargeText(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.style,
    super.fontWeight,
    super.fontSize,
    super.letterSpacing,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.fontStyle,
  }) : super(variant: AppTextVariant.displayLarge);
}

class _DisplayMediumText extends AppText {
  const _DisplayMediumText(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.style,
    super.fontWeight,
    super.fontSize,
    super.letterSpacing,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.fontStyle,
  }) : super(variant: AppTextVariant.displayMedium);
}

class _DisplaySmallText extends AppText {
  const _DisplaySmallText(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.style,
    super.fontWeight,
    super.fontSize,
    super.letterSpacing,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.fontStyle,
  }) : super(variant: AppTextVariant.displaySmall);
}

class _HeadlineLargeText extends AppText {
  const _HeadlineLargeText(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.style,
    super.fontWeight,
    super.fontSize,
    super.letterSpacing,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.fontStyle,
  }) : super(variant: AppTextVariant.headlineLarge);
}

class _HeadlineMediumText extends AppText {
  const _HeadlineMediumText(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.style,
    super.fontWeight,
    super.fontSize,
    super.letterSpacing,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.fontStyle,
  }) : super(variant: AppTextVariant.headlineMedium);
}

class _HeadlineSmallText extends AppText {
  const _HeadlineSmallText(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.style,
    super.fontWeight,
    super.fontSize,
    super.letterSpacing,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.fontStyle,
  }) : super(variant: AppTextVariant.headlineSmall);
}

class _TitleLargeText extends AppText {
  const _TitleLargeText(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.style,
    super.fontWeight,
    super.fontSize,
    super.letterSpacing,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.fontStyle,
  }) : super(variant: AppTextVariant.titleLarge);
}

class _TitleMediumText extends AppText {
  const _TitleMediumText(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.style,
    super.fontWeight,
    super.fontSize,
    super.letterSpacing,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.fontStyle,
  }) : super(variant: AppTextVariant.titleMedium);
}

class _TitleSmallText extends AppText {
  const _TitleSmallText(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.style,
    super.fontWeight,
    super.fontSize,
    super.letterSpacing,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.fontStyle,
  }) : super(variant: AppTextVariant.titleSmall);
}

class _BodyLargeText extends AppText {
  const _BodyLargeText(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.style,
    super.fontWeight,
    super.fontSize,
    super.letterSpacing,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.fontStyle,
  }) : super(variant: AppTextVariant.bodyLarge);
}

class _BodyMediumText extends AppText {
  const _BodyMediumText(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.style,
    super.fontWeight,
    super.fontSize,
    super.letterSpacing,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.fontStyle,
  }) : super(variant: AppTextVariant.bodyMedium);
}

class _BodySmallText extends AppText {
  const _BodySmallText(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.style,
    super.fontWeight,
    super.fontSize,
    super.letterSpacing,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.fontStyle,
  }) : super(variant: AppTextVariant.bodySmall);
}

class _LabelLargeText extends AppText {
  const _LabelLargeText(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.style,
    super.fontWeight,
    super.fontSize,
    super.letterSpacing,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.fontStyle,
  }) : super(variant: AppTextVariant.labelLarge);
}

class _LabelMediumText extends AppText {
  const _LabelMediumText(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.style,
    super.fontWeight,
    super.fontSize,
    super.letterSpacing,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.fontStyle,
  }) : super(variant: AppTextVariant.labelMedium);
}

class _LabelSmallText extends AppText {
  const _LabelSmallText(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
    super.style,
    super.fontWeight,
    super.fontSize,
    super.letterSpacing,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.fontStyle,
  }) : super(variant: AppTextVariant.labelSmall);
}
