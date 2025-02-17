// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'demo_schema.schema.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DemoModel _$DemoModelFromJson(Map<String, dynamic> json) {
  return _DemoModel.fromJson(json);
}

/// @nodoc
mixin _$DemoModel {
  @JsonKey(name: DemoModel.idKey)
  DemoId get id => throw _privateConstructorUsedError;
  @JsonKey(name: DemoModel.nameKey)
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: DemoModel.descriptionKey)
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: DemoModel.ageKey)
  int get age => throw _privateConstructorUsedError;
  @JsonKey(name: DemoModel.birthdateKey)
  DateTime? get birthdate => throw _privateConstructorUsedError;
  @JsonKey(name: DemoModel.addressKey)
  String? get address => throw _privateConstructorUsedError;
  @JoinedColumn(foreignKey: "other_id", candidateKey: null)
  @JsonKey(name: DemoModel.otherKey)
  OtherModel? get other => throw _privateConstructorUsedError;

  /// Serializes this DemoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DemoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DemoModelCopyWith<DemoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DemoModelCopyWith<$Res> {
  factory $DemoModelCopyWith(DemoModel value, $Res Function(DemoModel) then) =
      _$DemoModelCopyWithImpl<$Res, DemoModel>;
  @useResult
  $Res call(
      {@JsonKey(name: DemoModel.idKey) DemoId id,
      @JsonKey(name: DemoModel.nameKey) String? name,
      @JsonKey(name: DemoModel.descriptionKey) String? description,
      @JsonKey(name: DemoModel.ageKey) int age,
      @JsonKey(name: DemoModel.birthdateKey) DateTime? birthdate,
      @JsonKey(name: DemoModel.addressKey) String? address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: DemoModel.otherKey)
      OtherModel? other});

  $OtherModelCopyWith<$Res>? get other;
}

/// @nodoc
class _$DemoModelCopyWithImpl<$Res, $Val extends DemoModel>
    implements $DemoModelCopyWith<$Res> {
  _$DemoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DemoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? description = freezed,
    Object? age = null,
    Object? birthdate = freezed,
    Object? address = freezed,
    Object? other = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as DemoId,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      birthdate: freezed == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      other: freezed == other
          ? _value.other
          : other // ignore: cast_nullable_to_non_nullable
              as OtherModel?,
    ) as $Val);
  }

  /// Create a copy of DemoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OtherModelCopyWith<$Res>? get other {
    if (_value.other == null) {
      return null;
    }

    return $OtherModelCopyWith<$Res>(_value.other!, (value) {
      return _then(_value.copyWith(other: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DemoModelImplCopyWith<$Res>
    implements $DemoModelCopyWith<$Res> {
  factory _$$DemoModelImplCopyWith(
          _$DemoModelImpl value, $Res Function(_$DemoModelImpl) then) =
      __$$DemoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: DemoModel.idKey) DemoId id,
      @JsonKey(name: DemoModel.nameKey) String? name,
      @JsonKey(name: DemoModel.descriptionKey) String? description,
      @JsonKey(name: DemoModel.ageKey) int age,
      @JsonKey(name: DemoModel.birthdateKey) DateTime? birthdate,
      @JsonKey(name: DemoModel.addressKey) String? address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: DemoModel.otherKey)
      OtherModel? other});

  @override
  $OtherModelCopyWith<$Res>? get other;
}

/// @nodoc
class __$$DemoModelImplCopyWithImpl<$Res>
    extends _$DemoModelCopyWithImpl<$Res, _$DemoModelImpl>
    implements _$$DemoModelImplCopyWith<$Res> {
  __$$DemoModelImplCopyWithImpl(
      _$DemoModelImpl _value, $Res Function(_$DemoModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DemoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? description = freezed,
    Object? age = null,
    Object? birthdate = freezed,
    Object? address = freezed,
    Object? other = freezed,
  }) {
    return _then(_$DemoModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as DemoId,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      birthdate: freezed == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      other: freezed == other
          ? _value.other
          : other // ignore: cast_nullable_to_non_nullable
              as OtherModel?,
    ));
  }
}

/// @nodoc

@TableModel(DemoModel.tableName)
@JsonSerializable(explicitToJson: true)
class _$DemoModelImpl extends _DemoModel {
  const _$DemoModelImpl(
      {@JsonKey(name: DemoModel.idKey) required this.id,
      @JsonKey(name: DemoModel.nameKey) required this.name,
      @JsonKey(name: DemoModel.descriptionKey) required this.description,
      @JsonKey(name: DemoModel.ageKey) required this.age,
      @JsonKey(name: DemoModel.birthdateKey) required this.birthdate,
      @JsonKey(name: DemoModel.addressKey) required this.address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: DemoModel.otherKey)
      required this.other})
      : super._();

  factory _$DemoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DemoModelImplFromJson(json);

  @override
  @JsonKey(name: DemoModel.idKey)
  final DemoId id;
  @override
  @JsonKey(name: DemoModel.nameKey)
  final String? name;
  @override
  @JsonKey(name: DemoModel.descriptionKey)
  final String? description;
  @override
  @JsonKey(name: DemoModel.ageKey)
  final int age;
  @override
  @JsonKey(name: DemoModel.birthdateKey)
  final DateTime? birthdate;
  @override
  @JsonKey(name: DemoModel.addressKey)
  final String? address;
  @override
  @JoinedColumn(foreignKey: "other_id", candidateKey: null)
  @JsonKey(name: DemoModel.otherKey)
  final OtherModel? other;

  @override
  String toString() {
    return 'DemoModel(id: $id, name: $name, description: $description, age: $age, birthdate: $birthdate, address: $address, other: $other)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DemoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.birthdate, birthdate) ||
                other.birthdate == birthdate) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.other, this.other) || other.other == this.other));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, description, age, birthdate, address, other);

  /// Create a copy of DemoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DemoModelImplCopyWith<_$DemoModelImpl> get copyWith =>
      __$$DemoModelImplCopyWithImpl<_$DemoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DemoModelImplToJson(
      this,
    );
  }
}

