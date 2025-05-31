import 'package:flutter/widgets.dart';

import '../../app/app_style.dart';
import '../core/app_icon.dart';
import '../core/buttons/app_icon_button.dart';

class FieldClearButton extends StatelessWidget {
  const FieldClearButton({
    super.key,
    required this.onPressed,
    this.icon,
  });

  final VoidCallback onPressed;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      onPressed: onPressed,
      icon: icon ?? const AppIcon(AS.clearIcon),
      padding: EdgeInsets.zero,
      isSmall: true,
    );
  }
}
