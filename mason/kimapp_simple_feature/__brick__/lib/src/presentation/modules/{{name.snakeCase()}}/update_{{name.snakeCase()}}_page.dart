import '../../../../exports.dart';

@RoutePage()
class Update{{name.pascalCase()}}Page extends HookConsumerWidget {
  const Update{{name.pascalCase()}}Page({super.key});
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