// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Failure {
  StackTrace get stackTrace => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StackTrace stackTrace, String? message) exception,
    required TResult Function(StackTrace stackTrace, String? message)
        noInternet,
    required TResult Function(StackTrace stackTrace, String? message)
        serverDown,
    required TResult Function(StackTrace stackTrace, String? message)
        incorrectLoginCredential,
    required TResult Function(StackTrace stackTrace, String? message)
        authException,
    required TResult Function(StackTrace stackTrace, String? message)
        databaseError,
    required TResult Function(StackTrace stackTrace, String? message) forbidden,
    required TResult Function(StackTrace stackTrace, String? message)
        uniqueConstraint,
    required TResult Function(StackTrace stackTrace, String? message) notFound,
    required TResult Function(StackTrace stackTrace, String? message)
        userAlreadyRegistered,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StackTrace stackTrace, String? message)? exception,
    TResult? Function(StackTrace stackTrace, String? message)? noInternet,
    TResult? Function(StackTrace stackTrace, String? message)? serverDown,
    TResult? Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult? Function(StackTrace stackTrace, String? message)? authException,
    TResult? Function(StackTrace stackTrace, String? message)? databaseError,
    TResult? Function(StackTrace stackTrace, String? message)? forbidden,
    TResult? Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult? Function(StackTrace stackTrace, String? message)? notFound,
    TResult? Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StackTrace stackTrace, String? message)? exception,
    TResult Function(StackTrace stackTrace, String? message)? noInternet,
    TResult Function(StackTrace stackTrace, String? message)? serverDown,
    TResult Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult Function(StackTrace stackTrace, String? message)? authException,
    TResult Function(StackTrace stackTrace, String? message)? databaseError,
    TResult Function(StackTrace stackTrace, String? message)? forbidden,
    TResult Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult Function(StackTrace stackTrace, String? message)? notFound,
    TResult Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExceptionFailure value) exception,
    required TResult Function(NoInternetFailure value) noInternet,
    required TResult Function(ServerDownFailure value) serverDown,
    required TResult Function(IncorrectLoginCredential value)
        incorrectLoginCredential,
    required TResult Function(AuthExceptionFailure value) authException,
    required TResult Function(DatabaseErrorFailure value) databaseError,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(UniqueConstraintFailure value) uniqueConstraint,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(_UserAlreadyRegistered value)
        userAlreadyRegistered,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExceptionFailure value)? exception,
    TResult? Function(NoInternetFailure value)? noInternet,
    TResult? Function(ServerDownFailure value)? serverDown,
    TResult? Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult? Function(AuthExceptionFailure value)? authException,
    TResult? Function(DatabaseErrorFailure value)? databaseError,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExceptionFailure value)? exception,
    TResult Function(NoInternetFailure value)? noInternet,
    TResult Function(ServerDownFailure value)? serverDown,
    TResult Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult Function(AuthExceptionFailure value)? authException,
    TResult Function(DatabaseErrorFailure value)? databaseError,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FailureCopyWith<Failure> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
  @useResult
  $Res call({StackTrace stackTrace, String? message});
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExceptionFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ExceptionFailureCopyWith(
          _$ExceptionFailure value, $Res Function(_$ExceptionFailure) then) =
      __$$ExceptionFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StackTrace stackTrace, String? message});
}

/// @nodoc
class __$$ExceptionFailureCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ExceptionFailure>
    implements _$$ExceptionFailureCopyWith<$Res> {
  __$$ExceptionFailureCopyWithImpl(
      _$ExceptionFailure _value, $Res Function(_$ExceptionFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = freezed,
  }) {
    return _then(_$ExceptionFailure(
      null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ExceptionFailure extends ExceptionFailure with DiagnosticableTreeMixin {
  const _$ExceptionFailure(this.stackTrace, [this.message]) : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Failure.exception(stackTrace: $stackTrace, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Failure.exception'))
      ..add(DiagnosticsProperty('stackTrace', stackTrace))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExceptionFailure &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExceptionFailureCopyWith<_$ExceptionFailure> get copyWith =>
      __$$ExceptionFailureCopyWithImpl<_$ExceptionFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StackTrace stackTrace, String? message) exception,
    required TResult Function(StackTrace stackTrace, String? message)
        noInternet,
    required TResult Function(StackTrace stackTrace, String? message)
        serverDown,
    required TResult Function(StackTrace stackTrace, String? message)
        incorrectLoginCredential,
    required TResult Function(StackTrace stackTrace, String? message)
        authException,
    required TResult Function(StackTrace stackTrace, String? message)
        databaseError,
    required TResult Function(StackTrace stackTrace, String? message) forbidden,
    required TResult Function(StackTrace stackTrace, String? message)
        uniqueConstraint,
    required TResult Function(StackTrace stackTrace, String? message) notFound,
    required TResult Function(StackTrace stackTrace, String? message)
        userAlreadyRegistered,
  }) {
    return exception(stackTrace, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StackTrace stackTrace, String? message)? exception,
    TResult? Function(StackTrace stackTrace, String? message)? noInternet,
    TResult? Function(StackTrace stackTrace, String? message)? serverDown,
    TResult? Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult? Function(StackTrace stackTrace, String? message)? authException,
    TResult? Function(StackTrace stackTrace, String? message)? databaseError,
    TResult? Function(StackTrace stackTrace, String? message)? forbidden,
    TResult? Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult? Function(StackTrace stackTrace, String? message)? notFound,
    TResult? Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
  }) {
    return exception?.call(stackTrace, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StackTrace stackTrace, String? message)? exception,
    TResult Function(StackTrace stackTrace, String? message)? noInternet,
    TResult Function(StackTrace stackTrace, String? message)? serverDown,
    TResult Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult Function(StackTrace stackTrace, String? message)? authException,
    TResult Function(StackTrace stackTrace, String? message)? databaseError,
    TResult Function(StackTrace stackTrace, String? message)? forbidden,
    TResult Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult Function(StackTrace stackTrace, String? message)? notFound,
    TResult Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
    required TResult orElse(),
  }) {
    if (exception != null) {
      return exception(stackTrace, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExceptionFailure value) exception,
    required TResult Function(NoInternetFailure value) noInternet,
    required TResult Function(ServerDownFailure value) serverDown,
    required TResult Function(IncorrectLoginCredential value)
        incorrectLoginCredential,
    required TResult Function(AuthExceptionFailure value) authException,
    required TResult Function(DatabaseErrorFailure value) databaseError,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(UniqueConstraintFailure value) uniqueConstraint,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(_UserAlreadyRegistered value)
        userAlreadyRegistered,
  }) {
    return exception(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExceptionFailure value)? exception,
    TResult? Function(NoInternetFailure value)? noInternet,
    TResult? Function(ServerDownFailure value)? serverDown,
    TResult? Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult? Function(AuthExceptionFailure value)? authException,
    TResult? Function(DatabaseErrorFailure value)? databaseError,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
  }) {
    return exception?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExceptionFailure value)? exception,
    TResult Function(NoInternetFailure value)? noInternet,
    TResult Function(ServerDownFailure value)? serverDown,
    TResult Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult Function(AuthExceptionFailure value)? authException,
    TResult Function(DatabaseErrorFailure value)? databaseError,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
    required TResult orElse(),
  }) {
    if (exception != null) {
      return exception(this);
    }
    return orElse();
  }
}

