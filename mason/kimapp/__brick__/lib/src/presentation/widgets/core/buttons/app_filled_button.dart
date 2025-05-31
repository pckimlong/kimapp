import 'package:flutter/widgets.dart';
import 'package:moon_design/moon_design.dart';

class AppFilledButton extends StatelessWidget {
  const AppFilledButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.leading,
    this.trailing,
    this.isSmall = false,
  });

  final VoidCallback? onPressed;
  final Widget label;
  final Widget? leading;
  final Widget? trailing;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return MoonFilledButton(
      onTap: onPressed,
      label: label,
      leading: leading,
      backgroundColor: onPressed == null ? context.moonColors?.bulma.withValues(alpha: 0.4) : null,
      trailing: trailing,
      buttonSize: isSmall ? MoonButtonSize.sm : null,
    );
  }
}
