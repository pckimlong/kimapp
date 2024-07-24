// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testing.schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TestingModelImpl _$$TestingModelImplFromJson(Map<String, dynamic> json) =>
    _$TestingModelImpl(
      id: TestingId.fromJson(json['id']),
      name: json['name'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      nullColumn: json['null_column'] as String?,
      selfref: json['selfref'] == null
          ? null
          : Example2Model.fromJson(json['selfref'] as Map<String, dynamic>),
      freezedClass:
          FreezedModel.fromJson(json['freezedClass'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TestingModelImplToJson(_$TestingModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'null_column': instance.nullColumn,
      'selfref': instance.selfref,
      'freezedClass': instance.freezedClass,
    };

_$TestingViewImpl _$$TestingViewImplFromJson(Map<String, dynamic> json) =>
    _$TestingViewImpl(
      id: TestingId.fromJson(json['id']),
      name: json['name'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      nullColumn: json['null_column'] as String?,
      selfref: json['selfref'] == null
          ? null
          : Example2Model.fromJson(json['selfref'] as Map<String, dynamic>),
      freezedClass:
          FreezedModel.fromJson(json['freezedClass'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TestingViewImplToJson(_$TestingViewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'null_column': instance.nullColumn,
      'selfref': instance.selfref,
      'freezedClass': instance.freezedClass,
    };

// **************************************************************************
// TableModelGenerator
// **************************************************************************

const _tableTestingModel = TableBuilder(
  tableName: "testings",
  columns: [
    ColumnBuilder('id'),
    ColumnBuilder('name'),
    ColumnBuilder('phone'),
    ColumnBuilder('address'),
    ColumnBuilder('null_column'),
    ColumnBuilder.join(Example2Model.table,
        key: "selfref", candidateKey: null, foreignKey: null),
    ColumnBuilder.join(FreezedModel.table,
        key: "freezedClass", candidateKey: null, foreignKey: null),
  ],
);

const _tableTestingView = TableBuilder(
  tableName: "v_testings",
  columns: [
    ColumnBuilder('id'),
    ColumnBuilder('name'),
    ColumnBuilder('phone'),
    ColumnBuilder('address'),
    ColumnBuilder('null_column'),
    ColumnBuilder.join(Example2Model.table,
        key: "selfref", candidateKey: null, foreignKey: null),
    ColumnBuilder.join(FreezedModel.table,
        key: "freezedClass", candidateKey: null, foreignKey: null),
  ],
);
