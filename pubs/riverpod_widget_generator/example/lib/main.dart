import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_widget_generator/riverpod_widget_generator.dart';

part 'main.freezed.dart';
part 'main.g.dart';

@freezed
class AnimalModel with _$AnimalModel {
  const AnimalModel._();

  const factory AnimalModel({
    required String name,
    required int age,
  }) = _AnimalModel;
}

@stateWidget
@riverpod
class Animal extends _$Animal {
  @override
  Future<AnimalModel> build({
    required int age,
  }) async {
    return AnimalModel(name: 'Dog', age: age);
  }
}
