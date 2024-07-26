// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_schema.schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserBaseModelImpl _$$UserBaseModelImplFromJson(Map<String, dynamic> json) =>
    _$UserBaseModelImpl(
      id: DemoId.fromJson(json['id']),
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$$UserBaseModelImplToJson(_$UserBaseModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };

_$UserDetailModelImpl _$$UserDetailModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserDetailModelImpl(
      id: DemoId.fromJson(json['id']),
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$$UserDetailModelImplToJson(
        _$UserDetailModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };

_$UserLiteModelImpl _$$UserLiteModelImplFromJson(Map<String, dynamic> json) =>
    _$UserLiteModelImpl(
      id: DemoId.fromJson(json['id']),
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$$UserLiteModelImplToJson(_$UserLiteModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };

// **************************************************************************
// TableModelGenerator
// **************************************************************************

const _tableUserBaseModel = TableBuilder(
  tableName: "users",
  columns: [
    ColumnBuilder('id'),
    ColumnBuilder('name'),
    ColumnBuilder('description'),
  ],
);

const _tableUserDetailModel = TableBuilder(
  tableName: "v_user_detail",
  columns: [
    ColumnBuilder('id'),
    ColumnBuilder('name'),
    ColumnBuilder('description'),
  ],
);

const _tableUserLiteModel = TableBuilder(
  tableName: "test",
  columns: [
    ColumnBuilder('id'),
    ColumnBuilder('name'),
    ColumnBuilder('description'),
  ],
);
