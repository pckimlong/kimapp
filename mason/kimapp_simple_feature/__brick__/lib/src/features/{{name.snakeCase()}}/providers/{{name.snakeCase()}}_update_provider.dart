import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import '../{{name.snakeCase()}}_schema.schema.dart';
import '../i_{{name.snakeCase()}}_repo.dart';
import '{{name.snakeCase()}}_detail_provider.dart';
import '{{name.snakeCase()}}_list_pagination_provider.dart';
import '{{name.snakeCase()}}_list_provider.dart';

part '{{name.snakeCase()}}_update_provider.freezed.dart';
part '{{name.snakeCase()}}_update_provider.g.dart';

@freezed
class {{name.pascalCase()}}UpdateState
    with _${{name.pascalCase()}}UpdateState, ProviderStatusClassMixin<{{name.pascalCase()}}UpdateState, {{name.pascalCase()}}Model>, UpdateFormMixin {
  const factory {{name.pascalCase()}}UpdateState({
    // TODO - Add form properties
    required String name,
    @Default(ProviderStatus.initial()) ProviderStatus<{{name.pascalCase()}}Model> status,
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

        //! Use with caution
        /// this update might lead to data inconsistency, for example, if we have update the item to not meet the param filter
        /// in this case, the item should be removed from the paginated list, but using this method will just update the item
        /// other case is if we update sort order, the item might need to change position
        {{name.pascalCase()}}PaginationTracker.instance.updatePaginatedItem(ref, success);
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
     const {{name.pascalCase()}}UpdateState(name: '');
  
}
