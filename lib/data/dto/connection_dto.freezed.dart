// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConnectionDto {

 ConnectionProtocol get protocol; String get remoteAddress; String get username; String get password; String? get displayName; String get rootPath; bool get allowSelfSignedCertificate;
/// Create a copy of ConnectionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectionDtoCopyWith<ConnectionDto> get copyWith => _$ConnectionDtoCopyWithImpl<ConnectionDto>(this as ConnectionDto, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ConnectionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectionDto&&(identical(other.protocol, _this.protocol) || other.protocol == _this.protocol)&&(identical(other.remoteAddress, _this.remoteAddress) || other.remoteAddress == _this.remoteAddress)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.password, _this.password) || other.password == _this.password)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.rootPath, _this.rootPath) || other.rootPath == _this.rootPath)&&(identical(other.allowSelfSignedCertificate, _this.allowSelfSignedCertificate) || other.allowSelfSignedCertificate == _this.allowSelfSignedCertificate));
}


@override
int get hashCode {
  final _this = this as ConnectionDto;
  return Object.hash(runtimeType,_this.protocol,_this.remoteAddress,_this.username,_this.password,_this.displayName,_this.rootPath,_this.allowSelfSignedCertificate);
}

@override
String toString() {
  final _this = this as ConnectionDto;
  return 'ConnectionDto(protocol: ${_this.protocol}, remoteAddress: ${_this.remoteAddress}, username: ${_this.username}, password: ${_this.password}, displayName: ${_this.displayName}, rootPath: ${_this.rootPath}, allowSelfSignedCertificate: ${_this.allowSelfSignedCertificate})';
}


}

/// @nodoc
abstract mixin class $ConnectionDtoCopyWith<$Res>  {
  factory $ConnectionDtoCopyWith(ConnectionDto value, $Res Function(ConnectionDto) _then) = _$ConnectionDtoCopyWithImpl;
@useResult
$Res call({
 ConnectionProtocol protocol, String remoteAddress, String username, String password, String? displayName, String rootPath, bool allowSelfSignedCertificate
});




}
/// @nodoc
class _$ConnectionDtoCopyWithImpl<$Res>
    implements $ConnectionDtoCopyWith<$Res> {
  _$ConnectionDtoCopyWithImpl(this._self, this._then);

  final ConnectionDto _self;
  final $Res Function(ConnectionDto) _then;

/// Create a copy of ConnectionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? protocol = null,Object? remoteAddress = null,Object? username = null,Object? password = null,Object? displayName = freezed,Object? rootPath = null,Object? allowSelfSignedCertificate = null,}) {
  return _then(ConnectionDto(
protocol: null == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as ConnectionProtocol,remoteAddress: null == remoteAddress ? _self.remoteAddress : remoteAddress // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,rootPath: null == rootPath ? _self.rootPath : rootPath // ignore: cast_nullable_to_non_nullable
as String,allowSelfSignedCertificate: null == allowSelfSignedCertificate ? _self.allowSelfSignedCertificate : allowSelfSignedCertificate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ConnectionDto].
extension ConnectionDtoPatterns on ConnectionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConnectionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConnectionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConnectionDto value)  $default,){
final _that = this;
switch (_that) {
case _ConnectionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConnectionDto value)?  $default,){
final _that = this;
switch (_that) {
case _ConnectionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ConnectionProtocol protocol,  String remoteAddress,  String username,  String password,  String? displayName,  String rootPath,  bool allowSelfSignedCertificate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConnectionDto() when $default != null:
return $default(_that.protocol,_that.remoteAddress,_that.username,_that.password,_that.displayName,_that.rootPath,_that.allowSelfSignedCertificate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ConnectionProtocol protocol,  String remoteAddress,  String username,  String password,  String? displayName,  String rootPath,  bool allowSelfSignedCertificate)  $default,) {final _that = this;
switch (_that) {
case _ConnectionDto():
return $default(_that.protocol,_that.remoteAddress,_that.username,_that.password,_that.displayName,_that.rootPath,_that.allowSelfSignedCertificate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ConnectionProtocol protocol,  String remoteAddress,  String username,  String password,  String? displayName,  String rootPath,  bool allowSelfSignedCertificate)?  $default,) {final _that = this;
switch (_that) {
case _ConnectionDto() when $default != null:
return $default(_that.protocol,_that.remoteAddress,_that.username,_that.password,_that.displayName,_that.rootPath,_that.allowSelfSignedCertificate);case _:
  return null;

}
}

}

/// @nodoc


class _ConnectionDto extends ConnectionDto {
  const _ConnectionDto({required this.protocol, required this.remoteAddress, required this.username, required this.password, this.displayName, this.rootPath = '/', this.allowSelfSignedCertificate = false}): super._();
  

@override final  ConnectionProtocol protocol;
@override final  String remoteAddress;
@override final  String username;
@override final  String password;
@override final  String? displayName;
@override@JsonKey() final  String rootPath;
@override@JsonKey() final  bool allowSelfSignedCertificate;

/// Create a copy of ConnectionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectionDtoCopyWith<_ConnectionDto> get copyWith => __$ConnectionDtoCopyWithImpl<_ConnectionDto>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionDto&&(identical(other.protocol, protocol) || other.protocol == protocol)&&(identical(other.remoteAddress, remoteAddress) || other.remoteAddress == remoteAddress)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.rootPath, rootPath) || other.rootPath == rootPath)&&(identical(other.allowSelfSignedCertificate, allowSelfSignedCertificate) || other.allowSelfSignedCertificate == allowSelfSignedCertificate));
}


@override
int get hashCode {
    return Object.hash(runtimeType,protocol,remoteAddress,username,password,displayName,rootPath,allowSelfSignedCertificate);
}

@override
String toString() {
    return 'ConnectionDto(protocol: $protocol, remoteAddress: $remoteAddress, username: $username, password: $password, displayName: $displayName, rootPath: $rootPath, allowSelfSignedCertificate: $allowSelfSignedCertificate)';
}


}

/// @nodoc
abstract mixin class _$ConnectionDtoCopyWith<$Res> implements $ConnectionDtoCopyWith<$Res> {
  factory _$ConnectionDtoCopyWith(_ConnectionDto value, $Res Function(_ConnectionDto) _then) = __$ConnectionDtoCopyWithImpl;
@override @useResult
$Res call({
 ConnectionProtocol protocol, String remoteAddress, String username, String password, String? displayName, String rootPath, bool allowSelfSignedCertificate
});




}
/// @nodoc
class __$ConnectionDtoCopyWithImpl<$Res>
    implements _$ConnectionDtoCopyWith<$Res> {
  __$ConnectionDtoCopyWithImpl(this._self, this._then);

  final _ConnectionDto _self;
  final $Res Function(_ConnectionDto) _then;

/// Create a copy of ConnectionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? protocol = null,Object? remoteAddress = null,Object? username = null,Object? password = null,Object? displayName = freezed,Object? rootPath = null,Object? allowSelfSignedCertificate = null,}) {
  return _then(_ConnectionDto(
protocol: null == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as ConnectionProtocol,remoteAddress: null == remoteAddress ? _self.remoteAddress : remoteAddress // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,rootPath: null == rootPath ? _self.rootPath : rootPath // ignore: cast_nullable_to_non_nullable
as String,allowSelfSignedCertificate: null == allowSelfSignedCertificate ? _self.allowSelfSignedCertificate : allowSelfSignedCertificate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
