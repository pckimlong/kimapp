
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


import '../{{name.snakeCase()}}_model.dart';
import '../i_{{name.snakeCase()}}_repo.dart';

part '{{name.snakeCase()}}_detail_provider.g.dart';

@riverpod
class {{name.pascalCase()}}Detail extends _${{name.pascalCase()}}Detail {
  @override
  FutureOr<{{name.pascalCase()}}Model> build({{name.pascalCase()}}Id id) {
    return ref.watch({{name.camelCase()}}RepoProvider).findOne(id).then((value) => value.getOrThrow());
  }

  /// Perform side-effect update detail provider
  void updateState({{name.pascalCase()}}Model Function({{name.pascalCase()}}Model oldState) newState) {
    state = state.whenData(newState);
  }
}
