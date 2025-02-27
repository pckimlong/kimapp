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
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

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
  $Res call({int? id, String name, int age, String? description});
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
    Object? id = freezed,
    Object? name = null,
    Object? age = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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
  $Res call({int? id, String name, int age, String? description});
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
    Object? id = freezed,
    Object? name = null,
    Object? age = null,
    Object? description = freezed,
  }) {
    return _then(_$AnimalModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AnimalModelImpl extends _AnimalModel {
  const _$AnimalModelImpl(
      {this.id, required this.name, required this.age, this.description})
      : super._();

  @override
  final int? id;
  @override
  final String name;
  @override
  final int age;
  @override
  final String? description;

  @override
  String toString() {
    return 'AnimalModel(id: $id, name: $name, age: $age, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnimalModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, age, description);

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
      {final int? id,
      required final String name,
      required final int age,
      final String? description}) = _$AnimalModelImpl;
  const _AnimalModel._() : super._();

  @override
  int? get id;
  @override
  String get name;
  @override
  int get age;
  @override
  String? get description;

  /// Create a copy of AnimalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnimalModelImplCopyWith<_$AnimalModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
