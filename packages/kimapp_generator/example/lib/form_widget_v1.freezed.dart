// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_widget_v1.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FormWidgetExampleState {
  String get name;
  ProviderStatus<bool> get status;

  /// Create a copy of FormWidgetExampleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FormWidgetExampleStateCopyWith<FormWidgetExampleState> get copyWith =>
      _$FormWidgetExampleStateCopyWithImpl<FormWidgetExampleState>(
          this as FormWidgetExampleState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FormWidgetExampleState &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, status);

  @override
  String toString() {
    return 'FormWidgetExampleState(name: $name, status: $status)';
  }
}

/// @nodoc
abstract mixin class $FormWidgetExampleStateCopyWith<$Res> {
  factory $FormWidgetExampleStateCopyWith(FormWidgetExampleState value,
          $Res Function(FormWidgetExampleState) _then) =
      _$FormWidgetExampleStateCopyWithImpl;
  @useResult
  $Res call({String name, ProviderStatus<bool> status});

  $ProviderStatusCopyWith<bool, $Res> get status;
}

/// @nodoc
class _$FormWidgetExampleStateCopyWithImpl<$Res>
    implements $FormWidgetExampleStateCopyWith<$Res> {
  _$FormWidgetExampleStateCopyWithImpl(this._self, this._then);

  final FormWidgetExampleState _self;
  final $Res Function(FormWidgetExampleState) _then;

  /// Create a copy of FormWidgetExampleState
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
              as ProviderStatus<bool>,
    ));
  }

  /// Create a copy of FormWidgetExampleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProviderStatusCopyWith<bool, $Res> get status {
    return $ProviderStatusCopyWith<bool, $Res>(_self.status, (value) {
      return _then(_self.copyWith(status: value));
    });
  }
}

/// Adds pattern-matching-related methods to [FormWidgetExampleState].
extension FormWidgetExampleStatePatterns on FormWidgetExampleState {
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
    TResult Function(_FormWidgetExampleState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FormWidgetExampleState() when $default != null:
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
    TResult Function(_FormWidgetExampleState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FormWidgetExampleState():
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
    TResult? Function(_FormWidgetExampleState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FormWidgetExampleState() when $default != null:
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
    TResult Function(String name, ProviderStatus<bool> status)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FormWidgetExampleState() when $default != null:
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
    TResult Function(String name, ProviderStatus<bool> status) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FormWidgetExampleState():
        return $default(_that.name, _that.status);
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
    TResult? Function(String name, ProviderStatus<bool> status)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FormWidgetExampleState() when $default != null:
        return $default(_that.name, _that.status);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _FormWidgetExampleState extends FormWidgetExampleState {
  const _FormWidgetExampleState(
      {required this.name, this.status = const ProviderStatus.initial()})
      : super._();

  @override
  final String name;
  @override
  @JsonKey()
  final ProviderStatus<bool> status;

  /// Create a copy of FormWidgetExampleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FormWidgetExampleStateCopyWith<_FormWidgetExampleState> get copyWith =>
      __$FormWidgetExampleStateCopyWithImpl<_FormWidgetExampleState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FormWidgetExampleState &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, status);

  @override
  String toString() {
    return 'FormWidgetExampleState(name: $name, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$FormWidgetExampleStateCopyWith<$Res>
    implements $FormWidgetExampleStateCopyWith<$Res> {
  factory _$FormWidgetExampleStateCopyWith(_FormWidgetExampleState value,
          $Res Function(_FormWidgetExampleState) _then) =
      __$FormWidgetExampleStateCopyWithImpl;
  @override
  @useResult
  $Res call({String name, ProviderStatus<bool> status});

  @override
  $ProviderStatusCopyWith<bool, $Res> get status;
}

/// @nodoc
class __$FormWidgetExampleStateCopyWithImpl<$Res>
    implements _$FormWidgetExampleStateCopyWith<$Res> {
  __$FormWidgetExampleStateCopyWithImpl(this._self, this._then);

  final _FormWidgetExampleState _self;
  final $Res Function(_FormWidgetExampleState) _then;

  /// Create a copy of FormWidgetExampleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? status = null,
  }) {
    return _then(_FormWidgetExampleState(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProviderStatus<bool>,
    ));
  }

  /// Create a copy of FormWidgetExampleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProviderStatusCopyWith<bool, $Res> get status {
    return $ProviderStatusCopyWith<bool, $Res>(_self.status, (value) {
      return _then(_self.copyWith(status: value));
    });
  }
}

// dart format on
