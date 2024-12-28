import '../../../../exports.dart';

@RoutePage()
class Create{{name.pascalCase()}}Page extends HookConsumerWidget {
  const Create{{name.pascalCase()}}Page({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _Body();
  }
}

class _Body extends HookConsumerWidget {
  const _Body();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}