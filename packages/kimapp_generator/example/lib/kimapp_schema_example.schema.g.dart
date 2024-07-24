// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kimapp_schema_example.schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Example2ModelImpl _$$Example2ModelImplFromJson(Map<String, dynamic> json) =>
    _$Example2ModelImpl(
      id: ExmapleId.fromJson(json['id']),
      name: json['name'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$$Example2ModelImplToJson(_$Example2ModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
    };

_$CreateExampleParamImpl _$$CreateExampleParamImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateExampleParamImpl(
      name: json['name'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$$CreateExampleParamImplToJson(
        _$CreateExampleParamImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
    };

_$ExampleViewImpl _$$ExampleViewImplFromJson(Map<String, dynamic> json) =>
    _$ExampleViewImpl(
      id: ExmapleId.fromJson(json['id']),
      name: json['name'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$$ExampleViewImplToJson(_$ExampleViewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
    };

// **************************************************************************
// TableModelGenerator
// **************************************************************************

const _tableExample2Model = TableBuilder(
  tableName: "exampleses",
  columns: [
    ColumnBuilder('id'),
    ColumnBuilder('name'),
    ColumnBuilder('phone'),
  ],
);

const _tableCreateExampleParam = TableBuilder(
  tableName: "exampleses",
  columns: [
    ColumnBuilder('name'),
    ColumnBuilder('phone'),
  ],
);

const _tableExampleView = TableBuilder(
  tableName: "v_examples",
  columns: [
    ColumnBuilder('id'),
    ColumnBuilder('name'),
    ColumnBuilder('phone'),
  ],
);
