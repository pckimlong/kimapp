import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/helpers/build_context_helper.dart';
import '../../app/app_style.dart';

class BaseDialog extends StatelessWidget {
  const BaseDialog({
    super.key,
    this.title,
    this.showCloseButton = true,
    this.titlePadding,
    this.contentPadding,
    this.insetPadding = const EdgeInsets.symmetric(
      horizontal: AS.dialogSideInsetPadding,
      vertical: 24,
    ),
    this.content,
    this.actions,
    this.shapeBorder,
    this.backgroundColor,
    this.width,
    this.height,
    this.showDivider = false,
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
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final defaultDialogWidth =
        context.screenWidth < AS.mobileBreakpoint ? context.screenWidth : AS.mobileBreakpoint;

    return AlertDialog(
      titlePadding: titlePadding ??
          EdgeInsets.all(24).copyWith(bottom: 0, top: 12, right: showCloseButton ? 12 : 24),
      contentPadding: contentPadding ?? EdgeInsets.all(24).copyWith(top: 8),
      insetPadding: insetPadding,
      backgroundColor: backgroundColor,
      surfaceTintColor: backgroundColor,
      actions: actions,
      shape: shapeBorder,
      title: title != null || showCloseButton
          ? Column(
              children: [
                Row(
                  children: [
                    if (title != null)
                      Expanded(
                        child: DefaultTextStyle.merge(
                          child: title!,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    if (showCloseButton)
                      IconButton(
                        onPressed: () {
                          context.maybePop();
                        },
                        icon: const Icon(Icons.close),
                      ),
                  ],
                ),
                if (showDivider) ...[AS.hGap8, Divider(height: 1)],
              ],
            )
          : null,
      content: SizedBox(width: width ?? defaultDialogWidth, height: height, child: content),
    );
  }
}
