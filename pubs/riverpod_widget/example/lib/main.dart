import 'package:example/main.widget.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_widget/riverpod_widget.dart';

part 'main.freezed.dart';
part 'main.g.dart';

@freezed
class AnimalModel with _$AnimalModel {
  const AnimalModel._();

  const factory AnimalModel({
    int? id,
    required String name,
    required int age,
    String? description,
  }) = _AnimalModel;
}

@stateWidget
@riverpod
class Animal extends _$Animal {
  @override
  Future<AnimalModel> build({required String animalName, int age = 1}) async {
    return const AnimalModel(name: 'Dog', age: 1, description: 'This is a dog');
  }
}

void main() {
  AnimalSelectWidget(
    selector: (state) => state.age,
    onStateChanged: (previous, next) {},
    builder: (context, ref, value) {
      return const Text('data');
    },
  );
}
