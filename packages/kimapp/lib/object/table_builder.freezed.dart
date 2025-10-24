// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table_builder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TableBuilder {
  String get tableName;
  List<ColumnBuilder> get columns;

  /// Create a copy of TableBuilder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TableBuilderCopyWith<TableBuilder> get copyWith =>
      _$TableBuilderCopyWithImpl<TableBuilder>(
          this as TableBuilder, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TableBuilder &&
            (identical(other.tableName, tableName) ||
                other.tableName == tableName) &&
            const DeepCollectionEquality().equals(other.columns, columns));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, tableName, const DeepCollectionEquality().hash(columns));

  @override
  String toString() {
    return 'TableBuilder(tableName: $tableName, columns: $columns)';
  }
}

/// @nodoc
abstract mixin class $TableBuilderCopyWith<$Res> {
  factory $TableBuilderCopyWith(
          TableBuilder value, $Res Function(TableBuilder) _then) =
      _$TableBuilderCopyWithImpl;
  @useResult
  $Res call({String tableName, List<ColumnBuilder> columns});
}

/// @nodoc
class _$TableBuilderCopyWithImpl<$Res> implements $TableBuilderCopyWith<$Res> {
  _$TableBuilderCopyWithImpl(this._self, this._then);

  final TableBuilder _self;
  final $Res Function(TableBuilder) _then;

  /// Create a copy of TableBuilder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tableName = null,
    Object? columns = null,
  }) {
    return _then(_self.copyWith(
      tableName: null == tableName
          ? _self.tableName
          : tableName // ignore: cast_nullable_to_non_nullable
              as String,
      columns: null == columns
          ? _self.columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<ColumnBuilder>,
    ));
  }
}

/// Adds pattern-matching-related methods to [TableBuilder].
extension TableBuilderPatterns on TableBuilder {
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
    TResult Function(_TableBuilder value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TableBuilder() when $default != null:
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
    TResult Function(_TableBuilder value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TableBuilder():
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
    TResult? Function(_TableBuilder value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TableBuilder() when $default != null:
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
    TResult Function(String tableName, List<ColumnBuilder> columns)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TableBuilder() when $default != null:
        return $default(_that.tableName, _that.columns);
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
    TResult Function(String tableName, List<ColumnBuilder> columns) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TableBuilder():
        return $default(_that.tableName, _that.columns);
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
    TResult? Function(String tableName, List<ColumnBuilder> columns)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TableBuilder() when $default != null:
        return $default(_that.tableName, _that.columns);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _TableBuilder extends TableBuilder {
  const _TableBuilder(
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

  /// Create a copy of TableBuilder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TableBuilderCopyWith<_TableBuilder> get copyWith =>
      __$TableBuilderCopyWithImpl<_TableBuilder>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TableBuilder &&
            (identical(other.tableName, tableName) ||
                other.tableName == tableName) &&
            const DeepCollectionEquality().equals(other._columns, _columns));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, tableName, const DeepCollectionEquality().hash(_columns));

  @override
  String toString() {
    return 'TableBuilder(tableName: $tableName, columns: $columns)';
  }
}

/// @nodoc
abstract mixin class _$TableBuilderCopyWith<$Res>
    implements $TableBuilderCopyWith<$Res> {
  factory _$TableBuilderCopyWith(
          _TableBuilder value, $Res Function(_TableBuilder) _then) =
      __$TableBuilderCopyWithImpl;
  @override
  @useResult
  $Res call({String tableName, List<ColumnBuilder> columns});
}

/// @nodoc
class __$TableBuilderCopyWithImpl<$Res>
    implements _$TableBuilderCopyWith<$Res> {
  __$TableBuilderCopyWithImpl(this._self, this._then);

  final _TableBuilder _self;
  final $Res Function(_TableBuilder) _then;

  /// Create a copy of TableBuilder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tableName = null,
    Object? columns = null,
  }) {
    return _then(_TableBuilder(
      tableName: null == tableName
          ? _self.tableName
          : tableName // ignore: cast_nullable_to_non_nullable
              as String,
      columns: null == columns
          ? _self._columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<ColumnBuilder>,
    ));
  }
}

/// @nodoc
mixin _$ColumnBuilder {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ColumnBuilder);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ColumnBuilder()';
  }
}

/// @nodoc
class $ColumnBuilderCopyWith<$Res> {
  $ColumnBuilderCopyWith(ColumnBuilder _, $Res Function(ColumnBuilder) __);
}