abstract class ExceptionFailure extends Failure {
  const factory ExceptionFailure(final StackTrace stackTrace,
      [final String? message]) = _$ExceptionFailure;
  const ExceptionFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$ExceptionFailureCopyWith<_$ExceptionFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NoInternetFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$NoInternetFailureCopyWith(
          _$NoInternetFailure value, $Res Function(_$NoInternetFailure) then) =
      __$$NoInternetFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StackTrace stackTrace, String? message});
}

/// @nodoc
class __$$NoInternetFailureCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NoInternetFailure>
    implements _$$NoInternetFailureCopyWith<$Res> {
  __$$NoInternetFailureCopyWithImpl(
      _$NoInternetFailure _value, $Res Function(_$NoInternetFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = freezed,
  }) {
    return _then(_$NoInternetFailure(
      null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NoInternetFailure extends NoInternetFailure
    with DiagnosticableTreeMixin {
  const _$NoInternetFailure(this.stackTrace, [this.message]) : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Failure.noInternet(stackTrace: $stackTrace, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Failure.noInternet'))
      ..add(DiagnosticsProperty('stackTrace', stackTrace))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoInternetFailure &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NoInternetFailureCopyWith<_$NoInternetFailure> get copyWith =>
      __$$NoInternetFailureCopyWithImpl<_$NoInternetFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StackTrace stackTrace, String? message) exception,
    required TResult Function(StackTrace stackTrace, String? message)
        noInternet,
    required TResult Function(StackTrace stackTrace, String? message)
        serverDown,
    required TResult Function(StackTrace stackTrace, String? message)
        incorrectLoginCredential,
    required TResult Function(StackTrace stackTrace, String? message)
        authException,
    required TResult Function(StackTrace stackTrace, String? message)
        databaseError,
    required TResult Function(StackTrace stackTrace, String? message) forbidden,
    required TResult Function(StackTrace stackTrace, String? message)
        uniqueConstraint,
    required TResult Function(StackTrace stackTrace, String? message) notFound,
    required TResult Function(StackTrace stackTrace, String? message)
        userAlreadyRegistered,
  }) {
    return noInternet(stackTrace, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StackTrace stackTrace, String? message)? exception,
    TResult? Function(StackTrace stackTrace, String? message)? noInternet,
    TResult? Function(StackTrace stackTrace, String? message)? serverDown,
    TResult? Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult? Function(StackTrace stackTrace, String? message)? authException,
    TResult? Function(StackTrace stackTrace, String? message)? databaseError,
    TResult? Function(StackTrace stackTrace, String? message)? forbidden,
    TResult? Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult? Function(StackTrace stackTrace, String? message)? notFound,
    TResult? Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
  }) {
    return noInternet?.call(stackTrace, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StackTrace stackTrace, String? message)? exception,
    TResult Function(StackTrace stackTrace, String? message)? noInternet,
    TResult Function(StackTrace stackTrace, String? message)? serverDown,
    TResult Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult Function(StackTrace stackTrace, String? message)? authException,
    TResult Function(StackTrace stackTrace, String? message)? databaseError,
    TResult Function(StackTrace stackTrace, String? message)? forbidden,
    TResult Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult Function(StackTrace stackTrace, String? message)? notFound,
    TResult Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
    required TResult orElse(),
  }) {
    if (noInternet != null) {
      return noInternet(stackTrace, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExceptionFailure value) exception,
    required TResult Function(NoInternetFailure value) noInternet,
    required TResult Function(ServerDownFailure value) serverDown,
    required TResult Function(IncorrectLoginCredential value)
        incorrectLoginCredential,
    required TResult Function(AuthExceptionFailure value) authException,
    required TResult Function(DatabaseErrorFailure value) databaseError,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(UniqueConstraintFailure value) uniqueConstraint,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(_UserAlreadyRegistered value)
        userAlreadyRegistered,
  }) {
    return noInternet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExceptionFailure value)? exception,
    TResult? Function(NoInternetFailure value)? noInternet,
    TResult? Function(ServerDownFailure value)? serverDown,
    TResult? Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult? Function(AuthExceptionFailure value)? authException,
    TResult? Function(DatabaseErrorFailure value)? databaseError,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
  }) {
    return noInternet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExceptionFailure value)? exception,
    TResult Function(NoInternetFailure value)? noInternet,
    TResult Function(ServerDownFailure value)? serverDown,
    TResult Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult Function(AuthExceptionFailure value)? authException,
    TResult Function(DatabaseErrorFailure value)? databaseError,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
    required TResult orElse(),
  }) {
    if (noInternet != null) {
      return noInternet(this);
    }
    return orElse();
  }
}

abstract class NoInternetFailure extends Failure {
  const factory NoInternetFailure(final StackTrace stackTrace,
      [final String? message]) = _$NoInternetFailure;
  const NoInternetFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$NoInternetFailureCopyWith<_$NoInternetFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ServerDownFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ServerDownFailureCopyWith(
          _$ServerDownFailure value, $Res Function(_$ServerDownFailure) then) =
      __$$ServerDownFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StackTrace stackTrace, String? message});
}

