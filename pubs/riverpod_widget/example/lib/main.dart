// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    String? description,
    String? email,
    @Default(false) bool isActive,
  }) = _AnimalModel;
}

class Testing {
  final int age;
  final String name;

  Testing({required this.age, required this.name});

  Testing copyWith({
    int? age,
    String? name,
  }) {
    return Testing(
      age: age ?? this.age,
      name: name ?? this.name,
    );
  }
}

@formWidget
@riverpod
class AnimalModelForm extends _$AnimalModelFormWidget {
  @override
  Testing build(int age) {
    throw UnimplementedError();
  }

  @override
  Future<int> submit(int age) {
    throw UnimplementedError();
  }
}
