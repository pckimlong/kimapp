// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_widget_v2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductParam {
  String get name;
  ProviderStatus<void> get status;

  /// Create a copy of ProductParam
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProductParamCopyWith<ProductParam> get copyWith =>
      _$ProductParamCopyWithImpl<ProductParam>(
          this as ProductParam, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProductParam &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, status);

  @override
  String toString() {
    return 'ProductParam(name: $name, status: $status)';
  }
}

/// @nodoc
abstract mixin class $ProductParamCopyWith<$Res> {
  factory $ProductParamCopyWith(
          ProductParam value, $Res Function(ProductParam) _then) =
      _$ProductParamCopyWithImpl;
  @useResult
  $Res call({String name, ProviderStatus<void> status});

  $ProviderStatusCopyWith<void, $Res> get status;
}

/// @nodoc
class _$ProductParamCopyWithImpl<$Res> implements $ProductParamCopyWith<$Res> {
  _$ProductParamCopyWithImpl(this._self, this._then);

  final ProductParam _self;
  final $Res Function(ProductParam) _then;

  /// Create a copy of ProductParam
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? status = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProviderStatus<void>,
    ));
  }

  /// Create a copy of ProductParam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProviderStatusCopyWith<void, $Res> get status {
    return $ProviderStatusCopyWith<void, $Res>(_self.status, (value) {
      return _then(_self.copyWith(status: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ProductParam].
extension ProductParamPatterns on ProductParam {
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
    TResult Function(_ProductParam value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductParam() when $default != null:
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
    TResult Function(_ProductParam value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductParam():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(_ProductParam value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductParam() when $default != null:
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
    TResult Function(String name, ProviderStatus<void> status)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductParam() when $default != null:
        return $default(_that.name, _that.status);
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
    TResult Function(String name, ProviderStatus<void> status) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductParam():
        return $default(_that.name, _that.status);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(String name, ProviderStatus<void> status)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductParam() when $default != null:
        return $default(_that.name, _that.status);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ProductParam extends ProductParam {
  const _ProductParam(
      {required this.name, this.status = const ProviderStatus.initial()})
      : super._();

  @override
  final String name;
  @override
  @JsonKey()
  final ProviderStatus<void> status;

  /// Create a copy of ProductParam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProductParamCopyWith<_ProductParam> get copyWith =>
      __$ProductParamCopyWithImpl<_ProductParam>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProductParam &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, status);

  @override
  String toString() {
    return 'ProductParam(name: $name, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$ProductParamCopyWith<$Res>
    implements $ProductParamCopyWith<$Res> {
  factory _$ProductParamCopyWith(
          _ProductParam value, $Res Function(_ProductParam) _then) =
      __$ProductParamCopyWithImpl;
  @override
  @useResult
  $Res call({String name, ProviderStatus<void> status});

  @override
  $ProviderStatusCopyWith<void, $Res> get status;
}

/// @nodoc
class __$ProductParamCopyWithImpl<$Res>
    implements _$ProductParamCopyWith<$Res> {
  __$ProductParamCopyWithImpl(this._self, this._then);

  final _ProductParam _self;
  final $Res Function(_ProductParam) _then;

  /// Create a copy of ProductParam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? status = null,
  }) {
    return _then(_ProductParam(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProviderStatus<void>,
    ));
  }

  /// Create a copy of ProductParam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProviderStatusCopyWith<void, $Res> get status {
    return $ProviderStatusCopyWith<void, $Res>(_self.status, (value) {
      return _then(_self.copyWith(status: value));
    });
  }
}

// dart format on
