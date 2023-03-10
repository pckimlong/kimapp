import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_{{name.snakeCase()}}_provider.g.dart';


/// Creates new [{{name.pascalCase()}}Model] by call to repository then insert created item to [{{name.pascalcase()}}ListProvider]
@riverpod
class Create{{name.pascalCase()}} extends _$Create{{name.pascalCase()}} {
  @override
  Future<bool> build() async {
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
        ref.read({{name.pascalcase()}}ListProvider.notifier).insertItem(success);
        if (onSuccess != null) onSuccess(success);
        return null;
      },
    );
  }
}