/// Adds pattern-matching-related methods to [ColumnBuilder].
extension ColumnBuilderPatterns on ColumnBuilder {
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
    TResult Function(_ColumnBuilder value)? $default, {
    TResult Function(_Join value)? join,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ColumnBuilder() when $default != null:
        return $default(_that);
      case _Join() when join != null:
        return join(_that);
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
    TResult Function(_ColumnBuilder value) $default, {
    required TResult Function(_Join value) join,
  }) {
    final _that = this;
    switch (_that) {
      case _ColumnBuilder():
        return $default(_that);
      case _Join():
        return join(_that);
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
    TResult? Function(_ColumnBuilder value)? $default, {
    TResult? Function(_Join value)? join,
  }) {
    final _that = this;
    switch (_that) {
      case _ColumnBuilder() when $default != null:
        return $default(_that);
      case _Join() when join != null:
        return join(_that);
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
    TResult Function(String column)? $default, {
    TResult Function(TableBuilder table, String? key, String? foreignKey,
            String? candidateKey)?
        join,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ColumnBuilder() when $default != null:
        return $default(_that.column);
      case _Join() when join != null:
        return join(
            _that.table, _that.key, _that.foreignKey, _that.candidateKey);
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
    TResult Function(String column) $default, {
    required TResult Function(TableBuilder table, String? key,
            String? foreignKey, String? candidateKey)
        join,
  }) {
    final _that = this;
    switch (_that) {
      case _ColumnBuilder():
        return $default(_that.column);
      case _Join():
        return join(
            _that.table, _that.key, _that.foreignKey, _that.candidateKey);
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
    TResult? Function(String column)? $default, {
    TResult? Function(TableBuilder table, String? key, String? foreignKey,
            String? candidateKey)?
        join,
  }) {
    final _that = this;
    switch (_that) {
      case _ColumnBuilder() when $default != null:
        return $default(_that.column);
      case _Join() when join != null:
        return join(
            _that.table, _that.key, _that.foreignKey, _that.candidateKey);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ColumnBuilder extends ColumnBuilder {
  const _ColumnBuilder(this.column) : super._();

  final String column;

  /// Create a copy of ColumnBuilder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ColumnBuilderCopyWith<_ColumnBuilder> get copyWith =>
      __$ColumnBuilderCopyWithImpl<_ColumnBuilder>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ColumnBuilder &&
            (identical(other.column, column) || other.column == column));
  }

  @override
  int get hashCode => Object.hash(runtimeType, column);

  @override
  String toString() {
    return 'ColumnBuilder(column: $column)';
  }
}

/// @nodoc
abstract mixin class _$ColumnBuilderCopyWith<$Res>
    implements $ColumnBuilderCopyWith<$Res> {
  factory _$ColumnBuilderCopyWith(
          _ColumnBuilder value, $Res Function(_ColumnBuilder) _then) =
      __$ColumnBuilderCopyWithImpl;
  @useResult
  $Res call({String column});
}

/// @nodoc
class __$ColumnBuilderCopyWithImpl<$Res>
    implements _$ColumnBuilderCopyWith<$Res> {
  __$ColumnBuilderCopyWithImpl(this._self, this._then);

  final _ColumnBuilder _self;
  final $Res Function(_ColumnBuilder) _then;

  /// Create a copy of ColumnBuilder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? column = null,
  }) {
    return _then(_ColumnBuilder(
      null == column
          ? _self.column
          : column // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _Join extends ColumnBuilder {
  const _Join(this.table, {this.key, this.foreignKey, this.candidateKey})
      : super._();

  final TableBuilder table;
  final String? key;
  final String? foreignKey;
  final String? candidateKey;

  /// Create a copy of ColumnBuilder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$JoinCopyWith<_Join> get copyWith =>
      __$JoinCopyWithImpl<_Join>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Join &&
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

  @override
  String toString() {
    return 'ColumnBuilder.join(table: $table, key: $key, foreignKey: $foreignKey, candidateKey: $candidateKey)';
  }
}

/// @nodoc
abstract mixin class _$JoinCopyWith<$Res>
    implements $ColumnBuilderCopyWith<$Res> {
  factory _$JoinCopyWith(_Join value, $Res Function(_Join) _then) =
      __$JoinCopyWithImpl;
  @useResult
  $Res call(
      {TableBuilder table,
      String? key,
      String? foreignKey,
      String? candidateKey});

  $TableBuilderCopyWith<$Res> get table;
}

/// @nodoc
class __$JoinCopyWithImpl<$Res> implements _$JoinCopyWith<$Res> {
  __$JoinCopyWithImpl(this._self, this._then);

  final _Join _self;
  final $Res Function(_Join) _then;

  /// Create a copy of ColumnBuilder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? table = null,
    Object? key = freezed,
    Object? foreignKey = freezed,
    Object? candidateKey = freezed,
  }) {
    return _then(_Join(
      null == table
          ? _self.table
          : table // ignore: cast_nullable_to_non_nullable
              as TableBuilder,
      key: freezed == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      foreignKey: freezed == foreignKey
          ? _self.foreignKey
          : foreignKey // ignore: cast_nullable_to_non_nullable
              as String?,
      candidateKey: freezed == candidateKey
          ? _self.candidateKey
          : candidateKey // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of ColumnBuilder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TableBuilderCopyWith<$Res> get table {
    return $TableBuilderCopyWith<$Res>(_self.table, (value) {
      return _then(_self.copyWith(table: value));
    });
  }
}

// dart format on
