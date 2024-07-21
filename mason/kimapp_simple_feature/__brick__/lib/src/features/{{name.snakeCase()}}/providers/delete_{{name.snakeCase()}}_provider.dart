import 'package:fpdart/fpdart.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../{{name.snakeCase()}}_model.dart';
import '../i_{{name.snakeCase()}}_repo.dart';
import 'providers.dart';

part 'delete_{{name.snakeCase()}}_provider.g.dart';

@riverpod
class Delete{{name.pascalCase()}} extends _$Delete{{name.pascalCase()}} {
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