import 'package:autoverpod/autoverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../i_{{name.snakeCase()}}_repo.dart';
import '../{{name.snakeCase()}}_schema.schema.dart';
import '{{name.snakeCase()}}_detail_provider.dart';
import '{{name.snakeCase()}}_list_pagination_provider.dart';
import '{{name.snakeCase()}}_list_provider.dart';

part '{{name.snakeCase()}}_update_provider.g.dart';

@formWidget
@riverpod
class {{name.pascalCase()}}Update extends _${{name.pascalCase()}}UpdateWidget {
  @override
  Future<{{name.pascalCase()}}UpdateParam> build({{name.pascalCase()}}Id {{name.camelCase()}}Id) async {
    final result = await ref.read({{name.camelCase()}}RepoProvider).findOne({{name.camelCase()}}Id).getOrThrow();
    return {{name.pascalCase()}}UpdateParam(
        // TODO: Initialize form fields with the {{name.camelCase()}} data
    );
  }

  @override
  Future<{{name.pascalCase()}}Model> submit({{name.pascalCase()}}UpdateParam state) async {
    return await ref.read({{name.camelCase()}}RepoProvider).update({{name.camelCase()}}Id, data: state).getOrThrow();
  }

  @override
  void onSuccess({{name.pascalCase()}}Model result) {
    ref.read({{name.camelCase()}}ListProvider.notifier).updateItem(result);
    ref.read({{name.camelCase()}}DetailProvider({{name.camelCase()}}Id).notifier).updateState((_) => result);

    //! Use with caution
    /// this update might lead to data inconsistency, for example, if we have update the item to not meet the param filter
    /// in this case, the item should be removed from the paginated list, but using this method will just update the item
    /// other case is if we update sort order, the item might need to change position
    {{name.pascalCase()}}PaginationTracker.instance.updatePaginatedItem(ref, result);
    
    super.onSuccess(result);
  }
}
