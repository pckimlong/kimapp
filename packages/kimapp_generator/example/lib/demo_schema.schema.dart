// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// KimappSchemaGenerator
// **************************************************************************

// Generated from: demo_schema.dart
//
// Generated Classes:
// - DemoTable: Static constants for table/column names - table, name, description, age, address, other
// - DemoModel: name:String?, description:String?, age:int, address:String?, other:OtherModel?
// - DemoDetailModel: name:String?, description:String?, age:int, address:String?, other:OtherModel?, name2:String, age2:int
// - DemoLiteModel: name:String?, age:int, address:String?, other:OtherModel?

// ignore_for_file: invalid_annotation_target, unused_import, require_trailing_commas
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';
import 'package:example/other_schema.schema.dart';
import 'demo_schema.dart';
part 'demo_schema.schema.freezed.dart';
part 'demo_schema.schema.g.dart';

class DemoTable {
  const DemoTable._();
  static const String table = "demos";
  static const String name = "name";
  static const String description = "description";
  static const String age = "age";
  static const String address = "address";
  static const String other = "other";
}

abstract class BaseDemoSchema {}

abstract class IDemoModel {
  String? get name;
  String? get description;
  int get age;
  String? get address;
  OtherModel? get other;
}

@freezed
sealed class DemoModel with _$DemoModel implements BaseDemoSchema, IDemoModel {
  const DemoModel._();
  @TableModel(DemoModel.tableName)
  @JsonSerializable(explicitToJson: true)
  const factory DemoModel({
    @JsonKey(name: "name") required String? name,
    @JsonKey(name: "description") required String? description,
    @JsonKey(name: "age") required int age,
    @JsonKey(name: "address") required String? address,
    @JoinedColumn(foreignKey: "other_id", candidateKey: null)
    @JsonKey(name: "other")
    required OtherModel? other,
  }) = _DemoModel;
  factory DemoModel.fromJson(Map<String, dynamic> json) =>
      _$DemoModelFromJson(json);
  static const TableBuilder table = _tableDemoModel;
  static const String tableName = "demos";
}

@freezed
sealed class DemoDetailModel
    with _$DemoDetailModel
    implements BaseDemoSchema, IDemoModel {
  const DemoDetailModel._();
  @TableModel(DemoDetailModel.tableName)
  @JsonSerializable(explicitToJson: true)
  const factory DemoDetailModel({
    @JsonKey(name: "name") required String? name,
    @JsonKey(name: "description") required String? description,
    @JsonKey(name: "age") required int age,
    @JsonKey(name: "address") required String? address,
    @JoinedColumn(foreignKey: "other_id", candidateKey: null)
    @JsonKey(name: "other")
    required OtherModel? other,
    @JsonKey(name: "name2") required String name2,
    @JsonKey(name: "age2") required int age2,
  }) = _DemoDetailModel;
  factory DemoDetailModel.fromJson(Map<String, dynamic> json) =>
      _$DemoDetailModelFromJson(json);
  static const TableBuilder table = _tableDemoDetailModel;
  static const String tableName = "v_demo_detail";
  DemoModel toDemoModel() {
    return DemoModel(
      name: name,
      description: description,
      age: age,
      address: address,
      other: other,
    );
  }
}

@freezed
sealed class DemoLiteModel with _$DemoLiteModel implements BaseDemoSchema {
  const DemoLiteModel._();
  @JsonSerializable(explicitToJson: true)
  const factory DemoLiteModel({
    @JsonKey(name: "name") required String? name,
    @JsonKey(name: "age") required int age,
    @JsonKey(name: "address") required String? address,
    @JoinedColumn(foreignKey: "other_id", candidateKey: null)
    @JsonKey(name: "other")
    required OtherModel? other,
  }) = _DemoLiteModel;
  factory DemoLiteModel.fromJson(Map<String, dynamic> json) =>
      _$DemoLiteModelFromJson(json);
}
