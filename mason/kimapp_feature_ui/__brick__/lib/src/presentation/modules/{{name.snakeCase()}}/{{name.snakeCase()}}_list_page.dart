import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'widgets/{{name.snakeCase()}}_pagination_list_base.dart';

@RoutePage()
class {{name.pascalCase()}}ListPage extends ConsumerWidget {
  const {{name.pascalCase()}}ListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return {{name.pascalCase()}}PaginationListBase();
  }
}
