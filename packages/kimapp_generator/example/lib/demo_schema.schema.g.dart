// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_schema.schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DemoModelImpl _$$DemoModelImplFromJson(Map<String, dynamic> json) =>
    _$DemoModelImpl(
      name: json['name'] as String?,
      description: json['description'] as String?,
      age: (json['age'] as num).toInt(),
      birthdate: json['birthdate'] == null
          ? null
          : DateTime.parse(json['birthdate'] as String),
      address: json['address'] as String?,
      other: json['other'] == null
          ? null
          : OtherModel.fromJson(json['other'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DemoModelImplToJson(_$DemoModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'age': instance.age,
      'birthdate': instance.birthdate?.toIso8601String(),
      'address': instance.address,
      'other': instance.other?.toJson(),
    };

_$DemoDetailModelImpl _$$DemoDetailModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DemoDetailModelImpl(
      name: json['name'] as String?,
      description: json['description'] as String?,
      age: (json['age'] as num).toInt(),
      birthdate: json['birthdate'] == null
          ? null
          : DateTime.parse(json['birthdate'] as String),
      address: json['address'] as String?,
      other: json['other'] == null
          ? null
          : OtherModel.fromJson(json['other'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DemoDetailModelImplToJson(
        _$DemoDetailModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'age': instance.age,
      'birthdate': instance.birthdate?.toIso8601String(),
      'address': instance.address,
      'other': instance.other?.toJson(),
    };

_$DemoLiteModelImpl _$$DemoLiteModelImplFromJson(Map<String, dynamic> json) =>
    _$DemoLiteModelImpl(
      name: json['name'] as String?,
      age: (json['age'] as num).toInt(),
      birthdate: json['birthdate'] == null
          ? null
          : DateTime.parse(json['birthdate'] as String),
      address: json['address'] as String?,
      other: json['other'] == null
          ? null
          : OtherModel.fromJson(json['other'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DemoLiteModelImplToJson(_$DemoLiteModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'birthdate': instance.birthdate?.toIso8601String(),
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
    ColumnBuilder('birthdate'),
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
    ColumnBuilder('birthdate'),
    ColumnBuilder('address'),
    ColumnBuilder.join(OtherModel.table,
        key: "other", candidateKey: null, foreignKey: 'other_id'),
  ],
);
