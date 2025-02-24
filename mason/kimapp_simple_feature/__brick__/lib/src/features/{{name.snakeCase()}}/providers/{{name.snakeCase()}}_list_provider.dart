import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:kimapp_utils/kimapp_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../{{name.snakeCase()}}_schema.schema.dart';
import '../i_{{name.snakeCase()}}_repo.dart';

part '{{name.snakeCase()}}_list_provider.g.dart';

@stateWidget
@riverpod
class {{name.pascalCase()}}List extends _${{name.pascalCase()}}List {
  @override
  FutureOr<IList<{{name.pascalCase()}}Model>> build() {
    return _fetchItems();
  }

  Future<IList<{{name.pascalCase()}}Model>> _fetchItems() {
    return ref.watch({{name.camelCase()}}RepoProvider).findAll().then((value) => value.getOrThrow());
  }

  void updateItem({{name.pascalCase()}}Model item) {
    state = state.whenData((value) => value.updateById([item], (e) => e.id == item.id));
  }

  void insertItem({{name.pascalCase()}}Model item, {int index = 0}) {
    state = state.whenData((value) => value.insert(index, item));
  }

  Future<void> refreshItems() async {
    state = await AsyncValue.guard(() => _fetchItems());
  }
}
