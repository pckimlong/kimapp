// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table_structure_example.table.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SampleRawModel _$SampleRawModelFromJson(Map<String, dynamic> json) {
  return _SampleRawModel.fromJson(json);
}

/// @nodoc
mixin _$SampleRawModel {
  @JsonKey(name: "id")
  SampleId get id => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "description")
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: "createdAt")
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "updatedAt")
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: "ids")
  List<int> get ids => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SampleRawModelCopyWith<SampleRawModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SampleRawModelCopyWith<$Res> {
  factory $SampleRawModelCopyWith(
          SampleRawModel value, $Res Function(SampleRawModel) then) =
      _$SampleRawModelCopyWithImpl<$Res, SampleRawModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") SampleId id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "createdAt") DateTime createdAt,
      @JsonKey(name: "updatedAt") DateTime updatedAt,
      @JsonKey(name: "ids") List<int> ids});
}

/// @nodoc
class _$SampleRawModelCopyWithImpl<$Res, $Val extends SampleRawModel>
    implements $SampleRawModelCopyWith<$Res> {
  _$SampleRawModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? ids = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as SampleId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ids: null == ids
          ? _value.ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SampleRawModelImplCopyWith<$Res>
    implements $SampleRawModelCopyWith<$Res> {
  factory _$$SampleRawModelImplCopyWith(_$SampleRawModelImpl value,
          $Res Function(_$SampleRawModelImpl) then) =
      __$$SampleRawModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") SampleId id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "createdAt") DateTime createdAt,
      @JsonKey(name: "updatedAt") DateTime updatedAt,
      @JsonKey(name: "ids") List<int> ids});
}

/// @nodoc
class __$$SampleRawModelImplCopyWithImpl<$Res>
    extends _$SampleRawModelCopyWithImpl<$Res, _$SampleRawModelImpl>
    implements _$$SampleRawModelImplCopyWith<$Res> {
  __$$SampleRawModelImplCopyWithImpl(
      _$SampleRawModelImpl _value, $Res Function(_$SampleRawModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? ids = null,
  }) {
    return _then(_$SampleRawModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as SampleId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ids: null == ids
          ? _value._ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@TableModel("samples")
class _$SampleRawModelImpl extends _SampleRawModel {
  const _$SampleRawModelImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "name") required this.name,
      @JsonKey(name: "description") this.description,
      @JsonKey(name: "createdAt") required this.createdAt,
      @JsonKey(name: "updatedAt") required this.updatedAt,
      @JsonKey(name: "ids") required final List<int> ids})
      : _ids = ids,
        super._();

  factory _$SampleRawModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SampleRawModelImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final SampleId id;
  @override
  @JsonKey(name: "name")
  final String name;
  @override
  @JsonKey(name: "description")
  final String? description;
  @override
  @JsonKey(name: "createdAt")
  final DateTime createdAt;
  @override
  @JsonKey(name: "updatedAt")
  final DateTime updatedAt;
  final List<int> _ids;
  @override
  @JsonKey(name: "ids")
  List<int> get ids {
    if (_ids is EqualUnmodifiableListView) return _ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ids);
  }

  @override
  String toString() {
    return 'SampleRawModel(id: $id, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, ids: $ids)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SampleRawModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._ids, _ids));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, createdAt,
      updatedAt, const DeepCollectionEquality().hash(_ids));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SampleRawModelImplCopyWith<_$SampleRawModelImpl> get copyWith =>
      __$$SampleRawModelImplCopyWithImpl<_$SampleRawModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SampleRawModelImplToJson(
      this,
    );
  }
}

abstract class _SampleRawModel extends SampleRawModel {
  const factory _SampleRawModel(
          {@JsonKey(name: "id") required final SampleId id,
          @JsonKey(name: "name") required final String name,
          @JsonKey(name: "description") final String? description,
          @JsonKey(name: "createdAt") required final DateTime createdAt,
          @JsonKey(name: "updatedAt") required final DateTime updatedAt,
          @JsonKey(name: "ids") required final List<int> ids}) =
      _$SampleRawModelImpl;
  const _SampleRawModel._() : super._();

  factory _SampleRawModel.fromJson(Map<String, dynamic> json) =
      _$SampleRawModelImpl.fromJson;

  @override
  @JsonKey(name: "id")
  SampleId get id;
  @override
  @JsonKey(name: "name")
  String get name;
  @override
  @JsonKey(name: "description")
  String? get description;
  @override
  @JsonKey(name: "createdAt")
  DateTime get createdAt;
  @override
  @JsonKey(name: "updatedAt")
  DateTime get updatedAt;
  @override
  @JsonKey(name: "ids")
  List<int> get ids;
  @override
  @JsonKey(ignore: true)
  _$$SampleRawModelImplCopyWith<_$SampleRawModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateSampleParam _$UpdateSampleParamFromJson(Map<String, dynamic> json) {
  return _UpdateSampleParam.fromJson(json);
}

/// @nodoc
mixin _$UpdateSampleParam {
  @JsonKey(name: "id")
  SampleId get id => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "description")
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: "updatedAt")
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: "ids")
  List<int> get ids => throw _privateConstructorUsedError;
  @JsonKey(name: "address")
  int get address => throw _privateConstructorUsedError;
  @JoinedColumn(foreignKey: "example_id")
  @JsonKey(name: "ex")
  ExampleModel get ex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateSampleParamCopyWith<UpdateSampleParam> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateSampleParamCopyWith<$Res> {
  factory $UpdateSampleParamCopyWith(
          UpdateSampleParam value, $Res Function(UpdateSampleParam) then) =
      _$UpdateSampleParamCopyWithImpl<$Res, UpdateSampleParam>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") SampleId id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "updatedAt") DateTime updatedAt,
      @JsonKey(name: "ids") List<int> ids,
      @JsonKey(name: "address") int address,
      @JoinedColumn(foreignKey: "example_id")
      @JsonKey(name: "ex")
      ExampleModel ex});

  $ExampleModelCopyWith<$Res> get ex;
}

