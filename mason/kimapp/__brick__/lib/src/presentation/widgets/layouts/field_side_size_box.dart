import 'package:flutter/widgets.dart';

class FieldSideSizeBox extends StatelessWidget {
  const FieldSideSizeBox({
    super.key,
    this.size = 24,
    required this.child,
  });

  final double size;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: child,
    );
  }
}
