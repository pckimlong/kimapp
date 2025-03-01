import 'package:fpdart/fpdart.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../{{name.snakeCase()}}_schema.schema.dart';
import '../i_{{name.snakeCase()}}_repo.dart';
import '{{name.snakeCase()}}_detail_provider.dart';
import '{{name.snakeCase()}}_list_pagination_provider.dart';
import '{{name.snakeCase()}}_list_provider.dart';

part '{{name.snakeCase()}}_delete_provider.g.dart';

@riverpod
class {{name.pascalCase()}}Delete extends _${{name.pascalCase()}}Delete {
  @override
  ProviderStatus<Unit> build({{name.pascalCase()}}Id id) => const ProviderStatus.initial();


  Future<ProviderStatus<Unit>> call() async {
    return await perform((state) async {
     final result = await ref.read({{name.camelCase()}}RepoProvider).delete(id);
     return result.getOrThrow();
}, onSuccess: (success) {
    ref.read({{name.camelCase()}}ListProvider.notifier).removeWhere((e) => e.id == id);
    ref.invalidate({{name.camelCase()}}DetailProvider(id));

    /// Can set the invalidateOnLength to 0, but if it just 1, the invalidate is not expensive, it deserve to be used
    /// since it will help accurate the data consistency
    {{name.pascalCase()}}PaginationTracker.instance.deletePaginatedItem(ref, id, invalidateOnLength: 1);
  },);
  }
}