// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FailureInfo {
  StackTrace get stackTrace;
  String get debugMessage;

  /// Readable message which will be display to user, If [message] is not provided or null
  /// The default message define in [Kimapp] service will be use instead when calling it from [Failure.message()] function
  String? get message;
  Object? get errorObject;

  /// Create a copy of FailureInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FailureInfoCopyWith<FailureInfo> get copyWith =>
      _$FailureInfoCopyWithImpl<FailureInfo>(this as FailureInfo, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FailureInfo &&
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

  @override
  String toString() {
    return 'FailureInfo(stackTrace: $stackTrace, debugMessage: $debugMessage, message: $message, errorObject: $errorObject)';
  }
}

/// @nodoc
abstract mixin class $FailureInfoCopyWith<$Res> {
  factory $FailureInfoCopyWith(
          FailureInfo value, $Res Function(FailureInfo) _then) =
      _$FailureInfoCopyWithImpl;
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String debugMessage,
      String? message,
      Object? errorObject});
}

/// @nodoc
class _$FailureInfoCopyWithImpl<$Res> implements $FailureInfoCopyWith<$Res> {
  _$FailureInfoCopyWithImpl(this._self, this._then);

  final FailureInfo _self;
  final $Res Function(FailureInfo) _then;

  /// Create a copy of FailureInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? debugMessage = null,
    Object? message = freezed,
    Object? errorObject = freezed,
  }) {
    return _then(_self.copyWith(
      stackTrace: null == stackTrace
          ? _self.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      debugMessage: null == debugMessage
          ? _self.debugMessage
          : debugMessage // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      errorObject: freezed == errorObject ? _self.errorObject : errorObject,
    ));
  }
}

/// Adds pattern-matching-related methods to [FailureInfo].
extension FailureInfoPatterns on FailureInfo {
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
    TResult Function(_FailureInfo value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FailureInfo() when $default != null:
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
    TResult Function(_FailureInfo value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FailureInfo():
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
    TResult? Function(_FailureInfo value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FailureInfo() when $default != null:
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
    TResult Function(StackTrace stackTrace, String debugMessage,
            String? message, Object? errorObject)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FailureInfo() when $default != null:
        return $default(_that.stackTrace, _that.debugMessage, _that.message,
            _that.errorObject);
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
    TResult Function(StackTrace stackTrace, String debugMessage,
            String? message, Object? errorObject)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FailureInfo():
        return $default(_that.stackTrace, _that.debugMessage, _that.message,
            _that.errorObject);
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
    TResult? Function(StackTrace stackTrace, String debugMessage,
            String? message, Object? errorObject)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FailureInfo() when $default != null:
        return $default(_that.stackTrace, _that.debugMessage, _that.message,
            _that.errorObject);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _FailureInfo implements FailureInfo {
  _FailureInfo(
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

  /// Create a copy of FailureInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FailureInfoCopyWith<_FailureInfo> get copyWith =>
      __$FailureInfoCopyWithImpl<_FailureInfo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FailureInfo &&
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

  @override
  String toString() {
    return 'FailureInfo(stackTrace: $stackTrace, debugMessage: $debugMessage, message: $message, errorObject: $errorObject)';
  }
}

/// @nodoc
abstract mixin class _$FailureInfoCopyWith<$Res>
    implements $FailureInfoCopyWith<$Res> {
  factory _$FailureInfoCopyWith(
          _FailureInfo value, $Res Function(_FailureInfo) _then) =
      __$FailureInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String debugMessage,
      String? message,
      Object? errorObject});
}

/// @nodoc
class __$FailureInfoCopyWithImpl<$Res> implements _$FailureInfoCopyWith<$Res> {
  __$FailureInfoCopyWithImpl(this._self, this._then);

  final _FailureInfo _self;
  final $Res Function(_FailureInfo) _then;

  /// Create a copy of FailureInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? stackTrace = null,
    Object? debugMessage = null,
    Object? message = freezed,
    Object? errorObject = freezed,
  }) {
    return _then(_FailureInfo(
      stackTrace: null == stackTrace
          ? _self.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      debugMessage: null == debugMessage
          ? _self.debugMessage
          : debugMessage // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      errorObject: freezed == errorObject ? _self.errorObject : errorObject,
    ));
  }
}

/// @nodoc
mixin _$Failure {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Failure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Failure()';
  }
}

/// @nodoc
class $FailureCopyWith<$Res> {
  $FailureCopyWith(Failure _, $Res Function(Failure) __);
}

