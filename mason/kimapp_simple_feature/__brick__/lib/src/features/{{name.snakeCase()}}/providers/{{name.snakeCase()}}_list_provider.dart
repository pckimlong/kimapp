import 'package:autoverpod/autoverpod.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kimapp_utils/kimapp_utils.dart';

import '../i_{{name.snakeCase()}}_repo.dart';
import '../{{name.snakeCase()}}_schema.schema.dart';

part '{{name.snakeCase()}}_list_provider.g.dart';

@stateWidget
@riverpod
class {{name.pascalCase()}}List extends _${{name.pascalCase()}}List with IListAsyncNotifier<{{name.pascalCase()}}Model> {
  @override
  bool identity({{name.pascalCase()}}Model item) => item.id == item.id;

  @override
  FutureOr<IList<{{name.pascalCase()}}Model>> build() {
    return ref.watch({{name.camelCase()}}RepoProvider).findAll().getOrThrow();
  }
}
