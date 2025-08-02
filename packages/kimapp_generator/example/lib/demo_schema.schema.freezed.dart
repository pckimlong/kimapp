// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'demo_schema.schema.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DemoModel {
  @JsonKey(name: DemoModel.nameKey)
  String? get name;
  @JsonKey(name: DemoModel.descriptionKey)
  String? get description;
  @JsonKey(name: DemoModel.ageKey)
  int get age;
  @JsonKey(name: DemoModel.addressKey)
  String? get address;
  @JoinedColumn(foreignKey: "other_id", candidateKey: null)
  @JsonKey(name: DemoModel.otherKey)
  OtherModel? get other;

  /// Create a copy of DemoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DemoModelCopyWith<DemoModel> get copyWith =>
      _$DemoModelCopyWithImpl<DemoModel>(this as DemoModel, _$identity);

  /// Serializes this DemoModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DemoModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.other, this.other) || other.other == this.other));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, description, age, address, other);

  @override
  String toString() {
    return 'DemoModel(name: $name, description: $description, age: $age, address: $address, other: $other)';
  }
}

/// @nodoc
abstract mixin class $DemoModelCopyWith<$Res> {
  factory $DemoModelCopyWith(DemoModel value, $Res Function(DemoModel) _then) =
      _$DemoModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: DemoModel.nameKey) String? name,
      @JsonKey(name: DemoModel.descriptionKey) String? description,
      @JsonKey(name: DemoModel.ageKey) int age,
      @JsonKey(name: DemoModel.addressKey) String? address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: DemoModel.otherKey)
      OtherModel? other});

  $OtherModelCopyWith<$Res>? get other;
}

/// @nodoc
class _$DemoModelCopyWithImpl<$Res> implements $DemoModelCopyWith<$Res> {
  _$DemoModelCopyWithImpl(this._self, this._then);

  final DemoModel _self;
  final $Res Function(DemoModel) _then;

  /// Create a copy of DemoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? age = null,
    Object? address = freezed,
    Object? other = freezed,
  }) {
    return _then(_self.copyWith(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      age: null == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      other: freezed == other
          ? _self.other
          : other // ignore: cast_nullable_to_non_nullable
              as OtherModel?,
    ));
  }

  /// Create a copy of DemoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OtherModelCopyWith<$Res>? get other {
    if (_self.other == null) {
      return null;
    }

    return $OtherModelCopyWith<$Res>(_self.other!, (value) {
      return _then(_self.copyWith(other: value));
    });
  }
}

/// @nodoc

@TableModel(DemoModel.tableName)
@JsonSerializable(explicitToJson: true)
class _DemoModel extends DemoModel {
  const _DemoModel(
      {@JsonKey(name: DemoModel.nameKey) required this.name,
      @JsonKey(name: DemoModel.descriptionKey) required this.description,
      @JsonKey(name: DemoModel.ageKey) required this.age,
      @JsonKey(name: DemoModel.addressKey) required this.address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: DemoModel.otherKey)
      required this.other})
      : super._();
  factory _DemoModel.fromJson(Map<String, dynamic> json) =>
      _$DemoModelFromJson(json);

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
  @JsonKey(name: DemoModel.addressKey)
  final String? address;
  @override
  @JoinedColumn(foreignKey: "other_id", candidateKey: null)
  @JsonKey(name: DemoModel.otherKey)
  final OtherModel? other;

  /// Create a copy of DemoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DemoModelCopyWith<_DemoModel> get copyWith =>
      __$DemoModelCopyWithImpl<_DemoModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DemoModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DemoModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.other, this.other) || other.other == this.other));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, description, age, address, other);

  @override
  String toString() {
    return 'DemoModel(name: $name, description: $description, age: $age, address: $address, other: $other)';
  }
}

/// @nodoc
abstract mixin class _$DemoModelCopyWith<$Res>
    implements $DemoModelCopyWith<$Res> {
  factory _$DemoModelCopyWith(
          _DemoModel value, $Res Function(_DemoModel) _then) =
      __$DemoModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: DemoModel.nameKey) String? name,
      @JsonKey(name: DemoModel.descriptionKey) String? description,
      @JsonKey(name: DemoModel.ageKey) int age,
      @JsonKey(name: DemoModel.addressKey) String? address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: DemoModel.otherKey)
      OtherModel? other});

  @override
  $OtherModelCopyWith<$Res>? get other;
}

