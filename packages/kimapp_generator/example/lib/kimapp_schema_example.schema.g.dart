// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kimapp_schema_example.schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExampleModelImpl _$$ExampleModelImplFromJson(Map<String, dynamic> json) =>
    _$ExampleModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
    );

Map<String, dynamic> _$$ExampleModelImplToJson(_$ExampleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'age': instance.age,
    };

_$CreateExampleParamImpl _$$CreateExampleParamImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateExampleParamImpl(
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
    );

Map<String, dynamic> _$$CreateExampleParamImplToJson(
        _$CreateExampleParamImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
    };

_$UpdateExampleParamImpl _$$UpdateExampleParamImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateExampleParamImpl();

Map<String, dynamic> _$$UpdateExampleParamImplToJson(
        _$UpdateExampleParamImpl instance) =>
    <String, dynamic>{};

_$ExampleViewImpl _$$ExampleViewImplFromJson(Map<String, dynamic> json) =>
    _$ExampleViewImpl();

Map<String, dynamic> _$$ExampleViewImplToJson(_$ExampleViewImpl instance) =>
    <String, dynamic>{};

// **************************************************************************
// TableModelGenerator
// **************************************************************************

const _tableExampleModel = TableBuilder(
  tableName: "exampleses",
  columns: [
    ColumnBuilder('id'),
    ColumnBuilder('name'),
    ColumnBuilder('age'),
  ],
);

const _tableCreateExampleParam = TableBuilder(
  tableName: "exampleses",
  columns: [
    ColumnBuilder('name'),
    ColumnBuilder('age'),
  ],
);

const _tableUpdateExampleParam = TableBuilder(
  tableName: "exampleses",
  columns: [],
);

const _tableExampleView = TableBuilder(
  tableName: "v_examples",
  columns: [],
);
