import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/helpers/build_context_helper.dart';
import '../core/app_circle_progress.dart';

class ButtonLeadingProgress extends ConsumerWidget {
  const ButtonLeadingProgress({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: SizedBox.square(
        dimension: 12,
        child: AppCircleProgress(
          color: color ?? context.onPrimaryColor,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