abstract class _DemoModel extends DemoModel {
  const factory _DemoModel(
      {@JsonKey(name: DemoModel.idKey) required final DemoId id,
      @JsonKey(name: DemoModel.nameKey) required final String? name,
      @JsonKey(name: DemoModel.descriptionKey)
      required final String? description,
      @JsonKey(name: DemoModel.ageKey) required final int age,
      @JsonKey(name: DemoModel.birthdateKey) required final DateTime? birthdate,
      @JsonKey(name: DemoModel.addressKey) required final String? address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: DemoModel.otherKey)
      required final OtherModel? other}) = _$DemoModelImpl;
  const _DemoModel._() : super._();

  factory _DemoModel.fromJson(Map<String, dynamic> json) =
      _$DemoModelImpl.fromJson;

  @override
  @JsonKey(name: DemoModel.idKey)
  DemoId get id;
  @override
  @JsonKey(name: DemoModel.nameKey)
  String? get name;
  @override
  @JsonKey(name: DemoModel.descriptionKey)
  String? get description;
  @override
  @JsonKey(name: DemoModel.ageKey)
  int get age;
  @override
  @JsonKey(name: DemoModel.birthdateKey)
  DateTime? get birthdate;
  @override
  @JsonKey(name: DemoModel.addressKey)
  String? get address;
  @override
  @JoinedColumn(foreignKey: "other_id", candidateKey: null)
  @JsonKey(name: DemoModel.otherKey)
  OtherModel? get other;

  /// Create a copy of DemoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DemoModelImplCopyWith<_$DemoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DemoDetailModel _$DemoDetailModelFromJson(Map<String, dynamic> json) {
  return _DemoDetailModel.fromJson(json);
}

/// @nodoc
mixin _$DemoDetailModel {
  @JsonKey(name: DemoDetailModel.idKey)
  DemoId get id => throw _privateConstructorUsedError;
  @JsonKey(name: DemoDetailModel.nameKey)
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this DemoDetailModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DemoDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DemoDetailModelCopyWith<DemoDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DemoDetailModelCopyWith<$Res> {
  factory $DemoDetailModelCopyWith(
          DemoDetailModel value, $Res Function(DemoDetailModel) then) =
      _$DemoDetailModelCopyWithImpl<$Res, DemoDetailModel>;
  @useResult
  $Res call(
      {@JsonKey(name: DemoDetailModel.idKey) DemoId id,
      @JsonKey(name: DemoDetailModel.nameKey) String? name});
}

/// @nodoc
class _$DemoDetailModelCopyWithImpl<$Res, $Val extends DemoDetailModel>
    implements $DemoDetailModelCopyWith<$Res> {
  _$DemoDetailModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DemoDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as DemoId,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DemoDetailModelImplCopyWith<$Res>
    implements $DemoDetailModelCopyWith<$Res> {
  factory _$$DemoDetailModelImplCopyWith(_$DemoDetailModelImpl value,
          $Res Function(_$DemoDetailModelImpl) then) =
      __$$DemoDetailModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: DemoDetailModel.idKey) DemoId id,
      @JsonKey(name: DemoDetailModel.nameKey) String? name});
}

