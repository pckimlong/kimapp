import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/widgets.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/helpers/build_context_helper.dart';

class AppDottedCard extends StatelessWidget {
  const AppDottedCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: [6, 4],
      color: context.moonColors?.beerus ?? context.colors.outline.withValues(alpha: 0.8),
      strokeCap: StrokeCap.round,
      borderType: BorderType.RRect,
      radius: (context.moonBorders?.surfaceSm as BorderRadius).topLeft,
      padding: EdgeInsets.all(16),
      child: child,
    );
  }
}
