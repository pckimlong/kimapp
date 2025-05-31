import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:kimapp/object/failure.dart';

import '../../../core/helpers/build_context_helper.dart';
import '../../app/app_style.dart';
import '../components/failure_widget.dart';
import '../core/buttons/app_filled_button.dart';

class ActionableForm extends StatefulWidget {
  const ActionableForm({
    super.key,
    required this.onSubmit,
    required this.onCancel,
    required this.failure,
    this.flexibleChild = false,
    required this.isProgressing,
    required this.child,
    this.saveButtonBuilder,
  });

  final VoidCallback? onSubmit;
  final VoidCallback? onCancel;
  final bool flexibleChild;
  final Failure? failure;
  final bool isProgressing;
  final Widget child;
  final Widget Function(VoidCallback? press, bool isProgressing)? saveButtonBuilder;

  @override
  State<ActionableForm> createState() => _ActionableFormState();
}

class _ActionableFormState extends State<ActionableForm> {
  @override
  void didUpdateWidget(covariant ActionableForm oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isProgressing == false && widget.isProgressing == true) {
      BotToast.showLoading();
    }

    if (oldWidget.isProgressing == true && widget.isProgressing == false) {
      BotToast.closeAllLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.flexibleChild) Flexible(child: widget.child) else widget.child,
        FailureWidget(failure: widget.failure),
        AS.hGap24,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.saveButtonBuilder != null)
              widget.saveButtonBuilder!(widget.onSubmit, widget.isProgressing)
            else
              SizedBox(
                width: widget.onCancel == null ? context.screenWidth * 0.8 : null,
                child: AppFilledButton(onPressed: widget.onSubmit, label: const Text("Save")),
              ),
            if (widget.onCancel != null) ...[
              AS.wGap12,
              OutlinedButton(
                onPressed: widget.onCancel,
                child: const Text("Cancel"),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
