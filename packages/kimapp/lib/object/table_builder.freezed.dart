// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table_builder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TableBuilder {
  String get tableName => throw _privateConstructorUsedError;
  List<ColumnBuilder> get columns => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TableBuilderCopyWith<TableBuilder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TableBuilderCopyWith<$Res> {
  factory $TableBuilderCopyWith(
          TableBuilder value, $Res Function(TableBuilder) then) =
      _$TableBuilderCopyWithImpl<$Res, TableBuilder>;
  @useResult
  $Res call({String tableName, List<ColumnBuilder> columns});
}

/// @nodoc
class _$TableBuilderCopyWithImpl<$Res, $Val extends TableBuilder>
    implements $TableBuilderCopyWith<$Res> {
  _$TableBuilderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tableName = null,
    Object? columns = null,
  }) {
    return _then(_value.copyWith(
      tableName: null == tableName
          ? _value.tableName
          : tableName // ignore: cast_nullable_to_non_nullable
              as String,
      columns: null == columns
          ? _value.columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<ColumnBuilder>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TableBuilderCopyWith<$Res>
    implements $TableBuilderCopyWith<$Res> {
  factory _$$_TableBuilderCopyWith(
          _$_TableBuilder value, $Res Function(_$_TableBuilder) then) =
      __$$_TableBuilderCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String tableName, List<ColumnBuilder> columns});
}

/// @nodoc
class __$$_TableBuilderCopyWithImpl<$Res>
    extends _$TableBuilderCopyWithImpl<$Res, _$_TableBuilder>
    implements _$$_TableBuilderCopyWith<$Res> {
  __$$_TableBuilderCopyWithImpl(
      _$_TableBuilder _value, $Res Function(_$_TableBuilder) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tableName = null,
    Object? columns = null,
  }) {
    return _then(_$_TableBuilder(
      tableName: null == tableName
          ? _value.tableName
          : tableName // ignore: cast_nullable_to_non_nullable
              as String,
      columns: null == columns
          ? _value._columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<ColumnBuilder>,
    ));
  }
}

/// @nodoc

class _$_TableBuilder extends _TableBuilder {
  const _$_TableBuilder(
      {required this.tableName, required final List<ColumnBuilder> columns})
      : _columns = columns,
        super._();

  @override
  final String tableName;
  final List<ColumnBuilder> _columns;
  @override
  List<ColumnBuilder> get columns {
    if (_columns is EqualUnmodifiableListView) return _columns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_columns);
  }

  @override
  String toString() {
    return 'TableBuilder(tableName: $tableName, columns: $columns)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TableBuilder &&
            (identical(other.tableName, tableName) ||
                other.tableName == tableName) &&
            const DeepCollectionEquality().equals(other._columns, _columns));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, tableName, const DeepCollectionEquality().hash(_columns));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TableBuilderCopyWith<_$_TableBuilder> get copyWith =>
      __$$_TableBuilderCopyWithImpl<_$_TableBuilder>(this, _$identity);
}

abstract class _TableBuilder extends TableBuilder {
  const factory _TableBuilder(
      {required final String tableName,
      required final List<ColumnBuilder> columns}) = _$_TableBuilder;
  const _TableBuilder._() : super._();

