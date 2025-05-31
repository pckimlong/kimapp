import 'package:flutter/widgets.dart';
import 'package:moon_design/moon_design.dart';

import '../../../core/helpers/build_context_helper.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    required this.child,
    this.radius,
    this.height,
    this.width,
    this.backgroundColor,
    this.backgroundImage,
  });

  final Widget child;
  final double? radius;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final ImageProvider? backgroundImage;

  @override
  Widget build(BuildContext context) {
    return MoonAvatar(
      content: child,
      backgroundImage: backgroundImage,
      backgroundColor: backgroundColor ?? context.colors.secondary.withValues(alpha: 0.3),
      borderRadius: radius != null ? BorderRadius.circular(radius!) : null,
      height: height,
      width: width,
    );
  }
}
