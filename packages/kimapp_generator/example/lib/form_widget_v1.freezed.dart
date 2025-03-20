// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
