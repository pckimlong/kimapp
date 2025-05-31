import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kimapp/kimapp.dart' hide TableBuilder, ColumnBuilder;
import 'package:kimapp/kimapp.dart';

import '../../app/app_style.dart';
import '../components/app_error_widget.dart';
import '../components/cancel_button.dart';
import '../components/save_button.dart';
import 'base_dialog.dart';

class ActionableDialog<T> extends StatelessWidget {
  const ActionableDialog({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.status,
    this.submitText = 'Save',
    required this.child,
    this.maxWidth = AS.tabletBreakpoint,
    this.submitIcon,
  });

  final Widget title;
  final String submitText;
  final VoidCallback onSubmit;
  final Widget? submitIcon;
  final ProviderStatus<T> status;
  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      width: maxWidth,
      title: title,
      showDivider: true,
      actions: [
        Row(
          children: [
            Expanded(child: CancelButton(onPressed: context.maybePop)),
            AS.wGap12,
            Expanded(
              child: SaveButton(
                onPressed: onSubmit,
                isInProgress: status.isInProgress,
                icon: submitIcon,
                label: submitText,
              ),
            ),
          ],
        ),
      ],
      content: SingleChildScrollView(
        child: Column(
          children: [
            AS.hGap12,
            if (status.isFailure) ...[
              AS.hGap12,
              AppErrorWidget(error: status.failure),
              AS.hGap4,
            ],
            child,
          ],
        ),
      ),
    );
  }
}
