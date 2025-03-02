// ignore_for_file: invalid_use_of_internal_member

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages, implementation_imports
import 'package:riverpod/src/async_notifier.dart';

mixin IListAsyncNotifier<T> on AsyncNotifierBase<IList<T>> {
  /// Returns true if the given [item] matches the identity criteria for updating/removing items.
  ///
  /// This is used by [removeItem], [updateItem], and [updateItems] to determine which items
  /// to modify in the list. Typically compares unique identifiers like IDs.
  bool identity(T item);

  void insertItem(T item, {int index = 0}) {
    state = state.whenData((value) => value.insert(index, item));
  }

  void removeWhere(bool Function(T item) test) {
    state = state.whenData((value) => value.removeWhere(test));
  }

  void removeItem(T item) {
    state = state.whenData((value) => value.removeWhere((e) => identity(e)));
  }

  void updateItem(T item) {
    state =
        state.whenData((value) => value.updateById([item], (e) => identity(e)));
  }

  void updateState(IList<T> Function(IList<T> value) update) {
    state = state.whenData(update);
  }

  void updateItems(List<T> items) {
    state =
        state.whenData((value) => value.updateById(items, (e) => identity(e)));
  }
}
