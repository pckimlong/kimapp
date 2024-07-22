// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kimapp_schema_example.schema.dart';

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
  /// id field
  @JsonKey(name: "id")
  int get id => throw _privateConstructorUsedError;

  /// name field
  @JsonKey(name: "name")
  String get name => throw _privateConstructorUsedError;

  /// age field
  @JsonKey(name: "age")
  int get age => throw _privateConstructorUsedError;

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
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "age") int age});
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
    Object? age = null,
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
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
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
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "age") int age});
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
    Object? age = null,
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
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@TableModel("exampleses")
class _$ExampleModelImpl extends _ExampleModel {
  const _$ExampleModelImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "name") required this.name,
      @JsonKey(name: "age") required this.age})
      : super._();

  factory _$ExampleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExampleModelImplFromJson(json);

  /// id field
  @override
  @JsonKey(name: "id")
  final int id;

  /// name field
  @override
  @JsonKey(name: "name")
  final String name;

  /// age field
  @override
  @JsonKey(name: "age")
  final int age;

  @override
  String toString() {
    return 'ExampleModel(id: $id, name: $name, age: $age)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExampleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, age);

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
      {@JsonKey(name: "id") required final int id,
      @JsonKey(name: "name") required final String name,
      @JsonKey(name: "age") required final int age}) = _$ExampleModelImpl;
  const _ExampleModel._() : super._();

  factory _ExampleModel.fromJson(Map<String, dynamic> json) =
      _$ExampleModelImpl.fromJson;

  @override

  /// id field
  @JsonKey(name: "id")
  int get id;
  @override

  /// name field
  @JsonKey(name: "name")
  String get name;
  @override

  /// age field
  @JsonKey(name: "age")
  int get age;
  @override
  @JsonKey(ignore: true)
  _$$ExampleModelImplCopyWith<_$ExampleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateExampleParam _$CreateExampleParamFromJson(Map<String, dynamic> json) {
  return _CreateExampleParam.fromJson(json);
}

/// @nodoc
mixin _$CreateExampleParam {
  @JsonKey(name: "name")
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "age")
  int get age => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateExampleParamCopyWith<CreateExampleParam> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateExampleParamCopyWith<$Res> {
  factory $CreateExampleParamCopyWith(
          CreateExampleParam value, $Res Function(CreateExampleParam) then) =
      _$CreateExampleParamCopyWithImpl<$Res, CreateExampleParam>;
  @useResult
  $Res call(
      {@JsonKey(name: "name") String name, @JsonKey(name: "age") int age});
}

/// @nodoc
class _$CreateExampleParamCopyWithImpl<$Res, $Val extends CreateExampleParam>
    implements $CreateExampleParamCopyWith<$Res> {
  _$CreateExampleParamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
abstract class _$$CreateExampleParamImplCopyWith<$Res>
    implements $CreateExampleParamCopyWith<$Res> {
  factory _$$CreateExampleParamImplCopyWith(_$CreateExampleParamImpl value,
          $Res Function(_$CreateExampleParamImpl) then) =
      __$$CreateExampleParamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "name") String name, @JsonKey(name: "age") int age});
}

