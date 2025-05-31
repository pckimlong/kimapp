import 'package:flutter/material.dart';
import 'package:kimapp/kimapp.dart' hide TableBuilder, ColumnBuilder;
import 'package:kimapp/kimapp.dart';

import '../../app/app_style.dart';
import 'actionable_dialog.dart';

class ActionableFormDialog<T> extends StatelessWidget {
  const ActionableFormDialog({
    super.key,
    required this.formKey,
    required this.title,
    required this.onSubmit,
    required this.status,
    this.submitText = 'Save',
    this.maxWidth = AS.tabletBreakpoint,
    this.submitIcon,
    required this.child,
  });

  final GlobalKey<FormState> formKey;
  final Widget title;
  final String submitText;
  final VoidCallback onSubmit;
  final Widget? submitIcon;
  final ProviderStatus<T> status;
  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return ActionableDialog(
      title: title,
      onSubmit: () {
        if (!formKey.currentState!.validate()) return;
        formKey.currentState!.save();
        onSubmit();
      },
      status: status,
      submitText: submitText,
      submitIcon: submitIcon,
      maxWidth: maxWidth,
      child: child,
    );
  }
}
