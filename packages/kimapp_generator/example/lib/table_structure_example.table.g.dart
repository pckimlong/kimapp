// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_structure_example.table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SampleRawModelImpl _$$SampleRawModelImplFromJson(Map<String, dynamic> json) =>
    _$SampleRawModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      ids: (json['ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$$SampleRawModelImplToJson(
        _$SampleRawModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'ids': instance.ids,
    };

_$UpdateSampleParamImpl _$$UpdateSampleParamImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateSampleParamImpl(
      name: json['name'] as String,
      description: json['description'] as String?,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      ids: (json['ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      address: (json['address'] as num).toInt(),
      ex: ExampleModel.fromJson(json['ex'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UpdateSampleParamImplToJson(
        _$UpdateSampleParamImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'ids': instance.ids,
      'address': instance.address,
      'ex': instance.ex,
    };

// **************************************************************************
// TableModelGenerator
// **************************************************************************

const _tableSampleRawModel = TableBuilder(
  tableName: "samples",
  columns: [
    ColumnBuilder('id'),
    ColumnBuilder('name'),
    ColumnBuilder('description'),
    ColumnBuilder('createdAt'),
    ColumnBuilder('updatedAt'),
    ColumnBuilder('ids'),
  ],
);

const _tableUpdateSampleParam = TableBuilder(
  tableName: "v_sample",
  columns: [
    ColumnBuilder('name'),
    ColumnBuilder('description'),
    ColumnBuilder('updatedAt'),
    ColumnBuilder('ids'),
    ColumnBuilder('address'),
    ColumnBuilder.join(ExampleModel.table,
        key: "ex", candidateKey: null, foreignKey: 'example_id'),
  ],
);
