import 'package:flutter/material.dart';

import '../../../core/helpers/build_context_helper.dart';
import '../../app/app_style.dart';
import '../core/buttons/app_outline_button.dart';
import '../core/buttons/app_text_button.dart';

class MultiListSelectionDivider extends StatelessWidget {
  const MultiListSelectionDivider({
    super.key,
    this.label,
    this.selectedCount,
    this.onSelectAllPressed,
    this.onClearAllPressed,
  });

  final String? label;
  final int? selectedCount;
  final VoidCallback? onSelectAllPressed;
  final VoidCallback? onClearAllPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        if (onSelectAllPressed != null) ...[
          ...[
            AppTextButton(
              onPressed: onSelectAllPressed,
              leading: const Icon(Icons.check_box_outlined, size: 18),
              label: const Text(
                'Select All',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
          AS.wGap8,
        ],
        Text(
          label ?? 'Selected',
          style: theme.textTheme.titleSmall,
        ),
        if (selectedCount != null) ...[
          AS.wGap4,
          Badge.count(
            count: selectedCount!,
            backgroundColor: context.primaryColor,
          ),
        ],
        AS.wGap8,
        Expanded(
          child: Divider(
            color: theme.colorScheme.outlineVariant,
            thickness: 1,
          ),
        ),
        if (onClearAllPressed != null) ...[
          AS.wGap8,
          AppOutlineButton(
            isSmall: true,
            onPressed: onClearAllPressed,
            label: const Text('Clear'),
          ),
        ],
      ],
    );
  }
}
