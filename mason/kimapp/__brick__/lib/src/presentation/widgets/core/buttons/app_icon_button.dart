import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.padding,
    this.iconColor,
    this.isSmall = false,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final EdgeInsetsGeometry? padding;
  final Color? iconColor;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return MoonButton.icon(
      iconColor: iconColor,
      buttonSize: isSmall ? MoonButtonSize.xs : null,
      padding: padding,
      onTap: onPressed,
      icon: icon,
    );
  }
}
