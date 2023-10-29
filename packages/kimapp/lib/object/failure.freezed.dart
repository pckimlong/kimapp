// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FailureInfo {
  StackTrace get stackTrace => throw _privateConstructorUsedError;
  String get debugMessage => throw _privateConstructorUsedError;

  /// Readable message which will be display to user, If [message] is not provided or null
  /// The default message define in [Kimapp] service will be use instead when calling it from [Failure.message()] function
  String? get message => throw _privateConstructorUsedError;
  Object? get errorObject => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FailureInfoCopyWith<FailureInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureInfoCopyWith<$Res> {
  factory $FailureInfoCopyWith(
          FailureInfo value, $Res Function(FailureInfo) then) =
      _$FailureInfoCopyWithImpl<$Res, FailureInfo>;
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String debugMessage,
      String? message,
      Object? errorObject});
}

/// @nodoc
class _$FailureInfoCopyWithImpl<$Res, $Val extends FailureInfo>
    implements $FailureInfoCopyWith<$Res> {
  _$FailureInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? debugMessage = null,
    Object? message = freezed,
    Object? errorObject = freezed,
  }) {
    return _then(_value.copyWith(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      debugMessage: null == debugMessage
          ? _value.debugMessage
          : debugMessage // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      errorObject: freezed == errorObject ? _value.errorObject : errorObject,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FailureInfoCopyWith<$Res>
    implements $FailureInfoCopyWith<$Res> {
  factory _$$_FailureInfoCopyWith(
          _$_FailureInfo value, $Res Function(_$_FailureInfo) then) =
      __$$_FailureInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String debugMessage,
      String? message,
      Object? errorObject});
}

/// @nodoc
class __$$_FailureInfoCopyWithImpl<$Res>
    extends _$FailureInfoCopyWithImpl<$Res, _$_FailureInfo>
    implements _$$_FailureInfoCopyWith<$Res> {
  __$$_FailureInfoCopyWithImpl(
      _$_FailureInfo _value, $Res Function(_$_FailureInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? debugMessage = null,
    Object? message = freezed,
    Object? errorObject = freezed,
  }) {
    return _then(_$_FailureInfo(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      debugMessage: null == debugMessage
          ? _value.debugMessage
          : debugMessage // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      errorObject: freezed == errorObject ? _value.errorObject : errorObject,
    ));
  }
}

/// @nodoc

class _$_FailureInfo implements _FailureInfo {
  _$_FailureInfo(
      {required this.stackTrace,
      required this.debugMessage,
      this.message,
      this.errorObject});

  @override
  final StackTrace stackTrace;
  @override
  final String debugMessage;

  /// Readable message which will be display to user, If [message] is not provided or null
  /// The default message define in [Kimapp] service will be use instead when calling it from [Failure.message()] function
  @override
  final String? message;
  @override
  final Object? errorObject;

  @override
  String toString() {
    return 'FailureInfo(stackTrace: $stackTrace, debugMessage: $debugMessage, message: $message, errorObject: $errorObject)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FailureInfo &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.debugMessage, debugMessage) ||
                other.debugMessage == debugMessage) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other.errorObject, errorObject));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace, debugMessage,
      message, const DeepCollectionEquality().hash(errorObject));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FailureInfoCopyWith<_$_FailureInfo> get copyWith =>
      __$$_FailureInfoCopyWithImpl<_$_FailureInfo>(this, _$identity);
}

abstract class _FailureInfo implements FailureInfo {
  factory _FailureInfo(
      {required final StackTrace stackTrace,
      required final String debugMessage,
      final String? message,
      final Object? errorObject}) = _$_FailureInfo;

  @override
  StackTrace get stackTrace;
  @override
  String get debugMessage;
  @override

