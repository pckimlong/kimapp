// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_schema.schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DemoModel _$DemoModelFromJson(Map<String, dynamic> json) => _DemoModel(
      name: json['name'] as String?,
      description: json['description'] as String?,
      age: (json['age'] as num).toInt(),
      address: json['address'] as String?,
      other: json['other'] == null
          ? null
          : OtherModel.fromJson(json['other'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DemoModelToJson(_DemoModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'age': instance.age,
      'address': instance.address,
      'other': instance.other?.toJson(),
    };

_DemoDetailModel _$DemoDetailModelFromJson(Map<String, dynamic> json) =>
    _DemoDetailModel(
      name: json['name'] as String?,
      description: json['description'] as String?,
      age: (json['age'] as num).toInt(),
      address: json['address'] as String?,
      other: json['other'] == null
          ? null
          : OtherModel.fromJson(json['other'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DemoDetailModelToJson(_DemoDetailModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'age': instance.age,
      'address': instance.address,
      'other': instance.other?.toJson(),
    };

_DemoLiteModel _$DemoLiteModelFromJson(Map<String, dynamic> json) =>
    _DemoLiteModel(
      name: json['name'] as String?,
      age: (json['age'] as num).toInt(),
      address: json['address'] as String?,
      other: json['other'] == null
          ? null
          : OtherModel.fromJson(json['other'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DemoLiteModelToJson(_DemoLiteModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'address': instance.address,
      'other': instance.other?.toJson(),
    };

// **************************************************************************
// TableModelGenerator
// **************************************************************************

const _tableDemoModel = TableBuilder(
  tableName: "demos",
  columns: [
    ColumnBuilder('name'),
    ColumnBuilder('description'),
    ColumnBuilder('age'),
    ColumnBuilder('address'),
    ColumnBuilder.join(OtherModel.table,
        key: "other", candidateKey: null, foreignKey: 'other_id'),
  ],
);

const _tableDemoDetailModel = TableBuilder(
  tableName: "v_demo_detail",
  columns: [
    ColumnBuilder('name'),
    ColumnBuilder('description'),
    ColumnBuilder('age'),
    ColumnBuilder('address'),
    ColumnBuilder.join(OtherModel.table,
        key: "other", candidateKey: null, foreignKey: 'other_id'),
  ],
);
