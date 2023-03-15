// Package imports:
// ignore_for_file: unused_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import '../../../../exports.dart';
import '../core/core.dart';
import '../model/models.dart';
import '../param/params.dart';
import '../repository/i_{{name.snakeCase()}}_repo.dart';

part "{{name.snakeCase()}}_list_provider.freezed.dart";
part '{{name.snakeCase()}}_list_provider.g.dart';

@riverpod
class {{name.pascalCase()}}List extends _${{name.pascalCase()}}List {
  @override
  FutureOr<IList<{{name.pascalCase()}}Model>> build() {
    ref.autoInvalidateSelf(const Duration(minutes: 5));
    return _fetchItems();
  }

  Future<IList<{{name.pascalCase()}}Model>> _fetchItems() {
    const param = {{name.pascalCase()}}ListParam(); // use static filter for now
    return ref.watch({{name.camelCase()}}RepoProvider).findAll(param).then((value) => value.getOrThrow());
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

/// Retrieve side effect version of [{{name.pascalCase()}}Model] from [ListProvider]
/// by given [Id]. If [Id] is null or no item found
/// null will be returned
@riverpod
FutureOr<{{name.pascalCase()}}Model?> {{name.camelCase()}}OfId({{name.pascalCase()}}OfIdRef ref, {{name.pascalCase()}}Id? {{name.camelCase()}}Id) {
  return ref.watch(
    {{name.camelCase()}}ListProvider.selectAsync(
      (baseList) => baseList.firstOrNullWhere(
        (object) => object.id == {{name.camelCase()}}Id,
      ),
    ),
  );
}

// Side-effect filter version
@freezed
class {{name.pascalCase()}}ListFilterParam with _${{name.pascalCase()}}ListFilterParam {
  const factory {{name.pascalCase()}}ListFilterParam() = _{{name.pascalCase()}}ListFilterParam;
}

@riverpod
AsyncValue<IList<{{name.pascalCase()}}Model>> {{name.camelCase()}}FilteredList(
  {{name.pascalCase()}}FilteredListRef ref, {
  {{name.pascalCase()}}ListFilterParam filter = const {{name.pascalCase()}}ListFilterParam(),
}) {
  return ref.watch({{name.camelCase()}}ListProvider).whenData(
    (baseList) {
      var filtered = baseList.toIterable();
      // TODO - Implement filter

      return filtered.toIList();
    },
  );
}
