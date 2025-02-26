// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AnimalModel {
  String get name => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;

  /// Create a copy of AnimalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnimalModelCopyWith<AnimalModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnimalModelCopyWith<$Res> {
  factory $AnimalModelCopyWith(
          AnimalModel value, $Res Function(AnimalModel) then) =
      _$AnimalModelCopyWithImpl<$Res, AnimalModel>;
  @useResult
  $Res call({String name, int age});
}

/// @nodoc
class _$AnimalModelCopyWithImpl<$Res, $Val extends AnimalModel>
    implements $AnimalModelCopyWith<$Res> {
  _$AnimalModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnimalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? age = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnimalModelImplCopyWith<$Res>
    implements $AnimalModelCopyWith<$Res> {
  factory _$$AnimalModelImplCopyWith(
          _$AnimalModelImpl value, $Res Function(_$AnimalModelImpl) then) =
      __$$AnimalModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int age});
}

/// @nodoc
class __$$AnimalModelImplCopyWithImpl<$Res>
    extends _$AnimalModelCopyWithImpl<$Res, _$AnimalModelImpl>
    implements _$$AnimalModelImplCopyWith<$Res> {
  __$$AnimalModelImplCopyWithImpl(
      _$AnimalModelImpl _value, $Res Function(_$AnimalModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AnimalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? age = null,
  }) {
    return _then(_$AnimalModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AnimalModelImpl extends _AnimalModel {
  const _$AnimalModelImpl({required this.name, required this.age}) : super._();

  @override
  final String name;
  @override
  final int age;

  @override
  String toString() {
    return 'AnimalModel(name: $name, age: $age)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnimalModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, age);

  /// Create a copy of AnimalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnimalModelImplCopyWith<_$AnimalModelImpl> get copyWith =>
      __$$AnimalModelImplCopyWithImpl<_$AnimalModelImpl>(this, _$identity);
}

abstract class _AnimalModel extends AnimalModel {
  const factory _AnimalModel(
      {required final String name, required final int age}) = _$AnimalModelImpl;
  const _AnimalModel._() : super._();

  @override
  String get name;
  @override
  int get age;

  /// Create a copy of AnimalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnimalModelImplCopyWith<_$AnimalModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
