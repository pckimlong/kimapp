// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_schema.schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OtherModel _$OtherModelFromJson(Map<String, dynamic> json) => _OtherModel(
      id: OtherId.fromJson(json['id']),
      name: json['name'] as String,
    );

Map<String, dynamic> _$OtherModelToJson(_OtherModel instance) =>
    <String, dynamic>{
      'id': instance.id.toJson(),
      'name': instance.name,
    };

// **************************************************************************
// TableModelGenerator
// **************************************************************************

const _tableOtherModel = TableBuilder(
  tableName: "others",
  columns: [
    ColumnBuilder('id'),
    ColumnBuilder('name'),
  ],
);