/// @nodoc
class __$$ServerDownFailureCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ServerDownFailure>
    implements _$$ServerDownFailureCopyWith<$Res> {
  __$$ServerDownFailureCopyWithImpl(
      _$ServerDownFailure _value, $Res Function(_$ServerDownFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = freezed,
  }) {
    return _then(_$ServerDownFailure(
      null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ServerDownFailure extends ServerDownFailure
    with DiagnosticableTreeMixin {
  const _$ServerDownFailure(this.stackTrace, [this.message]) : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Failure.serverDown(stackTrace: $stackTrace, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Failure.serverDown'))
      ..add(DiagnosticsProperty('stackTrace', stackTrace))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerDownFailure &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerDownFailureCopyWith<_$ServerDownFailure> get copyWith =>
      __$$ServerDownFailureCopyWithImpl<_$ServerDownFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StackTrace stackTrace, String? message) exception,
    required TResult Function(StackTrace stackTrace, String? message)
        noInternet,
    required TResult Function(StackTrace stackTrace, String? message)
        serverDown,
    required TResult Function(StackTrace stackTrace, String? message)
        incorrectLoginCredential,
    required TResult Function(StackTrace stackTrace, String? message)
        authException,
    required TResult Function(StackTrace stackTrace, String? message)
        databaseError,
    required TResult Function(StackTrace stackTrace, String? message) forbidden,
    required TResult Function(StackTrace stackTrace, String? message)
        uniqueConstraint,
    required TResult Function(StackTrace stackTrace, String? message) notFound,
    required TResult Function(StackTrace stackTrace, String? message)
        userAlreadyRegistered,
  }) {
    return serverDown(stackTrace, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StackTrace stackTrace, String? message)? exception,
    TResult? Function(StackTrace stackTrace, String? message)? noInternet,
    TResult? Function(StackTrace stackTrace, String? message)? serverDown,
    TResult? Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult? Function(StackTrace stackTrace, String? message)? authException,
    TResult? Function(StackTrace stackTrace, String? message)? databaseError,
    TResult? Function(StackTrace stackTrace, String? message)? forbidden,
    TResult? Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult? Function(StackTrace stackTrace, String? message)? notFound,
    TResult? Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
  }) {
    return serverDown?.call(stackTrace, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StackTrace stackTrace, String? message)? exception,
    TResult Function(StackTrace stackTrace, String? message)? noInternet,
    TResult Function(StackTrace stackTrace, String? message)? serverDown,
    TResult Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult Function(StackTrace stackTrace, String? message)? authException,
    TResult Function(StackTrace stackTrace, String? message)? databaseError,
    TResult Function(StackTrace stackTrace, String? message)? forbidden,
    TResult Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult Function(StackTrace stackTrace, String? message)? notFound,
    TResult Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
    required TResult orElse(),
  }) {
    if (serverDown != null) {
      return serverDown(stackTrace, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExceptionFailure value) exception,
    required TResult Function(NoInternetFailure value) noInternet,
    required TResult Function(ServerDownFailure value) serverDown,
    required TResult Function(IncorrectLoginCredential value)
        incorrectLoginCredential,
    required TResult Function(AuthExceptionFailure value) authException,
    required TResult Function(DatabaseErrorFailure value) databaseError,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(UniqueConstraintFailure value) uniqueConstraint,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(_UserAlreadyRegistered value)
        userAlreadyRegistered,
  }) {
    return serverDown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExceptionFailure value)? exception,
    TResult? Function(NoInternetFailure value)? noInternet,
    TResult? Function(ServerDownFailure value)? serverDown,
    TResult? Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult? Function(AuthExceptionFailure value)? authException,
    TResult? Function(DatabaseErrorFailure value)? databaseError,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
  }) {
    return serverDown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExceptionFailure value)? exception,
    TResult Function(NoInternetFailure value)? noInternet,
    TResult Function(ServerDownFailure value)? serverDown,
    TResult Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult Function(AuthExceptionFailure value)? authException,
    TResult Function(DatabaseErrorFailure value)? databaseError,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
    required TResult orElse(),
  }) {
    if (serverDown != null) {
      return serverDown(this);
    }
    return orElse();
  }
}

abstract class ServerDownFailure extends Failure {
  const factory ServerDownFailure(final StackTrace stackTrace,
      [final String? message]) = _$ServerDownFailure;
  const ServerDownFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$ServerDownFailureCopyWith<_$ServerDownFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IncorrectLoginCredentialCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$IncorrectLoginCredentialCopyWith(_$IncorrectLoginCredential value,
          $Res Function(_$IncorrectLoginCredential) then) =
      __$$IncorrectLoginCredentialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StackTrace stackTrace, String? message});
}

