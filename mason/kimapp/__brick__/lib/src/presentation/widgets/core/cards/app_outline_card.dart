import 'package:flutter/material.dart';

import 'app_card_base.dart';

class AppOutlineCard extends AppCardBase {
  const AppOutlineCard({
    super.key,
    super.margin,
    super.padding,
    super.color,
    super.elevation,
    super.shape,
    super.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: margin ?? EdgeInsets.zero,
      color: Colors.transparent,
      elevation: elevation,
      shape: shape,
      child: buildChild(),
    );
  }
}
