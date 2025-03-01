import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'build_context_helper.dart';

extension WidgetExtension on Widget {
  Future<T?> showDialog<T>(BuildContext context, {bool barrierDismissible = true}) async {
    return await context.showAppDialog<T>(
      builder: (context) => this,
      barrierDismissible: barrierDismissible,
    );
  }

  Future<T?> showModalBottomSheet<T>(
    BuildContext context, {
    bool isDismissible = true,
    bool enableDrag = true,
  }) async {
    return await context.showAppModalBottomSheet<T>(
      builder: (context) => this,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
    );
  }
}
