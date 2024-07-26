// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_schema.schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OtherModelImpl _$$OtherModelImplFromJson(Map<String, dynamic> json) =>
    _$OtherModelImpl(
      id: OtherId.fromJson(json['id']),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$OtherModelImplToJson(_$OtherModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
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