/// @nodoc
class __$$IncorrectLoginCredentialCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$IncorrectLoginCredential>
    implements _$$IncorrectLoginCredentialCopyWith<$Res> {
  __$$IncorrectLoginCredentialCopyWithImpl(_$IncorrectLoginCredential _value,
      $Res Function(_$IncorrectLoginCredential) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = freezed,
  }) {
    return _then(_$IncorrectLoginCredential(
      null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$IncorrectLoginCredential extends IncorrectLoginCredential
    with DiagnosticableTreeMixin {
  const _$IncorrectLoginCredential(this.stackTrace, [this.message]) : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Failure.incorrectLoginCredential(stackTrace: $stackTrace, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Failure.incorrectLoginCredential'))
      ..add(DiagnosticsProperty('stackTrace', stackTrace))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncorrectLoginCredential &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IncorrectLoginCredentialCopyWith<_$IncorrectLoginCredential>
      get copyWith =>
          __$$IncorrectLoginCredentialCopyWithImpl<_$IncorrectLoginCredential>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StackTrace stackTrace, String? message) exception,
    required TResult Function(StackTrace stackTrace, String? message)
        noInternet,
    required TResult Function(StackTrace stackTrace, String? message)
        serverDown,
    required TResult Function(StackTrace stackTrace, String? message)
        incorrectLoginCredential,
    required TResult Function(StackTrace stackTrace, String? message)
        authException,
    required TResult Function(StackTrace stackTrace, String? message)
        databaseError,
    required TResult Function(StackTrace stackTrace, String? message) forbidden,
    required TResult Function(StackTrace stackTrace, String? message)
        uniqueConstraint,
    required TResult Function(StackTrace stackTrace, String? message) notFound,
    required TResult Function(StackTrace stackTrace, String? message)
        userAlreadyRegistered,
  }) {
    return incorrectLoginCredential(stackTrace, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StackTrace stackTrace, String? message)? exception,
    TResult? Function(StackTrace stackTrace, String? message)? noInternet,
    TResult? Function(StackTrace stackTrace, String? message)? serverDown,
    TResult? Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult? Function(StackTrace stackTrace, String? message)? authException,
    TResult? Function(StackTrace stackTrace, String? message)? databaseError,
    TResult? Function(StackTrace stackTrace, String? message)? forbidden,
    TResult? Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult? Function(StackTrace stackTrace, String? message)? notFound,
    TResult? Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
  }) {
    return incorrectLoginCredential?.call(stackTrace, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StackTrace stackTrace, String? message)? exception,
    TResult Function(StackTrace stackTrace, String? message)? noInternet,
    TResult Function(StackTrace stackTrace, String? message)? serverDown,
    TResult Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult Function(StackTrace stackTrace, String? message)? authException,
    TResult Function(StackTrace stackTrace, String? message)? databaseError,
    TResult Function(StackTrace stackTrace, String? message)? forbidden,
    TResult Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult Function(StackTrace stackTrace, String? message)? notFound,
    TResult Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
    required TResult orElse(),
  }) {
    if (incorrectLoginCredential != null) {
      return incorrectLoginCredential(stackTrace, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExceptionFailure value) exception,
    required TResult Function(NoInternetFailure value) noInternet,
    required TResult Function(ServerDownFailure value) serverDown,
    required TResult Function(IncorrectLoginCredential value)
        incorrectLoginCredential,
    required TResult Function(AuthExceptionFailure value) authException,
    required TResult Function(DatabaseErrorFailure value) databaseError,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(UniqueConstraintFailure value) uniqueConstraint,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(_UserAlreadyRegistered value)
        userAlreadyRegistered,
  }) {
    return incorrectLoginCredential(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExceptionFailure value)? exception,
    TResult? Function(NoInternetFailure value)? noInternet,
    TResult? Function(ServerDownFailure value)? serverDown,
    TResult? Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult? Function(AuthExceptionFailure value)? authException,
    TResult? Function(DatabaseErrorFailure value)? databaseError,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
  }) {
    return incorrectLoginCredential?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExceptionFailure value)? exception,
    TResult Function(NoInternetFailure value)? noInternet,
    TResult Function(ServerDownFailure value)? serverDown,
    TResult Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult Function(AuthExceptionFailure value)? authException,
    TResult Function(DatabaseErrorFailure value)? databaseError,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
    required TResult orElse(),
  }) {
    if (incorrectLoginCredential != null) {
      return incorrectLoginCredential(this);
    }
    return orElse();
  }
}

abstract class IncorrectLoginCredential extends Failure {
  const factory IncorrectLoginCredential(final StackTrace stackTrace,
      [final String? message]) = _$IncorrectLoginCredential;
  const IncorrectLoginCredential._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$IncorrectLoginCredentialCopyWith<_$IncorrectLoginCredential>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthExceptionFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$AuthExceptionFailureCopyWith(_$AuthExceptionFailure value,
          $Res Function(_$AuthExceptionFailure) then) =
      __$$AuthExceptionFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StackTrace stackTrace, String? message});
}

/// @nodoc
class __$$AuthExceptionFailureCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$AuthExceptionFailure>
    implements _$$AuthExceptionFailureCopyWith<$Res> {
  __$$AuthExceptionFailureCopyWithImpl(_$AuthExceptionFailure _value,
      $Res Function(_$AuthExceptionFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = freezed,
  }) {
    return _then(_$AuthExceptionFailure(
      null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthExceptionFailure extends AuthExceptionFailure
    with DiagnosticableTreeMixin {
  const _$AuthExceptionFailure(this.stackTrace, [this.message]) : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Failure.authException(stackTrace: $stackTrace, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Failure.authException'))
      ..add(DiagnosticsProperty('stackTrace', stackTrace))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthExceptionFailure &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthExceptionFailureCopyWith<_$AuthExceptionFailure> get copyWith =>
      __$$AuthExceptionFailureCopyWithImpl<_$AuthExceptionFailure>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StackTrace stackTrace, String? message) exception,
    required TResult Function(StackTrace stackTrace, String? message)
        noInternet,
    required TResult Function(StackTrace stackTrace, String? message)
        serverDown,
    required TResult Function(StackTrace stackTrace, String? message)
        incorrectLoginCredential,
    required TResult Function(StackTrace stackTrace, String? message)
        authException,
    required TResult Function(StackTrace stackTrace, String? message)
        databaseError,
    required TResult Function(StackTrace stackTrace, String? message) forbidden,
    required TResult Function(StackTrace stackTrace, String? message)
        uniqueConstraint,
    required TResult Function(StackTrace stackTrace, String? message) notFound,
    required TResult Function(StackTrace stackTrace, String? message)
        userAlreadyRegistered,
  }) {
    return authException(stackTrace, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StackTrace stackTrace, String? message)? exception,
    TResult? Function(StackTrace stackTrace, String? message)? noInternet,
    TResult? Function(StackTrace stackTrace, String? message)? serverDown,
    TResult? Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult? Function(StackTrace stackTrace, String? message)? authException,
    TResult? Function(StackTrace stackTrace, String? message)? databaseError,
    TResult? Function(StackTrace stackTrace, String? message)? forbidden,
    TResult? Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult? Function(StackTrace stackTrace, String? message)? notFound,
    TResult? Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
  }) {
    return authException?.call(stackTrace, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StackTrace stackTrace, String? message)? exception,
    TResult Function(StackTrace stackTrace, String? message)? noInternet,
    TResult Function(StackTrace stackTrace, String? message)? serverDown,
    TResult Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult Function(StackTrace stackTrace, String? message)? authException,
    TResult Function(StackTrace stackTrace, String? message)? databaseError,
    TResult Function(StackTrace stackTrace, String? message)? forbidden,
    TResult Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult Function(StackTrace stackTrace, String? message)? notFound,
    TResult Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
    required TResult orElse(),
  }) {
    if (authException != null) {
      return authException(stackTrace, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExceptionFailure value) exception,
    required TResult Function(NoInternetFailure value) noInternet,
    required TResult Function(ServerDownFailure value) serverDown,
    required TResult Function(IncorrectLoginCredential value)
        incorrectLoginCredential,
    required TResult Function(AuthExceptionFailure value) authException,
    required TResult Function(DatabaseErrorFailure value) databaseError,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(UniqueConstraintFailure value) uniqueConstraint,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(_UserAlreadyRegistered value)
        userAlreadyRegistered,
  }) {
    return authException(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExceptionFailure value)? exception,
    TResult? Function(NoInternetFailure value)? noInternet,
    TResult? Function(ServerDownFailure value)? serverDown,
    TResult? Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult? Function(AuthExceptionFailure value)? authException,
    TResult? Function(DatabaseErrorFailure value)? databaseError,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
  }) {
    return authException?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExceptionFailure value)? exception,
    TResult Function(NoInternetFailure value)? noInternet,
    TResult Function(ServerDownFailure value)? serverDown,
    TResult Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult Function(AuthExceptionFailure value)? authException,
    TResult Function(DatabaseErrorFailure value)? databaseError,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
    required TResult orElse(),
  }) {
    if (authException != null) {
      return authException(this);
    }
    return orElse();
  }
}

