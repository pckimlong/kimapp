// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table_structure_example.table.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreateSampleParam _$CreateSampleParamFromJson(Map<String, dynamic> json) {
  return _CreateSampleParam.fromJson(json);
}

/// @nodoc
mixin _$CreateSampleParam {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateSampleParamCopyWith<CreateSampleParam> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateSampleParamCopyWith<$Res> {
  factory $CreateSampleParamCopyWith(
          CreateSampleParam value, $Res Function(CreateSampleParam) then) =
      _$CreateSampleParamCopyWithImpl<$Res, CreateSampleParam>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'createdAt') DateTime createdAt});
}

/// @nodoc
class _$CreateSampleParamCopyWithImpl<$Res, $Val extends CreateSampleParam>
    implements $CreateSampleParamCopyWith<$Res> {
  _$CreateSampleParamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateSampleParamImplCopyWith<$Res>
    implements $CreateSampleParamCopyWith<$Res> {
  factory _$$CreateSampleParamImplCopyWith(_$CreateSampleParamImpl value,
          $Res Function(_$CreateSampleParamImpl) then) =
      __$$CreateSampleParamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'createdAt') DateTime createdAt});
}

/// @nodoc
class __$$CreateSampleParamImplCopyWithImpl<$Res>
    extends _$CreateSampleParamCopyWithImpl<$Res, _$CreateSampleParamImpl>
    implements _$$CreateSampleParamImplCopyWith<$Res> {
  __$$CreateSampleParamImplCopyWithImpl(_$CreateSampleParamImpl _value,
      $Res Function(_$CreateSampleParamImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$CreateSampleParamImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateSampleParamImpl extends _CreateSampleParam {
  const _$CreateSampleParamImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'description') this.description,
      @JsonKey(name: 'createdAt') required this.createdAt})
      : super._();

  factory _$CreateSampleParamImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateSampleParamImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'description')
  final String? description;
  @override
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @override
  String toString() {
    return 'CreateSampleParam(id: $id, name: $name, description: $description, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateSampleParamImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, description, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateSampleParamImplCopyWith<_$CreateSampleParamImpl> get copyWith =>
      __$$CreateSampleParamImplCopyWithImpl<_$CreateSampleParamImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateSampleParamImplToJson(
      this,
    );
  }
}

abstract class _CreateSampleParam extends CreateSampleParam {
  const factory _CreateSampleParam(
          {@JsonKey(name: 'id') required final int id,
          @JsonKey(name: 'name') required final String name,
          @JsonKey(name: 'description') final String? description,
          @JsonKey(name: 'createdAt') required final DateTime createdAt}) =
      _$CreateSampleParamImpl;
  const _CreateSampleParam._() : super._();

  factory _CreateSampleParam.fromJson(Map<String, dynamic> json) =
      _$CreateSampleParamImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(name: 'createdAt')
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$CreateSampleParamImplCopyWith<_$CreateSampleParamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateSampleParam _$UpdateSampleParamFromJson(Map<String, dynamic> json) {
  return _UpdateSampleParam.fromJson(json);
}

/// @nodoc
mixin _$UpdateSampleParam {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateSampleParamCopyWith<UpdateSampleParam> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateSampleParamCopyWith<$Res> {
  factory $UpdateSampleParamCopyWith(
          UpdateSampleParam value, $Res Function(UpdateSampleParam) then) =
      _$UpdateSampleParamCopyWithImpl<$Res, UpdateSampleParam>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'createdAt') DateTime createdAt});
}

/// @nodoc
class _$UpdateSampleParamCopyWithImpl<$Res, $Val extends UpdateSampleParam>
    implements $UpdateSampleParamCopyWith<$Res> {
  _$UpdateSampleParamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateSampleParamImplCopyWith<$Res>
    implements $UpdateSampleParamCopyWith<$Res> {
  factory _$$UpdateSampleParamImplCopyWith(_$UpdateSampleParamImpl value,
          $Res Function(_$UpdateSampleParamImpl) then) =
      __$$UpdateSampleParamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'createdAt') DateTime createdAt});
}

/// @nodoc
class __$$UpdateSampleParamImplCopyWithImpl<$Res>
    extends _$UpdateSampleParamCopyWithImpl<$Res, _$UpdateSampleParamImpl>
    implements _$$UpdateSampleParamImplCopyWith<$Res> {
  __$$UpdateSampleParamImplCopyWithImpl(_$UpdateSampleParamImpl _value,
      $Res Function(_$UpdateSampleParamImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$UpdateSampleParamImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateSampleParamImpl extends _UpdateSampleParam {
  const _$UpdateSampleParamImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'description') this.description,
      @JsonKey(name: 'createdAt') required this.createdAt})
      : super._();

  factory _$UpdateSampleParamImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateSampleParamImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'description')
  final String? description;
  @override
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @override
  String toString() {
    return 'UpdateSampleParam(id: $id, name: $name, description: $description, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateSampleParamImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, description, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateSampleParamImplCopyWith<_$UpdateSampleParamImpl> get copyWith =>
      __$$UpdateSampleParamImplCopyWithImpl<_$UpdateSampleParamImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateSampleParamImplToJson(
      this,
    );
  }
}

abstract class _UpdateSampleParam extends UpdateSampleParam {
  const factory _UpdateSampleParam(
          {@JsonKey(name: 'id') required final int id,
          @JsonKey(name: 'name') required final String name,
          @JsonKey(name: 'description') final String? description,
          @JsonKey(name: 'createdAt') required final DateTime createdAt}) =
      _$UpdateSampleParamImpl;
  const _UpdateSampleParam._() : super._();

  factory _UpdateSampleParam.fromJson(Map<String, dynamic> json) =
      _$UpdateSampleParamImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(name: 'createdAt')
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$UpdateSampleParamImplCopyWith<_$UpdateSampleParamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
