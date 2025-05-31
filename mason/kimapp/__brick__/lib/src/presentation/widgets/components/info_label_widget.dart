import 'package:flutter/material.dart';

import '../../../core/helpers/build_context_helper.dart';
import '../../app/app_style.dart';
import '../core/buttons/app_text_button.dart';

class InfoLabelTheme extends InheritedTheme {
  const InfoLabelTheme({
    super.key,
    this.labelStyle,
    this.labelWidth = 80,
    required super.child,
    this.isHorizontal = false,
  });

  final TextStyle? labelStyle;

  /// Horizontal label width
  final double labelWidth;
  final bool isHorizontal;

  static InfoLabelTheme? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InfoLabelTheme>();
  }

  @override
  bool updateShouldNotify(InfoLabelTheme oldWidget) {
    return labelStyle != oldWidget.labelStyle || labelWidth != oldWidget.labelWidth;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return InfoLabelTheme(
      labelWidth: labelWidth,
      labelStyle: labelStyle,
      child: child,
    );
  }
}

class AppInfoLabel extends StatelessWidget {
  const AppInfoLabel({
    super.key,
    this.icon,
    this.isRequired = false,
    required this.label,
    required this.child,
    this.textStyle,
    this.space,
    this.isHorizontal,
    this.tooltip,
  });

  final String label;
  final bool isRequired;
  final Widget? icon;
  final Widget child;
  final TextStyle? textStyle;
  final double? space;
  final bool? isHorizontal;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = InfoLabelTheme.maybeOf(context);
    final isHorizontal = this.isHorizontal ?? theme?.isHorizontal ?? false;

    final labelWidget = Row(
      children: [
        if (icon != null) ...[icon!, AS.wGap4],
        Text(
          label,
          style: theme?.labelStyle ??
              textStyle ??
              context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        if (isRequired) ...[
          AS.wGap4,
          Text(
            '*',
            style: TextStyle(color: context.theme.colorScheme.error),
          ),
        ],
        if (tooltip != null) ...[
          AS.wGap4,
          IconButton(
            icon: Icon(Icons.help_outline, size: 16),
            onPressed: () => showTooltip(context, tooltip!),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints.tightFor(width: 16, height: 16),
          ),
        ],
      ],
    );

    if (isHorizontal) {
      return Row(
        children: [
          SizedBox(width: theme?.labelWidth ?? 80, child: labelWidget),
          SizedBox(width: space ?? 4),
          Expanded(child: Align(alignment: Alignment.centerLeft, child: child)),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelWidget,
        SizedBox(height: space ?? 4),
        child,
      ],
    );
  }

  void showTooltip(BuildContext context, String message) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          AppTextButton(
            onPressed: () => Navigator.pop(context),
            label: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}