abstract class AuthExceptionFailure extends Failure {
  const factory AuthExceptionFailure(final StackTrace stackTrace,
      [final String? message]) = _$AuthExceptionFailure;
  const AuthExceptionFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$AuthExceptionFailureCopyWith<_$AuthExceptionFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DatabaseErrorFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$DatabaseErrorFailureCopyWith(_$DatabaseErrorFailure value,
          $Res Function(_$DatabaseErrorFailure) then) =
      __$$DatabaseErrorFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StackTrace stackTrace, String? message});
}

/// @nodoc
class __$$DatabaseErrorFailureCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$DatabaseErrorFailure>
    implements _$$DatabaseErrorFailureCopyWith<$Res> {
  __$$DatabaseErrorFailureCopyWithImpl(_$DatabaseErrorFailure _value,
      $Res Function(_$DatabaseErrorFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = freezed,
  }) {
    return _then(_$DatabaseErrorFailure(
      null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$DatabaseErrorFailure extends DatabaseErrorFailure
    with DiagnosticableTreeMixin {
  const _$DatabaseErrorFailure(this.stackTrace, [this.message]) : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Failure.databaseError(stackTrace: $stackTrace, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Failure.databaseError'))
      ..add(DiagnosticsProperty('stackTrace', stackTrace))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatabaseErrorFailure &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DatabaseErrorFailureCopyWith<_$DatabaseErrorFailure> get copyWith =>
      __$$DatabaseErrorFailureCopyWithImpl<_$DatabaseErrorFailure>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StackTrace stackTrace, String? message) exception,
    required TResult Function(StackTrace stackTrace, String? message)
        noInternet,
    required TResult Function(StackTrace stackTrace, String? message)
        serverDown,
    required TResult Function(StackTrace stackTrace, String? message)
        incorrectLoginCredential,
    required TResult Function(StackTrace stackTrace, String? message)
        authException,
    required TResult Function(StackTrace stackTrace, String? message)
        databaseError,
    required TResult Function(StackTrace stackTrace, String? message) forbidden,
    required TResult Function(StackTrace stackTrace, String? message)
        uniqueConstraint,
    required TResult Function(StackTrace stackTrace, String? message) notFound,
    required TResult Function(StackTrace stackTrace, String? message)
        userAlreadyRegistered,
  }) {
    return databaseError(stackTrace, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StackTrace stackTrace, String? message)? exception,
    TResult? Function(StackTrace stackTrace, String? message)? noInternet,
    TResult? Function(StackTrace stackTrace, String? message)? serverDown,
    TResult? Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult? Function(StackTrace stackTrace, String? message)? authException,
    TResult? Function(StackTrace stackTrace, String? message)? databaseError,
    TResult? Function(StackTrace stackTrace, String? message)? forbidden,
    TResult? Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult? Function(StackTrace stackTrace, String? message)? notFound,
    TResult? Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
  }) {
    return databaseError?.call(stackTrace, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StackTrace stackTrace, String? message)? exception,
    TResult Function(StackTrace stackTrace, String? message)? noInternet,
    TResult Function(StackTrace stackTrace, String? message)? serverDown,
    TResult Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult Function(StackTrace stackTrace, String? message)? authException,
    TResult Function(StackTrace stackTrace, String? message)? databaseError,
    TResult Function(StackTrace stackTrace, String? message)? forbidden,
    TResult Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult Function(StackTrace stackTrace, String? message)? notFound,
    TResult Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
    required TResult orElse(),
  }) {
    if (databaseError != null) {
      return databaseError(stackTrace, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExceptionFailure value) exception,
    required TResult Function(NoInternetFailure value) noInternet,
    required TResult Function(ServerDownFailure value) serverDown,
    required TResult Function(IncorrectLoginCredential value)
        incorrectLoginCredential,
    required TResult Function(AuthExceptionFailure value) authException,
    required TResult Function(DatabaseErrorFailure value) databaseError,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(UniqueConstraintFailure value) uniqueConstraint,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(_UserAlreadyRegistered value)
        userAlreadyRegistered,
  }) {
    return databaseError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExceptionFailure value)? exception,
    TResult? Function(NoInternetFailure value)? noInternet,
    TResult? Function(ServerDownFailure value)? serverDown,
    TResult? Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult? Function(AuthExceptionFailure value)? authException,
    TResult? Function(DatabaseErrorFailure value)? databaseError,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
  }) {
    return databaseError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExceptionFailure value)? exception,
    TResult Function(NoInternetFailure value)? noInternet,
    TResult Function(ServerDownFailure value)? serverDown,
    TResult Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult Function(AuthExceptionFailure value)? authException,
    TResult Function(DatabaseErrorFailure value)? databaseError,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
    required TResult orElse(),
  }) {
    if (databaseError != null) {
      return databaseError(this);
    }
    return orElse();
  }
}

abstract class DatabaseErrorFailure extends Failure {
  const factory DatabaseErrorFailure(final StackTrace stackTrace,
      [final String? message]) = _$DatabaseErrorFailure;
  const DatabaseErrorFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$DatabaseErrorFailureCopyWith<_$DatabaseErrorFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ForbiddenFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ForbiddenFailureCopyWith(
          _$ForbiddenFailure value, $Res Function(_$ForbiddenFailure) then) =
      __$$ForbiddenFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StackTrace stackTrace, String? message});
}