/// @nodoc
class _$UpdateSampleParamCopyWithImpl<$Res, $Val extends UpdateSampleParam>
    implements $UpdateSampleParamCopyWith<$Res> {
  _$UpdateSampleParamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? updatedAt = null,
    Object? ids = null,
    Object? address = null,
    Object? ex = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as SampleId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ids: null == ids
          ? _value.ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<int>,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as int,
      ex: null == ex
          ? _value.ex
          : ex // ignore: cast_nullable_to_non_nullable
              as ExampleModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ExampleModelCopyWith<$Res> get ex {
    return $ExampleModelCopyWith<$Res>(_value.ex, (value) {
      return _then(_value.copyWith(ex: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UpdateSampleParamImplCopyWith<$Res>
    implements $UpdateSampleParamCopyWith<$Res> {
  factory _$$UpdateSampleParamImplCopyWith(_$UpdateSampleParamImpl value,
          $Res Function(_$UpdateSampleParamImpl) then) =
      __$$UpdateSampleParamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") SampleId id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "updatedAt") DateTime updatedAt,
      @JsonKey(name: "ids") List<int> ids,
      @JsonKey(name: "address") int address,
      @JoinedColumn(foreignKey: "example_id")
      @JsonKey(name: "ex")
      ExampleModel ex});

  @override
  $ExampleModelCopyWith<$Res> get ex;
}

/// @nodoc
class __$$UpdateSampleParamImplCopyWithImpl<$Res>
    extends _$UpdateSampleParamCopyWithImpl<$Res, _$UpdateSampleParamImpl>
    implements _$$UpdateSampleParamImplCopyWith<$Res> {
  __$$UpdateSampleParamImplCopyWithImpl(_$UpdateSampleParamImpl _value,
      $Res Function(_$UpdateSampleParamImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? updatedAt = null,
    Object? ids = null,
    Object? address = null,
    Object? ex = null,
  }) {
    return _then(_$UpdateSampleParamImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as SampleId,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ids: null == ids
          ? _value._ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<int>,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as int,
      ex: null == ex
          ? _value.ex
          : ex // ignore: cast_nullable_to_non_nullable
              as ExampleModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@TableModel("v_sample")
class _$UpdateSampleParamImpl extends _UpdateSampleParam {
  const _$UpdateSampleParamImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "name") required this.name,
      @JsonKey(name: "description") this.description,
      @JsonKey(name: "updatedAt") required this.updatedAt,
      @JsonKey(name: "ids") required final List<int> ids,
      @JsonKey(name: "address") required this.address,
      @JoinedColumn(foreignKey: "example_id")
      @JsonKey(name: "ex")
      required this.ex})
      : _ids = ids,
        super._();

  factory _$UpdateSampleParamImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateSampleParamImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final SampleId id;
  @override
  @JsonKey(name: "name")
  final String name;
  @override
  @JsonKey(name: "description")
  final String? description;
  @override
  @JsonKey(name: "updatedAt")
  final DateTime updatedAt;
  final List<int> _ids;
  @override
  @JsonKey(name: "ids")
  List<int> get ids {
    if (_ids is EqualUnmodifiableListView) return _ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ids);
  }

  @override
  @JsonKey(name: "address")
  final int address;
  @override
  @JoinedColumn(foreignKey: "example_id")
  @JsonKey(name: "ex")
  final ExampleModel ex;

  @override
  String toString() {
    return 'UpdateSampleParam(id: $id, name: $name, description: $description, updatedAt: $updatedAt, ids: $ids, address: $address, ex: $ex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateSampleParamImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._ids, _ids) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.ex, ex) || other.ex == ex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, updatedAt,
      const DeepCollectionEquality().hash(_ids), address, ex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateSampleParamImplCopyWith<_$UpdateSampleParamImpl> get copyWith =>
      __$$UpdateSampleParamImplCopyWithImpl<_$UpdateSampleParamImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateSampleParamImplToJson(
      this,
    );
  }
}

abstract class _UpdateSampleParam extends UpdateSampleParam {
  const factory _UpdateSampleParam(
      {@JsonKey(name: "id") required final SampleId id,
      @JsonKey(name: "name") required final String name,
      @JsonKey(name: "description") final String? description,
      @JsonKey(name: "updatedAt") required final DateTime updatedAt,
      @JsonKey(name: "ids") required final List<int> ids,
      @JsonKey(name: "address") required final int address,
      @JoinedColumn(foreignKey: "example_id")
      @JsonKey(name: "ex")
      required final ExampleModel ex}) = _$UpdateSampleParamImpl;
  const _UpdateSampleParam._() : super._();

  factory _UpdateSampleParam.fromJson(Map<String, dynamic> json) =
      _$UpdateSampleParamImpl.fromJson;

  @override
  @JsonKey(name: "id")
  SampleId get id;
  @override
  @JsonKey(name: "name")
  String get name;
  @override
  @JsonKey(name: "description")
  String? get description;
  @override
  @JsonKey(name: "updatedAt")
  DateTime get updatedAt;
  @override
  @JsonKey(name: "ids")
  List<int> get ids;
  @override
  @JsonKey(name: "address")
  int get address;
  @override
  @JoinedColumn(foreignKey: "example_id")
  @JsonKey(name: "ex")
  ExampleModel get ex;
  @override
  @JsonKey(ignore: true)
  _$$UpdateSampleParamImplCopyWith<_$UpdateSampleParamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
