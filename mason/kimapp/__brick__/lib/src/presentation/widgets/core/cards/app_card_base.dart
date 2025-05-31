import 'package:flutter/material.dart';

abstract class AppCardBase extends StatelessWidget {
  const AppCardBase({
    super.key,
    this.margin,
    this.padding,
    this.color,
    this.elevation,
    this.shape,
    this.child,
  });

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double? elevation;
  final ShapeBorder? shape;
  final Widget? child;

  @override
  Widget build(BuildContext context);

  Widget buildChild() {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: child,
    );
  }
}
