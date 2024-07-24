// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FreezedModel _$FreezedModelFromJson(Map<String, dynamic> json) {
  return _FreezedModel.fromJson(json);
}

/// @nodoc
mixin _$FreezedModel {
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FreezedModelCopyWith<$Res> {
  factory $FreezedModelCopyWith(
          FreezedModel value, $Res Function(FreezedModel) then) =
      _$FreezedModelCopyWithImpl<$Res, FreezedModel>;
}

/// @nodoc
class _$FreezedModelCopyWithImpl<$Res, $Val extends FreezedModel>
    implements $FreezedModelCopyWith<$Res> {
  _$FreezedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$FreezedModelImplCopyWith<$Res> {
  factory _$$FreezedModelImplCopyWith(
          _$FreezedModelImpl value, $Res Function(_$FreezedModelImpl) then) =
      __$$FreezedModelImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FreezedModelImplCopyWithImpl<$Res>
    extends _$FreezedModelCopyWithImpl<$Res, _$FreezedModelImpl>
    implements _$$FreezedModelImplCopyWith<$Res> {
  __$$FreezedModelImplCopyWithImpl(
      _$FreezedModelImpl _value, $Res Function(_$FreezedModelImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
@TableModel('FreezedModel')
class _$FreezedModelImpl extends _FreezedModel {
  const _$FreezedModelImpl() : super._();

  factory _$FreezedModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FreezedModelImplFromJson(json);

  @override
  String toString() {
    return 'FreezedModel()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FreezedModelImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return _$$FreezedModelImplToJson(
      this,
    );
  }
}

abstract class _FreezedModel extends FreezedModel {
  const factory _FreezedModel() = _$FreezedModelImpl;
  const _FreezedModel._() : super._();

  factory _FreezedModel.fromJson(Map<String, dynamic> json) =
      _$FreezedModelImpl.fromJson;
}
