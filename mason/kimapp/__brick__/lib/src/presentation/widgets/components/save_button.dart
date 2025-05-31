import 'package:flutter/widgets.dart';
import 'package:latte_link/src/presentation/widgets/components/button_leading_progress.dart'
    show ButtonLeadingProgress;

import '../core/buttons/app_filled_button.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required this.onPressed,
    this.isInProgress = false,
    this.label = 'Save',
    this.icon,
  });

  final VoidCallback? onPressed;
  final bool isInProgress;
  final String label;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return AppFilledButton(
      onPressed: onPressed,
      leading: isInProgress ? ButtonLeadingProgress() : icon,
      label: Text(label),
    );
  }
}
