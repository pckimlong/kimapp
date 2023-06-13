import '../../../exports.dart';

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
