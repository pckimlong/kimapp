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

Example2Model _$Example2ModelFromJson(Map<String, dynamic> json) {
  return _Example2Model.fromJson(json);
}

/// @nodoc
mixin _$Example2Model {
  /// id field
  @JsonKey(name: "id")
  ExmapleId get id => throw _privateConstructorUsedError;

  /// name field
  @JsonKey(name: "name")
  String get name => throw _privateConstructorUsedError;

  /// phone field
  @JsonKey(name: "phone")
  String get phone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $Example2ModelCopyWith<Example2Model> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Example2ModelCopyWith<$Res> {
  factory $Example2ModelCopyWith(
          Example2Model value, $Res Function(Example2Model) then) =
      _$Example2ModelCopyWithImpl<$Res, Example2Model>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") ExmapleId id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "phone") String phone});
}

/// @nodoc
class _$Example2ModelCopyWithImpl<$Res, $Val extends Example2Model>
    implements $Example2ModelCopyWith<$Res> {
  _$Example2ModelCopyWithImpl(this._value, this._then);

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
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as ExmapleId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Example2ModelImplCopyWith<$Res>
    implements $Example2ModelCopyWith<$Res> {
  factory _$$Example2ModelImplCopyWith(
          _$Example2ModelImpl value, $Res Function(_$Example2ModelImpl) then) =
      __$$Example2ModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") ExmapleId id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "phone") String phone});
}

/// @nodoc
class __$$Example2ModelImplCopyWithImpl<$Res>
    extends _$Example2ModelCopyWithImpl<$Res, _$Example2ModelImpl>
    implements _$$Example2ModelImplCopyWith<$Res> {
  __$$Example2ModelImplCopyWithImpl(
      _$Example2ModelImpl _value, $Res Function(_$Example2ModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
  }) {
    return _then(_$Example2ModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as ExmapleId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@TableModel("exampleses")
class _$Example2ModelImpl extends _Example2Model {
  const _$Example2ModelImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "name") required this.name,
      @JsonKey(name: "phone") required this.phone})
      : super._();

  factory _$Example2ModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$Example2ModelImplFromJson(json);

  /// id field
  @override
  @JsonKey(name: "id")
  final ExmapleId id;

  /// name field
  @override
  @JsonKey(name: "name")
  final String name;

  /// phone field
  @override
  @JsonKey(name: "phone")
  final String phone;

  @override
  String toString() {
    return 'Example2Model(id: $id, name: $name, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Example2ModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Example2ModelImplCopyWith<_$Example2ModelImpl> get copyWith =>
      __$$Example2ModelImplCopyWithImpl<_$Example2ModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Example2ModelImplToJson(
      this,
    );
  }
}

abstract class _Example2Model extends Example2Model {
  const factory _Example2Model(
          {@JsonKey(name: "id") required final ExmapleId id,
          @JsonKey(name: "name") required final String name,
          @JsonKey(name: "phone") required final String phone}) =
      _$Example2ModelImpl;
  const _Example2Model._() : super._();

  factory _Example2Model.fromJson(Map<String, dynamic> json) =
      _$Example2ModelImpl.fromJson;

  @override

  /// id field
  @JsonKey(name: "id")
  ExmapleId get id;
  @override

  /// name field
  @JsonKey(name: "name")
  String get name;
  @override

  /// phone field
  @JsonKey(name: "phone")
  String get phone;
  @override
  @JsonKey(ignore: true)
  _$$Example2ModelImplCopyWith<_$Example2ModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateExampleParam _$CreateExampleParamFromJson(Map<String, dynamic> json) {
  return _CreateExampleParam.fromJson(json);
}

/// @nodoc
mixin _$CreateExampleParam {
  @JsonKey(name: "name")
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "phone")
  String get phone => throw _privateConstructorUsedError;

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
      {@JsonKey(name: "name") String name,
      @JsonKey(name: "phone") String phone});
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
    Object? phone = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
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
      {@JsonKey(name: "name") String name,
      @JsonKey(name: "phone") String phone});
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
    Object? phone = null,
  }) {
    return _then(_$CreateExampleParamImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@TableModel("exampleses")
class _$CreateExampleParamImpl extends _CreateExampleParam {
  const _$CreateExampleParamImpl(
      {@JsonKey(name: "name") required this.name,
      @JsonKey(name: "phone") required this.phone})
      : super._();

  factory _$CreateExampleParamImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateExampleParamImplFromJson(json);

  @override
  @JsonKey(name: "name")
  final String name;
  @override
  @JsonKey(name: "phone")
  final String phone;

  @override
  String toString() {
    return 'CreateExampleParam(name: $name, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateExampleParamImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, phone);

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
          @JsonKey(name: "phone") required final String phone}) =
      _$CreateExampleParamImpl;
  const _CreateExampleParam._() : super._();

  factory _CreateExampleParam.fromJson(Map<String, dynamic> json) =
      _$CreateExampleParamImpl.fromJson;

  @override
  @JsonKey(name: "name")
  String get name;
  @override
  @JsonKey(name: "phone")
  String get phone;
  @override
  @JsonKey(ignore: true)
  _$$CreateExampleParamImplCopyWith<_$CreateExampleParamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExampleView _$ExampleViewFromJson(Map<String, dynamic> json) {
  return _ExampleView.fromJson(json);
}

/// @nodoc
mixin _$ExampleView {
  @JsonKey(name: "id")
  ExmapleId get id => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "phone")
  String get phone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExampleViewCopyWith<ExampleView> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExampleViewCopyWith<$Res> {
  factory $ExampleViewCopyWith(
          ExampleView value, $Res Function(ExampleView) then) =
      _$ExampleViewCopyWithImpl<$Res, ExampleView>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") ExmapleId id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "phone") String phone});
}

/// @nodoc
class _$ExampleViewCopyWithImpl<$Res, $Val extends ExampleView>
    implements $ExampleViewCopyWith<$Res> {
  _$ExampleViewCopyWithImpl(this._value, this._then);

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
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as ExmapleId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExampleViewImplCopyWith<$Res>
    implements $ExampleViewCopyWith<$Res> {
  factory _$$ExampleViewImplCopyWith(
          _$ExampleViewImpl value, $Res Function(_$ExampleViewImpl) then) =
      __$$ExampleViewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") ExmapleId id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "phone") String phone});
}

/// @nodoc
class __$$ExampleViewImplCopyWithImpl<$Res>
    extends _$ExampleViewCopyWithImpl<$Res, _$ExampleViewImpl>
    implements _$$ExampleViewImplCopyWith<$Res> {
  __$$ExampleViewImplCopyWithImpl(
      _$ExampleViewImpl _value, $Res Function(_$ExampleViewImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
  }) {
    return _then(_$ExampleViewImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as ExmapleId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@TableModel("v_examples")
class _$ExampleViewImpl extends _ExampleView {
  const _$ExampleViewImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "name") required this.name,
      @JsonKey(name: "phone") required this.phone})
      : super._();

  factory _$ExampleViewImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExampleViewImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final ExmapleId id;
  @override
  @JsonKey(name: "name")
  final String name;
  @override
  @JsonKey(name: "phone")
  final String phone;

  @override
  String toString() {
    return 'ExampleView(id: $id, name: $name, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExampleViewImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExampleViewImplCopyWith<_$ExampleViewImpl> get copyWith =>
      __$$ExampleViewImplCopyWithImpl<_$ExampleViewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExampleViewImplToJson(
      this,
    );
  }
}

abstract class _ExampleView extends ExampleView {
  const factory _ExampleView(
      {@JsonKey(name: "id") required final ExmapleId id,
      @JsonKey(name: "name") required final String name,
      @JsonKey(name: "phone") required final String phone}) = _$ExampleViewImpl;
  const _ExampleView._() : super._();

  factory _ExampleView.fromJson(Map<String, dynamic> json) =
      _$ExampleViewImpl.fromJson;

  @override
  @JsonKey(name: "id")
  ExmapleId get id;
  @override
  @JsonKey(name: "name")
  String get name;
  @override
  @JsonKey(name: "phone")
  String get phone;
  @override
  @JsonKey(ignore: true)
  _$$ExampleViewImplCopyWith<_$ExampleViewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
