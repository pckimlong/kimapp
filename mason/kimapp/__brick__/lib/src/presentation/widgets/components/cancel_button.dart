import 'package:flutter/widgets.dart';

import '../core/buttons/app_flat_button.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({
    super.key,
    required this.onPressed,
    this.label = 'Cancel',
    this.icon,
  });

  final VoidCallback onPressed;
  final Icon? icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return AppFlatButton(
      onPressed: onPressed,
      label: Text(label),
      leading: icon,
    );
  }
}
