// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateConnectionInput {

 String get displayName; String get remoteAddress; String get username; EncryptedValue get password; String get rootPath; bool get allowSelfSignedCertificate;
/// Create a copy of CreateConnectionInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateConnectionInputCopyWith<CreateConnectionInput> get copyWith => _$CreateConnectionInputCopyWithImpl<CreateConnectionInput>(this as CreateConnectionInput, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CreateConnectionInput;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateConnectionInput&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.remoteAddress, _this.remoteAddress) || other.remoteAddress == _this.remoteAddress)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.password, _this.password) || other.password == _this.password)&&(identical(other.rootPath, _this.rootPath) || other.rootPath == _this.rootPath)&&(identical(other.allowSelfSignedCertificate, _this.allowSelfSignedCertificate) || other.allowSelfSignedCertificate == _this.allowSelfSignedCertificate));
}


@override
int get hashCode {
  final _this = this as CreateConnectionInput;
  return Object.hash(runtimeType,_this.displayName,_this.remoteAddress,_this.username,_this.password,_this.rootPath,_this.allowSelfSignedCertificate);
}

@override
String toString() {
  final _this = this as CreateConnectionInput;
  return 'CreateConnectionInput(displayName: ${_this.displayName}, remoteAddress: ${_this.remoteAddress}, username: ${_this.username}, password: ${_this.password}, rootPath: ${_this.rootPath}, allowSelfSignedCertificate: ${_this.allowSelfSignedCertificate})';
}


}

/// @nodoc
abstract mixin class $CreateConnectionInputCopyWith<$Res>  {
  factory $CreateConnectionInputCopyWith(CreateConnectionInput value, $Res Function(CreateConnectionInput) _then) = _$CreateConnectionInputCopyWithImpl;
@useResult
$Res call({
 String displayName, String remoteAddress, String username, EncryptedValue password, String rootPath, bool allowSelfSignedCertificate
});


$EncryptedValueCopyWith<$Res> get password;

}
/// @nodoc
class _$CreateConnectionInputCopyWithImpl<$Res>
    implements $CreateConnectionInputCopyWith<$Res> {
  _$CreateConnectionInputCopyWithImpl(this._self, this._then);

  final CreateConnectionInput _self;
  final $Res Function(CreateConnectionInput) _then;

/// Create a copy of CreateConnectionInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? remoteAddress = null,Object? username = null,Object? password = null,Object? rootPath = null,Object? allowSelfSignedCertificate = null,}) {
  return _then(CreateConnectionInput(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,remoteAddress: null == remoteAddress ? _self.remoteAddress : remoteAddress // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as EncryptedValue,rootPath: null == rootPath ? _self.rootPath : rootPath // ignore: cast_nullable_to_non_nullable
as String,allowSelfSignedCertificate: null == allowSelfSignedCertificate ? _self.allowSelfSignedCertificate : allowSelfSignedCertificate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of CreateConnectionInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EncryptedValueCopyWith<$Res> get password {
  
  return $EncryptedValueCopyWith<$Res>(_self.password, (value) {
    return _then(_self.copyWith(password: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreateConnectionInput].
extension CreateConnectionInputPatterns on CreateConnectionInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateConnectionInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateConnectionInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateConnectionInput value)  $default,){
final _that = this;
switch (_that) {
case _CreateConnectionInput():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateConnectionInput value)?  $default,){
final _that = this;
switch (_that) {
case _CreateConnectionInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String displayName,  String remoteAddress,  String username,  EncryptedValue password,  String rootPath,  bool allowSelfSignedCertificate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateConnectionInput() when $default != null:
return $default(_that.displayName,_that.remoteAddress,_that.username,_that.password,_that.rootPath,_that.allowSelfSignedCertificate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String displayName,  String remoteAddress,  String username,  EncryptedValue password,  String rootPath,  bool allowSelfSignedCertificate)  $default,) {final _that = this;
switch (_that) {
case _CreateConnectionInput():
return $default(_that.displayName,_that.remoteAddress,_that.username,_that.password,_that.rootPath,_that.allowSelfSignedCertificate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String displayName,  String remoteAddress,  String username,  EncryptedValue password,  String rootPath,  bool allowSelfSignedCertificate)?  $default,) {final _that = this;
switch (_that) {
case _CreateConnectionInput() when $default != null:
return $default(_that.displayName,_that.remoteAddress,_that.username,_that.password,_that.rootPath,_that.allowSelfSignedCertificate);case _:
  return null;

}
}

}

/// @nodoc


class _CreateConnectionInput implements CreateConnectionInput {
  const _CreateConnectionInput({required this.displayName, required this.remoteAddress, required this.username, required this.password, this.rootPath = '/', this.allowSelfSignedCertificate = false});
  

@override final  String displayName;
@override final  String remoteAddress;
@override final  String username;
@override final  EncryptedValue password;
@override@JsonKey() final  String rootPath;
@override@JsonKey() final  bool allowSelfSignedCertificate;

/// Create a copy of CreateConnectionInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateConnectionInputCopyWith<_CreateConnectionInput> get copyWith => __$CreateConnectionInputCopyWithImpl<_CreateConnectionInput>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateConnectionInput&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.remoteAddress, remoteAddress) || other.remoteAddress == remoteAddress)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.rootPath, rootPath) || other.rootPath == rootPath)&&(identical(other.allowSelfSignedCertificate, allowSelfSignedCertificate) || other.allowSelfSignedCertificate == allowSelfSignedCertificate));
}


@override
int get hashCode {
    return Object.hash(runtimeType,displayName,remoteAddress,username,password,rootPath,allowSelfSignedCertificate);
}

@override
String toString() {
    return 'CreateConnectionInput(displayName: $displayName, remoteAddress: $remoteAddress, username: $username, password: $password, rootPath: $rootPath, allowSelfSignedCertificate: $allowSelfSignedCertificate)';
}


}

/// @nodoc
abstract mixin class _$CreateConnectionInputCopyWith<$Res> implements $CreateConnectionInputCopyWith<$Res> {
  factory _$CreateConnectionInputCopyWith(_CreateConnectionInput value, $Res Function(_CreateConnectionInput) _then) = __$CreateConnectionInputCopyWithImpl;
@override @useResult
$Res call({
 String displayName, String remoteAddress, String username, EncryptedValue password, String rootPath, bool allowSelfSignedCertificate
});


@override $EncryptedValueCopyWith<$Res> get password;

}
/// @nodoc
class __$CreateConnectionInputCopyWithImpl<$Res>
    implements _$CreateConnectionInputCopyWith<$Res> {
  __$CreateConnectionInputCopyWithImpl(this._self, this._then);

  final _CreateConnectionInput _self;
  final $Res Function(_CreateConnectionInput) _then;

/// Create a copy of CreateConnectionInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? remoteAddress = null,Object? username = null,Object? password = null,Object? rootPath = null,Object? allowSelfSignedCertificate = null,}) {
  return _then(_CreateConnectionInput(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,remoteAddress: null == remoteAddress ? _self.remoteAddress : remoteAddress // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as EncryptedValue,rootPath: null == rootPath ? _self.rootPath : rootPath // ignore: cast_nullable_to_non_nullable
as String,allowSelfSignedCertificate: null == allowSelfSignedCertificate ? _self.allowSelfSignedCertificate : allowSelfSignedCertificate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of CreateConnectionInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EncryptedValueCopyWith<$Res> get password {
  
  return $EncryptedValueCopyWith<$Res>(_self.password, (value) {
    return _then(_self.copyWith(password: value));
  });
}
}

// dart format on