/// Adds pattern-matching-related methods to [Failure].
extension FailurePatterns on Failure {
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
    TResult Function(_Failure value)? $default, {
    TResult Function(ExceptionFailure value)? exception,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(ServerError value)? serverError,
    TResult Function(DatabaseFailure value)? databaseFailure,
    TResult Function(AuthFailure value)? authFailure,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Failure() when $default != null:
        return $default(_that);
      case ExceptionFailure() when exception != null:
        return exception(_that);
      case NetworkFailure() when networkFailure != null:
        return networkFailure(_that);
      case ServerError() when serverError != null:
        return serverError(_that);
      case DatabaseFailure() when databaseFailure != null:
        return databaseFailure(_that);
      case AuthFailure() when authFailure != null:
        return authFailure(_that);
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
    TResult Function(_Failure value) $default, {
    required TResult Function(ExceptionFailure value) exception,
    required TResult Function(NetworkFailure value) networkFailure,
    required TResult Function(ServerError value) serverError,
    required TResult Function(DatabaseFailure value) databaseFailure,
    required TResult Function(AuthFailure value) authFailure,
  }) {
    final _that = this;
    switch (_that) {
      case _Failure():
        return $default(_that);
      case ExceptionFailure():
        return exception(_that);
      case NetworkFailure():
        return networkFailure(_that);
      case ServerError():
        return serverError(_that);
      case DatabaseFailure():
        return databaseFailure(_that);
      case AuthFailure():
        return authFailure(_that);
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
    TResult? Function(_Failure value)? $default, {
    TResult? Function(ExceptionFailure value)? exception,
    TResult? Function(NetworkFailure value)? networkFailure,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(DatabaseFailure value)? databaseFailure,
    TResult? Function(AuthFailure value)? authFailure,
  }) {
    final _that = this;
    switch (_that) {
      case _Failure() when $default != null:
        return $default(_that);
      case ExceptionFailure() when exception != null:
        return exception(_that);
      case NetworkFailure() when networkFailure != null:
        return networkFailure(_that);
      case ServerError() when serverError != null:
        return serverError(_that);
      case DatabaseFailure() when databaseFailure != null:
        return databaseFailure(_that);
      case AuthFailure() when authFailure != null:
        return authFailure(_that);
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
    TResult Function(FailureInfo info)? $default, {
    TResult Function(FailureInfo info)? exception,
    TResult Function(FailureInfo info)? networkFailure,
    TResult Function(FailureInfo info)? serverError,
    TResult Function(DatabaseFailures failures)? databaseFailure,
    TResult Function(AuthFailures failures)? authFailure,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Failure() when $default != null:
        return $default(_that.info);
      case ExceptionFailure() when exception != null:
        return exception(_that.info);
      case NetworkFailure() when networkFailure != null:
        return networkFailure(_that.info);
      case ServerError() when serverError != null:
        return serverError(_that.info);
      case DatabaseFailure() when databaseFailure != null:
        return databaseFailure(_that.failures);
      case AuthFailure() when authFailure != null:
        return authFailure(_that.failures);
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
    TResult Function(FailureInfo info) $default, {
    required TResult Function(FailureInfo info) exception,
    required TResult Function(FailureInfo info) networkFailure,
    required TResult Function(FailureInfo info) serverError,
    required TResult Function(DatabaseFailures failures) databaseFailure,
    required TResult Function(AuthFailures failures) authFailure,
  }) {
    final _that = this;
    switch (_that) {
      case _Failure():
        return $default(_that.info);
      case ExceptionFailure():
        return exception(_that.info);
      case NetworkFailure():
        return networkFailure(_that.info);
      case ServerError():
        return serverError(_that.info);
      case DatabaseFailure():
        return databaseFailure(_that.failures);
      case AuthFailure():
        return authFailure(_that.failures);
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
    TResult? Function(FailureInfo info)? $default, {
    TResult? Function(FailureInfo info)? exception,
    TResult? Function(FailureInfo info)? networkFailure,
    TResult? Function(FailureInfo info)? serverError,
    TResult? Function(DatabaseFailures failures)? databaseFailure,
    TResult? Function(AuthFailures failures)? authFailure,
  }) {
    final _that = this;
    switch (_that) {
      case _Failure() when $default != null:
        return $default(_that.info);
      case ExceptionFailure() when exception != null:
        return exception(_that.info);
      case NetworkFailure() when networkFailure != null:
        return networkFailure(_that.info);
      case ServerError() when serverError != null:
        return serverError(_that.info);
      case DatabaseFailure() when databaseFailure != null:
        return databaseFailure(_that.failures);
      case AuthFailure() when authFailure != null:
        return authFailure(_that.failures);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Failure extends Failure {
  const _Failure(this.info) : super._();

  final FailureInfo info;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FailureCopyWith<_Failure> get copyWith =>
      __$FailureCopyWithImpl<_Failure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Failure &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @override
  String toString() {
    return 'Failure(info: $info)';
  }
}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) =
      __$FailureCopyWithImpl;
  @useResult
  $Res call({FailureInfo info});

  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$FailureCopyWithImpl<$Res> implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? info = null,
  }) {
    return _then(_Failure(
      null == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureInfoCopyWith<$Res> get info {
    return $FailureInfoCopyWith<$Res>(_self.info, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

/// @nodoc

class ExceptionFailure extends Failure {
  const ExceptionFailure(this.info) : super._();

  final FailureInfo info;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExceptionFailureCopyWith<ExceptionFailure> get copyWith =>
      _$ExceptionFailureCopyWithImpl<ExceptionFailure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExceptionFailure &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @override
  String toString() {
    return 'Failure.exception(info: $info)';
  }
}

/// @nodoc
abstract mixin class $ExceptionFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory $ExceptionFailureCopyWith(
          ExceptionFailure value, $Res Function(ExceptionFailure) _then) =
      _$ExceptionFailureCopyWithImpl;
  @useResult
  $Res call({FailureInfo info});

  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class _$ExceptionFailureCopyWithImpl<$Res>
    implements $ExceptionFailureCopyWith<$Res> {
  _$ExceptionFailureCopyWithImpl(this._self, this._then);

  final ExceptionFailure _self;
  final $Res Function(ExceptionFailure) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? info = null,
  }) {
    return _then(ExceptionFailure(
      null == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureInfoCopyWith<$Res> get info {
    return $FailureInfoCopyWith<$Res>(_self.info, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

/// @nodoc

class NetworkFailure extends Failure {
  const NetworkFailure(this.info) : super._();

  final FailureInfo info;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NetworkFailureCopyWith<NetworkFailure> get copyWith =>
      _$NetworkFailureCopyWithImpl<NetworkFailure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NetworkFailure &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @override
  String toString() {
    return 'Failure.networkFailure(info: $info)';
  }
}

/// @nodoc
abstract mixin class $NetworkFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory $NetworkFailureCopyWith(
          NetworkFailure value, $Res Function(NetworkFailure) _then) =
      _$NetworkFailureCopyWithImpl;
  @useResult
  $Res call({FailureInfo info});

  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class _$NetworkFailureCopyWithImpl<$Res>
    implements $NetworkFailureCopyWith<$Res> {
  _$NetworkFailureCopyWithImpl(this._self, this._then);

  final NetworkFailure _self;
  final $Res Function(NetworkFailure) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? info = null,
  }) {
    return _then(NetworkFailure(
      null == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureInfoCopyWith<$Res> get info {
    return $FailureInfoCopyWith<$Res>(_self.info, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

/// @nodoc

class ServerError extends Failure {
  const ServerError(this.info) : super._();

  final FailureInfo info;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ServerErrorCopyWith<ServerError> get copyWith =>
      _$ServerErrorCopyWithImpl<ServerError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ServerError &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @override
  String toString() {
    return 'Failure.serverError(info: $info)';
  }
}

/// @nodoc
abstract mixin class $ServerErrorCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory $ServerErrorCopyWith(
          ServerError value, $Res Function(ServerError) _then) =
      _$ServerErrorCopyWithImpl;
  @useResult
  $Res call({FailureInfo info});

  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class _$ServerErrorCopyWithImpl<$Res> implements $ServerErrorCopyWith<$Res> {
  _$ServerErrorCopyWithImpl(this._self, this._then);

  final ServerError _self;
  final $Res Function(ServerError) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? info = null,
  }) {
    return _then(ServerError(
      null == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureInfoCopyWith<$Res> get info {
    return $FailureInfoCopyWith<$Res>(_self.info, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

/// @nodoc

class DatabaseFailure extends Failure {
  const DatabaseFailure(this.failures) : super._();

  final DatabaseFailures failures;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DatabaseFailureCopyWith<DatabaseFailure> get copyWith =>
      _$DatabaseFailureCopyWithImpl<DatabaseFailure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DatabaseFailure &&
            (identical(other.failures, failures) ||
                other.failures == failures));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failures);

  @override
  String toString() {
    return 'Failure.databaseFailure(failures: $failures)';
  }
}

/// @nodoc
abstract mixin class $DatabaseFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory $DatabaseFailureCopyWith(
          DatabaseFailure value, $Res Function(DatabaseFailure) _then) =
      _$DatabaseFailureCopyWithImpl;
  @useResult
  $Res call({DatabaseFailures failures});

  $DatabaseFailuresCopyWith<$Res> get failures;
}

/// @nodoc
class _$DatabaseFailureCopyWithImpl<$Res>
    implements $DatabaseFailureCopyWith<$Res> {
  _$DatabaseFailureCopyWithImpl(this._self, this._then);

  final DatabaseFailure _self;
  final $Res Function(DatabaseFailure) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? failures = null,
  }) {
    return _then(DatabaseFailure(
      null == failures
          ? _self.failures
          : failures // ignore: cast_nullable_to_non_nullable
              as DatabaseFailures,
    ));
  }

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DatabaseFailuresCopyWith<$Res> get failures {
    return $DatabaseFailuresCopyWith<$Res>(_self.failures, (value) {
      return _then(_self.copyWith(failures: value));
    });
  }
}

/// @nodoc

class AuthFailure extends Failure {
  const AuthFailure(this.failures) : super._();

  final AuthFailures failures;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthFailureCopyWith<AuthFailure> get copyWith =>
      _$AuthFailureCopyWithImpl<AuthFailure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthFailure &&
            (identical(other.failures, failures) ||
                other.failures == failures));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failures);

  @override
  String toString() {
    return 'Failure.authFailure(failures: $failures)';
  }
}

/// @nodoc
abstract mixin class $AuthFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory $AuthFailureCopyWith(
          AuthFailure value, $Res Function(AuthFailure) _then) =
      _$AuthFailureCopyWithImpl;
  @useResult
  $Res call({AuthFailures failures});

  $AuthFailuresCopyWith<$Res> get failures;
}

/// @nodoc
class _$AuthFailureCopyWithImpl<$Res> implements $AuthFailureCopyWith<$Res> {
  _$AuthFailureCopyWithImpl(this._self, this._then);

  final AuthFailure _self;
  final $Res Function(AuthFailure) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? failures = null,
  }) {
    return _then(AuthFailure(
      null == failures
          ? _self.failures
          : failures // ignore: cast_nullable_to_non_nullable
              as AuthFailures,
    ));
  }

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthFailuresCopyWith<$Res> get failures {
    return $AuthFailuresCopyWith<$Res>(_self.failures, (value) {
      return _then(_self.copyWith(failures: value));
    });
  }
}

/// @nodoc
mixin _$DatabaseFailures {
  FailureInfo get info;

  /// Create a copy of DatabaseFailures
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DatabaseFailuresCopyWith<DatabaseFailures> get copyWith =>
      _$DatabaseFailuresCopyWithImpl<DatabaseFailures>(
          this as DatabaseFailures, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DatabaseFailures &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @override
  String toString() {
    return 'DatabaseFailures(info: $info)';
  }
}

/// @nodoc
abstract mixin class $DatabaseFailuresCopyWith<$Res> {
  factory $DatabaseFailuresCopyWith(
          DatabaseFailures value, $Res Function(DatabaseFailures) _then) =
      _$DatabaseFailuresCopyWithImpl;
  @useResult
  $Res call({FailureInfo info});

  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class _$DatabaseFailuresCopyWithImpl<$Res>
    implements $DatabaseFailuresCopyWith<$Res> {
  _$DatabaseFailuresCopyWithImpl(this._self, this._then);

  final DatabaseFailures _self;
  final $Res Function(DatabaseFailures) _then;

  /// Create a copy of DatabaseFailures
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_self.copyWith(
      info: null == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }

  /// Create a copy of DatabaseFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureInfoCopyWith<$Res> get info {
    return $FailureInfoCopyWith<$Res>(_self.info, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

/// Adds pattern-matching-related methods to [DatabaseFailures].
extension DatabaseFailuresPatterns on DatabaseFailures {
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
    TResult Function(_DatabaseFailures value)? $default, {
    TResult Function(_UniqueConstraint value)? uniqueConstraint,
    TResult Function(_NotFound value)? notFound,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DatabaseFailures() when $default != null:
        return $default(_that);
      case _UniqueConstraint() when uniqueConstraint != null:
        return uniqueConstraint(_that);
      case _NotFound() when notFound != null:
        return notFound(_that);
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
    TResult Function(_DatabaseFailures value) $default, {
    required TResult Function(_UniqueConstraint value) uniqueConstraint,
    required TResult Function(_NotFound value) notFound,
  }) {
    final _that = this;
    switch (_that) {
      case _DatabaseFailures():
        return $default(_that);
      case _UniqueConstraint():
        return uniqueConstraint(_that);
      case _NotFound():
        return notFound(_that);
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
    TResult? Function(_DatabaseFailures value)? $default, {
    TResult? Function(_UniqueConstraint value)? uniqueConstraint,
    TResult? Function(_NotFound value)? notFound,
  }) {
    final _that = this;
    switch (_that) {
      case _DatabaseFailures() when $default != null:
        return $default(_that);
      case _UniqueConstraint() when uniqueConstraint != null:
        return uniqueConstraint(_that);
      case _NotFound() when notFound != null:
        return notFound(_that);
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
    TResult Function(FailureInfo info)? $default, {
    TResult Function(FailureInfo info)? uniqueConstraint,
    TResult Function(FailureInfo info)? notFound,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DatabaseFailures() when $default != null:
        return $default(_that.info);
      case _UniqueConstraint() when uniqueConstraint != null:
        return uniqueConstraint(_that.info);
      case _NotFound() when notFound != null:
        return notFound(_that.info);
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
    TResult Function(FailureInfo info) $default, {
    required TResult Function(FailureInfo info) uniqueConstraint,
    required TResult Function(FailureInfo info) notFound,
  }) {
    final _that = this;
    switch (_that) {
      case _DatabaseFailures():
        return $default(_that.info);
      case _UniqueConstraint():
        return uniqueConstraint(_that.info);
      case _NotFound():
        return notFound(_that.info);
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
    TResult? Function(FailureInfo info)? $default, {
    TResult? Function(FailureInfo info)? uniqueConstraint,
    TResult? Function(FailureInfo info)? notFound,
  }) {
    final _that = this;
    switch (_that) {
      case _DatabaseFailures() when $default != null:
        return $default(_that.info);
      case _UniqueConstraint() when uniqueConstraint != null:
        return uniqueConstraint(_that.info);
      case _NotFound() when notFound != null:
        return notFound(_that.info);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DatabaseFailures extends DatabaseFailures {
  const _DatabaseFailures(this.info) : super._();

  @override
  final FailureInfo info;

  /// Create a copy of DatabaseFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DatabaseFailuresCopyWith<_DatabaseFailures> get copyWith =>
      __$DatabaseFailuresCopyWithImpl<_DatabaseFailures>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DatabaseFailures &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @override
  String toString() {
    return 'DatabaseFailures(info: $info)';
  }
}

/// @nodoc
abstract mixin class _$DatabaseFailuresCopyWith<$Res>
    implements $DatabaseFailuresCopyWith<$Res> {
  factory _$DatabaseFailuresCopyWith(
          _DatabaseFailures value, $Res Function(_DatabaseFailures) _then) =
      __$DatabaseFailuresCopyWithImpl;
  @override
  @useResult
  $Res call({FailureInfo info});

  @override
  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$DatabaseFailuresCopyWithImpl<$Res>
    implements _$DatabaseFailuresCopyWith<$Res> {
  __$DatabaseFailuresCopyWithImpl(this._self, this._then);

  final _DatabaseFailures _self;
  final $Res Function(_DatabaseFailures) _then;

  /// Create a copy of DatabaseFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? info = null,
  }) {
    return _then(_DatabaseFailures(
      null == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }

  /// Create a copy of DatabaseFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureInfoCopyWith<$Res> get info {
    return $FailureInfoCopyWith<$Res>(_self.info, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

/// @nodoc

class _UniqueConstraint extends DatabaseFailures {
  const _UniqueConstraint(this.info) : super._();

  @override
  final FailureInfo info;

  /// Create a copy of DatabaseFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UniqueConstraintCopyWith<_UniqueConstraint> get copyWith =>
      __$UniqueConstraintCopyWithImpl<_UniqueConstraint>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UniqueConstraint &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @override
  String toString() {
    return 'DatabaseFailures.uniqueConstraint(info: $info)';
  }
}

/// @nodoc
abstract mixin class _$UniqueConstraintCopyWith<$Res>
    implements $DatabaseFailuresCopyWith<$Res> {
  factory _$UniqueConstraintCopyWith(
          _UniqueConstraint value, $Res Function(_UniqueConstraint) _then) =
      __$UniqueConstraintCopyWithImpl;
  @override
  @useResult
  $Res call({FailureInfo info});

  @override
  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$UniqueConstraintCopyWithImpl<$Res>
    implements _$UniqueConstraintCopyWith<$Res> {
  __$UniqueConstraintCopyWithImpl(this._self, this._then);

  final _UniqueConstraint _self;
  final $Res Function(_UniqueConstraint) _then;

  /// Create a copy of DatabaseFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? info = null,
  }) {
    return _then(_UniqueConstraint(
      null == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }

  /// Create a copy of DatabaseFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureInfoCopyWith<$Res> get info {
    return $FailureInfoCopyWith<$Res>(_self.info, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

/// @nodoc

class _NotFound extends DatabaseFailures {
  const _NotFound(this.info) : super._();

  @override
  final FailureInfo info;

  /// Create a copy of DatabaseFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NotFoundCopyWith<_NotFound> get copyWith =>
      __$NotFoundCopyWithImpl<_NotFound>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotFound &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @override
  String toString() {
    return 'DatabaseFailures.notFound(info: $info)';
  }
}

/// @nodoc
abstract mixin class _$NotFoundCopyWith<$Res>
    implements $DatabaseFailuresCopyWith<$Res> {
  factory _$NotFoundCopyWith(_NotFound value, $Res Function(_NotFound) _then) =
      __$NotFoundCopyWithImpl;
  @override
  @useResult
  $Res call({FailureInfo info});

  @override
  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$NotFoundCopyWithImpl<$Res> implements _$NotFoundCopyWith<$Res> {
  __$NotFoundCopyWithImpl(this._self, this._then);

  final _NotFound _self;
  final $Res Function(_NotFound) _then;

  /// Create a copy of DatabaseFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? info = null,
  }) {
    return _then(_NotFound(
      null == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }

  /// Create a copy of DatabaseFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureInfoCopyWith<$Res> get info {
    return $FailureInfoCopyWith<$Res>(_self.info, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

/// @nodoc
mixin _$AuthFailures {
  FailureInfo get info;

  /// Create a copy of AuthFailures
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthFailuresCopyWith<AuthFailures> get copyWith =>
      _$AuthFailuresCopyWithImpl<AuthFailures>(
          this as AuthFailures, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthFailures &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @override
  String toString() {
    return 'AuthFailures(info: $info)';
  }
}

/// @nodoc
abstract mixin class $AuthFailuresCopyWith<$Res> {
  factory $AuthFailuresCopyWith(
          AuthFailures value, $Res Function(AuthFailures) _then) =
      _$AuthFailuresCopyWithImpl;
  @useResult
  $Res call({FailureInfo info});

  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class _$AuthFailuresCopyWithImpl<$Res> implements $AuthFailuresCopyWith<$Res> {
  _$AuthFailuresCopyWithImpl(this._self, this._then);

  final AuthFailures _self;
  final $Res Function(AuthFailures) _then;

  /// Create a copy of AuthFailures
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_self.copyWith(
      info: null == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }

  /// Create a copy of AuthFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureInfoCopyWith<$Res> get info {
    return $FailureInfoCopyWith<$Res>(_self.info, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

/// Adds pattern-matching-related methods to [AuthFailures].
extension AuthFailuresPatterns on AuthFailures {
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
    TResult Function(_AuthFailures value)? $default, {
    TResult Function(_IncorrectLoginCredential value)? incorrectLoginCredential,
    TResult Function(_Forbidden value)? forbidden,
    TResult Function(_UserAlreadyRegistered value)? alreadyRegistered,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuthFailures() when $default != null:
        return $default(_that);
      case _IncorrectLoginCredential() when incorrectLoginCredential != null:
        return incorrectLoginCredential(_that);
      case _Forbidden() when forbidden != null:
        return forbidden(_that);
      case _UserAlreadyRegistered() when alreadyRegistered != null:
        return alreadyRegistered(_that);
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
    TResult Function(_AuthFailures value) $default, {
    required TResult Function(_IncorrectLoginCredential value)
        incorrectLoginCredential,
    required TResult Function(_Forbidden value) forbidden,
    required TResult Function(_UserAlreadyRegistered value) alreadyRegistered,
  }) {
    final _that = this;
    switch (_that) {
      case _AuthFailures():
        return $default(_that);
      case _IncorrectLoginCredential():
        return incorrectLoginCredential(_that);
      case _Forbidden():
        return forbidden(_that);
      case _UserAlreadyRegistered():
        return alreadyRegistered(_that);
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
    TResult? Function(_AuthFailures value)? $default, {
    TResult? Function(_IncorrectLoginCredential value)?
        incorrectLoginCredential,
    TResult? Function(_Forbidden value)? forbidden,
    TResult? Function(_UserAlreadyRegistered value)? alreadyRegistered,
  }) {
    final _that = this;
    switch (_that) {
      case _AuthFailures() when $default != null:
        return $default(_that);
      case _IncorrectLoginCredential() when incorrectLoginCredential != null:
        return incorrectLoginCredential(_that);
      case _Forbidden() when forbidden != null:
        return forbidden(_that);
      case _UserAlreadyRegistered() when alreadyRegistered != null:
        return alreadyRegistered(_that);
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
    TResult Function(FailureInfo info)? $default, {
    TResult Function(FailureInfo info)? incorrectLoginCredential,
    TResult Function(FailureInfo info)? forbidden,
    TResult Function(FailureInfo info)? alreadyRegistered,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuthFailures() when $default != null:
        return $default(_that.info);
      case _IncorrectLoginCredential() when incorrectLoginCredential != null:
        return incorrectLoginCredential(_that.info);
      case _Forbidden() when forbidden != null:
        return forbidden(_that.info);
      case _UserAlreadyRegistered() when alreadyRegistered != null:
        return alreadyRegistered(_that.info);
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
    TResult Function(FailureInfo info) $default, {
    required TResult Function(FailureInfo info) incorrectLoginCredential,
    required TResult Function(FailureInfo info) forbidden,
    required TResult Function(FailureInfo info) alreadyRegistered,
  }) {
    final _that = this;
    switch (_that) {
      case _AuthFailures():
        return $default(_that.info);
      case _IncorrectLoginCredential():
        return incorrectLoginCredential(_that.info);
      case _Forbidden():
        return forbidden(_that.info);
      case _UserAlreadyRegistered():
        return alreadyRegistered(_that.info);
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
    TResult? Function(FailureInfo info)? $default, {
    TResult? Function(FailureInfo info)? incorrectLoginCredential,
    TResult? Function(FailureInfo info)? forbidden,
    TResult? Function(FailureInfo info)? alreadyRegistered,
  }) {
    final _that = this;
    switch (_that) {
      case _AuthFailures() when $default != null:
        return $default(_that.info);
      case _IncorrectLoginCredential() when incorrectLoginCredential != null:
        return incorrectLoginCredential(_that.info);
      case _Forbidden() when forbidden != null:
        return forbidden(_that.info);
      case _UserAlreadyRegistered() when alreadyRegistered != null:
        return alreadyRegistered(_that.info);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AuthFailures extends AuthFailures {
  const _AuthFailures(this.info) : super._();

  @override
  final FailureInfo info;

  /// Create a copy of AuthFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthFailuresCopyWith<_AuthFailures> get copyWith =>
      __$AuthFailuresCopyWithImpl<_AuthFailures>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthFailures &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @override
  String toString() {
    return 'AuthFailures(info: $info)';
  }
}

/// @nodoc
abstract mixin class _$AuthFailuresCopyWith<$Res>
    implements $AuthFailuresCopyWith<$Res> {
  factory _$AuthFailuresCopyWith(
          _AuthFailures value, $Res Function(_AuthFailures) _then) =
      __$AuthFailuresCopyWithImpl;
  @override
  @useResult
  $Res call({FailureInfo info});

  @override
  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$AuthFailuresCopyWithImpl<$Res>
    implements _$AuthFailuresCopyWith<$Res> {
  __$AuthFailuresCopyWithImpl(this._self, this._then);

  final _AuthFailures _self;
  final $Res Function(_AuthFailures) _then;

  /// Create a copy of AuthFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? info = null,
  }) {
    return _then(_AuthFailures(
      null == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }

  /// Create a copy of AuthFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureInfoCopyWith<$Res> get info {
    return $FailureInfoCopyWith<$Res>(_self.info, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

/// @nodoc

class _IncorrectLoginCredential extends AuthFailures {
  const _IncorrectLoginCredential(this.info) : super._();

  @override
  final FailureInfo info;

  /// Create a copy of AuthFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IncorrectLoginCredentialCopyWith<_IncorrectLoginCredential> get copyWith =>
      __$IncorrectLoginCredentialCopyWithImpl<_IncorrectLoginCredential>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IncorrectLoginCredential &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @override
  String toString() {
    return 'AuthFailures.incorrectLoginCredential(info: $info)';
  }
}

/// @nodoc
abstract mixin class _$IncorrectLoginCredentialCopyWith<$Res>
    implements $AuthFailuresCopyWith<$Res> {
  factory _$IncorrectLoginCredentialCopyWith(_IncorrectLoginCredential value,
          $Res Function(_IncorrectLoginCredential) _then) =
      __$IncorrectLoginCredentialCopyWithImpl;
  @override
  @useResult
  $Res call({FailureInfo info});

  @override
  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$IncorrectLoginCredentialCopyWithImpl<$Res>
    implements _$IncorrectLoginCredentialCopyWith<$Res> {
  __$IncorrectLoginCredentialCopyWithImpl(this._self, this._then);

  final _IncorrectLoginCredential _self;
  final $Res Function(_IncorrectLoginCredential) _then;

  /// Create a copy of AuthFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? info = null,
  }) {
    return _then(_IncorrectLoginCredential(
      null == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }

  /// Create a copy of AuthFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureInfoCopyWith<$Res> get info {
    return $FailureInfoCopyWith<$Res>(_self.info, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

/// @nodoc

class _Forbidden extends AuthFailures {
  const _Forbidden(this.info) : super._();

  @override
  final FailureInfo info;

  /// Create a copy of AuthFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ForbiddenCopyWith<_Forbidden> get copyWith =>
      __$ForbiddenCopyWithImpl<_Forbidden>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Forbidden &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @override
  String toString() {
    return 'AuthFailures.forbidden(info: $info)';
  }
}

/// @nodoc
abstract mixin class _$ForbiddenCopyWith<$Res>
    implements $AuthFailuresCopyWith<$Res> {
  factory _$ForbiddenCopyWith(
          _Forbidden value, $Res Function(_Forbidden) _then) =
      __$ForbiddenCopyWithImpl;
  @override
  @useResult
  $Res call({FailureInfo info});

  @override
  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$ForbiddenCopyWithImpl<$Res> implements _$ForbiddenCopyWith<$Res> {
  __$ForbiddenCopyWithImpl(this._self, this._then);

  final _Forbidden _self;
  final $Res Function(_Forbidden) _then;

  /// Create a copy of AuthFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? info = null,
  }) {
    return _then(_Forbidden(
      null == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }

  /// Create a copy of AuthFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureInfoCopyWith<$Res> get info {
    return $FailureInfoCopyWith<$Res>(_self.info, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

/// @nodoc

class _UserAlreadyRegistered extends AuthFailures {
  const _UserAlreadyRegistered(this.info) : super._();

  @override
  final FailureInfo info;

  /// Create a copy of AuthFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserAlreadyRegisteredCopyWith<_UserAlreadyRegistered> get copyWith =>
      __$UserAlreadyRegisteredCopyWithImpl<_UserAlreadyRegistered>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserAlreadyRegistered &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @override
  String toString() {
    return 'AuthFailures.alreadyRegistered(info: $info)';
  }
}

/// @nodoc
abstract mixin class _$UserAlreadyRegisteredCopyWith<$Res>
    implements $AuthFailuresCopyWith<$Res> {
  factory _$UserAlreadyRegisteredCopyWith(_UserAlreadyRegistered value,
          $Res Function(_UserAlreadyRegistered) _then) =
      __$UserAlreadyRegisteredCopyWithImpl;
  @override
  @useResult
  $Res call({FailureInfo info});

  @override
  $FailureInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$UserAlreadyRegisteredCopyWithImpl<$Res>
    implements _$UserAlreadyRegisteredCopyWith<$Res> {
  __$UserAlreadyRegisteredCopyWithImpl(this._self, this._then);

  final _UserAlreadyRegistered _self;
  final $Res Function(_UserAlreadyRegistered) _then;

  /// Create a copy of AuthFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? info = null,
  }) {
    return _then(_UserAlreadyRegistered(
      null == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as FailureInfo,
    ));
  }

  /// Create a copy of AuthFailures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureInfoCopyWith<$Res> get info {
    return $FailureInfoCopyWith<$Res>(_self.info, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

// dart format on
