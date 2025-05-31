import 'package:flutter/widgets.dart';
import 'package:moon_design/moon_design.dart';

class AppCircleProgress extends StatelessWidget {
  const AppCircleProgress({
    super.key,
    this.color,
    this.strokeWidth,
  });

  final Color? color;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    return MoonCircularLoader(color: color, strokeWidth: strokeWidth);
  }
}
