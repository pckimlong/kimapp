// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:kimapp/kimapp.dart';

@TableStructure('users', columns: ['id', 'name'])
class TestingId extends Identity<int> {
  const TestingId._(this.value);

  @override
  final int value;

  factory TestingId.fromJson(dynamic value) {
    return TestingId._(value);
  }
}

@TableModel("")
class TestModel {
  final String name;
  final int age;
  final DateTime date;
  TestModel({
    required this.name,
    required this.age,
    required this.date,
  });
}

@JsonSerializable()
class TestJson {
  final String name;
  final String address;
  final DateTime date;

  TestJson({
    required this.name,
    required this.address,
    required this.date,
  });
}
