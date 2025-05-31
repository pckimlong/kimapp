import 'package:flutter/widgets.dart';
import 'package:moon_design/moon_design.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.leading,
    this.trailing,
  });

  final VoidCallback? onPressed;
  final Widget label;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return MoonTextButton(
      onTap: onPressed,
      label: label,
      leading: leading,
      trailing: trailing,
    );
  }
}
