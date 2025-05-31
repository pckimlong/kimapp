import 'package:flutter/widgets.dart';
import 'package:moon_design/moon_design.dart';

class AppOutlineButton extends StatelessWidget {
  const AppOutlineButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.leading,
    this.trailing,
    this.isSmall = false,
    this.isTiny = false,
    this.lighterBorder = false,
  });

  final VoidCallback? onPressed;
  final Widget label;
  final Widget? leading;
  final Widget? trailing;
  final bool isSmall;
  final bool isTiny;
  final bool lighterBorder;

  @override
  Widget build(BuildContext context) {
    return MoonOutlinedButton(
      onTap: onPressed,
      label: label,
      leading: leading,
      borderColor: lighterBorder ? context.moonColors?.beerus : null,
      trailing: trailing,
      buttonSize: isTiny
          ? MoonButtonSize.xs
          : isSmall
              ? MoonButtonSize.sm
              : null,
    );
  }
}
