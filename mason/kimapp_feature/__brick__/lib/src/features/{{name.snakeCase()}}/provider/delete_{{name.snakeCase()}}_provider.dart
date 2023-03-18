// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import '../../../../../../../exports.dart';
// ignore: unused_import
import '../{{name.snakeCase()}}.dart';

part 'delete_{{name.snakeCase()}}_provider.freezed.dart';
part 'delete_{{name.snakeCase()}}_provider.g.dart';

@freezed
class Delete{{name.pascalCase()}}Data with _$Delete{{name.pascalCase()}}Data, ProviderStatusClassMixin<Delete{{name.pascalCase()}}Data, Unit> {
  const factory Delete{{name.pascalCase()}}Data({
    required {{name.pascalCase()}}Id {{name.camelCase()}}Id,

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

    return Delete{{name.pascalCase()}}Param({{name.camelCase()}}Id: {{name.camelCase()}}Id);
  }
}

@riverpod
class Delete{{name.pascalCase()}} extends _$Delete{{name.pascalCase()}} with _$Delete{{name.pascalCase()}}Form {
  Future<ProviderStatus<Unit>> call() async {
    return await perform<Unit>(
      (state) async {
        _performValidation();

        final result = await ref.read({{name.camelCase()}}RepoProvider).delete(state.toParam());
        return result.getOrThrow();
      },
      onSuccess: (_) {
        ref.invalidate({{name.camelCase()}}ListProvider);
        ref.invalidate({{name.camelCase()}}DetailProvider({{name.camelCase()}}Id));
        ref.invalidate({{name.camelCase()}}ListPaginationProvider);
      },
    );
  }

  void _performValidation() {}

  @override
  Delete{{name.pascalCase()}}Data build({{name.pascalCase()}}Id {{name.camelCase()}}Id) => Delete{{name.pascalCase()}}Data({{name.camelCase()}}Id: {{name.camelCase()}}Id);
}
