import 'package:autoverpod/autoverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../i_{{name.snakeCase()}}_repo.dart';
import '../{{name.snakeCase()}}_schema.schema.dart';
import '{{name.snakeCase()}}_list_provider.dart';
import '{{name.snakeCase()}}_list_pagination_provider.dart';

part '{{name.snakeCase()}}_create_provider.g.dart';

@formWidget
@riverpod
class {{name.pascalCase()}}Create extends _${{name.pascalCase()}}CreateWidget {
  @override
  {{name.pascalCase()}}CreateParam build() => const {{name.pascalCase()}}CreateParam();

  @override
  Future<{{name.pascalCase()}}Model> submit({{name.pascalCase()}}CreateParam state) async {
    return await ref.read({{name.camelCase()}}RepoProvider).create(state).getOrThrow();
  }

  @override
  void onSuccess({{name.pascalCase()}}Model result) {
    ref.read({{name.camelCase()}}ListProvider.notifier).insertItem(result);
    ref.invalidate({{name.camelCase()}}ListPaginationProvider);
  }
}
