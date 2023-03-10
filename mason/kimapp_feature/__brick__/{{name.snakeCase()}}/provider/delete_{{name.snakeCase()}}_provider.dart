import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_{{name.snakeCase()}}_provider.g.dart';

/// Delete [{{name.pascalCase()}}Model] by call to repository then perform refresh to [{{name.pascalcase()}}ListProvider]
/// by doing validation on provider
@riverpod
class Delete{{name.pascalCase()}} extends _$Delete{{name.pascalCase()}} {
  @override
  Future<bool> build({{name.pascalCase()}}Id {{name.pascalcase()}}Id) async {
    return false;
  }


  Future<String?> call({
    void Function(dynamic value)? onSuccess,
    void Function(Failure failure)? onFailure,
  }) async {
    if (state == const AsyncValue.data(true) || state.isLoading) return null;
    state = const AsyncValue.loading();

    final result = await ref.read();

    return result.fold(
      (failure) {
        state = AsyncValue.error(failure, failure.stackTrace);
        if (onFailure != null) onFailure(failure);
        return failure.message;
      },
      (success) {
        state = const AsyncValue.data(true);
        ref.invalidate({{name.pascalcase()}}ListProvider);
        if (onSuccess != null) onSuccess(success);
        return null;
      },
    );
  }
}
