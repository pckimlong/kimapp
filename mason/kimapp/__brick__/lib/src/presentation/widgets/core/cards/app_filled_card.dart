import 'package:flutter/material.dart';

import 'app_card_base.dart';

class AppFilledCard extends AppCardBase {
  const AppFilledCard({
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
    return Card.filled(
      margin: margin ?? EdgeInsets.zero,
      color: color,
      elevation: elevation,
      shape: shape,
      child: buildChild(),
    );
  }
}
