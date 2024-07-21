// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_structure_example.table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateSampleParamImpl _$$CreateSampleParamImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateSampleParamImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$CreateSampleParamImplToJson(
        _$CreateSampleParamImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$UpdateSampleParamImpl _$$UpdateSampleParamImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateSampleParamImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UpdateSampleParamImplToJson(
        _$UpdateSampleParamImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
    };
