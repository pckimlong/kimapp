import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    @Default(false) bool isActive,
  }) = _AnimalModel;
}

@stateWidget
@riverpod
Future<IList<int>> age(Ref ref) async {
  await Future.delayed(const Duration(seconds: 1));
  return IList();
}
