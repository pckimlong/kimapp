// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_schema.schema.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserBaseModel _$UserBaseModelFromJson(Map<String, dynamic> json) {
  return _UserBaseModel.fromJson(json);
}

/// @nodoc
mixin _$UserBaseModel {
  @JsonKey(name: UserBaseModel.idKey)
  DemoId get id => throw _privateConstructorUsedError;
  @JsonKey(name: UserBaseModel.nameKey)
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: UserBaseModel.descriptionKey)
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserBaseModelCopyWith<UserBaseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserBaseModelCopyWith<$Res> {
  factory $UserBaseModelCopyWith(
          UserBaseModel value, $Res Function(UserBaseModel) then) =
      _$UserBaseModelCopyWithImpl<$Res, UserBaseModel>;
  @useResult
  $Res call(
      {@JsonKey(name: UserBaseModel.idKey) DemoId id,
      @JsonKey(name: UserBaseModel.nameKey) String name,
      @JsonKey(name: UserBaseModel.descriptionKey) String description});
}

/// @nodoc
class _$UserBaseModelCopyWithImpl<$Res, $Val extends UserBaseModel>
    implements $UserBaseModelCopyWith<$Res> {
  _$UserBaseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as DemoId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserBaseModelImplCopyWith<$Res>
    implements $UserBaseModelCopyWith<$Res> {
  factory _$$UserBaseModelImplCopyWith(
          _$UserBaseModelImpl value, $Res Function(_$UserBaseModelImpl) then) =
      __$$UserBaseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: UserBaseModel.idKey) DemoId id,
      @JsonKey(name: UserBaseModel.nameKey) String name,
      @JsonKey(name: UserBaseModel.descriptionKey) String description});
}

