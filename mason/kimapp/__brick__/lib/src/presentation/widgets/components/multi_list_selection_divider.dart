import 'package:flutter/material.dart';

import '../../../core/helpers/build_context_helper.dart';
import '../../app/app_style.dart';

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
            TextButton(
              onPressed: onSelectAllPressed,
              child: Row(
                children: [
                  Icon(Icons.check_box_outlined, size: 18),
                  Text(
                    'Select All',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
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
          OutlinedButton(
            onPressed: onClearAllPressed,
            child: const Text('Clear'),
          ),
        ],
      ],
    );
  }
}
