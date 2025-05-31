import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../app/app_style.dart';
import '../core/app_icon.dart';
import '../core/app_text_form_field.dart';
import 'field_clear_button.dart';

class TappableField extends StatefulWidget {
  const TappableField({
    super.key,
    this.value,
    this.hintText,
    this.onTap,
    this.isRequired = false,
    this.textStyle,
    this.onClear,
    this.trailing,
    this.leading,
    this.showIndicatorTrailing = true,
  });

  final String? value;
  final String? hintText;
  final VoidCallback? onTap;
  final bool isRequired;
  final TextStyle? textStyle;
  final VoidCallback? onClear;
  final Widget? trailing;
  final Widget? leading;
  final bool showIndicatorTrailing;

  @override
  State<TappableField> createState() => _TappableFieldState();
}

class _TappableFieldState extends State<TappableField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(TappableField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _controller.text = widget.value ?? '';
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      canRequestFocus: false,
      controller: _controller,
      onTap: widget.onTap,
      style: widget.textStyle,
      leading: widget.leading,
      hintText: widget.hintText,
      trailing: widget.onClear != null && widget.value.isNotNullOrBlank
          ? FieldClearButton(onPressed: widget.onClear!)
          : widget.trailing ?? (widget.showIndicatorTrailing ? AppIcon(AS.fieldChevyDown) : null),
      validator: widget.isRequired ? FormBuilderValidators.required() : null,
    );
  }
}
