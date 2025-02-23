import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/helpers/build_context_helper.dart';
import '../app/app_style.dart';

class BaseDialog extends StatelessWidget {
  const BaseDialog({
    super.key,
    this.title,
    this.showCloseButton = false,
    this.titlePadding,
    this.contentPadding,
    this.insetPadding = const EdgeInsets.symmetric(horizontal: AS.sidePadding, vertical: 24),
    this.content,
    this.actions,
    this.shapeBorder,
    this.backgroundColor,
    this.width,
    this.height,
  });

  final Widget? title;
  final bool showCloseButton;
  final EdgeInsets? titlePadding;
  final EdgeInsets? contentPadding;
  final EdgeInsets insetPadding;
  final Widget? content;
  final List<Widget>? actions;
  final ShapeBorder? shapeBorder;
  final Color? backgroundColor;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final defaultDialogWidth =
        context.screenWidth < AS.mobileBreakpoint ? context.screenWidth : AS.mobileBreakpoint;

    return AlertDialog(
      titlePadding: titlePadding,
      contentPadding: contentPadding,
      insetPadding: insetPadding,
      backgroundColor: backgroundColor,
      surfaceTintColor: backgroundColor,
      actions: actions,
      shape: shapeBorder,
      title: title != null || showCloseButton
          ? Row(
              children: [
                if (title != null) Expanded(child: title!),
                if (showCloseButton)
                  IconButton(
                    onPressed: () {
                      context.maybePop();
                    },
                    icon: const Icon(Icons.close),
                  ),
              ],
            )
          : null,
      content: SizedBox(
        width: width ?? defaultDialogWidth,
        height: height,
        child: content,
      ),
    );
  }
}
