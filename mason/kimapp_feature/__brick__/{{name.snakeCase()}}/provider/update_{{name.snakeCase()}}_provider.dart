import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_{{name.snakeCase()}}_provider.g.dart';

/// Update [{{name.pascalCase()}}Model] by call to repository then update item to [{{name.pascalcase()}}ListProvider]
@riverpod
class Update{{name.pascalCase()}} extends _$Update{{name.pascalCase()}} {
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
        ref.read({{name.pascalcase()}}ListProvider.notifier).updateItem(success);
        if (onSuccess != null) onSuccess(success);
        return null;
      },
    );
  }
}