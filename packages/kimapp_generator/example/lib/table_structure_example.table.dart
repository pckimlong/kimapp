// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// TableStructureGenerator
// **************************************************************************

// ignore_for_file: invalid_annotation_target, unnecessary_import
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kimapp/kimapp.dart';

part 'table_structure_example.table.freezed.dart';
part 'table_structure_example.table.g.dart';

class SampleId extends Identity<int> {
  const SampleId._(this.value);

  @override
  final int value;

  factory SampleId.fromJson(dynamic value) {
    return SampleId._(value);
  }

  factory SampleId.fromValue(int value) {
    return SampleId._(value);
  }
}

class SampleTable {
  const SampleTable._();

  static const String table = "samples";

  static const String id = "id";
  static const String name = "name";
  static const String description = "description";
  static const String createdAt = "createdAt";
  static const String updatedAt = "updatedAt";
}

@freezed
class CreateSampleParam with _$CreateSampleParam {
  const CreateSampleParam._();
  const factory CreateSampleParam({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'createdAt') required DateTime createdAt,
  }) = _CreateSampleParam;

  factory CreateSampleParam.fromJson(Map<String, dynamic> json) =>
      _$CreateSampleParamFromJson(json);
}

@freezed
class UpdateSampleParam with _$UpdateSampleParam {
  const UpdateSampleParam._();
  const factory UpdateSampleParam({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'createdAt') required DateTime createdAt,
  }) = _UpdateSampleParam;

  factory UpdateSampleParam.fromJson(Map<String, dynamic> json) =>
      _$UpdateSampleParamFromJson(json);
}
