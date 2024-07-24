// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'testing.schema.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TestingModel _$TestingModelFromJson(Map<String, dynamic> json) {
  return _TestingModel.fromJson(json);
}

/// @nodoc
mixin _$TestingModel {
  /// id field
  @JsonKey(name: "id")
  TestingId get id => throw _privateConstructorUsedError;

  /// name field
  @JsonKey(name: "name")
  String get name => throw _privateConstructorUsedError;

  /// phone field
  @JsonKey(name: "phone")
  String get phone => throw _privateConstructorUsedError;

  /// address field
  @JsonKey(name: "address")
  String get address => throw _privateConstructorUsedError;

  /// null_column field
  @JsonKey(name: "null_column")
  String? get nullColumn => throw _privateConstructorUsedError;

  /// selfref field
  @JoinedColumn(foreignKey: null, candidateKey: null)
  @JsonKey(name: "selfref")
  Example2Model? get selfref => throw _privateConstructorUsedError;

  /// freezedClass field
  @JoinedColumn(foreignKey: null, candidateKey: null)
  @JsonKey(name: "freezedClass")
  FreezedModel get freezedClass => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TestingModelCopyWith<TestingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestingModelCopyWith<$Res> {
  factory $TestingModelCopyWith(
          TestingModel value, $Res Function(TestingModel) then) =
      _$TestingModelCopyWithImpl<$Res, TestingModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") TestingId id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "phone") String phone,
      @JsonKey(name: "address") String address,
      @JsonKey(name: "null_column") String? nullColumn,
      @JoinedColumn(foreignKey: null, candidateKey: null)
      @JsonKey(name: "selfref")
      Example2Model? selfref,
      @JoinedColumn(foreignKey: null, candidateKey: null)
      @JsonKey(name: "freezedClass")
      FreezedModel freezedClass});

  $Example2ModelCopyWith<$Res>? get selfref;
  $FreezedModelCopyWith<$Res> get freezedClass;
}

