// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'other_schema.schema.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OtherModel {
  @JsonKey(name: "id")
  OtherId get id;
  @JsonKey(name: "name")
  String get name;

  /// Create a copy of OtherModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OtherModelCopyWith<OtherModel> get copyWith =>
      _$OtherModelCopyWithImpl<OtherModel>(this as OtherModel, _$identity);

  /// Serializes this OtherModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OtherModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @override
  String toString() {
    return 'OtherModel(id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class $OtherModelCopyWith<$Res> {
  factory $OtherModelCopyWith(
          OtherModel value, $Res Function(OtherModel) _then) =
      _$OtherModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "id") OtherId id, @JsonKey(name: "name") String name});
}

/// @nodoc
class _$OtherModelCopyWithImpl<$Res> implements $OtherModelCopyWith<$Res> {
  _$OtherModelCopyWithImpl(this._self, this._then);

  final OtherModel _self;
  final $Res Function(OtherModel) _then;

  /// Create a copy of OtherModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as OtherId,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@TableModel(OtherModel.tableName)
@JsonSerializable(explicitToJson: true)
class _OtherModel extends OtherModel {
  const _OtherModel(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "name") required this.name})
      : super._();
  factory _OtherModel.fromJson(Map<String, dynamic> json) =>
      _$OtherModelFromJson(json);

  @override
  @JsonKey(name: "id")
  final OtherId id;
  @override
  @JsonKey(name: "name")
  final String name;

  /// Create a copy of OtherModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OtherModelCopyWith<_OtherModel> get copyWith =>
      __$OtherModelCopyWithImpl<_OtherModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OtherModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OtherModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @override
  String toString() {
    return 'OtherModel(id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class _$OtherModelCopyWith<$Res>
    implements $OtherModelCopyWith<$Res> {
  factory _$OtherModelCopyWith(
          _OtherModel value, $Res Function(_OtherModel) _then) =
      __$OtherModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") OtherId id, @JsonKey(name: "name") String name});
}

/// @nodoc
class __$OtherModelCopyWithImpl<$Res> implements _$OtherModelCopyWith<$Res> {
  __$OtherModelCopyWithImpl(this._self, this._then);

  final _OtherModel _self;
  final $Res Function(_OtherModel) _then;

  /// Create a copy of OtherModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_OtherModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as OtherId,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
