import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:kimapp_utils/kimapp_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../{{name.snakeCase()}}_schema.schema.dart';
import '../i_{{name.snakeCase()}}_repo.dart';

part '{{name.snakeCase()}}_detail_provider.g.dart';

@stateWidget
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
