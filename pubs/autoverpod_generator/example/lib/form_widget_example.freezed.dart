// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_widget_example.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateUserModel {

 String get name; int? get age; String? get email; String? get address; String? get phone;
/// Create a copy of UpdateUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateUserModelCopyWith<UpdateUserModel> get copyWith => _$UpdateUserModelCopyWithImpl<UpdateUserModel>(this as UpdateUserModel, _$identity);

  /// Serializes this UpdateUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateUserModel&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age)&&(identical(other.email, email) || other.email == email)&&(identical(other.address, address) || other.address == address)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,age,email,address,phone);

@override
String toString() {
  return 'UpdateUserModel(name: $name, age: $age, email: $email, address: $address, phone: $phone)';
}


}

/// @nodoc
abstract mixin class $UpdateUserModelCopyWith<$Res>  {
  factory $UpdateUserModelCopyWith(UpdateUserModel value, $Res Function(UpdateUserModel) _then) = _$UpdateUserModelCopyWithImpl;
@useResult
$Res call({
 String name, int? age, String? email, String? address, String? phone
});




}
/// @nodoc
class _$UpdateUserModelCopyWithImpl<$Res>
    implements $UpdateUserModelCopyWith<$Res> {
  _$UpdateUserModelCopyWithImpl(this._self, this._then);

  final UpdateUserModel _self;
  final $Res Function(UpdateUserModel) _then;

/// Create a copy of UpdateUserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? age = freezed,Object? email = freezed,Object? address = freezed,Object? phone = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateUserModel].
extension UpdateUserModelPatterns on UpdateUserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateUserModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateUserModel value)  $default,){
final _that = this;
switch (_that) {
case _UpdateUserModel():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateUserModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int? age,  String? email,  String? address,  String? phone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateUserModel() when $default != null:
return $default(_that.name,_that.age,_that.email,_that.address,_that.phone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int? age,  String? email,  String? address,  String? phone)  $default,) {final _that = this;
switch (_that) {
case _UpdateUserModel():
return $default(_that.name,_that.age,_that.email,_that.address,_that.phone);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int? age,  String? email,  String? address,  String? phone)?  $default,) {final _that = this;
switch (_that) {
case _UpdateUserModel() when $default != null:
return $default(_that.name,_that.age,_that.email,_that.address,_that.phone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateUserModel extends UpdateUserModel {
  const _UpdateUserModel({this.name = '', this.age, this.email, this.address, this.phone}): super._();
  factory _UpdateUserModel.fromJson(Map<String, dynamic> json) => _$UpdateUserModelFromJson(json);

@override@JsonKey() final  String name;
@override final  int? age;
@override final  String? email;
@override final  String? address;
@override final  String? phone;

/// Create a copy of UpdateUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateUserModelCopyWith<_UpdateUserModel> get copyWith => __$UpdateUserModelCopyWithImpl<_UpdateUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateUserModel&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age)&&(identical(other.email, email) || other.email == email)&&(identical(other.address, address) || other.address == address)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,age,email,address,phone);

@override
String toString() {
  return 'UpdateUserModel(name: $name, age: $age, email: $email, address: $address, phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$UpdateUserModelCopyWith<$Res> implements $UpdateUserModelCopyWith<$Res> {
  factory _$UpdateUserModelCopyWith(_UpdateUserModel value, $Res Function(_UpdateUserModel) _then) = __$UpdateUserModelCopyWithImpl;
@override @useResult
$Res call({
 String name, int? age, String? email, String? address, String? phone
});




}
/// @nodoc
class __$UpdateUserModelCopyWithImpl<$Res>
    implements _$UpdateUserModelCopyWith<$Res> {
  __$UpdateUserModelCopyWithImpl(this._self, this._then);

  final _UpdateUserModel _self;
  final $Res Function(_UpdateUserModel) _then;

/// Create a copy of UpdateUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? age = freezed,Object? email = freezed,Object? address = freezed,Object? phone = freezed,}) {
  return _then(_UpdateUserModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