/// @nodoc
class __$$ForbiddenFailureCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ForbiddenFailure>
    implements _$$ForbiddenFailureCopyWith<$Res> {
  __$$ForbiddenFailureCopyWithImpl(
      _$ForbiddenFailure _value, $Res Function(_$ForbiddenFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = freezed,
  }) {
    return _then(_$ForbiddenFailure(
      null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ForbiddenFailure extends ForbiddenFailure with DiagnosticableTreeMixin {
  const _$ForbiddenFailure(this.stackTrace, [this.message]) : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Failure.forbidden(stackTrace: $stackTrace, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Failure.forbidden'))
      ..add(DiagnosticsProperty('stackTrace', stackTrace))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForbiddenFailure &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ForbiddenFailureCopyWith<_$ForbiddenFailure> get copyWith =>
      __$$ForbiddenFailureCopyWithImpl<_$ForbiddenFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StackTrace stackTrace, String? message) exception,
    required TResult Function(StackTrace stackTrace, String? message)
        noInternet,
    required TResult Function(StackTrace stackTrace, String? message)
        serverDown,
    required TResult Function(StackTrace stackTrace, String? message)
        incorrectLoginCredential,
    required TResult Function(StackTrace stackTrace, String? message)
        authException,
    required TResult Function(StackTrace stackTrace, String? message)
        databaseError,
    required TResult Function(StackTrace stackTrace, String? message) forbidden,
    required TResult Function(StackTrace stackTrace, String? message)
        uniqueConstraint,
    required TResult Function(StackTrace stackTrace, String? message) notFound,
    required TResult Function(StackTrace stackTrace, String? message)
        userAlreadyRegistered,
  }) {
    return forbidden(stackTrace, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StackTrace stackTrace, String? message)? exception,
    TResult? Function(StackTrace stackTrace, String? message)? noInternet,
    TResult? Function(StackTrace stackTrace, String? message)? serverDown,
    TResult? Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult? Function(StackTrace stackTrace, String? message)? authException,
    TResult? Function(StackTrace stackTrace, String? message)? databaseError,
    TResult? Function(StackTrace stackTrace, String? message)? forbidden,
    TResult? Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult? Function(StackTrace stackTrace, String? message)? notFound,
    TResult? Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
  }) {
    return forbidden?.call(stackTrace, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StackTrace stackTrace, String? message)? exception,
    TResult Function(StackTrace stackTrace, String? message)? noInternet,
    TResult Function(StackTrace stackTrace, String? message)? serverDown,
    TResult Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult Function(StackTrace stackTrace, String? message)? authException,
    TResult Function(StackTrace stackTrace, String? message)? databaseError,
    TResult Function(StackTrace stackTrace, String? message)? forbidden,
    TResult Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult Function(StackTrace stackTrace, String? message)? notFound,
    TResult Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
    required TResult orElse(),
  }) {
    if (forbidden != null) {
      return forbidden(stackTrace, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExceptionFailure value) exception,
    required TResult Function(NoInternetFailure value) noInternet,
    required TResult Function(ServerDownFailure value) serverDown,
    required TResult Function(IncorrectLoginCredential value)
        incorrectLoginCredential,
    required TResult Function(AuthExceptionFailure value) authException,
    required TResult Function(DatabaseErrorFailure value) databaseError,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(UniqueConstraintFailure value) uniqueConstraint,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(_UserAlreadyRegistered value)
        userAlreadyRegistered,
  }) {
    return forbidden(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExceptionFailure value)? exception,
    TResult? Function(NoInternetFailure value)? noInternet,
    TResult? Function(ServerDownFailure value)? serverDown,
    TResult? Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult? Function(AuthExceptionFailure value)? authException,
    TResult? Function(DatabaseErrorFailure value)? databaseError,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
  }) {
    return forbidden?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExceptionFailure value)? exception,
    TResult Function(NoInternetFailure value)? noInternet,
    TResult Function(ServerDownFailure value)? serverDown,
    TResult Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult Function(AuthExceptionFailure value)? authException,
    TResult Function(DatabaseErrorFailure value)? databaseError,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
    required TResult orElse(),
  }) {
    if (forbidden != null) {
      return forbidden(this);
    }
    return orElse();
  }
}

abstract class ForbiddenFailure extends Failure {
  const factory ForbiddenFailure(final StackTrace stackTrace,
      [final String? message]) = _$ForbiddenFailure;
  const ForbiddenFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$ForbiddenFailureCopyWith<_$ForbiddenFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UniqueConstraintFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$UniqueConstraintFailureCopyWith(_$UniqueConstraintFailure value,
          $Res Function(_$UniqueConstraintFailure) then) =
      __$$UniqueConstraintFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StackTrace stackTrace, String? message});
}

