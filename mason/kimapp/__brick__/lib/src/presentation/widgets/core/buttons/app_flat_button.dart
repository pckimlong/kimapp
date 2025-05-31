import 'package:flutter/widgets.dart';
import 'package:moon_design/moon_design.dart';

class AppFlatButton extends StatelessWidget {
  const AppFlatButton({
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
    return MoonButton(
      backgroundColor: context.moonColors?.gohan,
      onTap: onPressed,
      label: label,
      leading: leading,
      trailing: trailing,
    );
  }
}
