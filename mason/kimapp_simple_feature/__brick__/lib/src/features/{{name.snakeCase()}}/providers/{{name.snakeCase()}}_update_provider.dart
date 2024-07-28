import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../exports.dart';
import '../{{name.snakeCase()}}_schema.dart';
import '../{{name.snakeCase()}}_repo.dart';
import 'providers.dart';

part '{{name.snakeCase()}}_update_provider.freezed.dart';
part '{{name.snakeCase()}}_update_provider.g.dart';

@freezed
class {{name.pascalCase()}}UpdateState
    with _${{name.pascalCase()}}UpdateState, ProviderStatusClassMixin<{{name.pascalCase()}}UpdateState, {{name.pascalCase()}}Model>, UpdateFormMixin {
  const factory {{name.pascalCase()}}UpdateState({
    // TODO - Add form properties
    @Default(ProviderStatus.initial()) ProviderStatusconst const <{{name.pascalCase()}}Model> status,
    @Default(false) bool initialLoaded,
  }) = _{{name.pascalCase()}}UpdateState;

  const {{name.pascalCase()}}UpdateState._();

  @override
  {{name.pascalCase()}}UpdateState updateStatus(ProviderStatus<{{name.pascalCase()}}Model> newStatus) {
    return copyWith(status: newStatus);
  }

  {{name.pascalCase()}}UpdateParam toParam() {
    // TODO - perform validation
    throw UnimplementedError();
  }
}

@kimappForm
@riverpod
class {{name.pascalCase()}}Update extends _${{name.pascalCase()}}Update with _${{name.pascalCase()}}UpdateForm {
  Future<ProviderStatus<{{name.pascalCase()}}Model>> call() async {
    return await perform<{{name.pascalCase()}}Model>(
      (state) async {
        final param = state.toParam();
        final result = await ref.read({{name.camelCase()}}RepoProvider).update({{name.camelCase()}}Id, data: param);
        return result.getOrThrow();
      },
      onSuccess: (success) {
        ref.read({{name.camelCase()}}ListProvider.notifier).updateItem(success);
        ref.read({{name.camelCase()}}DetailProvider({{name.camelCase()}}Id).notifier).updateState((_) => success);
        ref.invalidate({{name.camelCase()}}ListPaginationProvider);
      },
    );
  }

  void updateState({{name.pascalCase()}}UpdateState Function({{name.pascalCase()}}UpdateState oldState) newState) {
    state = newState(state).copyWith(status: state.status);
  }

  @override
  Future<  {{name.pascalCase()}}UpdateState> initState([  {{name.pascalCase()}}UpdateState? local]) async {
    if (local != null) return local;

    final result =  await ref
        .read({{name.camelCase()}}RepoProvider)
        .findOne({{name.camelCase()}}Id)
        .then((value) => value.getOrThrow());
        
    return const   {{name.pascalCase()}}UpdateState();
  }


  @override
  {{name.pascalCase()}}UpdateState build({{name.pascalCase()}}Id {{name.camelCase()}}Id) =>
     const {{name.pascalCase()}}UpdateState();
  
}
