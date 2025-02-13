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
  @JsonKey(name: OtherModel.idKey)
  OtherId get id => throw _privateConstructorUsedError;
  @JsonKey(name: OtherModel.nameKey)
  String get name => throw _privateConstructorUsedError;

  /// Serializes this OtherModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OtherModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtherModelCopyWith<OtherModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtherModelCopyWith<$Res> {
  factory $OtherModelCopyWith(
          OtherModel value, $Res Function(OtherModel) then) =
      _$OtherModelCopyWithImpl<$Res, OtherModel>;
  @useResult
  $Res call(
      {@JsonKey(name: OtherModel.idKey) OtherId id,
      @JsonKey(name: OtherModel.nameKey) String name});
}

/// @nodoc
class _$OtherModelCopyWithImpl<$Res, $Val extends OtherModel>
    implements $OtherModelCopyWith<$Res> {
  _$OtherModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtherModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as OtherId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OtherModelImplCopyWith<$Res>
    implements $OtherModelCopyWith<$Res> {
  factory _$$OtherModelImplCopyWith(
          _$OtherModelImpl value, $Res Function(_$OtherModelImpl) then) =
      __$$OtherModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: OtherModel.idKey) OtherId id,
      @JsonKey(name: OtherModel.nameKey) String name});
}

/// @nodoc
class __$$OtherModelImplCopyWithImpl<$Res>
    extends _$OtherModelCopyWithImpl<$Res, _$OtherModelImpl>
    implements _$$OtherModelImplCopyWith<$Res> {
  __$$OtherModelImplCopyWithImpl(
      _$OtherModelImpl _value, $Res Function(_$OtherModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtherModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$OtherModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as OtherId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@TableModel(OtherModel.tableName)
@JsonSerializable(explicitToJson: true)
class _$OtherModelImpl extends _OtherModel {
  const _$OtherModelImpl(
      {@JsonKey(name: OtherModel.idKey) required this.id,
      @JsonKey(name: OtherModel.nameKey) required this.name})
      : super._();

  factory _$OtherModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtherModelImplFromJson(json);

  @override
  @JsonKey(name: OtherModel.idKey)
  final OtherId id;
  @override
  @JsonKey(name: OtherModel.nameKey)
  final String name;

  @override
  String toString() {
    return 'OtherModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtherModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of OtherModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtherModelImplCopyWith<_$OtherModelImpl> get copyWith =>
      __$$OtherModelImplCopyWithImpl<_$OtherModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtherModelImplToJson(
      this,
    );
  }
}

abstract class _OtherModel extends OtherModel {
  const factory _OtherModel(
          {@JsonKey(name: OtherModel.idKey) required final OtherId id,
          @JsonKey(name: OtherModel.nameKey) required final String name}) =
      _$OtherModelImpl;
  const _OtherModel._() : super._();

  factory _OtherModel.fromJson(Map<String, dynamic> json) =
      _$OtherModelImpl.fromJson;

  @override
  @JsonKey(name: OtherModel.idKey)
  OtherId get id;
  @override
  @JsonKey(name: OtherModel.nameKey)
  String get name;

  /// Create a copy of OtherModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtherModelImplCopyWith<_$OtherModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
