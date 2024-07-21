// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state_widget_example.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExampleModel _$ExampleModelFromJson(Map<String, dynamic> json) {
  return _ExampleModel.fromJson(json);
}

/// @nodoc
mixin _$ExampleModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExampleModelCopyWith<ExampleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExampleModelCopyWith<$Res> {
  factory $ExampleModelCopyWith(
          ExampleModel value, $Res Function(ExampleModel) then) =
      _$ExampleModelCopyWithImpl<$Res, ExampleModel>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$ExampleModelCopyWithImpl<$Res, $Val extends ExampleModel>
    implements $ExampleModelCopyWith<$Res> {
  _$ExampleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExampleModelImplCopyWith<$Res>
    implements $ExampleModelCopyWith<$Res> {
  factory _$$ExampleModelImplCopyWith(
          _$ExampleModelImpl value, $Res Function(_$ExampleModelImpl) then) =
      __$$ExampleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$ExampleModelImplCopyWithImpl<$Res>
    extends _$ExampleModelCopyWithImpl<$Res, _$ExampleModelImpl>
    implements _$$ExampleModelImplCopyWith<$Res> {
  __$$ExampleModelImplCopyWithImpl(
      _$ExampleModelImpl _value, $Res Function(_$ExampleModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$ExampleModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@TableModel('xxx')
class _$ExampleModelImpl extends _ExampleModel {
  const _$ExampleModelImpl({required this.id, required this.name}) : super._();

  factory _$ExampleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExampleModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'ExampleModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExampleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExampleModelImplCopyWith<_$ExampleModelImpl> get copyWith =>
      __$$ExampleModelImplCopyWithImpl<_$ExampleModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExampleModelImplToJson(
      this,
    );
  }
}

abstract class _ExampleModel extends ExampleModel {
  const factory _ExampleModel(
      {required final int id, required final String name}) = _$ExampleModelImpl;
  const _ExampleModel._() : super._();

  factory _ExampleModel.fromJson(Map<String, dynamic> json) =
      _$ExampleModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$ExampleModelImplCopyWith<_$ExampleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
