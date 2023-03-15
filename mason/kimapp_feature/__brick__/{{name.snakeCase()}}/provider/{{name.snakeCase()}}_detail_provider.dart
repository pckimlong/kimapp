// Package imports:
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import '../{{name.snakeCase()}}.dart';

part '{{name.snakeCase()}}_detail_provider.g.dart';

@riverpod
class {{name.pascalCase()}}Detail extends _${{name.pascalCase()}}Detail {
  @override
  FutureOr<{{name.pascalCase()}}DetailModel> build({{name.pascalCase()}}Id {{name.snakeCase()}}Id) {
    ref.autoInvalidateSelf(const Duration(minutes: 3));
    return ref.watch({{name.camelCase()}}RepoProvider).findOne({{name.snakeCase()}}Id).then((value) => value.getOrThrow());
  }

  /// Perform side-effect update detail provider
  void updateState({{name.pascalCase()}}DetailModel Function({{name.pascalCase()}}DetailModel oldState) newState) {
    state = state.whenData(newState);
  }
}