/// @nodoc
class __$$UserBaseModelImplCopyWithImpl<$Res>
    extends _$UserBaseModelCopyWithImpl<$Res, _$UserBaseModelImpl>
    implements _$$UserBaseModelImplCopyWith<$Res> {
  __$$UserBaseModelImplCopyWithImpl(
      _$UserBaseModelImpl _value, $Res Function(_$UserBaseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
  }) {
    return _then(_$UserBaseModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as DemoId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@TableModel(UserBaseModel.tableName)
class _$UserBaseModelImpl extends _UserBaseModel {
  const _$UserBaseModelImpl(
      {@JsonKey(name: UserBaseModel.idKey) required this.id,
      @JsonKey(name: UserBaseModel.nameKey) required this.name,
      @JsonKey(name: UserBaseModel.descriptionKey) required this.description})
      : super._();

  factory _$UserBaseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserBaseModelImplFromJson(json);

  @override
  @JsonKey(name: UserBaseModel.idKey)
  final DemoId id;
  @override
  @JsonKey(name: UserBaseModel.nameKey)
  final String name;
  @override
  @JsonKey(name: UserBaseModel.descriptionKey)
  final String description;

  @override
  String toString() {
    return 'UserBaseModel(id: $id, name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserBaseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserBaseModelImplCopyWith<_$UserBaseModelImpl> get copyWith =>
      __$$UserBaseModelImplCopyWithImpl<_$UserBaseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserBaseModelImplToJson(
      this,
    );
  }
}

abstract class _UserBaseModel extends UserBaseModel {
  const factory _UserBaseModel(
      {@JsonKey(name: UserBaseModel.idKey) required final DemoId id,
      @JsonKey(name: UserBaseModel.nameKey) required final String name,
      @JsonKey(name: UserBaseModel.descriptionKey)
      required final String description}) = _$UserBaseModelImpl;
  const _UserBaseModel._() : super._();

  factory _UserBaseModel.fromJson(Map<String, dynamic> json) =
      _$UserBaseModelImpl.fromJson;

  @override
  @JsonKey(name: UserBaseModel.idKey)
  DemoId get id;
  @override
  @JsonKey(name: UserBaseModel.nameKey)
  String get name;
  @override
  @JsonKey(name: UserBaseModel.descriptionKey)
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$UserBaseModelImplCopyWith<_$UserBaseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserDetailModel _$UserDetailModelFromJson(Map<String, dynamic> json) {
  return _UserDetailModel.fromJson(json);
}

/// @nodoc
mixin _$UserDetailModel {
  @JsonKey(name: UserDetailModel.idKey)
  DemoId get id => throw _privateConstructorUsedError;
  @JsonKey(name: UserDetailModel.nameKey)
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: UserDetailModel.descriptionKey)
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDetailModelCopyWith<UserDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDetailModelCopyWith<$Res> {
  factory $UserDetailModelCopyWith(
          UserDetailModel value, $Res Function(UserDetailModel) then) =
      _$UserDetailModelCopyWithImpl<$Res, UserDetailModel>;
  @useResult
  $Res call(
      {@JsonKey(name: UserDetailModel.idKey) DemoId id,
      @JsonKey(name: UserDetailModel.nameKey) String name,
      @JsonKey(name: UserDetailModel.descriptionKey) String description});
}

/// @nodoc
class _$UserDetailModelCopyWithImpl<$Res, $Val extends UserDetailModel>
    implements $UserDetailModelCopyWith<$Res> {
  _$UserDetailModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as DemoId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserDetailModelImplCopyWith<$Res>
    implements $UserDetailModelCopyWith<$Res> {
  factory _$$UserDetailModelImplCopyWith(_$UserDetailModelImpl value,
          $Res Function(_$UserDetailModelImpl) then) =
      __$$UserDetailModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: UserDetailModel.idKey) DemoId id,
      @JsonKey(name: UserDetailModel.nameKey) String name,
      @JsonKey(name: UserDetailModel.descriptionKey) String description});
}

/// @nodoc
class __$$UserDetailModelImplCopyWithImpl<$Res>
    extends _$UserDetailModelCopyWithImpl<$Res, _$UserDetailModelImpl>
    implements _$$UserDetailModelImplCopyWith<$Res> {
  __$$UserDetailModelImplCopyWithImpl(
      _$UserDetailModelImpl _value, $Res Function(_$UserDetailModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
  }) {
    return _then(_$UserDetailModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as DemoId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@TableModel(UserDetailModel.tableName)
class _$UserDetailModelImpl extends _UserDetailModel {
  const _$UserDetailModelImpl(
      {@JsonKey(name: UserDetailModel.idKey) required this.id,
      @JsonKey(name: UserDetailModel.nameKey) required this.name,
      @JsonKey(name: UserDetailModel.descriptionKey) required this.description})
      : super._();

  factory _$UserDetailModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserDetailModelImplFromJson(json);

  @override
  @JsonKey(name: UserDetailModel.idKey)
  final DemoId id;
  @override
  @JsonKey(name: UserDetailModel.nameKey)
  final String name;
  @override
  @JsonKey(name: UserDetailModel.descriptionKey)
  final String description;

  @override
  String toString() {
    return 'UserDetailModel(id: $id, name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDetailModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDetailModelImplCopyWith<_$UserDetailModelImpl> get copyWith =>
      __$$UserDetailModelImplCopyWithImpl<_$UserDetailModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserDetailModelImplToJson(
      this,
    );
  }
}

abstract class _UserDetailModel extends UserDetailModel {
  const factory _UserDetailModel(
      {@JsonKey(name: UserDetailModel.idKey) required final DemoId id,
      @JsonKey(name: UserDetailModel.nameKey) required final String name,
      @JsonKey(name: UserDetailModel.descriptionKey)
      required final String description}) = _$UserDetailModelImpl;
  const _UserDetailModel._() : super._();

  factory _UserDetailModel.fromJson(Map<String, dynamic> json) =
      _$UserDetailModelImpl.fromJson;

  @override
  @JsonKey(name: UserDetailModel.idKey)
  DemoId get id;
  @override
  @JsonKey(name: UserDetailModel.nameKey)
  String get name;
  @override
  @JsonKey(name: UserDetailModel.descriptionKey)
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$UserDetailModelImplCopyWith<_$UserDetailModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserLiteModel _$UserLiteModelFromJson(Map<String, dynamic> json) {
  return _UserLiteModel.fromJson(json);
}

/// @nodoc
mixin _$UserLiteModel {
  @JsonKey(name: UserLiteModel.idKey)
  DemoId get id => throw _privateConstructorUsedError;
  @JsonKey(name: UserLiteModel.nameKey)
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: UserLiteModel.descriptionKey)
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserLiteModelCopyWith<UserLiteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserLiteModelCopyWith<$Res> {
  factory $UserLiteModelCopyWith(
          UserLiteModel value, $Res Function(UserLiteModel) then) =
      _$UserLiteModelCopyWithImpl<$Res, UserLiteModel>;
  @useResult
  $Res call(
      {@JsonKey(name: UserLiteModel.idKey) DemoId id,
      @JsonKey(name: UserLiteModel.nameKey) String name,
      @JsonKey(name: UserLiteModel.descriptionKey) String description});
}

/// @nodoc
class _$UserLiteModelCopyWithImpl<$Res, $Val extends UserLiteModel>
    implements $UserLiteModelCopyWith<$Res> {
  _$UserLiteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as DemoId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserLiteModelImplCopyWith<$Res>
    implements $UserLiteModelCopyWith<$Res> {
  factory _$$UserLiteModelImplCopyWith(
          _$UserLiteModelImpl value, $Res Function(_$UserLiteModelImpl) then) =
      __$$UserLiteModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: UserLiteModel.idKey) DemoId id,
      @JsonKey(name: UserLiteModel.nameKey) String name,
      @JsonKey(name: UserLiteModel.descriptionKey) String description});
}

/// @nodoc
class __$$UserLiteModelImplCopyWithImpl<$Res>
    extends _$UserLiteModelCopyWithImpl<$Res, _$UserLiteModelImpl>
    implements _$$UserLiteModelImplCopyWith<$Res> {
  __$$UserLiteModelImplCopyWithImpl(
      _$UserLiteModelImpl _value, $Res Function(_$UserLiteModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
  }) {
    return _then(_$UserLiteModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as DemoId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@TableModel(UserLiteModel.tableName)
class _$UserLiteModelImpl extends _UserLiteModel {
  const _$UserLiteModelImpl(
      {@JsonKey(name: UserLiteModel.idKey) required this.id,
      @JsonKey(name: UserLiteModel.nameKey) required this.name,
      @JsonKey(name: UserLiteModel.descriptionKey) required this.description})
      : super._();

  factory _$UserLiteModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserLiteModelImplFromJson(json);

  @override
  @JsonKey(name: UserLiteModel.idKey)
  final DemoId id;
  @override
  @JsonKey(name: UserLiteModel.nameKey)
  final String name;
  @override
  @JsonKey(name: UserLiteModel.descriptionKey)
  final String description;

  @override
  String toString() {
    return 'UserLiteModel(id: $id, name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserLiteModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserLiteModelImplCopyWith<_$UserLiteModelImpl> get copyWith =>
      __$$UserLiteModelImplCopyWithImpl<_$UserLiteModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserLiteModelImplToJson(
      this,
    );
  }
}

abstract class _UserLiteModel extends UserLiteModel {
  const factory _UserLiteModel(
      {@JsonKey(name: UserLiteModel.idKey) required final DemoId id,
      @JsonKey(name: UserLiteModel.nameKey) required final String name,
      @JsonKey(name: UserLiteModel.descriptionKey)
      required final String description}) = _$UserLiteModelImpl;
  const _UserLiteModel._() : super._();

  factory _UserLiteModel.fromJson(Map<String, dynamic> json) =
      _$UserLiteModelImpl.fromJson;

  @override
  @JsonKey(name: UserLiteModel.idKey)
  DemoId get id;
  @override
  @JsonKey(name: UserLiteModel.nameKey)
  String get name;
  @override
  @JsonKey(name: UserLiteModel.descriptionKey)
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$UserLiteModelImplCopyWith<_$UserLiteModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
