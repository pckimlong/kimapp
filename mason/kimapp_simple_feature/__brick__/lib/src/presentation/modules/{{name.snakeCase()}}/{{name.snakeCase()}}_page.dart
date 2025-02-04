import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class {{name.pascalCase()}}Page extends HookConsumerWidget {
  const {{name.pascalCase()}}Page({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoRouter();
  }
}
// TODO: Move this route definition to app_router.dart
// AutoRoute(
//   page: {{name.pascalCase()}}Route.page,
//   path: '{{name.camelCase()}}s',
//   children: [
//     AutoRoute(page: {{name.pascalCase()}}ListRoute.page, path: ''),
//     AutoRoute(page: {{name.pascalCase()}}CreateRoute.page, path: 'create'),
//     AutoRoute(page: {{name.pascalCase()}}DetailRoute.page, path: ':id'),
//     AutoRoute(page: {{name.pascalCase()}}UpdateRoute.page, path: ':id/update'),
//     RedirectRoute(path: '*', redirectTo: ''),
//   ],
// )
