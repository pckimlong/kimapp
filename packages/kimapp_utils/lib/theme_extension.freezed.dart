// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_extension.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$KimappThemeExtension {
  /// Provide a default loading for @stateWidget to display when no loading widget is provided
  Widget Function(BuildContext, WidgetRef)? get defaultLoadingStateWidget =>
      throw _privateConstructorUsedError;

  /// Provide a default error for @stateWidget to display when no error widget is provided
  Widget Function(BuildContext, WidgetRef, Object)?
      get defaultErrorStateWidget => throw _privateConstructorUsedError;

  /// Create a copy of KimappThemeExtension
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KimappThemeExtensionCopyWith<KimappThemeExtension> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KimappThemeExtensionCopyWith<$Res> {
  factory $KimappThemeExtensionCopyWith(KimappThemeExtension value,
          $Res Function(KimappThemeExtension) then) =
      _$KimappThemeExtensionCopyWithImpl<$Res, KimappThemeExtension>;
  @useResult
  $Res call(
      {Widget Function(BuildContext, WidgetRef)? defaultLoadingStateWidget,
      Widget Function(BuildContext, WidgetRef, Object)?
          defaultErrorStateWidget});
}

/// @nodoc
class _$KimappThemeExtensionCopyWithImpl<$Res,
        $Val extends KimappThemeExtension>
    implements $KimappThemeExtensionCopyWith<$Res> {
  _$KimappThemeExtensionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KimappThemeExtension
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultLoadingStateWidget = freezed,
    Object? defaultErrorStateWidget = freezed,
  }) {
    return _then(_value.copyWith(
      defaultLoadingStateWidget: freezed == defaultLoadingStateWidget
          ? _value.defaultLoadingStateWidget
          : defaultLoadingStateWidget // ignore: cast_nullable_to_non_nullable
              as Widget Function(BuildContext, WidgetRef)?,
      defaultErrorStateWidget: freezed == defaultErrorStateWidget
          ? _value.defaultErrorStateWidget
          : defaultErrorStateWidget // ignore: cast_nullable_to_non_nullable
              as Widget Function(BuildContext, WidgetRef, Object)?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KimappThemeExtensionImplCopyWith<$Res>
    implements $KimappThemeExtensionCopyWith<$Res> {
  factory _$$KimappThemeExtensionImplCopyWith(_$KimappThemeExtensionImpl value,
          $Res Function(_$KimappThemeExtensionImpl) then) =
      __$$KimappThemeExtensionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Widget Function(BuildContext, WidgetRef)? defaultLoadingStateWidget,
      Widget Function(BuildContext, WidgetRef, Object)?
          defaultErrorStateWidget});
}

/// @nodoc
class __$$KimappThemeExtensionImplCopyWithImpl<$Res>
    extends _$KimappThemeExtensionCopyWithImpl<$Res, _$KimappThemeExtensionImpl>
    implements _$$KimappThemeExtensionImplCopyWith<$Res> {
  __$$KimappThemeExtensionImplCopyWithImpl(_$KimappThemeExtensionImpl _value,
      $Res Function(_$KimappThemeExtensionImpl) _then)
      : super(_value, _then);

  /// Create a copy of KimappThemeExtension
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultLoadingStateWidget = freezed,
    Object? defaultErrorStateWidget = freezed,
  }) {
    return _then(_$KimappThemeExtensionImpl(
      defaultLoadingStateWidget: freezed == defaultLoadingStateWidget
          ? _value.defaultLoadingStateWidget
          : defaultLoadingStateWidget // ignore: cast_nullable_to_non_nullable
              as Widget Function(BuildContext, WidgetRef)?,
      defaultErrorStateWidget: freezed == defaultErrorStateWidget
          ? _value.defaultErrorStateWidget
          : defaultErrorStateWidget // ignore: cast_nullable_to_non_nullable
              as Widget Function(BuildContext, WidgetRef, Object)?,
    ));
  }
}

/// @nodoc

class _$KimappThemeExtensionImpl extends _KimappThemeExtension {
  const _$KimappThemeExtensionImpl(
      {this.defaultLoadingStateWidget, this.defaultErrorStateWidget})
      : super._();

  /// Provide a default loading for @stateWidget to display when no loading widget is provided
  @override
  final Widget Function(BuildContext, WidgetRef)? defaultLoadingStateWidget;

  /// Provide a default error for @stateWidget to display when no error widget is provided
  @override
  final Widget Function(BuildContext, WidgetRef, Object)?
      defaultErrorStateWidget;

  @override
  String toString() {
    return 'KimappThemeExtension(defaultLoadingStateWidget: $defaultLoadingStateWidget, defaultErrorStateWidget: $defaultErrorStateWidget)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KimappThemeExtensionImpl &&
            (identical(other.defaultLoadingStateWidget,
                    defaultLoadingStateWidget) ||
                other.defaultLoadingStateWidget == defaultLoadingStateWidget) &&
            (identical(
                    other.defaultErrorStateWidget, defaultErrorStateWidget) ||
                other.defaultErrorStateWidget == defaultErrorStateWidget));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, defaultLoadingStateWidget, defaultErrorStateWidget);

  /// Create a copy of KimappThemeExtension
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KimappThemeExtensionImplCopyWith<_$KimappThemeExtensionImpl>
      get copyWith =>
          __$$KimappThemeExtensionImplCopyWithImpl<_$KimappThemeExtensionImpl>(
              this, _$identity);
}

abstract class _KimappThemeExtension extends KimappThemeExtension {
  const factory _KimappThemeExtension(
      {final Widget Function(BuildContext, WidgetRef)?
          defaultLoadingStateWidget,
      final Widget Function(BuildContext, WidgetRef, Object)?
          defaultErrorStateWidget}) = _$KimappThemeExtensionImpl;
  const _KimappThemeExtension._() : super._();

  /// Provide a default loading for @stateWidget to display when no loading widget is provided
  @override
  Widget Function(BuildContext, WidgetRef)? get defaultLoadingStateWidget;

  /// Provide a default error for @stateWidget to display when no error widget is provided
  @override
  Widget Function(BuildContext, WidgetRef, Object)? get defaultErrorStateWidget;

  /// Create a copy of KimappThemeExtension
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KimappThemeExtensionImplCopyWith<_$KimappThemeExtensionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
