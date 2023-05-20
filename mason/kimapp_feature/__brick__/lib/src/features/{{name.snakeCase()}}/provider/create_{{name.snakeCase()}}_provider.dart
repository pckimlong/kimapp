// Package imports:
// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import '../../../../../../../exports.dart';
import '../{{name.snakeCase()}}.dart';

part 'create_{{name.snakeCase()}}_provider.freezed.dart';
part 'create_{{name.snakeCase()}}_provider.g.dart';

@freezed
class Create{{name.pascalCase()}}State
    with _$Create{{name.pascalCase()}}State, ProviderStatusClassMixin<Create{{name.pascalCase()}}State, {{name.pascalCase()}}DetailModel> {
  const factory Create{{name.pascalCase()}}State({
    /// provider status
    @Default(ProviderStatus.initial()) ProviderStatus<{{name.pascalCase()}}DetailModel> status,
  }) = _Create{{name.pascalCase()}}State;

  const Create{{name.pascalCase()}}State._();

  @override
  Create{{name.pascalCase()}}State updateStatus(ProviderStatus<{{name.pascalCase()}}DetailModel> newStatus) {
    return copyWith(status: newStatus);
  }

  Create{{name.pascalCase()}}Param toParam() {
    // perform validation
    // ...
    return const Create{{name.pascalCase()}}Param();
  }
}

@kimappForm
@riverpod
class Create{{name.pascalCase()}} extends _$Create{{name.pascalCase()}} with _$Create{{name.pascalCase()}}Form  {
  Future<ProviderStatus<{{name.pascalCase()}}DetailModel>> call() async {
    return await perform<{{name.pascalCase()}}DetailModel>(
      (state) async {
        final result = await ref.read({{name.camelCase()}}RepoProvider).create(state.toParam());
        return result.getOrThrow();
      },
      onSuccess: (success) async {
        ref.read({{name.camelCase()}}ListProvider.notifier).insertItem({{name.pascalCase()}}Model.fromDetailModel(success));
        ref.invalidate({{name.camelCase()}}ListPaginationProvider);
      },
    );
  }

  void updateState(Create{{name.pascalCase()}}State Function(Create{{name.pascalCase()}}State oldState) newState) {
    state = newState(state).copyWith(status: state.status);
  }


  @override
  Create{{name.pascalCase()}}State build() => const Create{{name.pascalCase()}}State();
}
