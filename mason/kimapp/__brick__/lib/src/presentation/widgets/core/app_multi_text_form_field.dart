import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:moon_design/moon_design.dart';

class AppMultiTextFormField extends StatelessWidget {
  const AppMultiTextFormField({
    super.key,
    this.height = 100,
    this.controller,
    this.hintText,
    this.isRequired = false,
    this.validator,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.words,
    this.readOnly = false,
    this.onTap,
    this.enabled = true,
    this.filled = false,
    this.backgroundColor,
    this.inputFormatters,
  }) : assert(
          !isRequired || validator == null,
          'validator must not be provided if isRequired is true',
        );

  final double height;
  final TextEditingController? controller;
  final String? hintText;
  final bool isRequired;
  final String? Function(String?)? validator;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final bool readOnly;
  final void Function()? onTap;
  final bool enabled;
  final bool filled;
  final Color? backgroundColor;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return MoonTextArea(
      controller: controller,
      enabled: enabled,
      height: height,
      hintText: hintText,
      autofocus: autofocus,
      readOnly: readOnly,
      onTap: onTap,
      backgroundColor: filled ? backgroundColor ?? context.moonColors?.gohan : null,
      inputFormatters: inputFormatters,
      validator: validator ??
          FormBuilderValidators.compose([if (isRequired) FormBuilderValidators.required()]),
      textCapitalization: textCapitalization,
    );
  }
}
