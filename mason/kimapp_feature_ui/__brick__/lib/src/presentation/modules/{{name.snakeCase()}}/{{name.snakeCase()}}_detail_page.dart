import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../features/{{name.snakeCase()}}/providers/{{name.snakeCase()}}_detail_provider.dart';
import '../../../features/{{name.snakeCase()}}/{{name.snakeCase()}}_schema.schema.dart';
import '../../widgets/async_value_widget.dart';
import '../../router/app_router.gr.dart';

@RoutePage()
class {{name.pascalCase()}}DetailPage extends StatefulHookConsumerWidget {
  const {{name.pascalCase()}}DetailPage({super.key, @PathParam('id') required this.{{name.camelCase()}}IdString,});

  final String {{name.camelCase()}}IdString;

  static void show(BuildContext context, {{name.pascalCase()}}Id {{name.camelCase()}}Id) {
    context.pushRoute({{name.pascalCase()}}DetailRoute({{name.camelCase()}}IdString: {{name.camelCase()}}Id.toString()));
  }

  @override
  ConsumerState<{{name.pascalCase()}}DetailPage> createState() => _{{name.pascalCase()}}DetailPageState();
}

class _{{name.pascalCase()}}DetailPageState extends ConsumerState<{{name.pascalCase()}}DetailPage> {
  @override
  Widget build(BuildContext context) {
    final {{name.camelCase()}}Id = {{name.pascalCase()}}Id.fromValue(widget.{{name.camelCase()}}IdString.toInt());
    final dataAsync = ref.watch({{name.camelCase()}}DetailProvider({{name.camelCase()}}Id));

    final body = dataAsync.onData((data) {
      return Center(child: Text(data.toString()));
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('{{name.pascalCase()}} Detail'),
      ),
      body: body,
    );
  }
}