/// @nodoc
class __$$CreateExampleParamImplCopyWithImpl<$Res>
    extends _$CreateExampleParamCopyWithImpl<$Res, _$CreateExampleParamImpl>
    implements _$$CreateExampleParamImplCopyWith<$Res> {
  __$$CreateExampleParamImplCopyWithImpl(_$CreateExampleParamImpl _value,
      $Res Function(_$CreateExampleParamImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? age = null,
  }) {
    return _then(_$CreateExampleParamImpl(
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
@JsonSerializable()
@TableModel("exampleses")
class _$CreateExampleParamImpl extends _CreateExampleParam {
  const _$CreateExampleParamImpl(
      {@JsonKey(name: "name") required this.name,
      @JsonKey(name: "age") required this.age})
      : super._();

  factory _$CreateExampleParamImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateExampleParamImplFromJson(json);

  @override
  @JsonKey(name: "name")
  final String name;
  @override
  @JsonKey(name: "age")
  final int age;

  @override
  String toString() {
    return 'CreateExampleParam(name: $name, age: $age)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateExampleParamImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, age);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateExampleParamImplCopyWith<_$CreateExampleParamImpl> get copyWith =>
      __$$CreateExampleParamImplCopyWithImpl<_$CreateExampleParamImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateExampleParamImplToJson(
      this,
    );
  }
}

abstract class _CreateExampleParam extends CreateExampleParam {
  const factory _CreateExampleParam(
      {@JsonKey(name: "name") required final String name,
      @JsonKey(name: "age") required final int age}) = _$CreateExampleParamImpl;
  const _CreateExampleParam._() : super._();

  factory _CreateExampleParam.fromJson(Map<String, dynamic> json) =
      _$CreateExampleParamImpl.fromJson;

  @override
  @JsonKey(name: "name")
  String get name;
  @override
  @JsonKey(name: "age")
  int get age;
  @override
  @JsonKey(ignore: true)
  _$$CreateExampleParamImplCopyWith<_$CreateExampleParamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateExampleParam _$UpdateExampleParamFromJson(Map<String, dynamic> json) {
  return _UpdateExampleParam.fromJson(json);
}

/// @nodoc
mixin _$UpdateExampleParam {
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateExampleParamCopyWith<$Res> {
  factory $UpdateExampleParamCopyWith(
          UpdateExampleParam value, $Res Function(UpdateExampleParam) then) =
      _$UpdateExampleParamCopyWithImpl<$Res, UpdateExampleParam>;
}

/// @nodoc
class _$UpdateExampleParamCopyWithImpl<$Res, $Val extends UpdateExampleParam>
    implements $UpdateExampleParamCopyWith<$Res> {
  _$UpdateExampleParamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$UpdateExampleParamImplCopyWith<$Res> {
  factory _$$UpdateExampleParamImplCopyWith(_$UpdateExampleParamImpl value,
          $Res Function(_$UpdateExampleParamImpl) then) =
      __$$UpdateExampleParamImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UpdateExampleParamImplCopyWithImpl<$Res>
    extends _$UpdateExampleParamCopyWithImpl<$Res, _$UpdateExampleParamImpl>
    implements _$$UpdateExampleParamImplCopyWith<$Res> {
  __$$UpdateExampleParamImplCopyWithImpl(_$UpdateExampleParamImpl _value,
      $Res Function(_$UpdateExampleParamImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
@TableModel("exampleses")
class _$UpdateExampleParamImpl extends _UpdateExampleParam {
  const _$UpdateExampleParamImpl() : super._();

  factory _$UpdateExampleParamImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateExampleParamImplFromJson(json);

  @override
  String toString() {
    return 'UpdateExampleParam()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UpdateExampleParamImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateExampleParamImplToJson(
      this,
    );
  }
}

abstract class _UpdateExampleParam extends UpdateExampleParam {
  const factory _UpdateExampleParam() = _$UpdateExampleParamImpl;
  const _UpdateExampleParam._() : super._();

  factory _UpdateExampleParam.fromJson(Map<String, dynamic> json) =
      _$UpdateExampleParamImpl.fromJson;
}

ExampleView _$ExampleViewFromJson(Map<String, dynamic> json) {
  return _ExampleView.fromJson(json);
}

/// @nodoc
mixin _$ExampleView {
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExampleViewCopyWith<$Res> {
  factory $ExampleViewCopyWith(
          ExampleView value, $Res Function(ExampleView) then) =
      _$ExampleViewCopyWithImpl<$Res, ExampleView>;
}

/// @nodoc
class _$ExampleViewCopyWithImpl<$Res, $Val extends ExampleView>
    implements $ExampleViewCopyWith<$Res> {
  _$ExampleViewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ExampleViewImplCopyWith<$Res> {
  factory _$$ExampleViewImplCopyWith(
          _$ExampleViewImpl value, $Res Function(_$ExampleViewImpl) then) =
      __$$ExampleViewImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ExampleViewImplCopyWithImpl<$Res>
    extends _$ExampleViewCopyWithImpl<$Res, _$ExampleViewImpl>
    implements _$$ExampleViewImplCopyWith<$Res> {
  __$$ExampleViewImplCopyWithImpl(
      _$ExampleViewImpl _value, $Res Function(_$ExampleViewImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
@TableModel("v_examples")
class _$ExampleViewImpl extends _ExampleView {
  const _$ExampleViewImpl() : super._();

  factory _$ExampleViewImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExampleViewImplFromJson(json);

  @override
  String toString() {
    return 'ExampleView()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ExampleViewImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return _$$ExampleViewImplToJson(
      this,
    );
  }
}

abstract class _ExampleView extends ExampleView {
  const factory _ExampleView() = _$ExampleViewImpl;
  const _ExampleView._() : super._();

  factory _ExampleView.fromJson(Map<String, dynamic> json) =
      _$ExampleViewImpl.fromJson;
}
