import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:moon_design/moon_design.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.isRequired = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.words,
    this.autofocus = false,
    this.maxLines,
    this.style,
    this.trailing,
    this.leading,
    this.inputFormatters,
    this.readOnly = false,
    this.onTap,
    this.canRequestFocus = true,
    this.mouseCursor,
    this.width,
    this.enabled = true,
    this.padding,
    this.filled = false,
    this.backgroundColor,
    this.focusNode,
    this.inactiveBorderColor,
    this.helper,
  }) : assert(
          !isRequired || validator == null,
          'validator must not be provided if isRequired is true',
        );

  final TextEditingController? controller;
  final String? hintText;
  final bool isRequired;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final int? maxLines;
  final TextStyle? style;
  final Widget? trailing;
  final Widget? leading;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final void Function()? onTap;
  final bool canRequestFocus;
  final MouseCursor? mouseCursor;
  final bool enabled;
  final double? width;
  final EdgeInsets? padding;
  final bool filled;
  final Color? backgroundColor;
  final FocusNode? focusNode;
  final Color? inactiveBorderColor;
  final Widget? helper;

  @override
  Widget build(BuildContext context) {
    return MoonFormTextInput(
      controller: controller,
      enabled: enabled,
      canRequestFocus: canRequestFocus,
      hintText: hintText,
      autofocus: autofocus,
      maxLines: maxLines,
      mouseCursor: mouseCursor,
      readOnly: readOnly,
      inactiveBorderColor: inactiveBorderColor,
      onTap: onTap,
      backgroundColor: filled ? backgroundColor ?? context.moonColors?.gohan : null,
      inputFormatters: inputFormatters,
      style: style,
      focusNode: focusNode,
      validator: validator ??
          FormBuilderValidators.compose([if (isRequired) FormBuilderValidators.required()]),
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      trailing: trailing,
      padding: padding,
      leading: leading,
      helper: helper,
    );
  }
}
