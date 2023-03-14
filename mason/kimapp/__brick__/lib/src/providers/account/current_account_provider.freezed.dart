// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_account_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CurrentAccountState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(AuthUserId authUserId) $default, {
    required TResult Function() none,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(AuthUserId authUserId)? $default, {
    TResult? Function()? none,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(AuthUserId authUserId)? $default, {
    TResult Function()? none,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(CurrentAccountStateData value) $default, {
    required TResult Function(_None value) none,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(CurrentAccountStateData value)? $default, {
    TResult? Function(_None value)? none,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(CurrentAccountStateData value)? $default, {
    TResult Function(_None value)? none,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentAccountStateCopyWith<$Res> {
  factory $CurrentAccountStateCopyWith(
          CurrentAccountState value, $Res Function(CurrentAccountState) then) =
      _$CurrentAccountStateCopyWithImpl<$Res, CurrentAccountState>;
}

/// @nodoc
class _$CurrentAccountStateCopyWithImpl<$Res, $Val extends CurrentAccountState>
    implements $CurrentAccountStateCopyWith<$Res> {
  _$CurrentAccountStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_NoneCopyWith<$Res> {
  factory _$$_NoneCopyWith(_$_None value, $Res Function(_$_None) then) =
      __$$_NoneCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_NoneCopyWithImpl<$Res>
    extends _$CurrentAccountStateCopyWithImpl<$Res, _$_None>
    implements _$$_NoneCopyWith<$Res> {
  __$$_NoneCopyWithImpl(_$_None _value, $Res Function(_$_None) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_None extends _None {
  const _$_None() : super._();

  @override
  String toString() {
    return 'CurrentAccountState.none()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_None);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(AuthUserId authUserId) $default, {
    required TResult Function() none,
  }) {
    return none();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(AuthUserId authUserId)? $default, {
    TResult? Function()? none,
  }) {
    return none?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(AuthUserId authUserId)? $default, {
    TResult Function()? none,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(CurrentAccountStateData value) $default, {
    required TResult Function(_None value) none,
  }) {
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(CurrentAccountStateData value)? $default, {
    TResult? Function(_None value)? none,
  }) {
    return none?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(CurrentAccountStateData value)? $default, {
    TResult Function(_None value)? none,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class _None extends CurrentAccountState {
  const factory _None() = _$_None;
  const _None._() : super._();
}

/// @nodoc
abstract class _$$CurrentAccountStateDataCopyWith<$Res> {
  factory _$$CurrentAccountStateDataCopyWith(_$CurrentAccountStateData value,
          $Res Function(_$CurrentAccountStateData) then) =
      __$$CurrentAccountStateDataCopyWithImpl<$Res>;
  @useResult
  $Res call({AuthUserId authUserId});
}

/// @nodoc
class __$$CurrentAccountStateDataCopyWithImpl<$Res>
    extends _$CurrentAccountStateCopyWithImpl<$Res, _$CurrentAccountStateData>
    implements _$$CurrentAccountStateDataCopyWith<$Res> {
  __$$CurrentAccountStateDataCopyWithImpl(_$CurrentAccountStateData _value,
      $Res Function(_$CurrentAccountStateData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authUserId = null,
  }) {
    return _then(_$CurrentAccountStateData(
      authUserId: null == authUserId
          ? _value.authUserId
          : authUserId // ignore: cast_nullable_to_non_nullable
              as AuthUserId,
    ));
  }
}

/// @nodoc

class _$CurrentAccountStateData extends CurrentAccountStateData {
  const _$CurrentAccountStateData({required this.authUserId}) : super._();

// Implement more information as need.
//
// Eg UserInfo, Role, Permission...
//
  @override
  final AuthUserId authUserId;

  @override
  String toString() {
    return 'CurrentAccountState(authUserId: $authUserId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrentAccountStateData &&
            (identical(other.authUserId, authUserId) ||
                other.authUserId == authUserId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, authUserId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrentAccountStateDataCopyWith<_$CurrentAccountStateData> get copyWith =>
      __$$CurrentAccountStateDataCopyWithImpl<_$CurrentAccountStateData>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(AuthUserId authUserId) $default, {
    required TResult Function() none,
  }) {
    return $default(authUserId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(AuthUserId authUserId)? $default, {
    TResult? Function()? none,
  }) {
    return $default?.call(authUserId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(AuthUserId authUserId)? $default, {
    TResult Function()? none,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(authUserId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(CurrentAccountStateData value) $default, {
    required TResult Function(_None value) none,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(CurrentAccountStateData value)? $default, {
    TResult? Function(_None value)? none,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(CurrentAccountStateData value)? $default, {
    TResult Function(_None value)? none,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class CurrentAccountStateData extends CurrentAccountState {
  const factory CurrentAccountStateData(
      {required final AuthUserId authUserId}) = _$CurrentAccountStateData;
  const CurrentAccountStateData._() : super._();

// Implement more information as need.
//
// Eg UserInfo, Role, Permission...
//
  AuthUserId get authUserId;
  @JsonKey(ignore: true)
  _$$CurrentAccountStateDataCopyWith<_$CurrentAccountStateData> get copyWith =>
      throw _privateConstructorUsedError;
}
