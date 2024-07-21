import '../../../../../../exports.dart';

@RoutePage()
class {{name.pascalCase()}}Page extends HookConsumerWidget {
  const {{name.pascalCase()}}Page({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoRouter();
  }
}