/// @nodoc
class __$$DemoDetailModelImplCopyWithImpl<$Res>
    extends _$DemoDetailModelCopyWithImpl<$Res, _$DemoDetailModelImpl>
    implements _$$DemoDetailModelImplCopyWith<$Res> {
  __$$DemoDetailModelImplCopyWithImpl(
      _$DemoDetailModelImpl _value, $Res Function(_$DemoDetailModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DemoDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
  }) {
    return _then(_$DemoDetailModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as DemoId,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@TableModel(DemoDetailModel.tableName)
@JsonSerializable(explicitToJson: true)
class _$DemoDetailModelImpl extends _DemoDetailModel {
  const _$DemoDetailModelImpl(
      {@JsonKey(name: DemoDetailModel.idKey) required this.id,
      @JsonKey(name: DemoDetailModel.nameKey) required this.name})
      : super._();

  factory _$DemoDetailModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DemoDetailModelImplFromJson(json);

  @override
  @JsonKey(name: DemoDetailModel.idKey)
  final DemoId id;
  @override
  @JsonKey(name: DemoDetailModel.nameKey)
  final String? name;

  @override
  String toString() {
    return 'DemoDetailModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DemoDetailModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of DemoDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DemoDetailModelImplCopyWith<_$DemoDetailModelImpl> get copyWith =>
      __$$DemoDetailModelImplCopyWithImpl<_$DemoDetailModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DemoDetailModelImplToJson(
      this,
    );
  }
}

abstract class _DemoDetailModel extends DemoDetailModel {
  const factory _DemoDetailModel(
      {@JsonKey(name: DemoDetailModel.idKey) required final DemoId id,
      @JsonKey(name: DemoDetailModel.nameKey)
      required final String? name}) = _$DemoDetailModelImpl;
  const _DemoDetailModel._() : super._();

  factory _DemoDetailModel.fromJson(Map<String, dynamic> json) =
      _$DemoDetailModelImpl.fromJson;

  @override
  @JsonKey(name: DemoDetailModel.idKey)
  DemoId get id;
  @override
  @JsonKey(name: DemoDetailModel.nameKey)
  String? get name;

  /// Create a copy of DemoDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DemoDetailModelImplCopyWith<_$DemoDetailModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DemoLiteModel _$DemoLiteModelFromJson(Map<String, dynamic> json) {
  return _DemoLiteModel.fromJson(json);
}

/// @nodoc
mixin _$DemoLiteModel {
  @JsonKey(name: DemoLiteModel.idKey)
  DemoId get id => throw _privateConstructorUsedError;
  @JsonKey(name: DemoLiteModel.descriptionKey)
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this DemoLiteModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DemoLiteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DemoLiteModelCopyWith<DemoLiteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DemoLiteModelCopyWith<$Res> {
  factory $DemoLiteModelCopyWith(
          DemoLiteModel value, $Res Function(DemoLiteModel) then) =
      _$DemoLiteModelCopyWithImpl<$Res, DemoLiteModel>;
  @useResult
  $Res call(
      {@JsonKey(name: DemoLiteModel.idKey) DemoId id,
      @JsonKey(name: DemoLiteModel.descriptionKey) String? description});
}

/// @nodoc
class _$DemoLiteModelCopyWithImpl<$Res, $Val extends DemoLiteModel>
    implements $DemoLiteModelCopyWith<$Res> {
  _$DemoLiteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DemoLiteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as DemoId,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DemoLiteModelImplCopyWith<$Res>
    implements $DemoLiteModelCopyWith<$Res> {
  factory _$$DemoLiteModelImplCopyWith(
          _$DemoLiteModelImpl value, $Res Function(_$DemoLiteModelImpl) then) =
      __$$DemoLiteModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: DemoLiteModel.idKey) DemoId id,
      @JsonKey(name: DemoLiteModel.descriptionKey) String? description});
}

/// @nodoc
class __$$DemoLiteModelImplCopyWithImpl<$Res>
    extends _$DemoLiteModelCopyWithImpl<$Res, _$DemoLiteModelImpl>
    implements _$$DemoLiteModelImplCopyWith<$Res> {
  __$$DemoLiteModelImplCopyWithImpl(
      _$DemoLiteModelImpl _value, $Res Function(_$DemoLiteModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DemoLiteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = freezed,
  }) {
    return _then(_$DemoLiteModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as DemoId,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@TableModel(DemoLiteModel.tableName)
@JsonSerializable(explicitToJson: true)
class _$DemoLiteModelImpl extends _DemoLiteModel {
  const _$DemoLiteModelImpl(
      {@JsonKey(name: DemoLiteModel.idKey) required this.id,
      @JsonKey(name: DemoLiteModel.descriptionKey) required this.description})
      : super._();

  factory _$DemoLiteModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DemoLiteModelImplFromJson(json);

  @override
  @JsonKey(name: DemoLiteModel.idKey)
  final DemoId id;
  @override
  @JsonKey(name: DemoLiteModel.descriptionKey)
  final String? description;

  @override
  String toString() {
    return 'DemoLiteModel(id: $id, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DemoLiteModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, description);

  /// Create a copy of DemoLiteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DemoLiteModelImplCopyWith<_$DemoLiteModelImpl> get copyWith =>
      __$$DemoLiteModelImplCopyWithImpl<_$DemoLiteModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DemoLiteModelImplToJson(
      this,
    );
  }
}

abstract class _DemoLiteModel extends DemoLiteModel {
  const factory _DemoLiteModel(
      {@JsonKey(name: DemoLiteModel.idKey) required final DemoId id,
      @JsonKey(name: DemoLiteModel.descriptionKey)
      required final String? description}) = _$DemoLiteModelImpl;
  const _DemoLiteModel._() : super._();

  factory _DemoLiteModel.fromJson(Map<String, dynamic> json) =
      _$DemoLiteModelImpl.fromJson;

  @override
  @JsonKey(name: DemoLiteModel.idKey)
  DemoId get id;
  @override
  @JsonKey(name: DemoLiteModel.descriptionKey)
  String? get description;

  /// Create a copy of DemoLiteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DemoLiteModelImplCopyWith<_$DemoLiteModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
