import 'package:fpdart/fpdart.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../{{name.snakeCase()}}.dart';

part 'delete_{{name.snakeCase()}}_provider.g.dart';

@riverpod
class Delete{{name.pascalCase()}} extends _$Delete{{name.pascalCase()}} {
  @override
  ProviderStatus<Unit> build(Delete{{name.pascalCase()}}Param param) => const ProviderStatus.initial();


  Future<ProviderStatus<Unit>> call() async {
    return await perform((state) async {
     final result = await ref.read({{name.camelCase()}}RepoProvider).delete(param);
     return result.getOrThrow();
}, onSuccess: (success) {
  ref.invalidate({{name.camelCase()}}ListProvider);
  ref.invalidate({{name.camelCase()}}DetailProvider(FindOne{{name.pascalCase()}}Param.byId(param.{{name.camelCase()}}Id)));
  ref.invalidate({{name.camelCase()}}ListPaginationProvider);
},);
  }
}