/// @nodoc
class __$$UniqueConstraintFailureCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UniqueConstraintFailure>
    implements _$$UniqueConstraintFailureCopyWith<$Res> {
  __$$UniqueConstraintFailureCopyWithImpl(_$UniqueConstraintFailure _value,
      $Res Function(_$UniqueConstraintFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = freezed,
  }) {
    return _then(_$UniqueConstraintFailure(
      null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UniqueConstraintFailure extends UniqueConstraintFailure
    with DiagnosticableTreeMixin {
  const _$UniqueConstraintFailure(this.stackTrace, [this.message]) : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Failure.uniqueConstraint(stackTrace: $stackTrace, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Failure.uniqueConstraint'))
      ..add(DiagnosticsProperty('stackTrace', stackTrace))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UniqueConstraintFailure &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UniqueConstraintFailureCopyWith<_$UniqueConstraintFailure> get copyWith =>
      __$$UniqueConstraintFailureCopyWithImpl<_$UniqueConstraintFailure>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StackTrace stackTrace, String? message) exception,
    required TResult Function(StackTrace stackTrace, String? message)
        noInternet,
    required TResult Function(StackTrace stackTrace, String? message)
        serverDown,
    required TResult Function(StackTrace stackTrace, String? message)
        incorrectLoginCredential,
    required TResult Function(StackTrace stackTrace, String? message)
        authException,
    required TResult Function(StackTrace stackTrace, String? message)
        databaseError,
    required TResult Function(StackTrace stackTrace, String? message) forbidden,
    required TResult Function(StackTrace stackTrace, String? message)
        uniqueConstraint,
    required TResult Function(StackTrace stackTrace, String? message) notFound,
    required TResult Function(StackTrace stackTrace, String? message)
        userAlreadyRegistered,
  }) {
    return uniqueConstraint(stackTrace, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StackTrace stackTrace, String? message)? exception,
    TResult? Function(StackTrace stackTrace, String? message)? noInternet,
    TResult? Function(StackTrace stackTrace, String? message)? serverDown,
    TResult? Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult? Function(StackTrace stackTrace, String? message)? authException,
    TResult? Function(StackTrace stackTrace, String? message)? databaseError,
    TResult? Function(StackTrace stackTrace, String? message)? forbidden,
    TResult? Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult? Function(StackTrace stackTrace, String? message)? notFound,
    TResult? Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
  }) {
    return uniqueConstraint?.call(stackTrace, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StackTrace stackTrace, String? message)? exception,
    TResult Function(StackTrace stackTrace, String? message)? noInternet,
    TResult Function(StackTrace stackTrace, String? message)? serverDown,
    TResult Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult Function(StackTrace stackTrace, String? message)? authException,
    TResult Function(StackTrace stackTrace, String? message)? databaseError,
    TResult Function(StackTrace stackTrace, String? message)? forbidden,
    TResult Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult Function(StackTrace stackTrace, String? message)? notFound,
    TResult Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
    required TResult orElse(),
  }) {
    if (uniqueConstraint != null) {
      return uniqueConstraint(stackTrace, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExceptionFailure value) exception,
    required TResult Function(NoInternetFailure value) noInternet,
    required TResult Function(ServerDownFailure value) serverDown,
    required TResult Function(IncorrectLoginCredential value)
        incorrectLoginCredential,
    required TResult Function(AuthExceptionFailure value) authException,
    required TResult Function(DatabaseErrorFailure value) databaseError,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(UniqueConstraintFailure value) uniqueConstraint,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(_UserAlreadyRegistered value)
        userAlreadyRegistered,
  }) {
    return uniqueConstraint(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExceptionFailure value)? exception,
    TResult? Function(NoInternetFailure value)? noInternet,
    TResult? Function(ServerDownFailure value)? serverDown,
    TResult? Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult? Function(AuthExceptionFailure value)? authException,
    TResult? Function(DatabaseErrorFailure value)? databaseError,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
  }) {
    return uniqueConstraint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExceptionFailure value)? exception,
    TResult Function(NoInternetFailure value)? noInternet,
    TResult Function(ServerDownFailure value)? serverDown,
    TResult Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult Function(AuthExceptionFailure value)? authException,
    TResult Function(DatabaseErrorFailure value)? databaseError,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
    required TResult orElse(),
  }) {
    if (uniqueConstraint != null) {
      return uniqueConstraint(this);
    }
    return orElse();
  }
}

abstract class UniqueConstraintFailure extends Failure {
  const factory UniqueConstraintFailure(final StackTrace stackTrace,
      [final String? message]) = _$UniqueConstraintFailure;
  const UniqueConstraintFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$UniqueConstraintFailureCopyWith<_$UniqueConstraintFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotFoundFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$NotFoundFailureCopyWith(
          _$NotFoundFailure value, $Res Function(_$NotFoundFailure) then) =
      __$$NotFoundFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StackTrace stackTrace, String? message});
}

/// @nodoc
class __$$NotFoundFailureCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NotFoundFailure>
    implements _$$NotFoundFailureCopyWith<$Res> {
  __$$NotFoundFailureCopyWithImpl(
      _$NotFoundFailure _value, $Res Function(_$NotFoundFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = freezed,
  }) {
    return _then(_$NotFoundFailure(
      null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NotFoundFailure extends NotFoundFailure with DiagnosticableTreeMixin {
  const _$NotFoundFailure(this.stackTrace, [this.message]) : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Failure.notFound(stackTrace: $stackTrace, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Failure.notFound'))
      ..add(DiagnosticsProperty('stackTrace', stackTrace))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotFoundFailure &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotFoundFailureCopyWith<_$NotFoundFailure> get copyWith =>
      __$$NotFoundFailureCopyWithImpl<_$NotFoundFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StackTrace stackTrace, String? message) exception,
    required TResult Function(StackTrace stackTrace, String? message)
        noInternet,
    required TResult Function(StackTrace stackTrace, String? message)
        serverDown,
    required TResult Function(StackTrace stackTrace, String? message)
        incorrectLoginCredential,
    required TResult Function(StackTrace stackTrace, String? message)
        authException,
    required TResult Function(StackTrace stackTrace, String? message)
        databaseError,
    required TResult Function(StackTrace stackTrace, String? message) forbidden,
    required TResult Function(StackTrace stackTrace, String? message)
        uniqueConstraint,
    required TResult Function(StackTrace stackTrace, String? message) notFound,
    required TResult Function(StackTrace stackTrace, String? message)
        userAlreadyRegistered,
  }) {
    return notFound(stackTrace, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StackTrace stackTrace, String? message)? exception,
    TResult? Function(StackTrace stackTrace, String? message)? noInternet,
    TResult? Function(StackTrace stackTrace, String? message)? serverDown,
    TResult? Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult? Function(StackTrace stackTrace, String? message)? authException,
    TResult? Function(StackTrace stackTrace, String? message)? databaseError,
    TResult? Function(StackTrace stackTrace, String? message)? forbidden,
    TResult? Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult? Function(StackTrace stackTrace, String? message)? notFound,
    TResult? Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
  }) {
    return notFound?.call(stackTrace, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StackTrace stackTrace, String? message)? exception,
    TResult Function(StackTrace stackTrace, String? message)? noInternet,
    TResult Function(StackTrace stackTrace, String? message)? serverDown,
    TResult Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult Function(StackTrace stackTrace, String? message)? authException,
    TResult Function(StackTrace stackTrace, String? message)? databaseError,
    TResult Function(StackTrace stackTrace, String? message)? forbidden,
    TResult Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult Function(StackTrace stackTrace, String? message)? notFound,
    TResult Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(stackTrace, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExceptionFailure value) exception,
    required TResult Function(NoInternetFailure value) noInternet,
    required TResult Function(ServerDownFailure value) serverDown,
    required TResult Function(IncorrectLoginCredential value)
        incorrectLoginCredential,
    required TResult Function(AuthExceptionFailure value) authException,
    required TResult Function(DatabaseErrorFailure value) databaseError,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(UniqueConstraintFailure value) uniqueConstraint,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(_UserAlreadyRegistered value)
        userAlreadyRegistered,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExceptionFailure value)? exception,
    TResult? Function(NoInternetFailure value)? noInternet,
    TResult? Function(ServerDownFailure value)? serverDown,
    TResult? Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult? Function(AuthExceptionFailure value)? authException,
    TResult? Function(DatabaseErrorFailure value)? databaseError,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
  }) {
    return notFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExceptionFailure value)? exception,
    TResult Function(NoInternetFailure value)? noInternet,
    TResult Function(ServerDownFailure value)? serverDown,
    TResult Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult Function(AuthExceptionFailure value)? authException,
    TResult Function(DatabaseErrorFailure value)? databaseError,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class NotFoundFailure extends Failure {
  const factory NotFoundFailure(final StackTrace stackTrace,
      [final String? message]) = _$NotFoundFailure;
  const NotFoundFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$NotFoundFailureCopyWith<_$NotFoundFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UserAlreadyRegisteredCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$_UserAlreadyRegisteredCopyWith(_$_UserAlreadyRegistered value,
          $Res Function(_$_UserAlreadyRegistered) then) =
      __$$_UserAlreadyRegisteredCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StackTrace stackTrace, String? message});
}

