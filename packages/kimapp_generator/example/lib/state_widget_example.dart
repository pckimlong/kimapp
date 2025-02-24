import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:kimapp_utils/kimapp_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state_widget_example.g.dart';

@riverpod
@stateWidget
int primative(Ref ref) {
  return 1;
}

@riverpod
@stateWidget
class PrimativeClass extends _$PrimativeClass {
  @override
  int build() {
    return 1;
  }
}

@riverpod
@stateWidget
class StringFuture extends _$StringFuture {
  @override
  Future<String> build({
    required String family,
    required String second,
  }) async {
    return 'string';
  }
}

@riverpod
@stateWidget
class StringFutureOptional extends _$StringFutureOptional {
  @override
  Future<String> build(
    int a, {
    required String family,
    String? second,
  }) async {
    return 'string';
  }
}

@riverpod
@stateWidget
int primativeFaimily(Ref ref, int family, int second) {
  return family;
}

@riverpod
@stateWidget
int primativeFaimilyRequired(Ref ref, {required int family, int? second}) {
  return family;
}

@riverpod
@stateWidget
int primativeFaimilyWithDefault(Ref ref, {required int family, int second = 1}) {
  return family;
}

@riverpod
@stateWidget
Future<int> primativeFaimilyWithDefaultAsync(Ref ref, {required int family, int? second}) async {
  return family;
}

@riverpod
@stateWidget
Stream<int> primativeFaimilyWithDefaultStream(Ref ref,
    {required int family, int second = 1}) async* {
  yield family;
}

@riverpod
@stateWidget
int primativeFaimilyOptional(Ref ref, {int? family}) {
  return family ?? 1;
}
