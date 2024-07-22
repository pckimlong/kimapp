// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// TableStructureGenerator
// **************************************************************************

// ignore_for_file: invalid_annotation_target, unused_import
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';

import 'package:example/state_widget_example.dart';
import 'table_structure_example.dart';

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
  static const String ids = "ids";
  static const String good = "good";
}

@freezed
class SampleRawModel with _$SampleRawModel {
  const SampleRawModel._();

  @TableModel("samples")
  const factory SampleRawModel({
    @JsonKey(name: "id") required SampleId id,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "createdAt") required DateTime createdAt,
    @JsonKey(name: "updatedAt") required DateTime updatedAt,
    @JsonKey(name: "ids") required List<int> ids,
  }) = _SampleRawModel;

  factory SampleRawModel.fromJson(Map<String, dynamic> json) =>
      _$SampleRawModelFromJson(json);

  static const TableBuilder table = _tableSampleRawModel;
}

@freezed
class UpdateSampleParam with _$UpdateSampleParam {
  const UpdateSampleParam._();

  @TableModel("v_sample")
  const factory UpdateSampleParam({
    @JsonKey(name: "id") required SampleId id,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "updatedAt") required DateTime updatedAt,
    @JsonKey(name: "ids") required List<int> ids,
    @JsonKey(name: "address") required int address,
    @JoinedColumn(foreignKey: "example_id")
    @JsonKey(name: "ex")
    required ExampleModel ex,
  }) = _UpdateSampleParam;

  factory UpdateSampleParam.fromJson(Map<String, dynamic> json) =>
      _$UpdateSampleParamFromJson(json);

  static const TableBuilder table = _tableUpdateSampleParam;
}