/// @nodoc
class __$$_UserAlreadyRegisteredCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$_UserAlreadyRegistered>
    implements _$$_UserAlreadyRegisteredCopyWith<$Res> {
  __$$_UserAlreadyRegisteredCopyWithImpl(_$_UserAlreadyRegistered _value,
      $Res Function(_$_UserAlreadyRegistered) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = freezed,
  }) {
    return _then(_$_UserAlreadyRegistered(
      null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_UserAlreadyRegistered extends _UserAlreadyRegistered
    with DiagnosticableTreeMixin {
  const _$_UserAlreadyRegistered(this.stackTrace, [this.message]) : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Failure.userAlreadyRegistered(stackTrace: $stackTrace, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Failure.userAlreadyRegistered'))
      ..add(DiagnosticsProperty('stackTrace', stackTrace))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserAlreadyRegistered &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserAlreadyRegisteredCopyWith<_$_UserAlreadyRegistered> get copyWith =>
      __$$_UserAlreadyRegisteredCopyWithImpl<_$_UserAlreadyRegistered>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StackTrace stackTrace, String? message) exception,
    required TResult Function(StackTrace stackTrace, String? message)
        noInternet,
    required TResult Function(StackTrace stackTrace, String? message)
        serverDown,
    required TResult Function(StackTrace stackTrace, String? message)
        incorrectLoginCredential,
    required TResult Function(StackTrace stackTrace, String? message)
        authException,
    required TResult Function(StackTrace stackTrace, String? message)
        databaseError,
    required TResult Function(StackTrace stackTrace, String? message) forbidden,
    required TResult Function(StackTrace stackTrace, String? message)
        uniqueConstraint,
    required TResult Function(StackTrace stackTrace, String? message) notFound,
    required TResult Function(StackTrace stackTrace, String? message)
        userAlreadyRegistered,
  }) {
    return userAlreadyRegistered(stackTrace, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StackTrace stackTrace, String? message)? exception,
    TResult? Function(StackTrace stackTrace, String? message)? noInternet,
    TResult? Function(StackTrace stackTrace, String? message)? serverDown,
    TResult? Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult? Function(StackTrace stackTrace, String? message)? authException,
    TResult? Function(StackTrace stackTrace, String? message)? databaseError,
    TResult? Function(StackTrace stackTrace, String? message)? forbidden,
    TResult? Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult? Function(StackTrace stackTrace, String? message)? notFound,
    TResult? Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
  }) {
    return userAlreadyRegistered?.call(stackTrace, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StackTrace stackTrace, String? message)? exception,
    TResult Function(StackTrace stackTrace, String? message)? noInternet,
    TResult Function(StackTrace stackTrace, String? message)? serverDown,
    TResult Function(StackTrace stackTrace, String? message)?
        incorrectLoginCredential,
    TResult Function(StackTrace stackTrace, String? message)? authException,
    TResult Function(StackTrace stackTrace, String? message)? databaseError,
    TResult Function(StackTrace stackTrace, String? message)? forbidden,
    TResult Function(StackTrace stackTrace, String? message)? uniqueConstraint,
    TResult Function(StackTrace stackTrace, String? message)? notFound,
    TResult Function(StackTrace stackTrace, String? message)?
        userAlreadyRegistered,
    required TResult orElse(),
  }) {
    if (userAlreadyRegistered != null) {
      return userAlreadyRegistered(stackTrace, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExceptionFailure value) exception,
    required TResult Function(NoInternetFailure value) noInternet,
    required TResult Function(ServerDownFailure value) serverDown,
    required TResult Function(IncorrectLoginCredential value)
        incorrectLoginCredential,
    required TResult Function(AuthExceptionFailure value) authException,
    required TResult Function(DatabaseErrorFailure value) databaseError,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(UniqueConstraintFailure value) uniqueConstraint,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(_UserAlreadyRegistered value)
        userAlreadyRegistered,
  }) {
    return userAlreadyRegistered(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExceptionFailure value)? exception,
    TResult? Function(NoInternetFailure value)? noInternet,
    TResult? Function(ServerDownFailure value)? serverDown,
    TResult? Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult? Function(AuthExceptionFailure value)? authException,
    TResult? Function(DatabaseErrorFailure value)? databaseError,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
  }) {
    return userAlreadyRegistered?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExceptionFailure value)? exception,
    TResult Function(NoInternetFailure value)? noInternet,
    TResult Function(ServerDownFailure value)? serverDown,
    TResult Function(IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult Function(AuthExceptionFailure value)? authException,
    TResult Function(DatabaseErrorFailure value)? databaseError,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(UniqueConstraintFailure value)? uniqueConstraint,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(_UserAlreadyRegistered value)? userAlreadyRegistered,
    required TResult orElse(),
  }) {
    if (userAlreadyRegistered != null) {
      return userAlreadyRegistered(this);
    }
    return orElse();
  }
}

abstract class _UserAlreadyRegistered extends Failure {
  const factory _UserAlreadyRegistered(final StackTrace stackTrace,
      [final String? message]) = _$_UserAlreadyRegistered;
  const _UserAlreadyRegistered._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_UserAlreadyRegisteredCopyWith<_$_UserAlreadyRegistered> get copyWith =>
      throw _privateConstructorUsedError;
}
