// ignore: prefer_const_constructors

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


import '../../../../exports.dart';


import '../{{name.snakeCase()}}.dart';

part 'update_{{name.snakeCase()}}_provider.freezed.dart';
part 'update_{{name.snakeCase()}}_provider.g.dart';

@freezed
class Update{{name.pascalCase()}}State
    with _$Update{{name.pascalCase()}}State, ProviderStatusClassMixin<Update{{name.pascalCase()}}State, {{name.pascalCase()}}DetailModel>, UpdateFormMixin {
  const factory Update{{name.pascalCase()}}State({
    @Default(ProviderStatus.initial()) ProviderStatus<{{name.pascalCase()}}DetailModel> status,
    @Default(false) bool initialLoaded,
  }) = _Update{{name.pascalCase()}}State;

  const Update{{name.pascalCase()}}State._();

  @override
  Update{{name.pascalCase()}}State updateStatus(ProviderStatus<{{name.pascalCase()}}DetailModel> newStatus) {
    return copyWith(status: newStatus);
  }

  Update{{name.pascalCase()}}Param toParam() {
    return const Update{{name.pascalCase()}}Param();
  }
}

@kimappForm
@riverpod
class Update{{name.pascalCase()}} extends _$Update{{name.pascalCase()}} with _$Update{{name.pascalCase()}}Form {
  Future<ProviderStatus<{{name.pascalCase()}}DetailModel>> call() async {
    return await perform<{{name.pascalCase()}}DetailModel>(
      (state) async {
        final param = state.toParam();
        final result = await ref.read({{name.camelCase()}}RepoProvider).update({{name.camelCase()}}Id, data: param);
        return result.getOrThrow();
      },
      onSuccess: (success) {
        ref.read({{name.camelCase()}}ListProvider.notifier).updateItem({{name.pascalCase()}}Model.fromDetailModel(success));
        ref.read({{name.camelCase()}}DetailProvider(FindOne{{name.pascalCase()}}Param.byId({{name.camelCase()}}Id)).notifier).updateState((_) => success);
        ref.invalidate({{name.camelCase()}}ListPaginationProvider);
      },
    );
  }

  void updateState(Update{{name.pascalCase()}}State Function(Update{{name.pascalCase()}}State oldState) newState) {
    state = newState(state).copyWith(status: state.status);
  }

  @override
  Future<  Update{{name.pascalCase()}}State> initState([  Update{{name.pascalCase()}}State? local]) async {
    if (local != null) return local;

    final result =  await ref
        .read({{name.camelCase()}}RepoProvider)
        .findOne(FindOne{{name.pascalCase()}}Param.byId({{name.camelCase()}}Id))
        .then((value) => value.getOrThrow());
        
    return const   Update{{name.pascalCase()}}State();
  }


  @override
  Update{{name.pascalCase()}}State build({{name.pascalCase()}}Id {{name.camelCase()}}Id) =>
     const Update{{name.pascalCase()}}State();
  
}
