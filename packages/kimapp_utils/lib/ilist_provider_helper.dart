// ignore_for_file: invalid_use_of_internal_member

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin IListAsyncNotifier<T> on AsyncNotifier<IList<T>> {
  /// Returns true if the given [item] matches the identity criteria for updating/removing items.
  ///
  /// This is used by [removeItem], [updateItem], and [updateItems] to determine which items
  /// to modify in the list. Typically compares unique identifiers like IDs.
  bool comparer(T a, T b);

  void insertItem(T item, {int index = 0}) {
    state = state.whenData((value) => value.insert(index, item));
  }

  void insertItems(IList<T> items, {int index = 0}) {
    state = state.whenData((value) => value.insertAll(index, items));
  }

  void addToLast(T item) {
    state = state.whenData((value) => value.add(item));
  }

  void removeWhere(bool Function(T item) test) {
    state = state.whenData((value) => value.removeWhere(test));
  }

  void removeItem(T item) {
    state = state.whenData((value) => value.removeWhere((e) => comparer(item, e)));
  }

  void updateItem(T item) {
    state = state.whenData((value) => value.updateById([item], (e) => comparer(item, e)));
  }

  void updateState(IList<T> Function(IList<T> value) update) {
    state = state.whenData(update);
  }

  void updateItems(List<T> items) {
    state = state.whenData(
        (value) => value.updateById(items, (e) => items.any((item) => comparer(item, e))));
  }
}
