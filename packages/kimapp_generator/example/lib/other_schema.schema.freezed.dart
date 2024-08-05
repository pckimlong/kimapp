// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'other_schema.schema.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OtherModel _$OtherModelFromJson(Map<String, dynamic> json) {
  return _OtherModel.fromJson(json);
}

/// @nodoc
mixin _$OtherModel {
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtherModelCopyWith<$Res> {
  factory $OtherModelCopyWith(
          OtherModel value, $Res Function(OtherModel) then) =
      _$OtherModelCopyWithImpl<$Res, OtherModel>;
}

/// @nodoc
class _$OtherModelCopyWithImpl<$Res, $Val extends OtherModel>
    implements $OtherModelCopyWith<$Res> {
  _$OtherModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$OtherModelImplCopyWith<$Res> {
  factory _$$OtherModelImplCopyWith(
          _$OtherModelImpl value, $Res Function(_$OtherModelImpl) then) =
      __$$OtherModelImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OtherModelImplCopyWithImpl<$Res>
    extends _$OtherModelCopyWithImpl<$Res, _$OtherModelImpl>
    implements _$$OtherModelImplCopyWith<$Res> {
  __$$OtherModelImplCopyWithImpl(
      _$OtherModelImpl _value, $Res Function(_$OtherModelImpl) _then)
      : super(_value, _then);
}

/// @nodoc

@TableModel(OtherModel.tableName)
@JsonSerializable(explicitToJson: true)
class _$OtherModelImpl extends _OtherModel {
  const _$OtherModelImpl() : super._();

  factory _$OtherModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtherModelImplFromJson(json);

  @override
  String toString() {
    return 'OtherModel()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OtherModelImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return _$$OtherModelImplToJson(
      this,
    );
  }
}

abstract class _OtherModel extends OtherModel {
  const factory _OtherModel() = _$OtherModelImpl;
  const _OtherModel._() : super._();

  factory _OtherModel.fromJson(Map<String, dynamic> json) =
      _$OtherModelImpl.fromJson;
}
