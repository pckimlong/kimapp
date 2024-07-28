import 'package:fpdart/fpdart.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../{{name.snakeCase()}}_schema.dart';
import '../{{name.snakeCase()}}_repo.dart';
import 'providers.dart';

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
  ref.invalidate({{name.camelCase()}}ListProvider);
  ref.invalidate({{name.camelCase()}}DetailProvider(id));
  ref.invalidate({{name.camelCase()}}ListPaginationProvider);
},);
  }
}