  @override
  String get tableName;
  @override
  List<ColumnBuilder> get columns;
  @override
  @JsonKey(ignore: true)
  _$$_TableBuilderCopyWith<_$_TableBuilder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ColumnBuilder {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String column) $default, {
    required TResult Function(TableBuilder table, String? key,
            String? foreignKey, String? candidateKey)
        join,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String column)? $default, {
    TResult? Function(TableBuilder table, String? key, String? foreignKey,
            String? candidateKey)?
        join,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String column)? $default, {
    TResult Function(TableBuilder table, String? key, String? foreignKey,
            String? candidateKey)?
        join,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ColumnBuilder value) $default, {
    required TResult Function(_Join value) join,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ColumnBuilder value)? $default, {
    TResult? Function(_Join value)? join,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ColumnBuilder value)? $default, {
    TResult Function(_Join value)? join,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ColumnBuilderCopyWith<$Res> {
  factory $ColumnBuilderCopyWith(
          ColumnBuilder value, $Res Function(ColumnBuilder) then) =
      _$ColumnBuilderCopyWithImpl<$Res, ColumnBuilder>;
}

/// @nodoc
class _$ColumnBuilderCopyWithImpl<$Res, $Val extends ColumnBuilder>
    implements $ColumnBuilderCopyWith<$Res> {
  _$ColumnBuilderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_ColumnBuilderCopyWith<$Res> {
  factory _$$_ColumnBuilderCopyWith(
          _$_ColumnBuilder value, $Res Function(_$_ColumnBuilder) then) =
      __$$_ColumnBuilderCopyWithImpl<$Res>;
  @useResult
  $Res call({String column});
}

/// @nodoc
class __$$_ColumnBuilderCopyWithImpl<$Res>
    extends _$ColumnBuilderCopyWithImpl<$Res, _$_ColumnBuilder>
    implements _$$_ColumnBuilderCopyWith<$Res> {
  __$$_ColumnBuilderCopyWithImpl(
      _$_ColumnBuilder _value, $Res Function(_$_ColumnBuilder) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? column = null,
  }) {
    return _then(_$_ColumnBuilder(
      null == column
          ? _value.column
          : column // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ColumnBuilder extends _ColumnBuilder {
  const _$_ColumnBuilder(this.column) : super._();

  @override
  final String column;

  @override
  String toString() {
    return 'ColumnBuilder(column: $column)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ColumnBuilder &&
            (identical(other.column, column) || other.column == column));
  }

  @override
  int get hashCode => Object.hash(runtimeType, column);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ColumnBuilderCopyWith<_$_ColumnBuilder> get copyWith =>
      __$$_ColumnBuilderCopyWithImpl<_$_ColumnBuilder>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String column) $default, {
    required TResult Function(TableBuilder table, String? key,
            String? foreignKey, String? candidateKey)
        join,
  }) {
    return $default(column);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String column)? $default, {
    TResult? Function(TableBuilder table, String? key, String? foreignKey,
            String? candidateKey)?
        join,
  }) {
    return $default?.call(column);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String column)? $default, {
    TResult Function(TableBuilder table, String? key, String? foreignKey,
            String? candidateKey)?
        join,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(column);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ColumnBuilder value) $default, {
    required TResult Function(_Join value) join,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ColumnBuilder value)? $default, {
    TResult? Function(_Join value)? join,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ColumnBuilder value)? $default, {
    TResult Function(_Join value)? join,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _ColumnBuilder extends ColumnBuilder {
  const factory _ColumnBuilder(final String column) = _$_ColumnBuilder;
  const _ColumnBuilder._() : super._();

  String get column;
  @JsonKey(ignore: true)
  _$$_ColumnBuilderCopyWith<_$_ColumnBuilder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_JoinCopyWith<$Res> {
  factory _$$_JoinCopyWith(_$_Join value, $Res Function(_$_Join) then) =
      __$$_JoinCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {TableBuilder table,
      String? key,
      String? foreignKey,
      String? candidateKey});

  $TableBuilderCopyWith<$Res> get table;
}

/// @nodoc
class __$$_JoinCopyWithImpl<$Res>
    extends _$ColumnBuilderCopyWithImpl<$Res, _$_Join>
    implements _$$_JoinCopyWith<$Res> {
  __$$_JoinCopyWithImpl(_$_Join _value, $Res Function(_$_Join) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? table = null,
    Object? key = freezed,
    Object? foreignKey = freezed,
    Object? candidateKey = freezed,
  }) {
    return _then(_$_Join(
      null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as TableBuilder,
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      foreignKey: freezed == foreignKey
          ? _value.foreignKey
          : foreignKey // ignore: cast_nullable_to_non_nullable
              as String?,
      candidateKey: freezed == candidateKey
          ? _value.candidateKey
          : candidateKey // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $TableBuilderCopyWith<$Res> get table {
    return $TableBuilderCopyWith<$Res>(_value.table, (value) {
      return _then(_value.copyWith(table: value));
    });
  }
}

/// @nodoc

class _$_Join extends _Join {
  const _$_Join(this.table, {this.key, this.foreignKey, this.candidateKey})
      : super._();

  @override
  final TableBuilder table;
  @override
  final String? key;
  @override
  final String? foreignKey;
  @override
  final String? candidateKey;

  @override
  String toString() {
    return 'ColumnBuilder.join(table: $table, key: $key, foreignKey: $foreignKey, candidateKey: $candidateKey)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Join &&
            (identical(other.table, table) || other.table == table) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.foreignKey, foreignKey) ||
                other.foreignKey == foreignKey) &&
            (identical(other.candidateKey, candidateKey) ||
                other.candidateKey == candidateKey));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, table, key, foreignKey, candidateKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JoinCopyWith<_$_Join> get copyWith =>
      __$$_JoinCopyWithImpl<_$_Join>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String column) $default, {
    required TResult Function(TableBuilder table, String? key,
            String? foreignKey, String? candidateKey)
        join,
  }) {
    return join(table, key, foreignKey, candidateKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String column)? $default, {
    TResult? Function(TableBuilder table, String? key, String? foreignKey,
            String? candidateKey)?
        join,
  }) {
    return join?.call(table, key, foreignKey, candidateKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String column)? $default, {
    TResult Function(TableBuilder table, String? key, String? foreignKey,
            String? candidateKey)?
        join,
    required TResult orElse(),
  }) {
    if (join != null) {
      return join(table, key, foreignKey, candidateKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ColumnBuilder value) $default, {
    required TResult Function(_Join value) join,
  }) {
    return join(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ColumnBuilder value)? $default, {
    TResult? Function(_Join value)? join,
  }) {
    return join?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ColumnBuilder value)? $default, {
    TResult Function(_Join value)? join,
    required TResult orElse(),
  }) {
    if (join != null) {
      return join(this);
    }
    return orElse();
  }
}

abstract class _Join extends ColumnBuilder {
  const factory _Join(final TableBuilder table,
      {final String? key,
      final String? foreignKey,
      final String? candidateKey}) = _$_Join;
  const _Join._() : super._();

  TableBuilder get table;
  String? get key;
  String? get foreignKey;
  String? get candidateKey;
  @JsonKey(ignore: true)
  _$$_JoinCopyWith<_$_Join> get copyWith => throw _privateConstructorUsedError;
}