/// @nodoc
class __$DemoModelCopyWithImpl<$Res> implements _$DemoModelCopyWith<$Res> {
  __$DemoModelCopyWithImpl(this._self, this._then);

  final _DemoModel _self;
  final $Res Function(_DemoModel) _then;

  /// Create a copy of DemoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? age = null,
    Object? address = freezed,
    Object? other = freezed,
  }) {
    return _then(_DemoModel(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      age: null == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      other: freezed == other
          ? _self.other
          : other // ignore: cast_nullable_to_non_nullable
              as OtherModel?,
    ));
  }

  /// Create a copy of DemoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OtherModelCopyWith<$Res>? get other {
    if (_self.other == null) {
      return null;
    }

    return $OtherModelCopyWith<$Res>(_self.other!, (value) {
      return _then(_self.copyWith(other: value));
    });
  }
}

/// @nodoc
mixin _$DemoDetailModel {
  @JsonKey(name: DemoDetailModel.nameKey)
  String? get name;
  @JsonKey(name: DemoDetailModel.descriptionKey)
  String? get description;
  @JsonKey(name: DemoDetailModel.ageKey)
  int get age;
  @JsonKey(name: DemoDetailModel.addressKey)
  String? get address;
  @JoinedColumn(foreignKey: "other_id", candidateKey: null)
  @JsonKey(name: DemoDetailModel.otherKey)
  OtherModel? get other;

  /// Create a copy of DemoDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DemoDetailModelCopyWith<DemoDetailModel> get copyWith =>
      _$DemoDetailModelCopyWithImpl<DemoDetailModel>(
          this as DemoDetailModel, _$identity);

  /// Serializes this DemoDetailModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DemoDetailModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.other, this.other) || other.other == this.other));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, description, age, address, other);

  @override
  String toString() {
    return 'DemoDetailModel(name: $name, description: $description, age: $age, address: $address, other: $other)';
  }
}

/// @nodoc
abstract mixin class $DemoDetailModelCopyWith<$Res> {
  factory $DemoDetailModelCopyWith(
          DemoDetailModel value, $Res Function(DemoDetailModel) _then) =
      _$DemoDetailModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: DemoDetailModel.nameKey) String? name,
      @JsonKey(name: DemoDetailModel.descriptionKey) String? description,
      @JsonKey(name: DemoDetailModel.ageKey) int age,
      @JsonKey(name: DemoDetailModel.addressKey) String? address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: DemoDetailModel.otherKey)
      OtherModel? other});

  $OtherModelCopyWith<$Res>? get other;
}

/// @nodoc
class _$DemoDetailModelCopyWithImpl<$Res>
    implements $DemoDetailModelCopyWith<$Res> {
  _$DemoDetailModelCopyWithImpl(this._self, this._then);

  final DemoDetailModel _self;
  final $Res Function(DemoDetailModel) _then;

  /// Create a copy of DemoDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? age = null,
    Object? address = freezed,
    Object? other = freezed,
  }) {
    return _then(_self.copyWith(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      age: null == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      other: freezed == other
          ? _self.other
          : other // ignore: cast_nullable_to_non_nullable
              as OtherModel?,
    ));
  }

  /// Create a copy of DemoDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OtherModelCopyWith<$Res>? get other {
    if (_self.other == null) {
      return null;
    }

    return $OtherModelCopyWith<$Res>(_self.other!, (value) {
      return _then(_self.copyWith(other: value));
    });
  }
}

/// @nodoc

