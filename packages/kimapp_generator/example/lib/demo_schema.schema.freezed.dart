// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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
  @JsonKey(name: "name")
  String? get name;
  @JsonKey(name: "description")
  String? get description;
  @JsonKey(name: "age")
  int get age;
  @JsonKey(name: "address")
  String? get address;
  @JoinedColumn(foreignKey: "other_id", candidateKey: null)
  @JsonKey(name: "other")
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
      {@JsonKey(name: "name") String? name,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "age") int age,
      @JsonKey(name: "address") String? address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: "other")
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

/// Adds pattern-matching-related methods to [DemoModel].
extension DemoModelPatterns on DemoModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_DemoModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DemoModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_DemoModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DemoModel():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_DemoModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DemoModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: "name") String? name,
            @JsonKey(name: "description") String? description,
            @JsonKey(name: "age") int age,
            @JsonKey(name: "address") String? address,
            @JoinedColumn(foreignKey: "other_id", candidateKey: null)
            @JsonKey(name: "other")
            OtherModel? other)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DemoModel() when $default != null:
        return $default(_that.name, _that.description, _that.age, _that.address,
            _that.other);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: "name") String? name,
            @JsonKey(name: "description") String? description,
            @JsonKey(name: "age") int age,
            @JsonKey(name: "address") String? address,
            @JoinedColumn(foreignKey: "other_id", candidateKey: null)
            @JsonKey(name: "other")
            OtherModel? other)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DemoModel():
        return $default(_that.name, _that.description, _that.age, _that.address,
            _that.other);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @JsonKey(name: "name") String? name,
            @JsonKey(name: "description") String? description,
            @JsonKey(name: "age") int age,
            @JsonKey(name: "address") String? address,
            @JoinedColumn(foreignKey: "other_id", candidateKey: null)
            @JsonKey(name: "other")
            OtherModel? other)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DemoModel() when $default != null:
        return $default(_that.name, _that.description, _that.age, _that.address,
            _that.other);
      case _:
        return null;
    }
  }
}

/// @nodoc

@TableModel(DemoModel.tableName)
@JsonSerializable(explicitToJson: true)
class _DemoModel extends DemoModel {
  const _DemoModel(
      {@JsonKey(name: "name") required this.name,
      @JsonKey(name: "description") required this.description,
      @JsonKey(name: "age") required this.age,
      @JsonKey(name: "address") required this.address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: "other")
      required this.other})
      : super._();
  factory _DemoModel.fromJson(Map<String, dynamic> json) =>
      _$DemoModelFromJson(json);

  @override
  @JsonKey(name: "name")
  final String? name;
  @override
  @JsonKey(name: "description")
  final String? description;
  @override
  @JsonKey(name: "age")
  final int age;
  @override
  @JsonKey(name: "address")
  final String? address;
  @override
  @JoinedColumn(foreignKey: "other_id", candidateKey: null)
  @JsonKey(name: "other")
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
      {@JsonKey(name: "name") String? name,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "age") int age,
      @JsonKey(name: "address") String? address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: "other")
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
  @JsonKey(name: "name")
  String? get name;
  @JsonKey(name: "description")
  String? get description;
  @JsonKey(name: "age")
  int get age;
  @JsonKey(name: "address")
  String? get address;
  @JoinedColumn(foreignKey: "other_id", candidateKey: null)
  @JsonKey(name: "other")
  OtherModel? get other;
  @JsonKey(name: "name2")
  String get name2;
  @JsonKey(name: "age2")
  int get age2;

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
            (identical(other.other, this.other) || other.other == this.other) &&
            (identical(other.name2, name2) || other.name2 == name2) &&
            (identical(other.age2, age2) || other.age2 == age2));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, description, age, address, other, name2, age2);

  @override
  String toString() {
    return 'DemoDetailModel(name: $name, description: $description, age: $age, address: $address, other: $other, name2: $name2, age2: $age2)';
  }
}

/// @nodoc
abstract mixin class $DemoDetailModelCopyWith<$Res> {
  factory $DemoDetailModelCopyWith(
          DemoDetailModel value, $Res Function(DemoDetailModel) _then) =
      _$DemoDetailModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "name") String? name,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "age") int age,
      @JsonKey(name: "address") String? address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: "other")
      OtherModel? other,
      @JsonKey(name: "name2") String name2,
      @JsonKey(name: "age2") int age2});

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
    Object? name2 = null,
    Object? age2 = null,
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
      name2: null == name2
          ? _self.name2
          : name2 // ignore: cast_nullable_to_non_nullable
              as String,
      age2: null == age2
          ? _self.age2
          : age2 // ignore: cast_nullable_to_non_nullable
              as int,
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

/// Adds pattern-matching-related methods to [DemoDetailModel].
extension DemoDetailModelPatterns on DemoDetailModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_DemoDetailModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DemoDetailModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_DemoDetailModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DemoDetailModel():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_DemoDetailModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DemoDetailModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: "name") String? name,
            @JsonKey(name: "description") String? description,
            @JsonKey(name: "age") int age,
            @JsonKey(name: "address") String? address,
            @JoinedColumn(foreignKey: "other_id", candidateKey: null)
            @JsonKey(name: "other")
            OtherModel? other,
            @JsonKey(name: "name2") String name2,
            @JsonKey(name: "age2") int age2)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DemoDetailModel() when $default != null:
        return $default(_that.name, _that.description, _that.age, _that.address,
            _that.other, _that.name2, _that.age2);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: "name") String? name,
            @JsonKey(name: "description") String? description,
            @JsonKey(name: "age") int age,
            @JsonKey(name: "address") String? address,
            @JoinedColumn(foreignKey: "other_id", candidateKey: null)
            @JsonKey(name: "other")
            OtherModel? other,
            @JsonKey(name: "name2") String name2,
            @JsonKey(name: "age2") int age2)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DemoDetailModel():
        return $default(_that.name, _that.description, _that.age, _that.address,
            _that.other, _that.name2, _that.age2);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @JsonKey(name: "name") String? name,
            @JsonKey(name: "description") String? description,
            @JsonKey(name: "age") int age,
            @JsonKey(name: "address") String? address,
            @JoinedColumn(foreignKey: "other_id", candidateKey: null)
            @JsonKey(name: "other")
            OtherModel? other,
            @JsonKey(name: "name2") String name2,
            @JsonKey(name: "age2") int age2)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DemoDetailModel() when $default != null:
        return $default(_that.name, _that.description, _that.age, _that.address,
            _that.other, _that.name2, _that.age2);
      case _:
        return null;
    }
  }
}

