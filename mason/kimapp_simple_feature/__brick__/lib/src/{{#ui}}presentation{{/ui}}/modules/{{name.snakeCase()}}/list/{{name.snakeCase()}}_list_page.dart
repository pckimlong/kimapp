import '../../../../../../exports.dart';

@RoutePage()
class {{name.pascalCase()}}ListPage extends ConsumerWidget {
  const {{name.pascalCase()}}ListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return {{name.pascalCase()}}ListBase();
  }
}
