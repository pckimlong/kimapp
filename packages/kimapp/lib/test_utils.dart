// ignore_for_file: depend_on_referenced_packages

import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

// Copied from riverpod package test utils
ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );
  addTearDown(container.dispose);
  return container;
}
