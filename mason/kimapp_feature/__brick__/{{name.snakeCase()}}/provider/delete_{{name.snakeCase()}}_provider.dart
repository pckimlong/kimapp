// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import '../../../../exports.dart';
// ignore: unused_import
import '../{{name.snakeCase()}}.dart';

part 'delete_{{name.snakeCase()}}_provider.freezed.dart';
part 'delete_{{name.snakeCase()}}_provider.g.dart';

@freezed
class Delete{{name.pascalCase()}}Data with _$Delete{{name.pascalCase()}}Data, ProviderStatusClassMixin<Delete{{name.pascalCase()}}Data, Unit> {
  const factory Delete{{name.pascalCase()}}Data({
    required {{name.pascalCase()}}Id {{name.snakeCase()}}Id,

    /// provider status
    @Default(ProviderStatus.initial()) ProviderStatus<Unit> status,
  }) = _Delete{{name.pascalCase()}}Data;

  const Delete{{name.pascalCase()}}Data._();

  @override
  Delete{{name.pascalCase()}}Data updateStatus(ProviderStatus<Unit> newStatus) {
    return copyWith(status: newStatus);
  }

  Delete{{name.pascalCase()}}Param toParam() {
    // Perform validation

    return Delete{{name.pascalCase()}}Param({{name.snakeCase()}}Id: {{name.snakeCase()}}Id);
  }
}

@riverpod
class Delete{{name.pascalCase()}} extends _$Delete{{name.pascalCase()}} {
  Future<ProviderStatus<Unit>> call() async {
    return await perform<Unit>(
      (state) async {
        _performValidation();

        final result = await ref.read({{name.snakeCase()}}RepoProvider).delete(state.toParam());
        return result.getOrThrow();
      },
      onSuccess: (_) {
        ref.invalidate({{name.snakeCase()}}ListProvider);
        ref.invalidate({{name.snakeCase()}}DetailProvider({{name.snakeCase()}}Id));
        ref.invalidate({{name.snakeCase()}}ListPaginationProvider);
      },
    );
  }

  void _performValidation() {}

  @override
  Delete{{name.pascalCase()}}Data build({{name.pascalCase()}}Id {{name.snakeCase()}}Id) => Delete{{name.pascalCase()}}Data({{name.snakeCase()}}Id: {{name.snakeCase()}}Id);
}
