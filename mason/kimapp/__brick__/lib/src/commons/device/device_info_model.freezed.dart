// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DeviceInfoModel _$DeviceInfoModelFromJson(Map<String, dynamic> json) {
  return _DeviceInfoModel.fromJson(json);
}

/// @nodoc
mixin _$DeviceInfoModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeviceInfoModelCopyWith<DeviceInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceInfoModelCopyWith<$Res> {
  factory $DeviceInfoModelCopyWith(
          DeviceInfoModel value, $Res Function(DeviceInfoModel) then) =
      _$DeviceInfoModelCopyWithImpl<$Res, DeviceInfoModel>;
  @useResult
  $Res call({String id, String name, String version});
}

/// @nodoc
class _$DeviceInfoModelCopyWithImpl<$Res, $Val extends DeviceInfoModel>
    implements $DeviceInfoModelCopyWith<$Res> {
  _$DeviceInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? version = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DeviceInfoModelCopyWith<$Res>
    implements $DeviceInfoModelCopyWith<$Res> {
  factory _$$_DeviceInfoModelCopyWith(
          _$_DeviceInfoModel value, $Res Function(_$_DeviceInfoModel) then) =
      __$$_DeviceInfoModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String version});
}

/// @nodoc
class __$$_DeviceInfoModelCopyWithImpl<$Res>
    extends _$DeviceInfoModelCopyWithImpl<$Res, _$_DeviceInfoModel>
    implements _$$_DeviceInfoModelCopyWith<$Res> {
  __$$_DeviceInfoModelCopyWithImpl(
      _$_DeviceInfoModel _value, $Res Function(_$_DeviceInfoModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? version = null,
  }) {
    return _then(_$_DeviceInfoModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DeviceInfoModel extends _DeviceInfoModel {
  const _$_DeviceInfoModel(
      {required this.id, required this.name, required this.version})
      : super._();

  factory _$_DeviceInfoModel.fromJson(Map<String, dynamic> json) =>
      _$$_DeviceInfoModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String version;

  @override
  String toString() {
    return 'DeviceInfoModel(id: $id, name: $name, version: $version)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeviceInfoModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeviceInfoModelCopyWith<_$_DeviceInfoModel> get copyWith =>
      __$$_DeviceInfoModelCopyWithImpl<_$_DeviceInfoModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DeviceInfoModelToJson(
      this,
    );
  }
}

abstract class _DeviceInfoModel extends DeviceInfoModel {
  const factory _DeviceInfoModel(
      {required final String id,
      required final String name,
      required final String version}) = _$_DeviceInfoModel;
  const _DeviceInfoModel._() : super._();

  factory _DeviceInfoModel.fromJson(Map<String, dynamic> json) =
      _$_DeviceInfoModel.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get version;
  @override
  @JsonKey(ignore: true)
  _$$_DeviceInfoModelCopyWith<_$_DeviceInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}
