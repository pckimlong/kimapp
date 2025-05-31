import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/app/app_info_provider.dart';

class AppVersionWidget extends ConsumerWidget {
  const AppVersionWidget({super.key, this.style});

  final TextStyle? style;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appInfo = ref.watch(appInfoProvider).valueOrNull;
    return Text(
      appInfo == null ? "" : "V ${appInfo.version}",
      style: style,
    );
  }
}
