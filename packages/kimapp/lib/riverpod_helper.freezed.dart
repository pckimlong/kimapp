// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'riverpod_helper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaginatedItem<T> {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PaginatedItem<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PaginatedItem<$T>()';
  }
}

/// @nodoc
class $PaginatedItemCopyWith<T, $Res> {
  $PaginatedItemCopyWith(
      PaginatedItem<T> _, $Res Function(PaginatedItem<T>) __);
}

/// @nodoc

class _Data<T> extends PaginatedItem<T> {
  const _Data(this.item) : super._();

  final T item;

  /// Create a copy of PaginatedItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DataCopyWith<T, _Data<T>> get copyWith =>
      __$DataCopyWithImpl<T, _Data<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Data<T> &&
            const DeepCollectionEquality().equals(other.item, item));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(item));

  @override
  String toString() {
    return 'PaginatedItem<$T>.data(item: $item)';
  }
}

/// @nodoc
abstract mixin class _$DataCopyWith<T, $Res>
    implements $PaginatedItemCopyWith<T, $Res> {
  factory _$DataCopyWith(_Data<T> value, $Res Function(_Data<T>) _then) =
      __$DataCopyWithImpl;
  @useResult
  $Res call({T item});
}

/// @nodoc
class __$DataCopyWithImpl<T, $Res> implements _$DataCopyWith<T, $Res> {
  __$DataCopyWithImpl(this._self, this._then);

  final _Data<T> _self;
  final $Res Function(_Data<T>) _then;

  /// Create a copy of PaginatedItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? item = freezed,
  }) {
    return _then(_Data<T>(
      freezed == item
          ? _self.item
          : item // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _Loading<T> extends PaginatedItem<T> {
  const _Loading({this.isFirstItem = true}) : super._();

  @JsonKey()
  final bool isFirstItem;

  /// Create a copy of PaginatedItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoadingCopyWith<T, _Loading<T>> get copyWith =>
      __$LoadingCopyWithImpl<T, _Loading<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Loading<T> &&
            (identical(other.isFirstItem, isFirstItem) ||
                other.isFirstItem == isFirstItem));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isFirstItem);

  @override
  String toString() {
    return 'PaginatedItem<$T>.loading(isFirstItem: $isFirstItem)';
  }
}

/// @nodoc
abstract mixin class _$LoadingCopyWith<T, $Res>
    implements $PaginatedItemCopyWith<T, $Res> {
  factory _$LoadingCopyWith(
          _Loading<T> value, $Res Function(_Loading<T>) _then) =
      __$LoadingCopyWithImpl;
  @useResult
  $Res call({bool isFirstItem});
}

/// @nodoc
class __$LoadingCopyWithImpl<T, $Res> implements _$LoadingCopyWith<T, $Res> {
  __$LoadingCopyWithImpl(this._self, this._then);

  final _Loading<T> _self;
  final $Res Function(_Loading<T>) _then;

  /// Create a copy of PaginatedItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isFirstItem = null,
  }) {
    return _then(_Loading<T>(
      isFirstItem: null == isFirstItem
          ? _self.isFirstItem
          : isFirstItem // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _Error<T> extends PaginatedItem<T> {
  const _Error(this.failure) : super._();

  final Failure failure;

  /// Create a copy of PaginatedItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ErrorCopyWith<T, _Error<T>> get copyWith =>
      __$ErrorCopyWithImpl<T, _Error<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Error<T> &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @override
  String toString() {
    return 'PaginatedItem<$T>.error(failure: $failure)';
  }
}

/// @nodoc
abstract mixin class _$ErrorCopyWith<T, $Res>
    implements $PaginatedItemCopyWith<T, $Res> {
  factory _$ErrorCopyWith(_Error<T> value, $Res Function(_Error<T>) _then) =
      __$ErrorCopyWithImpl;
  @useResult
  $Res call({Failure failure});

  $FailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$ErrorCopyWithImpl<T, $Res> implements _$ErrorCopyWith<T, $Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error<T> _self;
  final $Res Function(_Error<T>) _then;

  /// Create a copy of PaginatedItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? failure = null,
  }) {
    return _then(_Error<T>(
      null == failure
          ? _self.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure,
    ));
  }

  /// Create a copy of PaginatedItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureCopyWith<$Res> get failure {
    return $FailureCopyWith<$Res>(_self.failure, (value) {
      return _then(_self.copyWith(failure: value));
    });
  }
}

/// @nodoc
mixin _$ProviderStatus<T> {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ProviderStatus<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ProviderStatus<$T>()';
  }
}

/// @nodoc
class $ProviderStatusCopyWith<T, $Res> {
  $ProviderStatusCopyWith(
      ProviderStatus<T> _, $Res Function(ProviderStatus<T>) __);
}

/// @nodoc

class _Initial<T> implements ProviderStatus<T> {
  const _Initial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Initial<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ProviderStatus<$T>.initial()';
  }
}

/// @nodoc

class _InProgress<T> implements ProviderStatus<T> {
  const _InProgress();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _InProgress<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ProviderStatus<$T>.inProgress()';
  }
}

/// @nodoc

class _Failure<T> implements ProviderStatus<T> {
  const _Failure(this.failure);

  final Failure failure;

  /// Create a copy of ProviderStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FailureCopyWith<T, _Failure<T>> get copyWith =>
      __$FailureCopyWithImpl<T, _Failure<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Failure<T> &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @override
  String toString() {
    return 'ProviderStatus<$T>.failure(failure: $failure)';
  }
}

/// @nodoc
abstract mixin class _$FailureCopyWith<T, $Res>
    implements $ProviderStatusCopyWith<T, $Res> {
  factory _$FailureCopyWith(
          _Failure<T> value, $Res Function(_Failure<T>) _then) =
      __$FailureCopyWithImpl;
  @useResult
  $Res call({Failure failure});

  $FailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$FailureCopyWithImpl<T, $Res> implements _$FailureCopyWith<T, $Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure<T> _self;
  final $Res Function(_Failure<T>) _then;

  /// Create a copy of ProviderStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? failure = null,
  }) {
    return _then(_Failure<T>(
      null == failure
          ? _self.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure,
    ));
  }

  /// Create a copy of ProviderStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureCopyWith<$Res> get failure {
    return $FailureCopyWith<$Res>(_self.failure, (value) {
      return _then(_self.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _Success<T> implements ProviderStatus<T> {
  const _Success(this.success);

  final T success;

  /// Create a copy of ProviderStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SuccessCopyWith<T, _Success<T>> get copyWith =>
      __$SuccessCopyWithImpl<T, _Success<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Success<T> &&
            const DeepCollectionEquality().equals(other.success, success));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(success));

  @override
  String toString() {
    return 'ProviderStatus<$T>.success(success: $success)';
  }
}

/// @nodoc
abstract mixin class _$SuccessCopyWith<T, $Res>
    implements $ProviderStatusCopyWith<T, $Res> {
  factory _$SuccessCopyWith(
          _Success<T> value, $Res Function(_Success<T>) _then) =
      __$SuccessCopyWithImpl;
  @useResult
  $Res call({T success});
}

/// @nodoc
class __$SuccessCopyWithImpl<T, $Res> implements _$SuccessCopyWith<T, $Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success<T> _self;
  final $Res Function(_Success<T>) _then;

  /// Create a copy of ProviderStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? success = freezed,
  }) {
    return _then(_Success<T>(
      freezed == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

// dart format on
