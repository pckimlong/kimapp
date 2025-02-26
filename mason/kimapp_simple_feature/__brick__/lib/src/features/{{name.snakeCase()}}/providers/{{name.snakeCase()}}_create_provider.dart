import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';
import 'package:kimapp/riverpod_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../i_{{name.snakeCase()}}_repo.dart';
import '../{{name.snakeCase()}}_schema.schema.dart';
import '{{name.snakeCase()}}_list_pagination_provider.dart';
import '{{name.snakeCase()}}_list_provider.dart';

part '{{name.snakeCase()}}_create_provider.freezed.dart';
part '{{name.snakeCase()}}_create_provider.g.dart';

@freezed
class {{name.pascalCase()}}CreateState
    with _${{name.pascalCase()}}CreateState, ProviderStatusClassMixin<{{name.pascalCase()}}CreateState, {{name.pascalCase()}}Model> {
  const factory {{name.pascalCase()}}CreateState({
    // TODO - Add form properties
    @Default('') String name,
    @Default(ProviderStatus.initial()) ProviderStatus<{{name.pascalCase()}}Model> status,
  }) = _Create{{name.pascalCase()}}State;

  const {{name.pascalCase()}}CreateState._();

  @override
  {{name.pascalCase()}}CreateState updateStatus(ProviderStatus<{{name.pascalCase()}}Model> newStatus) {
    return copyWith(status: newStatus);
  }

  {{name.pascalCase()}}CreateParam toParam() {
    // TODO - perform validation
    
    throw UnimplementedError();
  }
}

@kimappForm
@riverpod
class {{name.pascalCase()}}Create extends _${{name.pascalCase()}}Create with _${{name.pascalCase()}}CreateForm  {
  Future<ProviderStatus<{{name.pascalCase()}}Model>> call() async {
    return await perform<{{name.pascalCase()}}Model>(
      (state) async {
        final result = await ref.read({{name.camelCase()}}RepoProvider).create(state.toParam());
        return result.getOrThrow();
      },
      onSuccess: (success) async {
        ref.read({{name.camelCase()}}ListProvider.notifier).insertItem(success);
        ref.invalidate({{name.camelCase()}}ListPaginationProvider);
      },
    );
  }

  void updateState({{name.pascalCase()}}CreateState Function({{name.pascalCase()}}CreateState oldState) newState) {
    state = newState(state).copyWith(status: state.status);
  }


  @override
  {{name.pascalCase()}}CreateState build() => const {{name.pascalCase()}}CreateState();
}