@TableModel(DemoDetailModel.tableName)
@JsonSerializable(explicitToJson: true)
class _DemoDetailModel extends DemoDetailModel {
  const _DemoDetailModel(
      {@JsonKey(name: DemoDetailModel.nameKey) required this.name,
      @JsonKey(name: DemoDetailModel.descriptionKey) required this.description,
      @JsonKey(name: DemoDetailModel.ageKey) required this.age,
      @JsonKey(name: DemoDetailModel.addressKey) required this.address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: DemoDetailModel.otherKey)
      required this.other})
      : super._();
  factory _DemoDetailModel.fromJson(Map<String, dynamic> json) =>
      _$DemoDetailModelFromJson(json);

  @override
  @JsonKey(name: DemoDetailModel.nameKey)
  final String? name;
  @override
  @JsonKey(name: DemoDetailModel.descriptionKey)
  final String? description;
  @override
  @JsonKey(name: DemoDetailModel.ageKey)
  final int age;
  @override
  @JsonKey(name: DemoDetailModel.addressKey)
  final String? address;
  @override
  @JoinedColumn(foreignKey: "other_id", candidateKey: null)
  @JsonKey(name: DemoDetailModel.otherKey)
  final OtherModel? other;

  /// Create a copy of DemoDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DemoDetailModelCopyWith<_DemoDetailModel> get copyWith =>
      __$DemoDetailModelCopyWithImpl<_DemoDetailModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DemoDetailModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DemoDetailModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.other, this.other) || other.other == this.other));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, description, age, address, other);

  @override
  String toString() {
    return 'DemoDetailModel(name: $name, description: $description, age: $age, address: $address, other: $other)';
  }
}

/// @nodoc
abstract mixin class _$DemoDetailModelCopyWith<$Res>
    implements $DemoDetailModelCopyWith<$Res> {
  factory _$DemoDetailModelCopyWith(
          _DemoDetailModel value, $Res Function(_DemoDetailModel) _then) =
      __$DemoDetailModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: DemoDetailModel.nameKey) String? name,
      @JsonKey(name: DemoDetailModel.descriptionKey) String? description,
      @JsonKey(name: DemoDetailModel.ageKey) int age,
      @JsonKey(name: DemoDetailModel.addressKey) String? address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: DemoDetailModel.otherKey)
      OtherModel? other});

  @override
  $OtherModelCopyWith<$Res>? get other;
}

/// @nodoc
class __$DemoDetailModelCopyWithImpl<$Res>
    implements _$DemoDetailModelCopyWith<$Res> {
  __$DemoDetailModelCopyWithImpl(this._self, this._then);

  final _DemoDetailModel _self;
  final $Res Function(_DemoDetailModel) _then;

  /// Create a copy of DemoDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? age = null,
    Object? address = freezed,
    Object? other = freezed,
  }) {
    return _then(_DemoDetailModel(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      age: null == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      other: freezed == other
          ? _self.other
          : other // ignore: cast_nullable_to_non_nullable
              as OtherModel?,
    ));
  }

  /// Create a copy of DemoDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OtherModelCopyWith<$Res>? get other {
    if (_self.other == null) {
      return null;
    }

    return $OtherModelCopyWith<$Res>(_self.other!, (value) {
      return _then(_self.copyWith(other: value));
    });
  }
}

/// @nodoc
mixin _$DemoLiteModel {
  @JsonKey(name: DemoLiteModel.nameKey)
  String? get name;
  @JsonKey(name: DemoLiteModel.ageKey)
  int get age;
  @JsonKey(name: DemoLiteModel.addressKey)
  String? get address;
  @JoinedColumn(foreignKey: "other_id", candidateKey: null)
  @JsonKey(name: DemoLiteModel.otherKey)
  OtherModel? get other;

  /// Create a copy of DemoLiteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DemoLiteModelCopyWith<DemoLiteModel> get copyWith =>
      _$DemoLiteModelCopyWithImpl<DemoLiteModel>(
          this as DemoLiteModel, _$identity);

  /// Serializes this DemoLiteModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DemoLiteModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.other, this.other) || other.other == this.other));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, age, address, other);

  @override
  String toString() {
    return 'DemoLiteModel(name: $name, age: $age, address: $address, other: $other)';
  }
}