/// @nodoc
class _$TestingModelCopyWithImpl<$Res, $Val extends TestingModel>
    implements $TestingModelCopyWith<$Res> {
  _$TestingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? address = null,
    Object? nullColumn = freezed,
    Object? selfref = freezed,
    Object? freezedClass = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as TestingId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      nullColumn: freezed == nullColumn
          ? _value.nullColumn
          : nullColumn // ignore: cast_nullable_to_non_nullable
              as String?,
      selfref: freezed == selfref
          ? _value.selfref
          : selfref // ignore: cast_nullable_to_non_nullable
              as Example2Model?,
      freezedClass: null == freezedClass
          ? _value.freezedClass
          : freezedClass // ignore: cast_nullable_to_non_nullable
              as FreezedModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $Example2ModelCopyWith<$Res>? get selfref {
    if (_value.selfref == null) {
      return null;
    }

    return $Example2ModelCopyWith<$Res>(_value.selfref!, (value) {
      return _then(_value.copyWith(selfref: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FreezedModelCopyWith<$Res> get freezedClass {
    return $FreezedModelCopyWith<$Res>(_value.freezedClass, (value) {
      return _then(_value.copyWith(freezedClass: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TestingModelImplCopyWith<$Res>
    implements $TestingModelCopyWith<$Res> {
  factory _$$TestingModelImplCopyWith(
          _$TestingModelImpl value, $Res Function(_$TestingModelImpl) then) =
      __$$TestingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") TestingId id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "phone") String phone,
      @JsonKey(name: "address") String address,
      @JsonKey(name: "null_column") String? nullColumn,
      @JoinedColumn(foreignKey: null, candidateKey: null)
      @JsonKey(name: "selfref")
      Example2Model? selfref,
      @JoinedColumn(foreignKey: null, candidateKey: null)
      @JsonKey(name: "freezedClass")
      FreezedModel freezedClass});

  @override
  $Example2ModelCopyWith<$Res>? get selfref;
  @override
  $FreezedModelCopyWith<$Res> get freezedClass;
}

/// @nodoc
class __$$TestingModelImplCopyWithImpl<$Res>
    extends _$TestingModelCopyWithImpl<$Res, _$TestingModelImpl>
    implements _$$TestingModelImplCopyWith<$Res> {
  __$$TestingModelImplCopyWithImpl(
      _$TestingModelImpl _value, $Res Function(_$TestingModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? address = null,
    Object? nullColumn = freezed,
    Object? selfref = freezed,
    Object? freezedClass = null,
  }) {
    return _then(_$TestingModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as TestingId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      nullColumn: freezed == nullColumn
          ? _value.nullColumn
          : nullColumn // ignore: cast_nullable_to_non_nullable
              as String?,
      selfref: freezed == selfref
          ? _value.selfref
          : selfref // ignore: cast_nullable_to_non_nullable
              as Example2Model?,
      freezedClass: null == freezedClass
          ? _value.freezedClass
          : freezedClass // ignore: cast_nullable_to_non_nullable
              as FreezedModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@TableModel("testings")
class _$TestingModelImpl extends _TestingModel {
  const _$TestingModelImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "name") required this.name,
      @JsonKey(name: "phone") required this.phone,
      @JsonKey(name: "address") required this.address,
      @JsonKey(name: "null_column") this.nullColumn,
      @JoinedColumn(foreignKey: null, candidateKey: null)
      @JsonKey(name: "selfref")
      this.selfref,
      @JoinedColumn(foreignKey: null, candidateKey: null)
      @JsonKey(name: "freezedClass")
      required this.freezedClass})
      : super._();

  factory _$TestingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestingModelImplFromJson(json);

  /// id field
  @override
  @JsonKey(name: "id")
  final TestingId id;

  /// name field
  @override
  @JsonKey(name: "name")
  final String name;

  /// phone field
  @override
  @JsonKey(name: "phone")
  final String phone;

  /// address field
  @override
  @JsonKey(name: "address")
  final String address;

  /// null_column field
  @override
  @JsonKey(name: "null_column")
  final String? nullColumn;

  /// selfref field
  @override
  @JoinedColumn(foreignKey: null, candidateKey: null)
  @JsonKey(name: "selfref")
  final Example2Model? selfref;

  /// freezedClass field
  @override
  @JoinedColumn(foreignKey: null, candidateKey: null)
  @JsonKey(name: "freezedClass")
  final FreezedModel freezedClass;

  @override
  String toString() {
    return 'TestingModel(id: $id, name: $name, phone: $phone, address: $address, nullColumn: $nullColumn, selfref: $selfref, freezedClass: $freezedClass)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestingModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.nullColumn, nullColumn) ||
                other.nullColumn == nullColumn) &&
            (identical(other.selfref, selfref) || other.selfref == selfref) &&
            (identical(other.freezedClass, freezedClass) ||
                other.freezedClass == freezedClass));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, phone, address, nullColumn, selfref, freezedClass);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestingModelImplCopyWith<_$TestingModelImpl> get copyWith =>
      __$$TestingModelImplCopyWithImpl<_$TestingModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TestingModelImplToJson(
      this,
    );
  }
}

abstract class _TestingModel extends TestingModel {
  const factory _TestingModel(
      {@JsonKey(name: "id") required final TestingId id,
      @JsonKey(name: "name") required final String name,
      @JsonKey(name: "phone") required final String phone,
      @JsonKey(name: "address") required final String address,
      @JsonKey(name: "null_column") final String? nullColumn,
      @JoinedColumn(foreignKey: null, candidateKey: null)
      @JsonKey(name: "selfref")
      final Example2Model? selfref,
      @JoinedColumn(foreignKey: null, candidateKey: null)
      @JsonKey(name: "freezedClass")
      required final FreezedModel freezedClass}) = _$TestingModelImpl;
  const _TestingModel._() : super._();

  factory _TestingModel.fromJson(Map<String, dynamic> json) =
      _$TestingModelImpl.fromJson;

  @override

  /// id field
  @JsonKey(name: "id")
  TestingId get id;
  @override

  /// name field
  @JsonKey(name: "name")
  String get name;
  @override

  /// phone field
  @JsonKey(name: "phone")
  String get phone;
  @override

  /// address field
  @JsonKey(name: "address")
  String get address;
  @override

  /// null_column field
  @JsonKey(name: "null_column")
  String? get nullColumn;
  @override

  /// selfref field
  @JoinedColumn(foreignKey: null, candidateKey: null)
  @JsonKey(name: "selfref")
  Example2Model? get selfref;
  @override

  /// freezedClass field
  @JoinedColumn(foreignKey: null, candidateKey: null)
  @JsonKey(name: "freezedClass")
  FreezedModel get freezedClass;
  @override
  @JsonKey(ignore: true)
  _$$TestingModelImplCopyWith<_$TestingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TestingView _$TestingViewFromJson(Map<String, dynamic> json) {
  return _TestingView.fromJson(json);
}

/// @nodoc
mixin _$TestingView {
  @JsonKey(name: "id")
  TestingId get id => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "phone")
  String get phone => throw _privateConstructorUsedError;
  @JsonKey(name: "address")
  String get address => throw _privateConstructorUsedError;
  @JsonKey(name: "null_column")
  String? get nullColumn => throw _privateConstructorUsedError;
  @JoinedColumn(foreignKey: null, candidateKey: null)
  @JsonKey(name: "selfref")
  Example2Model? get selfref => throw _privateConstructorUsedError;
  @JoinedColumn(foreignKey: null, candidateKey: null)
  @JsonKey(name: "freezedClass")
  FreezedModel get freezedClass => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TestingViewCopyWith<TestingView> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestingViewCopyWith<$Res> {
  factory $TestingViewCopyWith(
          TestingView value, $Res Function(TestingView) then) =
      _$TestingViewCopyWithImpl<$Res, TestingView>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") TestingId id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "phone") String phone,
      @JsonKey(name: "address") String address,
      @JsonKey(name: "null_column") String? nullColumn,
      @JoinedColumn(foreignKey: null, candidateKey: null)
      @JsonKey(name: "selfref")
      Example2Model? selfref,
      @JoinedColumn(foreignKey: null, candidateKey: null)
      @JsonKey(name: "freezedClass")
      FreezedModel freezedClass});

  $Example2ModelCopyWith<$Res>? get selfref;
  $FreezedModelCopyWith<$Res> get freezedClass;
}

/// @nodoc
class _$TestingViewCopyWithImpl<$Res, $Val extends TestingView>
    implements $TestingViewCopyWith<$Res> {
  _$TestingViewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? address = null,
    Object? nullColumn = freezed,
    Object? selfref = freezed,
    Object? freezedClass = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as TestingId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      nullColumn: freezed == nullColumn
          ? _value.nullColumn
          : nullColumn // ignore: cast_nullable_to_non_nullable
              as String?,
      selfref: freezed == selfref
          ? _value.selfref
          : selfref // ignore: cast_nullable_to_non_nullable
              as Example2Model?,
      freezedClass: null == freezedClass
          ? _value.freezedClass
          : freezedClass // ignore: cast_nullable_to_non_nullable
              as FreezedModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $Example2ModelCopyWith<$Res>? get selfref {
    if (_value.selfref == null) {
      return null;
    }

    return $Example2ModelCopyWith<$Res>(_value.selfref!, (value) {
      return _then(_value.copyWith(selfref: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FreezedModelCopyWith<$Res> get freezedClass {
    return $FreezedModelCopyWith<$Res>(_value.freezedClass, (value) {
      return _then(_value.copyWith(freezedClass: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TestingViewImplCopyWith<$Res>
    implements $TestingViewCopyWith<$Res> {
  factory _$$TestingViewImplCopyWith(
          _$TestingViewImpl value, $Res Function(_$TestingViewImpl) then) =
      __$$TestingViewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") TestingId id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "phone") String phone,
      @JsonKey(name: "address") String address,
      @JsonKey(name: "null_column") String? nullColumn,
      @JoinedColumn(foreignKey: null, candidateKey: null)
      @JsonKey(name: "selfref")
      Example2Model? selfref,
      @JoinedColumn(foreignKey: null, candidateKey: null)
      @JsonKey(name: "freezedClass")
      FreezedModel freezedClass});

  @override
  $Example2ModelCopyWith<$Res>? get selfref;
  @override
  $FreezedModelCopyWith<$Res> get freezedClass;
}

/// @nodoc
class __$$TestingViewImplCopyWithImpl<$Res>
    extends _$TestingViewCopyWithImpl<$Res, _$TestingViewImpl>
    implements _$$TestingViewImplCopyWith<$Res> {
  __$$TestingViewImplCopyWithImpl(
      _$TestingViewImpl _value, $Res Function(_$TestingViewImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? address = null,
    Object? nullColumn = freezed,
    Object? selfref = freezed,
    Object? freezedClass = null,
  }) {
    return _then(_$TestingViewImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as TestingId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      nullColumn: freezed == nullColumn
          ? _value.nullColumn
          : nullColumn // ignore: cast_nullable_to_non_nullable
              as String?,
      selfref: freezed == selfref
          ? _value.selfref
          : selfref // ignore: cast_nullable_to_non_nullable
              as Example2Model?,
      freezedClass: null == freezedClass
          ? _value.freezedClass
          : freezedClass // ignore: cast_nullable_to_non_nullable
              as FreezedModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@TableModel("v_testings")
class _$TestingViewImpl extends _TestingView {
  const _$TestingViewImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "name") required this.name,
      @JsonKey(name: "phone") required this.phone,
      @JsonKey(name: "address") required this.address,
      @JsonKey(name: "null_column") this.nullColumn,
      @JoinedColumn(foreignKey: null, candidateKey: null)
      @JsonKey(name: "selfref")
      this.selfref,
      @JoinedColumn(foreignKey: null, candidateKey: null)
      @JsonKey(name: "freezedClass")
      required this.freezedClass})
      : super._();

  factory _$TestingViewImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestingViewImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final TestingId id;
  @override
  @JsonKey(name: "name")
  final String name;
  @override
  @JsonKey(name: "phone")
  final String phone;
  @override
  @JsonKey(name: "address")
  final String address;
  @override
  @JsonKey(name: "null_column")
  final String? nullColumn;
  @override
  @JoinedColumn(foreignKey: null, candidateKey: null)
  @JsonKey(name: "selfref")
  final Example2Model? selfref;
  @override
  @JoinedColumn(foreignKey: null, candidateKey: null)
  @JsonKey(name: "freezedClass")
  final FreezedModel freezedClass;

  @override
  String toString() {
    return 'TestingView(id: $id, name: $name, phone: $phone, address: $address, nullColumn: $nullColumn, selfref: $selfref, freezedClass: $freezedClass)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestingViewImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.nullColumn, nullColumn) ||
                other.nullColumn == nullColumn) &&
            (identical(other.selfref, selfref) || other.selfref == selfref) &&
            (identical(other.freezedClass, freezedClass) ||
                other.freezedClass == freezedClass));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, phone, address, nullColumn, selfref, freezedClass);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestingViewImplCopyWith<_$TestingViewImpl> get copyWith =>
      __$$TestingViewImplCopyWithImpl<_$TestingViewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TestingViewImplToJson(
      this,
    );
  }
}

abstract class _TestingView extends TestingView {
  const factory _TestingView(
      {@JsonKey(name: "id") required final TestingId id,
      @JsonKey(name: "name") required final String name,
      @JsonKey(name: "phone") required final String phone,
      @JsonKey(name: "address") required final String address,
      @JsonKey(name: "null_column") final String? nullColumn,
      @JoinedColumn(foreignKey: null, candidateKey: null)
      @JsonKey(name: "selfref")
      final Example2Model? selfref,
      @JoinedColumn(foreignKey: null, candidateKey: null)
      @JsonKey(name: "freezedClass")
      required final FreezedModel freezedClass}) = _$TestingViewImpl;
  const _TestingView._() : super._();

  factory _TestingView.fromJson(Map<String, dynamic> json) =
      _$TestingViewImpl.fromJson;

  @override
  @JsonKey(name: "id")
  TestingId get id;
  @override
  @JsonKey(name: "name")
  String get name;
  @override
  @JsonKey(name: "phone")
  String get phone;
  @override
  @JsonKey(name: "address")
  String get address;
  @override
  @JsonKey(name: "null_column")
  String? get nullColumn;
  @override
  @JoinedColumn(foreignKey: null, candidateKey: null)
  @JsonKey(name: "selfref")
  Example2Model? get selfref;
  @override
  @JoinedColumn(foreignKey: null, candidateKey: null)
  @JsonKey(name: "freezedClass")
  FreezedModel get freezedClass;
  @override
  @JsonKey(ignore: true)
  _$$TestingViewImplCopyWith<_$TestingViewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