  /// Readable message which will be display to user, If [message] is not provided or null
  /// The default message define in [Kimapp] service will be use instead when calling it from [Failure.message()] function
  String? get message;
  @override
  Object? get errorObject;
  @override
  @JsonKey(ignore: true)
  _$$_FailureInfoCopyWith<_$_FailureInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Failure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(FailureInfo info) $default, {
    required TResult Function(FailureInfo info) exception,
    required TResult Function(FailureInfo info) networkFailure,
    required TResult Function(FailureInfo info) serverError,
    required TResult Function(DatabaseFailures failures) databaseFailure,
    required TResult Function(AuthFailures failures) authFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(FailureInfo info)? $default, {
    TResult? Function(FailureInfo info)? exception,
    TResult? Function(FailureInfo info)? networkFailure,
    TResult? Function(FailureInfo info)? serverError,
    TResult? Function(DatabaseFailures failures)? databaseFailure,
    TResult? Function(AuthFailures failures)? authFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(FailureInfo info)? $default, {
    TResult Function(FailureInfo info)? exception,
    TResult Function(FailureInfo info)? networkFailure,
    TResult Function(FailureInfo info)? serverError,
    TResult Function(DatabaseFailures failures)? databaseFailure,
    TResult Function(AuthFailures failures)? authFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Failure value) $default, {
    required TResult Function(ExceptionFailure value) exception,
    required TResult Function(NetworkFailure value) networkFailure,
    required TResult Function(ServerError value) serverError,
    required TResult Function(DatabaseFailure value) databaseFailure,
    required TResult Function(AuthFailure value) authFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Failure value)? $default, {
    TResult? Function(ExceptionFailure value)? exception,
    TResult? Function(NetworkFailure value)? networkFailure,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(DatabaseFailure value)? databaseFailure,
    TResult? Function(AuthFailure value)? authFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Failure value)? $default, {
    TResult Function(ExceptionFailure value)? exception,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(ServerError value)? serverError,
    TResult Function(DatabaseFailure value)? databaseFailure,
    TResult Function(AuthFailure value)? authFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_FailureCopyWith<$Res> {
  factory _$$_FailureCopyWith(
          _$_Failure value, $Res Function(_$_Failure) then) =
      __$$_FailureCopyWithImpl<$Res>;
  @useResult
  $Res call({FailureInfo info});

  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$_FailureCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$_Failure>
    implements _$$_FailureCopyWith<$Res> {
  __$$_FailureCopyWithImpl(_$_Failure _value, $Res Function(_$_Failure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$_Failure(
      null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $FailureInfoCopyWith<$Res> get info {
    return $FailureInfoCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value));
    });
  }
}

/// @nodoc

class _$_Failure extends _Failure {
  const _$_Failure(this.info) : super._();

  @override
  final FailureInfo info;

  @override
  String toString() {
    return 'Failure(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Failure &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FailureCopyWith<_$_Failure> get copyWith =>
      __$$_FailureCopyWithImpl<_$_Failure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(FailureInfo info) $default, {
    required TResult Function(FailureInfo info) exception,
    required TResult Function(FailureInfo info) networkFailure,
    required TResult Function(FailureInfo info) serverError,
    required TResult Function(DatabaseFailures failures) databaseFailure,
    required TResult Function(AuthFailures failures) authFailure,
  }) {
    return $default(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(FailureInfo info)? $default, {
    TResult? Function(FailureInfo info)? exception,
    TResult? Function(FailureInfo info)? networkFailure,
    TResult? Function(FailureInfo info)? serverError,
    TResult? Function(DatabaseFailures failures)? databaseFailure,
    TResult? Function(AuthFailures failures)? authFailure,
  }) {
    return $default?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(FailureInfo info)? $default, {
    TResult Function(FailureInfo info)? exception,
    TResult Function(FailureInfo info)? networkFailure,
    TResult Function(FailureInfo info)? serverError,
    TResult Function(DatabaseFailures failures)? databaseFailure,
    TResult Function(AuthFailures failures)? authFailure,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Failure value) $default, {
    required TResult Function(ExceptionFailure value) exception,
    required TResult Function(NetworkFailure value) networkFailure,
    required TResult Function(ServerError value) serverError,
    required TResult Function(DatabaseFailure value) databaseFailure,
    required TResult Function(AuthFailure value) authFailure,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Failure value)? $default, {
    TResult? Function(ExceptionFailure value)? exception,
    TResult? Function(NetworkFailure value)? networkFailure,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(DatabaseFailure value)? databaseFailure,
    TResult? Function(AuthFailure value)? authFailure,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Failure value)? $default, {
    TResult Function(ExceptionFailure value)? exception,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(ServerError value)? serverError,
    TResult Function(DatabaseFailure value)? databaseFailure,
    TResult Function(AuthFailure value)? authFailure,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _Failure extends Failure {
  const factory _Failure(final FailureInfo info) = _$_Failure;
  const _Failure._() : super._();

  FailureInfo get info;
  @JsonKey(ignore: true)
  _$$_FailureCopyWith<_$_Failure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExceptionFailureCopyWith<$Res> {
  factory _$$ExceptionFailureCopyWith(
          _$ExceptionFailure value, $Res Function(_$ExceptionFailure) then) =
      __$$ExceptionFailureCopyWithImpl<$Res>;
  @useResult
  $Res call({FailureInfo info});

  $FailureInfoCopyWith<$Res> get info;
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
    Object? info = null,
  }) {
    return _then(_$ExceptionFailure(
      null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $FailureInfoCopyWith<$Res> get info {
    return $FailureInfoCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value));
    });
  }
}

/// @nodoc

class _$ExceptionFailure extends ExceptionFailure {
  const _$ExceptionFailure(this.info) : super._();

  @override
  final FailureInfo info;

  @override
  String toString() {
    return 'Failure.exception(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExceptionFailure &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExceptionFailureCopyWith<_$ExceptionFailure> get copyWith =>
      __$$ExceptionFailureCopyWithImpl<_$ExceptionFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(FailureInfo info) $default, {
    required TResult Function(FailureInfo info) exception,
    required TResult Function(FailureInfo info) networkFailure,
    required TResult Function(FailureInfo info) serverError,
    required TResult Function(DatabaseFailures failures) databaseFailure,
    required TResult Function(AuthFailures failures) authFailure,
  }) {
    return exception(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(FailureInfo info)? $default, {
    TResult? Function(FailureInfo info)? exception,
    TResult? Function(FailureInfo info)? networkFailure,
    TResult? Function(FailureInfo info)? serverError,
    TResult? Function(DatabaseFailures failures)? databaseFailure,
    TResult? Function(AuthFailures failures)? authFailure,
  }) {
    return exception?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(FailureInfo info)? $default, {
    TResult Function(FailureInfo info)? exception,
    TResult Function(FailureInfo info)? networkFailure,
    TResult Function(FailureInfo info)? serverError,
    TResult Function(DatabaseFailures failures)? databaseFailure,
    TResult Function(AuthFailures failures)? authFailure,
    required TResult orElse(),
  }) {
    if (exception != null) {
      return exception(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Failure value) $default, {
    required TResult Function(ExceptionFailure value) exception,
    required TResult Function(NetworkFailure value) networkFailure,
    required TResult Function(ServerError value) serverError,
    required TResult Function(DatabaseFailure value) databaseFailure,
    required TResult Function(AuthFailure value) authFailure,
  }) {
    return exception(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Failure value)? $default, {
    TResult? Function(ExceptionFailure value)? exception,
    TResult? Function(NetworkFailure value)? networkFailure,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(DatabaseFailure value)? databaseFailure,
    TResult? Function(AuthFailure value)? authFailure,
  }) {
    return exception?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Failure value)? $default, {
    TResult Function(ExceptionFailure value)? exception,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(ServerError value)? serverError,
    TResult Function(DatabaseFailure value)? databaseFailure,
    TResult Function(AuthFailure value)? authFailure,
    required TResult orElse(),
  }) {
    if (exception != null) {
      return exception(this);
    }
    return orElse();
  }
}

abstract class ExceptionFailure extends Failure {
  const factory ExceptionFailure(final FailureInfo info) = _$ExceptionFailure;
  const ExceptionFailure._() : super._();

  FailureInfo get info;
  @JsonKey(ignore: true)
  _$$ExceptionFailureCopyWith<_$ExceptionFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NetworkFailureCopyWith<$Res> {
  factory _$$NetworkFailureCopyWith(
          _$NetworkFailure value, $Res Function(_$NetworkFailure) then) =
      __$$NetworkFailureCopyWithImpl<$Res>;
  @useResult
  $Res call({FailureInfo info});

  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$NetworkFailureCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NetworkFailure>
    implements _$$NetworkFailureCopyWith<$Res> {
  __$$NetworkFailureCopyWithImpl(
      _$NetworkFailure _value, $Res Function(_$NetworkFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$NetworkFailure(
      null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $FailureInfoCopyWith<$Res> get info {
    return $FailureInfoCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value));
    });
  }
}

/// @nodoc

class _$NetworkFailure extends NetworkFailure {
  const _$NetworkFailure(this.info) : super._();

  @override
  final FailureInfo info;

  @override
  String toString() {
    return 'Failure.networkFailure(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkFailure &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkFailureCopyWith<_$NetworkFailure> get copyWith =>
      __$$NetworkFailureCopyWithImpl<_$NetworkFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(FailureInfo info) $default, {
    required TResult Function(FailureInfo info) exception,
    required TResult Function(FailureInfo info) networkFailure,
    required TResult Function(FailureInfo info) serverError,
    required TResult Function(DatabaseFailures failures) databaseFailure,
    required TResult Function(AuthFailures failures) authFailure,
  }) {
    return networkFailure(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(FailureInfo info)? $default, {
    TResult? Function(FailureInfo info)? exception,
    TResult? Function(FailureInfo info)? networkFailure,
    TResult? Function(FailureInfo info)? serverError,
    TResult? Function(DatabaseFailures failures)? databaseFailure,
    TResult? Function(AuthFailures failures)? authFailure,
  }) {
    return networkFailure?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(FailureInfo info)? $default, {
    TResult Function(FailureInfo info)? exception,
    TResult Function(FailureInfo info)? networkFailure,
    TResult Function(FailureInfo info)? serverError,
    TResult Function(DatabaseFailures failures)? databaseFailure,
    TResult Function(AuthFailures failures)? authFailure,
    required TResult orElse(),
  }) {
    if (networkFailure != null) {
      return networkFailure(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Failure value) $default, {
    required TResult Function(ExceptionFailure value) exception,
    required TResult Function(NetworkFailure value) networkFailure,
    required TResult Function(ServerError value) serverError,
    required TResult Function(DatabaseFailure value) databaseFailure,
    required TResult Function(AuthFailure value) authFailure,
  }) {
    return networkFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Failure value)? $default, {
    TResult? Function(ExceptionFailure value)? exception,
    TResult? Function(NetworkFailure value)? networkFailure,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(DatabaseFailure value)? databaseFailure,
    TResult? Function(AuthFailure value)? authFailure,
  }) {
    return networkFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Failure value)? $default, {
    TResult Function(ExceptionFailure value)? exception,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(ServerError value)? serverError,
    TResult Function(DatabaseFailure value)? databaseFailure,
    TResult Function(AuthFailure value)? authFailure,
    required TResult orElse(),
  }) {
    if (networkFailure != null) {
      return networkFailure(this);
    }
    return orElse();
  }
}

abstract class NetworkFailure extends Failure {
  const factory NetworkFailure(final FailureInfo info) = _$NetworkFailure;
  const NetworkFailure._() : super._();

  FailureInfo get info;
  @JsonKey(ignore: true)
  _$$NetworkFailureCopyWith<_$NetworkFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ServerErrorCopyWith<$Res> {
  factory _$$ServerErrorCopyWith(
          _$ServerError value, $Res Function(_$ServerError) then) =
      __$$ServerErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({FailureInfo info});

  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$ServerErrorCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ServerError>
    implements _$$ServerErrorCopyWith<$Res> {
  __$$ServerErrorCopyWithImpl(
      _$ServerError _value, $Res Function(_$ServerError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$ServerError(
      null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $FailureInfoCopyWith<$Res> get info {
    return $FailureInfoCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value));
    });
  }
}

/// @nodoc

class _$ServerError extends ServerError {
  const _$ServerError(this.info) : super._();

  @override
  final FailureInfo info;

  @override
  String toString() {
    return 'Failure.serverError(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerError &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerErrorCopyWith<_$ServerError> get copyWith =>
      __$$ServerErrorCopyWithImpl<_$ServerError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(FailureInfo info) $default, {
    required TResult Function(FailureInfo info) exception,
    required TResult Function(FailureInfo info) networkFailure,
    required TResult Function(FailureInfo info) serverError,
    required TResult Function(DatabaseFailures failures) databaseFailure,
    required TResult Function(AuthFailures failures) authFailure,
  }) {
    return serverError(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(FailureInfo info)? $default, {
    TResult? Function(FailureInfo info)? exception,
    TResult? Function(FailureInfo info)? networkFailure,
    TResult? Function(FailureInfo info)? serverError,
    TResult? Function(DatabaseFailures failures)? databaseFailure,
    TResult? Function(AuthFailures failures)? authFailure,
  }) {
    return serverError?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(FailureInfo info)? $default, {
    TResult Function(FailureInfo info)? exception,
    TResult Function(FailureInfo info)? networkFailure,
    TResult Function(FailureInfo info)? serverError,
    TResult Function(DatabaseFailures failures)? databaseFailure,
    TResult Function(AuthFailures failures)? authFailure,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Failure value) $default, {
    required TResult Function(ExceptionFailure value) exception,
    required TResult Function(NetworkFailure value) networkFailure,
    required TResult Function(ServerError value) serverError,
    required TResult Function(DatabaseFailure value) databaseFailure,
    required TResult Function(AuthFailure value) authFailure,
  }) {
    return serverError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Failure value)? $default, {
    TResult? Function(ExceptionFailure value)? exception,
    TResult? Function(NetworkFailure value)? networkFailure,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(DatabaseFailure value)? databaseFailure,
    TResult? Function(AuthFailure value)? authFailure,
  }) {
    return serverError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Failure value)? $default, {
    TResult Function(ExceptionFailure value)? exception,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(ServerError value)? serverError,
    TResult Function(DatabaseFailure value)? databaseFailure,
    TResult Function(AuthFailure value)? authFailure,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(this);
    }
    return orElse();
  }
}

abstract class ServerError extends Failure {
  const factory ServerError(final FailureInfo info) = _$ServerError;
  const ServerError._() : super._();

  FailureInfo get info;
  @JsonKey(ignore: true)
  _$$ServerErrorCopyWith<_$ServerError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DatabaseFailureCopyWith<$Res> {
  factory _$$DatabaseFailureCopyWith(
          _$DatabaseFailure value, $Res Function(_$DatabaseFailure) then) =
      __$$DatabaseFailureCopyWithImpl<$Res>;
  @useResult
  $Res call({DatabaseFailures failures});

  $DatabaseFailuresCopyWith<$Res> get failures;
}

/// @nodoc
class __$$DatabaseFailureCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$DatabaseFailure>
    implements _$$DatabaseFailureCopyWith<$Res> {
  __$$DatabaseFailureCopyWithImpl(
      _$DatabaseFailure _value, $Res Function(_$DatabaseFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failures = null,
  }) {
    return _then(_$DatabaseFailure(
      null == failures
          ? _value.failures
          : failures // ignore: cast_nullable_to_non_nullable
              as DatabaseFailures,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $DatabaseFailuresCopyWith<$Res> get failures {
    return $DatabaseFailuresCopyWith<$Res>(_value.failures, (value) {
      return _then(_value.copyWith(failures: value));
    });
  }
}

/// @nodoc

class _$DatabaseFailure extends DatabaseFailure {
  const _$DatabaseFailure(this.failures) : super._();

  @override
  final DatabaseFailures failures;

  @override
  String toString() {
    return 'Failure.databaseFailure(failures: $failures)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatabaseFailure &&
            (identical(other.failures, failures) ||
                other.failures == failures));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failures);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DatabaseFailureCopyWith<_$DatabaseFailure> get copyWith =>
      __$$DatabaseFailureCopyWithImpl<_$DatabaseFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(FailureInfo info) $default, {
    required TResult Function(FailureInfo info) exception,
    required TResult Function(FailureInfo info) networkFailure,
    required TResult Function(FailureInfo info) serverError,
    required TResult Function(DatabaseFailures failures) databaseFailure,
    required TResult Function(AuthFailures failures) authFailure,
  }) {
    return databaseFailure(failures);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(FailureInfo info)? $default, {
    TResult? Function(FailureInfo info)? exception,
    TResult? Function(FailureInfo info)? networkFailure,
    TResult? Function(FailureInfo info)? serverError,
    TResult? Function(DatabaseFailures failures)? databaseFailure,
    TResult? Function(AuthFailures failures)? authFailure,
  }) {
    return databaseFailure?.call(failures);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(FailureInfo info)? $default, {
    TResult Function(FailureInfo info)? exception,
    TResult Function(FailureInfo info)? networkFailure,
    TResult Function(FailureInfo info)? serverError,
    TResult Function(DatabaseFailures failures)? databaseFailure,
    TResult Function(AuthFailures failures)? authFailure,
    required TResult orElse(),
  }) {
    if (databaseFailure != null) {
      return databaseFailure(failures);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Failure value) $default, {
    required TResult Function(ExceptionFailure value) exception,
    required TResult Function(NetworkFailure value) networkFailure,
    required TResult Function(ServerError value) serverError,
    required TResult Function(DatabaseFailure value) databaseFailure,
    required TResult Function(AuthFailure value) authFailure,
  }) {
    return databaseFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Failure value)? $default, {
    TResult? Function(ExceptionFailure value)? exception,
    TResult? Function(NetworkFailure value)? networkFailure,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(DatabaseFailure value)? databaseFailure,
    TResult? Function(AuthFailure value)? authFailure,
  }) {
    return databaseFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Failure value)? $default, {
    TResult Function(ExceptionFailure value)? exception,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(ServerError value)? serverError,
    TResult Function(DatabaseFailure value)? databaseFailure,
    TResult Function(AuthFailure value)? authFailure,
    required TResult orElse(),
  }) {
    if (databaseFailure != null) {
      return databaseFailure(this);
    }
    return orElse();
  }
}

abstract class DatabaseFailure extends Failure {
  const factory DatabaseFailure(final DatabaseFailures failures) =
      _$DatabaseFailure;
  const DatabaseFailure._() : super._();

  DatabaseFailures get failures;
  @JsonKey(ignore: true)
  _$$DatabaseFailureCopyWith<_$DatabaseFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthFailureCopyWith<$Res> {
  factory _$$AuthFailureCopyWith(
          _$AuthFailure value, $Res Function(_$AuthFailure) then) =
      __$$AuthFailureCopyWithImpl<$Res>;
  @useResult
  $Res call({AuthFailures failures});

  $AuthFailuresCopyWith<$Res> get failures;
}

/// @nodoc
class __$$AuthFailureCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$AuthFailure>
    implements _$$AuthFailureCopyWith<$Res> {
  __$$AuthFailureCopyWithImpl(
      _$AuthFailure _value, $Res Function(_$AuthFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failures = null,
  }) {
    return _then(_$AuthFailure(
      null == failures
          ? _value.failures
          : failures // ignore: cast_nullable_to_non_nullable
              as AuthFailures,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthFailuresCopyWith<$Res> get failures {
    return $AuthFailuresCopyWith<$Res>(_value.failures, (value) {
      return _then(_value.copyWith(failures: value));
    });
  }
}

/// @nodoc

class _$AuthFailure extends AuthFailure {
  const _$AuthFailure(this.failures) : super._();

  @override
  final AuthFailures failures;

  @override
  String toString() {
    return 'Failure.authFailure(failures: $failures)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthFailure &&
            (identical(other.failures, failures) ||
                other.failures == failures));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failures);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthFailureCopyWith<_$AuthFailure> get copyWith =>
      __$$AuthFailureCopyWithImpl<_$AuthFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(FailureInfo info) $default, {
    required TResult Function(FailureInfo info) exception,
    required TResult Function(FailureInfo info) networkFailure,
    required TResult Function(FailureInfo info) serverError,
    required TResult Function(DatabaseFailures failures) databaseFailure,
    required TResult Function(AuthFailures failures) authFailure,
  }) {
    return authFailure(failures);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(FailureInfo info)? $default, {
    TResult? Function(FailureInfo info)? exception,
    TResult? Function(FailureInfo info)? networkFailure,
    TResult? Function(FailureInfo info)? serverError,
    TResult? Function(DatabaseFailures failures)? databaseFailure,
    TResult? Function(AuthFailures failures)? authFailure,
  }) {
    return authFailure?.call(failures);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(FailureInfo info)? $default, {
    TResult Function(FailureInfo info)? exception,
    TResult Function(FailureInfo info)? networkFailure,
    TResult Function(FailureInfo info)? serverError,
    TResult Function(DatabaseFailures failures)? databaseFailure,
    TResult Function(AuthFailures failures)? authFailure,
    required TResult orElse(),
  }) {
    if (authFailure != null) {
      return authFailure(failures);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Failure value) $default, {
    required TResult Function(ExceptionFailure value) exception,
    required TResult Function(NetworkFailure value) networkFailure,
    required TResult Function(ServerError value) serverError,
    required TResult Function(DatabaseFailure value) databaseFailure,
    required TResult Function(AuthFailure value) authFailure,
  }) {
    return authFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Failure value)? $default, {
    TResult? Function(ExceptionFailure value)? exception,
    TResult? Function(NetworkFailure value)? networkFailure,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(DatabaseFailure value)? databaseFailure,
    TResult? Function(AuthFailure value)? authFailure,
  }) {
    return authFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Failure value)? $default, {
    TResult Function(ExceptionFailure value)? exception,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(ServerError value)? serverError,
    TResult Function(DatabaseFailure value)? databaseFailure,
    TResult Function(AuthFailure value)? authFailure,
    required TResult orElse(),
  }) {
    if (authFailure != null) {
      return authFailure(this);
    }
    return orElse();
  }
}

abstract class AuthFailure extends Failure {
  const factory AuthFailure(final AuthFailures failures) = _$AuthFailure;
  const AuthFailure._() : super._();

  AuthFailures get failures;
  @JsonKey(ignore: true)
  _$$AuthFailureCopyWith<_$AuthFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DatabaseFailures {
  FailureInfo get info => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(FailureInfo info) $default, {
    required TResult Function(FailureInfo info) uniqueConstraint,
    required TResult Function(FailureInfo info) notFound,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(FailureInfo info)? $default, {
    TResult? Function(FailureInfo info)? uniqueConstraint,
    TResult? Function(FailureInfo info)? notFound,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(FailureInfo info)? $default, {
    TResult Function(FailureInfo info)? uniqueConstraint,
    TResult Function(FailureInfo info)? notFound,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_DatabaseFailures value) $default, {
    required TResult Function(_UniqueConstraint value) uniqueConstraint,
    required TResult Function(_NotFound value) notFound,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_DatabaseFailures value)? $default, {
    TResult? Function(_UniqueConstraint value)? uniqueConstraint,
    TResult? Function(_NotFound value)? notFound,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_DatabaseFailures value)? $default, {
    TResult Function(_UniqueConstraint value)? uniqueConstraint,
    TResult Function(_NotFound value)? notFound,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DatabaseFailuresCopyWith<DatabaseFailures> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DatabaseFailuresCopyWith<$Res> {
  factory $DatabaseFailuresCopyWith(
          DatabaseFailures value, $Res Function(DatabaseFailures) then) =
      _$DatabaseFailuresCopyWithImpl<$Res, DatabaseFailures>;
  @useResult
  $Res call({FailureInfo info});

  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class _$DatabaseFailuresCopyWithImpl<$Res, $Val extends DatabaseFailures>
    implements $DatabaseFailuresCopyWith<$Res> {
  _$DatabaseFailuresCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_value.copyWith(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FailureInfoCopyWith<$Res> get info {
    return $FailureInfoCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DatabaseFailuresCopyWith<$Res>
    implements $DatabaseFailuresCopyWith<$Res> {
  factory _$$_DatabaseFailuresCopyWith(
          _$_DatabaseFailures value, $Res Function(_$_DatabaseFailures) then) =
      __$$_DatabaseFailuresCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FailureInfo info});

  @override
  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$_DatabaseFailuresCopyWithImpl<$Res>
    extends _$DatabaseFailuresCopyWithImpl<$Res, _$_DatabaseFailures>
    implements _$$_DatabaseFailuresCopyWith<$Res> {
  __$$_DatabaseFailuresCopyWithImpl(
      _$_DatabaseFailures _value, $Res Function(_$_DatabaseFailures) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$_DatabaseFailures(
      null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }
}

/// @nodoc

class _$_DatabaseFailures extends _DatabaseFailures {
  const _$_DatabaseFailures(this.info) : super._();

  @override
  final FailureInfo info;

  @override
  String toString() {
    return 'DatabaseFailures(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DatabaseFailures &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DatabaseFailuresCopyWith<_$_DatabaseFailures> get copyWith =>
      __$$_DatabaseFailuresCopyWithImpl<_$_DatabaseFailures>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(FailureInfo info) $default, {
    required TResult Function(FailureInfo info) uniqueConstraint,
    required TResult Function(FailureInfo info) notFound,
  }) {
    return $default(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(FailureInfo info)? $default, {
    TResult? Function(FailureInfo info)? uniqueConstraint,
    TResult? Function(FailureInfo info)? notFound,
  }) {
    return $default?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(FailureInfo info)? $default, {
    TResult Function(FailureInfo info)? uniqueConstraint,
    TResult Function(FailureInfo info)? notFound,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_DatabaseFailures value) $default, {
    required TResult Function(_UniqueConstraint value) uniqueConstraint,
    required TResult Function(_NotFound value) notFound,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_DatabaseFailures value)? $default, {
    TResult? Function(_UniqueConstraint value)? uniqueConstraint,
    TResult? Function(_NotFound value)? notFound,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_DatabaseFailures value)? $default, {
    TResult Function(_UniqueConstraint value)? uniqueConstraint,
    TResult Function(_NotFound value)? notFound,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _DatabaseFailures extends DatabaseFailures {
  const factory _DatabaseFailures(final FailureInfo info) = _$_DatabaseFailures;
  const _DatabaseFailures._() : super._();

  @override
  FailureInfo get info;
  @override
  @JsonKey(ignore: true)
  _$$_DatabaseFailuresCopyWith<_$_DatabaseFailures> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UniqueConstraintCopyWith<$Res>
    implements $DatabaseFailuresCopyWith<$Res> {
  factory _$$_UniqueConstraintCopyWith(
          _$_UniqueConstraint value, $Res Function(_$_UniqueConstraint) then) =
      __$$_UniqueConstraintCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FailureInfo info});

  @override
  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$_UniqueConstraintCopyWithImpl<$Res>
    extends _$DatabaseFailuresCopyWithImpl<$Res, _$_UniqueConstraint>
    implements _$$_UniqueConstraintCopyWith<$Res> {
  __$$_UniqueConstraintCopyWithImpl(
      _$_UniqueConstraint _value, $Res Function(_$_UniqueConstraint) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$_UniqueConstraint(
      null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }
}

/// @nodoc

class _$_UniqueConstraint extends _UniqueConstraint {
  const _$_UniqueConstraint(this.info) : super._();

  @override
  final FailureInfo info;

  @override
  String toString() {
    return 'DatabaseFailures.uniqueConstraint(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UniqueConstraint &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UniqueConstraintCopyWith<_$_UniqueConstraint> get copyWith =>
      __$$_UniqueConstraintCopyWithImpl<_$_UniqueConstraint>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(FailureInfo info) $default, {
    required TResult Function(FailureInfo info) uniqueConstraint,
    required TResult Function(FailureInfo info) notFound,
  }) {
    return uniqueConstraint(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(FailureInfo info)? $default, {
    TResult? Function(FailureInfo info)? uniqueConstraint,
    TResult? Function(FailureInfo info)? notFound,
  }) {
    return uniqueConstraint?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(FailureInfo info)? $default, {
    TResult Function(FailureInfo info)? uniqueConstraint,
    TResult Function(FailureInfo info)? notFound,
    required TResult orElse(),
  }) {
    if (uniqueConstraint != null) {
      return uniqueConstraint(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_DatabaseFailures value) $default, {
    required TResult Function(_UniqueConstraint value) uniqueConstraint,
    required TResult Function(_NotFound value) notFound,
  }) {
    return uniqueConstraint(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_DatabaseFailures value)? $default, {
    TResult? Function(_UniqueConstraint value)? uniqueConstraint,
    TResult? Function(_NotFound value)? notFound,
  }) {
    return uniqueConstraint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_DatabaseFailures value)? $default, {
    TResult Function(_UniqueConstraint value)? uniqueConstraint,
    TResult Function(_NotFound value)? notFound,
    required TResult orElse(),
  }) {
    if (uniqueConstraint != null) {
      return uniqueConstraint(this);
    }
    return orElse();
  }
}

abstract class _UniqueConstraint extends DatabaseFailures {
  const factory _UniqueConstraint(final FailureInfo info) = _$_UniqueConstraint;
  const _UniqueConstraint._() : super._();

  @override
  FailureInfo get info;
  @override
  @JsonKey(ignore: true)
  _$$_UniqueConstraintCopyWith<_$_UniqueConstraint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_NotFoundCopyWith<$Res>
    implements $DatabaseFailuresCopyWith<$Res> {
  factory _$$_NotFoundCopyWith(
          _$_NotFound value, $Res Function(_$_NotFound) then) =
      __$$_NotFoundCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FailureInfo info});

  @override
  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$_NotFoundCopyWithImpl<$Res>
    extends _$DatabaseFailuresCopyWithImpl<$Res, _$_NotFound>
    implements _$$_NotFoundCopyWith<$Res> {
  __$$_NotFoundCopyWithImpl(
      _$_NotFound _value, $Res Function(_$_NotFound) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$_NotFound(
      null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }
}

/// @nodoc

class _$_NotFound extends _NotFound {
  const _$_NotFound(this.info) : super._();

  @override
  final FailureInfo info;

  @override
  String toString() {
    return 'DatabaseFailures.notFound(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NotFound &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NotFoundCopyWith<_$_NotFound> get copyWith =>
      __$$_NotFoundCopyWithImpl<_$_NotFound>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(FailureInfo info) $default, {
    required TResult Function(FailureInfo info) uniqueConstraint,
    required TResult Function(FailureInfo info) notFound,
  }) {
    return notFound(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(FailureInfo info)? $default, {
    TResult? Function(FailureInfo info)? uniqueConstraint,
    TResult? Function(FailureInfo info)? notFound,
  }) {
    return notFound?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(FailureInfo info)? $default, {
    TResult Function(FailureInfo info)? uniqueConstraint,
    TResult Function(FailureInfo info)? notFound,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_DatabaseFailures value) $default, {
    required TResult Function(_UniqueConstraint value) uniqueConstraint,
    required TResult Function(_NotFound value) notFound,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_DatabaseFailures value)? $default, {
    TResult? Function(_UniqueConstraint value)? uniqueConstraint,
    TResult? Function(_NotFound value)? notFound,
  }) {
    return notFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_DatabaseFailures value)? $default, {
    TResult Function(_UniqueConstraint value)? uniqueConstraint,
    TResult Function(_NotFound value)? notFound,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class _NotFound extends DatabaseFailures {
  const factory _NotFound(final FailureInfo info) = _$_NotFound;
  const _NotFound._() : super._();

  @override
  FailureInfo get info;
  @override
  @JsonKey(ignore: true)
  _$$_NotFoundCopyWith<_$_NotFound> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AuthFailures {
  FailureInfo get info => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(FailureInfo info) $default, {
    required TResult Function(FailureInfo info) incorrectLoginCredential,
    required TResult Function(FailureInfo info) forbidden,
    required TResult Function(FailureInfo info) alreadyRegistered,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(FailureInfo info)? $default, {
    TResult? Function(FailureInfo info)? incorrectLoginCredential,
    TResult? Function(FailureInfo info)? forbidden,
    TResult? Function(FailureInfo info)? alreadyRegistered,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(FailureInfo info)? $default, {
    TResult Function(FailureInfo info)? incorrectLoginCredential,
    TResult Function(FailureInfo info)? forbidden,
    TResult Function(FailureInfo info)? alreadyRegistered,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AuthFailures value) $default, {
    required TResult Function(_IncorrectLoginCredential value)
        incorrectLoginCredential,
    required TResult Function(_Forbidden value) forbidden,
    required TResult Function(_UserAlreadyRegistered value) alreadyRegistered,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AuthFailures value)? $default, {
    TResult? Function(_IncorrectLoginCredential value)?
        incorrectLoginCredential,
    TResult? Function(_Forbidden value)? forbidden,
    TResult? Function(_UserAlreadyRegistered value)? alreadyRegistered,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AuthFailures value)? $default, {
    TResult Function(_IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult Function(_Forbidden value)? forbidden,
    TResult Function(_UserAlreadyRegistered value)? alreadyRegistered,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthFailuresCopyWith<AuthFailures> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthFailuresCopyWith<$Res> {
  factory $AuthFailuresCopyWith(
          AuthFailures value, $Res Function(AuthFailures) then) =
      _$AuthFailuresCopyWithImpl<$Res, AuthFailures>;
  @useResult
  $Res call({FailureInfo info});

  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class _$AuthFailuresCopyWithImpl<$Res, $Val extends AuthFailures>
    implements $AuthFailuresCopyWith<$Res> {
  _$AuthFailuresCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_value.copyWith(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FailureInfoCopyWith<$Res> get info {
    return $FailureInfoCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AuthFailuresCopyWith<$Res>
    implements $AuthFailuresCopyWith<$Res> {
  factory _$$_AuthFailuresCopyWith(
          _$_AuthFailures value, $Res Function(_$_AuthFailures) then) =
      __$$_AuthFailuresCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FailureInfo info});

  @override
  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$_AuthFailuresCopyWithImpl<$Res>
    extends _$AuthFailuresCopyWithImpl<$Res, _$_AuthFailures>
    implements _$$_AuthFailuresCopyWith<$Res> {
  __$$_AuthFailuresCopyWithImpl(
      _$_AuthFailures _value, $Res Function(_$_AuthFailures) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$_AuthFailures(
      null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }
}

/// @nodoc

class _$_AuthFailures extends _AuthFailures {
  const _$_AuthFailures(this.info) : super._();

  @override
  final FailureInfo info;

  @override
  String toString() {
    return 'AuthFailures(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthFailures &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthFailuresCopyWith<_$_AuthFailures> get copyWith =>
      __$$_AuthFailuresCopyWithImpl<_$_AuthFailures>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(FailureInfo info) $default, {
    required TResult Function(FailureInfo info) incorrectLoginCredential,
    required TResult Function(FailureInfo info) forbidden,
    required TResult Function(FailureInfo info) alreadyRegistered,
  }) {
    return $default(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(FailureInfo info)? $default, {
    TResult? Function(FailureInfo info)? incorrectLoginCredential,
    TResult? Function(FailureInfo info)? forbidden,
    TResult? Function(FailureInfo info)? alreadyRegistered,
  }) {
    return $default?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(FailureInfo info)? $default, {
    TResult Function(FailureInfo info)? incorrectLoginCredential,
    TResult Function(FailureInfo info)? forbidden,
    TResult Function(FailureInfo info)? alreadyRegistered,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AuthFailures value) $default, {
    required TResult Function(_IncorrectLoginCredential value)
        incorrectLoginCredential,
    required TResult Function(_Forbidden value) forbidden,
    required TResult Function(_UserAlreadyRegistered value) alreadyRegistered,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AuthFailures value)? $default, {
    TResult? Function(_IncorrectLoginCredential value)?
        incorrectLoginCredential,
    TResult? Function(_Forbidden value)? forbidden,
    TResult? Function(_UserAlreadyRegistered value)? alreadyRegistered,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AuthFailures value)? $default, {
    TResult Function(_IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult Function(_Forbidden value)? forbidden,
    TResult Function(_UserAlreadyRegistered value)? alreadyRegistered,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _AuthFailures extends AuthFailures {
  const factory _AuthFailures(final FailureInfo info) = _$_AuthFailures;
  const _AuthFailures._() : super._();

  @override
  FailureInfo get info;
  @override
  @JsonKey(ignore: true)
  _$$_AuthFailuresCopyWith<_$_AuthFailures> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_IncorrectLoginCredentialCopyWith<$Res>
    implements $AuthFailuresCopyWith<$Res> {
  factory _$$_IncorrectLoginCredentialCopyWith(
          _$_IncorrectLoginCredential value,
          $Res Function(_$_IncorrectLoginCredential) then) =
      __$$_IncorrectLoginCredentialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FailureInfo info});

  @override
  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$_IncorrectLoginCredentialCopyWithImpl<$Res>
    extends _$AuthFailuresCopyWithImpl<$Res, _$_IncorrectLoginCredential>
    implements _$$_IncorrectLoginCredentialCopyWith<$Res> {
  __$$_IncorrectLoginCredentialCopyWithImpl(_$_IncorrectLoginCredential _value,
      $Res Function(_$_IncorrectLoginCredential) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$_IncorrectLoginCredential(
      null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }
}

/// @nodoc

class _$_IncorrectLoginCredential extends _IncorrectLoginCredential {
  const _$_IncorrectLoginCredential(this.info) : super._();

  @override
  final FailureInfo info;

  @override
  String toString() {
    return 'AuthFailures.incorrectLoginCredential(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IncorrectLoginCredential &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IncorrectLoginCredentialCopyWith<_$_IncorrectLoginCredential>
      get copyWith => __$$_IncorrectLoginCredentialCopyWithImpl<
          _$_IncorrectLoginCredential>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(FailureInfo info) $default, {
    required TResult Function(FailureInfo info) incorrectLoginCredential,
    required TResult Function(FailureInfo info) forbidden,
    required TResult Function(FailureInfo info) alreadyRegistered,
  }) {
    return incorrectLoginCredential(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(FailureInfo info)? $default, {
    TResult? Function(FailureInfo info)? incorrectLoginCredential,
    TResult? Function(FailureInfo info)? forbidden,
    TResult? Function(FailureInfo info)? alreadyRegistered,
  }) {
    return incorrectLoginCredential?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(FailureInfo info)? $default, {
    TResult Function(FailureInfo info)? incorrectLoginCredential,
    TResult Function(FailureInfo info)? forbidden,
    TResult Function(FailureInfo info)? alreadyRegistered,
    required TResult orElse(),
  }) {
    if (incorrectLoginCredential != null) {
      return incorrectLoginCredential(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AuthFailures value) $default, {
    required TResult Function(_IncorrectLoginCredential value)
        incorrectLoginCredential,
    required TResult Function(_Forbidden value) forbidden,
    required TResult Function(_UserAlreadyRegistered value) alreadyRegistered,
  }) {
    return incorrectLoginCredential(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AuthFailures value)? $default, {
    TResult? Function(_IncorrectLoginCredential value)?
        incorrectLoginCredential,
    TResult? Function(_Forbidden value)? forbidden,
    TResult? Function(_UserAlreadyRegistered value)? alreadyRegistered,
  }) {
    return incorrectLoginCredential?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AuthFailures value)? $default, {
    TResult Function(_IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult Function(_Forbidden value)? forbidden,
    TResult Function(_UserAlreadyRegistered value)? alreadyRegistered,
    required TResult orElse(),
  }) {
    if (incorrectLoginCredential != null) {
      return incorrectLoginCredential(this);
    }
    return orElse();
  }
}

abstract class _IncorrectLoginCredential extends AuthFailures {
  const factory _IncorrectLoginCredential(final FailureInfo info) =
      _$_IncorrectLoginCredential;
  const _IncorrectLoginCredential._() : super._();

  @override
  FailureInfo get info;
  @override
  @JsonKey(ignore: true)
  _$$_IncorrectLoginCredentialCopyWith<_$_IncorrectLoginCredential>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ForbiddenCopyWith<$Res>
    implements $AuthFailuresCopyWith<$Res> {
  factory _$$_ForbiddenCopyWith(
          _$_Forbidden value, $Res Function(_$_Forbidden) then) =
      __$$_ForbiddenCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FailureInfo info});

  @override
  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$_ForbiddenCopyWithImpl<$Res>
    extends _$AuthFailuresCopyWithImpl<$Res, _$_Forbidden>
    implements _$$_ForbiddenCopyWith<$Res> {
  __$$_ForbiddenCopyWithImpl(
      _$_Forbidden _value, $Res Function(_$_Forbidden) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$_Forbidden(
      null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }
}

/// @nodoc

class _$_Forbidden extends _Forbidden {
  const _$_Forbidden(this.info) : super._();

  @override
  final FailureInfo info;

  @override
  String toString() {
    return 'AuthFailures.forbidden(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Forbidden &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ForbiddenCopyWith<_$_Forbidden> get copyWith =>
      __$$_ForbiddenCopyWithImpl<_$_Forbidden>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(FailureInfo info) $default, {
    required TResult Function(FailureInfo info) incorrectLoginCredential,
    required TResult Function(FailureInfo info) forbidden,
    required TResult Function(FailureInfo info) alreadyRegistered,
  }) {
    return forbidden(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(FailureInfo info)? $default, {
    TResult? Function(FailureInfo info)? incorrectLoginCredential,
    TResult? Function(FailureInfo info)? forbidden,
    TResult? Function(FailureInfo info)? alreadyRegistered,
  }) {
    return forbidden?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(FailureInfo info)? $default, {
    TResult Function(FailureInfo info)? incorrectLoginCredential,
    TResult Function(FailureInfo info)? forbidden,
    TResult Function(FailureInfo info)? alreadyRegistered,
    required TResult orElse(),
  }) {
    if (forbidden != null) {
      return forbidden(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AuthFailures value) $default, {
    required TResult Function(_IncorrectLoginCredential value)
        incorrectLoginCredential,
    required TResult Function(_Forbidden value) forbidden,
    required TResult Function(_UserAlreadyRegistered value) alreadyRegistered,
  }) {
    return forbidden(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AuthFailures value)? $default, {
    TResult? Function(_IncorrectLoginCredential value)?
        incorrectLoginCredential,
    TResult? Function(_Forbidden value)? forbidden,
    TResult? Function(_UserAlreadyRegistered value)? alreadyRegistered,
  }) {
    return forbidden?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AuthFailures value)? $default, {
    TResult Function(_IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult Function(_Forbidden value)? forbidden,
    TResult Function(_UserAlreadyRegistered value)? alreadyRegistered,
    required TResult orElse(),
  }) {
    if (forbidden != null) {
      return forbidden(this);
    }
    return orElse();
  }
}

abstract class _Forbidden extends AuthFailures {
  const factory _Forbidden(final FailureInfo info) = _$_Forbidden;
  const _Forbidden._() : super._();

  @override
  FailureInfo get info;
  @override
  @JsonKey(ignore: true)
  _$$_ForbiddenCopyWith<_$_Forbidden> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UserAlreadyRegisteredCopyWith<$Res>
    implements $AuthFailuresCopyWith<$Res> {
  factory _$$_UserAlreadyRegisteredCopyWith(_$_UserAlreadyRegistered value,
          $Res Function(_$_UserAlreadyRegistered) then) =
      __$$_UserAlreadyRegisteredCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FailureInfo info});

  @override
  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$_UserAlreadyRegisteredCopyWithImpl<$Res>
    extends _$AuthFailuresCopyWithImpl<$Res, _$_UserAlreadyRegistered>
    implements _$$_UserAlreadyRegisteredCopyWith<$Res> {
  __$$_UserAlreadyRegisteredCopyWithImpl(_$_UserAlreadyRegistered _value,
      $Res Function(_$_UserAlreadyRegistered) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$_UserAlreadyRegistered(
      null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }
}

/// @nodoc

class _$_UserAlreadyRegistered extends _UserAlreadyRegistered {
  const _$_UserAlreadyRegistered(this.info) : super._();

  @override
  final FailureInfo info;

  @override
  String toString() {
    return 'AuthFailures.alreadyRegistered(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserAlreadyRegistered &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserAlreadyRegisteredCopyWith<_$_UserAlreadyRegistered> get copyWith =>
      __$$_UserAlreadyRegisteredCopyWithImpl<_$_UserAlreadyRegistered>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(FailureInfo info) $default, {
    required TResult Function(FailureInfo info) incorrectLoginCredential,
    required TResult Function(FailureInfo info) forbidden,
    required TResult Function(FailureInfo info) alreadyRegistered,
  }) {
    return alreadyRegistered(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(FailureInfo info)? $default, {
    TResult? Function(FailureInfo info)? incorrectLoginCredential,
    TResult? Function(FailureInfo info)? forbidden,
    TResult? Function(FailureInfo info)? alreadyRegistered,
  }) {
    return alreadyRegistered?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(FailureInfo info)? $default, {
    TResult Function(FailureInfo info)? incorrectLoginCredential,
    TResult Function(FailureInfo info)? forbidden,
    TResult Function(FailureInfo info)? alreadyRegistered,
    required TResult orElse(),
  }) {
    if (alreadyRegistered != null) {
      return alreadyRegistered(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AuthFailures value) $default, {
    required TResult Function(_IncorrectLoginCredential value)
        incorrectLoginCredential,
    required TResult Function(_Forbidden value) forbidden,
    required TResult Function(_UserAlreadyRegistered value) alreadyRegistered,
  }) {
    return alreadyRegistered(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AuthFailures value)? $default, {
    TResult? Function(_IncorrectLoginCredential value)?
        incorrectLoginCredential,
    TResult? Function(_Forbidden value)? forbidden,
    TResult? Function(_UserAlreadyRegistered value)? alreadyRegistered,
  }) {
    return alreadyRegistered?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AuthFailures value)? $default, {
    TResult Function(_IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult Function(_Forbidden value)? forbidden,
    TResult Function(_UserAlreadyRegistered value)? alreadyRegistered,
    required TResult orElse(),
  }) {
    if (alreadyRegistered != null) {
      return alreadyRegistered(this);
    }
    return orElse();
  }
}

abstract class _UserAlreadyRegistered extends AuthFailures {
  const factory _UserAlreadyRegistered(final FailureInfo info) =
      _$_UserAlreadyRegistered;
  const _UserAlreadyRegistered._() : super._();

  @override
  FailureInfo get info;
  @override
  @JsonKey(ignore: true)
  _$$_UserAlreadyRegisteredCopyWith<_$_UserAlreadyRegistered> get copyWith =>
      throw _privateConstructorUsedError;
}