/// @nodoc
abstract mixin class $DemoLiteModelCopyWith<$Res> {
  factory $DemoLiteModelCopyWith(
          DemoLiteModel value, $Res Function(DemoLiteModel) _then) =
      _$DemoLiteModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: DemoLiteModel.nameKey) String? name,
      @JsonKey(name: DemoLiteModel.ageKey) int age,
      @JsonKey(name: DemoLiteModel.addressKey) String? address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: DemoLiteModel.otherKey)
      OtherModel? other});

  $OtherModelCopyWith<$Res>? get other;
}

/// @nodoc
class _$DemoLiteModelCopyWithImpl<$Res>
    implements $DemoLiteModelCopyWith<$Res> {
  _$DemoLiteModelCopyWithImpl(this._self, this._then);

  final DemoLiteModel _self;
  final $Res Function(DemoLiteModel) _then;

  /// Create a copy of DemoLiteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? age = null,
    Object? address = freezed,
    Object? other = freezed,
  }) {
    return _then(_self.copyWith(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      age: null == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      other: freezed == other
          ? _self.other
          : other // ignore: cast_nullable_to_non_nullable
              as OtherModel?,
    ));
  }

  /// Create a copy of DemoLiteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OtherModelCopyWith<$Res>? get other {
    if (_self.other == null) {
      return null;
    }

    return $OtherModelCopyWith<$Res>(_self.other!, (value) {
      return _then(_self.copyWith(other: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _DemoLiteModel extends DemoLiteModel {
  const _DemoLiteModel(
      {@JsonKey(name: DemoLiteModel.nameKey) required this.name,
      @JsonKey(name: DemoLiteModel.ageKey) required this.age,
      @JsonKey(name: DemoLiteModel.addressKey) required this.address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: DemoLiteModel.otherKey)
      required this.other})
      : super._();
  factory _DemoLiteModel.fromJson(Map<String, dynamic> json) =>
      _$DemoLiteModelFromJson(json);

  @override
  @JsonKey(name: DemoLiteModel.nameKey)
  final String? name;
  @override
  @JsonKey(name: DemoLiteModel.ageKey)
  final int age;
  @override
  @JsonKey(name: DemoLiteModel.addressKey)
  final String? address;
  @override
  @JoinedColumn(foreignKey: "other_id", candidateKey: null)
  @JsonKey(name: DemoLiteModel.otherKey)
  final OtherModel? other;

  /// Create a copy of DemoLiteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DemoLiteModelCopyWith<_DemoLiteModel> get copyWith =>
      __$DemoLiteModelCopyWithImpl<_DemoLiteModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DemoLiteModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DemoLiteModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.other, this.other) || other.other == this.other));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, age, address, other);

  @override
  String toString() {
    return 'DemoLiteModel(name: $name, age: $age, address: $address, other: $other)';
  }
}

/// @nodoc
abstract mixin class _$DemoLiteModelCopyWith<$Res>
    implements $DemoLiteModelCopyWith<$Res> {
  factory _$DemoLiteModelCopyWith(
          _DemoLiteModel value, $Res Function(_DemoLiteModel) _then) =
      __$DemoLiteModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: DemoLiteModel.nameKey) String? name,
      @JsonKey(name: DemoLiteModel.ageKey) int age,
      @JsonKey(name: DemoLiteModel.addressKey) String? address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: DemoLiteModel.otherKey)
      OtherModel? other});

  @override
  $OtherModelCopyWith<$Res>? get other;
}

/// @nodoc
class __$DemoLiteModelCopyWithImpl<$Res>
    implements _$DemoLiteModelCopyWith<$Res> {
  __$DemoLiteModelCopyWithImpl(this._self, this._then);

  final _DemoLiteModel _self;
  final $Res Function(_DemoLiteModel) _then;

  /// Create a copy of DemoLiteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = freezed,
    Object? age = null,
    Object? address = freezed,
    Object? other = freezed,
  }) {
    return _then(_DemoLiteModel(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      age: null == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      other: freezed == other
          ? _self.other
          : other // ignore: cast_nullable_to_non_nullable
              as OtherModel?,
    ));
  }

  /// Create a copy of DemoLiteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OtherModelCopyWith<$Res>? get other {
    if (_self.other == null) {
      return null;
    }

    return $OtherModelCopyWith<$Res>(_self.other!, (value) {
      return _then(_self.copyWith(other: value));
    });
  }
}

// dart format on