/// @nodoc

@TableModel(DemoDetailModel.tableName)
@JsonSerializable(explicitToJson: true)
class _DemoDetailModel extends DemoDetailModel {
  const _DemoDetailModel(
      {@JsonKey(name: "name") required this.name,
      @JsonKey(name: "description") required this.description,
      @JsonKey(name: "age") required this.age,
      @JsonKey(name: "address") required this.address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: "other")
      required this.other,
      @JsonKey(name: "name2") required this.name2,
      @JsonKey(name: "age2") required this.age2})
      : super._();
  factory _DemoDetailModel.fromJson(Map<String, dynamic> json) =>
      _$DemoDetailModelFromJson(json);

  @override
  @JsonKey(name: "name")
  final String? name;
  @override
  @JsonKey(name: "description")
  final String? description;
  @override
  @JsonKey(name: "age")
  final int age;
  @override
  @JsonKey(name: "address")
  final String? address;
  @override
  @JoinedColumn(foreignKey: "other_id", candidateKey: null)
  @JsonKey(name: "other")
  final OtherModel? other;
  @override
  @JsonKey(name: "name2")
  final String name2;
  @override
  @JsonKey(name: "age2")
  final int age2;

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
            (identical(other.other, this.other) || other.other == this.other) &&
            (identical(other.name2, name2) || other.name2 == name2) &&
            (identical(other.age2, age2) || other.age2 == age2));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, description, age, address, other, name2, age2);

  @override
  String toString() {
    return 'DemoDetailModel(name: $name, description: $description, age: $age, address: $address, other: $other, name2: $name2, age2: $age2)';
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
      {@JsonKey(name: "name") String? name,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "age") int age,
      @JsonKey(name: "address") String? address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: "other")
      OtherModel? other,
      @JsonKey(name: "name2") String name2,
      @JsonKey(name: "age2") int age2});

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
    Object? name2 = null,
    Object? age2 = null,
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
      name2: null == name2
          ? _self.name2
          : name2 // ignore: cast_nullable_to_non_nullable
              as String,
      age2: null == age2
          ? _self.age2
          : age2 // ignore: cast_nullable_to_non_nullable
              as int,
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
  @JsonKey(name: "name")
  String? get name;
  @JsonKey(name: "age")
  int get age;
  @JsonKey(name: "address")
  String? get address;
  @JoinedColumn(foreignKey: "other_id", candidateKey: null)
  @JsonKey(name: "other")
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
      {@JsonKey(name: "name") String? name,
      @JsonKey(name: "age") int age,
      @JsonKey(name: "address") String? address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: "other")
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

/// Adds pattern-matching-related methods to [DemoLiteModel].
extension DemoLiteModelPatterns on DemoLiteModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_DemoLiteModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DemoLiteModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_DemoLiteModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DemoLiteModel():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_DemoLiteModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DemoLiteModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: "name") String? name,
            @JsonKey(name: "age") int age,
            @JsonKey(name: "address") String? address,
            @JoinedColumn(foreignKey: "other_id", candidateKey: null)
            @JsonKey(name: "other")
            OtherModel? other)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DemoLiteModel() when $default != null:
        return $default(_that.name, _that.age, _that.address, _that.other);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: "name") String? name,
            @JsonKey(name: "age") int age,
            @JsonKey(name: "address") String? address,
            @JoinedColumn(foreignKey: "other_id", candidateKey: null)
            @JsonKey(name: "other")
            OtherModel? other)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DemoLiteModel():
        return $default(_that.name, _that.age, _that.address, _that.other);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @JsonKey(name: "name") String? name,
            @JsonKey(name: "age") int age,
            @JsonKey(name: "address") String? address,
            @JoinedColumn(foreignKey: "other_id", candidateKey: null)
            @JsonKey(name: "other")
            OtherModel? other)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DemoLiteModel() when $default != null:
        return $default(_that.name, _that.age, _that.address, _that.other);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _DemoLiteModel extends DemoLiteModel {
  const _DemoLiteModel(
      {@JsonKey(name: "name") required this.name,
      @JsonKey(name: "age") required this.age,
      @JsonKey(name: "address") required this.address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: "other")
      required this.other})
      : super._();
  factory _DemoLiteModel.fromJson(Map<String, dynamic> json) =>
      _$DemoLiteModelFromJson(json);

  @override
  @JsonKey(name: "name")
  final String? name;
  @override
  @JsonKey(name: "age")
  final int age;
  @override
  @JsonKey(name: "address")
  final String? address;
  @override
  @JoinedColumn(foreignKey: "other_id", candidateKey: null)
  @JsonKey(name: "other")
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
      {@JsonKey(name: "name") String? name,
      @JsonKey(name: "age") int age,
      @JsonKey(name: "address") String? address,
      @JoinedColumn(foreignKey: "other_id", candidateKey: null)
      @JsonKey(name: "other")
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
