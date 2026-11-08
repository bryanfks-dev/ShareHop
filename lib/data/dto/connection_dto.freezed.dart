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

 ConnectionProtocol get protocol; String get remoteAddress; String get username; String get password; String? get displayName;
/// Create a copy of ConnectionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectionDtoCopyWith<ConnectionDto> get copyWith => _$ConnectionDtoCopyWithImpl<ConnectionDto>(this as ConnectionDto, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ConnectionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectionDto&&(identical(other.protocol, _this.protocol) || other.protocol == _this.protocol)&&(identical(other.remoteAddress, _this.remoteAddress) || other.remoteAddress == _this.remoteAddress)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.password, _this.password) || other.password == _this.password)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName));
}


@override
int get hashCode {
  final _this = this as ConnectionDto;
  return Object.hash(runtimeType,_this.protocol,_this.remoteAddress,_this.username,_this.password,_this.displayName);
}

@override
String toString() {
  final _this = this as ConnectionDto;
  return 'ConnectionDto(protocol: ${_this.protocol}, remoteAddress: ${_this.remoteAddress}, username: ${_this.username}, password: ${_this.password}, displayName: ${_this.displayName})';
}


}

/// @nodoc
abstract mixin class $ConnectionDtoCopyWith<$Res>  {
  factory $ConnectionDtoCopyWith(ConnectionDto value, $Res Function(ConnectionDto) _then) = _$ConnectionDtoCopyWithImpl;
@useResult
$Res call({
 ConnectionProtocol protocol, String remoteAddress, String username, String password, String? displayName
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
@pragma('vm:prefer-inline') @override $Res call({Object? protocol = null,Object? remoteAddress = null,Object? username = null,Object? password = null,Object? displayName = freezed,}) {
  return _then(ConnectionDto(
protocol: null == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as ConnectionProtocol,remoteAddress: null == remoteAddress ? _self.remoteAddress : remoteAddress // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ConnectionProtocol protocol,  String remoteAddress,  String username,  String password,  String? displayName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConnectionDto() when $default != null:
return $default(_that.protocol,_that.remoteAddress,_that.username,_that.password,_that.displayName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ConnectionProtocol protocol,  String remoteAddress,  String username,  String password,  String? displayName)  $default,) {final _that = this;
switch (_that) {
case _ConnectionDto():
return $default(_that.protocol,_that.remoteAddress,_that.username,_that.password,_that.displayName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ConnectionProtocol protocol,  String remoteAddress,  String username,  String password,  String? displayName)?  $default,) {final _that = this;
switch (_that) {
case _ConnectionDto() when $default != null:
return $default(_that.protocol,_that.remoteAddress,_that.username,_that.password,_that.displayName);case _:
  return null;

}
}

}

/// @nodoc


class _ConnectionDto extends ConnectionDto {
  const _ConnectionDto({required this.protocol, required this.remoteAddress, required this.username, required this.password, this.displayName}): super._();
  

@override final  ConnectionProtocol protocol;
@override final  String remoteAddress;
@override final  String username;
@override final  String password;
@override final  String? displayName;

/// Create a copy of ConnectionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectionDtoCopyWith<_ConnectionDto> get copyWith => __$ConnectionDtoCopyWithImpl<_ConnectionDto>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionDto&&(identical(other.protocol, protocol) || other.protocol == protocol)&&(identical(other.remoteAddress, remoteAddress) || other.remoteAddress == remoteAddress)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}


@override
int get hashCode {
    return Object.hash(runtimeType,protocol,remoteAddress,username,password,displayName);
}

@override
String toString() {
    return 'ConnectionDto(protocol: $protocol, remoteAddress: $remoteAddress, username: $username, password: $password, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class _$ConnectionDtoCopyWith<$Res> implements $ConnectionDtoCopyWith<$Res> {
  factory _$ConnectionDtoCopyWith(_ConnectionDto value, $Res Function(_ConnectionDto) _then) = __$ConnectionDtoCopyWithImpl;
@override @useResult
$Res call({
 ConnectionProtocol protocol, String remoteAddress, String username, String password, String? displayName
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
@override @pragma('vm:prefer-inline') $Res call({Object? protocol = null,Object? remoteAddress = null,Object? username = null,Object? password = null,Object? displayName = freezed,}) {
  return _then(_ConnectionDto(
protocol: null == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as ConnectionProtocol,remoteAddress: null == remoteAddress ? _self.remoteAddress : remoteAddress // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ConnectionDraftDto {

 ConnectionProtocol get protocol; String get remoteAddress; String get username; String get password; String get displayName;
/// Create a copy of ConnectionDraftDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectionDraftDtoCopyWith<ConnectionDraftDto> get copyWith => _$ConnectionDraftDtoCopyWithImpl<ConnectionDraftDto>(this as ConnectionDraftDto, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ConnectionDraftDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectionDraftDto&&(identical(other.protocol, _this.protocol) || other.protocol == _this.protocol)&&(identical(other.remoteAddress, _this.remoteAddress) || other.remoteAddress == _this.remoteAddress)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.password, _this.password) || other.password == _this.password)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName));
}


@override
int get hashCode {
  final _this = this as ConnectionDraftDto;
  return Object.hash(runtimeType,_this.protocol,_this.remoteAddress,_this.username,_this.password,_this.displayName);
}

@override
String toString() {
  final _this = this as ConnectionDraftDto;
  return 'ConnectionDraftDto(protocol: ${_this.protocol}, remoteAddress: ${_this.remoteAddress}, username: ${_this.username}, password: ${_this.password}, displayName: ${_this.displayName})';
}


}

/// @nodoc
abstract mixin class $ConnectionDraftDtoCopyWith<$Res>  {
  factory $ConnectionDraftDtoCopyWith(ConnectionDraftDto value, $Res Function(ConnectionDraftDto) _then) = _$ConnectionDraftDtoCopyWithImpl;
@useResult
$Res call({
 ConnectionProtocol protocol, String remoteAddress, String username, String password, String displayName
});




}
/// @nodoc
class _$ConnectionDraftDtoCopyWithImpl<$Res>
    implements $ConnectionDraftDtoCopyWith<$Res> {
  _$ConnectionDraftDtoCopyWithImpl(this._self, this._then);

  final ConnectionDraftDto _self;
  final $Res Function(ConnectionDraftDto) _then;

/// Create a copy of ConnectionDraftDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? protocol = null,Object? remoteAddress = null,Object? username = null,Object? password = null,Object? displayName = null,}) {
  return _then(ConnectionDraftDto(
protocol: null == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as ConnectionProtocol,remoteAddress: null == remoteAddress ? _self.remoteAddress : remoteAddress // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ConnectionDraftDto].
extension ConnectionDraftDtoPatterns on ConnectionDraftDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConnectionDraftDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConnectionDraftDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConnectionDraftDto value)  $default,){
final _that = this;
switch (_that) {
case _ConnectionDraftDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConnectionDraftDto value)?  $default,){
final _that = this;
switch (_that) {
case _ConnectionDraftDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ConnectionProtocol protocol,  String remoteAddress,  String username,  String password,  String displayName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConnectionDraftDto() when $default != null:
return $default(_that.protocol,_that.remoteAddress,_that.username,_that.password,_that.displayName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ConnectionProtocol protocol,  String remoteAddress,  String username,  String password,  String displayName)  $default,) {final _that = this;
switch (_that) {
case _ConnectionDraftDto():
return $default(_that.protocol,_that.remoteAddress,_that.username,_that.password,_that.displayName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ConnectionProtocol protocol,  String remoteAddress,  String username,  String password,  String displayName)?  $default,) {final _that = this;
switch (_that) {
case _ConnectionDraftDto() when $default != null:
return $default(_that.protocol,_that.remoteAddress,_that.username,_that.password,_that.displayName);case _:
  return null;

}
}

}

/// @nodoc


class _ConnectionDraftDto extends ConnectionDraftDto {
  const _ConnectionDraftDto({required this.protocol, required this.remoteAddress, required this.username, required this.password, required this.displayName}): super._();
  

@override final  ConnectionProtocol protocol;
@override final  String remoteAddress;
@override final  String username;
@override final  String password;
@override final  String displayName;

/// Create a copy of ConnectionDraftDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectionDraftDtoCopyWith<_ConnectionDraftDto> get copyWith => __$ConnectionDraftDtoCopyWithImpl<_ConnectionDraftDto>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionDraftDto&&(identical(other.protocol, protocol) || other.protocol == protocol)&&(identical(other.remoteAddress, remoteAddress) || other.remoteAddress == remoteAddress)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}


@override
int get hashCode {
    return Object.hash(runtimeType,protocol,remoteAddress,username,password,displayName);
}

@override
String toString() {
    return 'ConnectionDraftDto(protocol: $protocol, remoteAddress: $remoteAddress, username: $username, password: $password, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class _$ConnectionDraftDtoCopyWith<$Res> implements $ConnectionDraftDtoCopyWith<$Res> {
  factory _$ConnectionDraftDtoCopyWith(_ConnectionDraftDto value, $Res Function(_ConnectionDraftDto) _then) = __$ConnectionDraftDtoCopyWithImpl;
@override @useResult
$Res call({
 ConnectionProtocol protocol, String remoteAddress, String username, String password, String displayName
});




}
/// @nodoc
class __$ConnectionDraftDtoCopyWithImpl<$Res>
    implements _$ConnectionDraftDtoCopyWith<$Res> {
  __$ConnectionDraftDtoCopyWithImpl(this._self, this._then);

  final _ConnectionDraftDto _self;
  final $Res Function(_ConnectionDraftDto) _then;

/// Create a copy of ConnectionDraftDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? protocol = null,Object? remoteAddress = null,Object? username = null,Object? password = null,Object? displayName = null,}) {
  return _then(_ConnectionDraftDto(
protocol: null == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as ConnectionProtocol,remoteAddress: null == remoteAddress ? _self.remoteAddress : remoteAddress // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ConnectionRevisionDto {

 String get id; NotRequiredValue<ConnectionProtocol>? get protocol; NotRequiredValue<String>? get remoteAddress; NotRequiredValue<String>? get username; NotRequiredValue<String>? get passwordSecretKey; NotRequiredValue<String>? get password; NotRequiredValue<String>? get displayName; NotRequiredValue<String>? get rootPath;
/// Create a copy of ConnectionRevisionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectionRevisionDtoCopyWith<ConnectionRevisionDto> get copyWith => _$ConnectionRevisionDtoCopyWithImpl<ConnectionRevisionDto>(this as ConnectionRevisionDto, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ConnectionRevisionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectionRevisionDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.protocol, _this.protocol) || other.protocol == _this.protocol)&&(identical(other.remoteAddress, _this.remoteAddress) || other.remoteAddress == _this.remoteAddress)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.passwordSecretKey, _this.passwordSecretKey) || other.passwordSecretKey == _this.passwordSecretKey)&&(identical(other.password, _this.password) || other.password == _this.password)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.rootPath, _this.rootPath) || other.rootPath == _this.rootPath));
}


@override
int get hashCode {
  final _this = this as ConnectionRevisionDto;
  return Object.hash(runtimeType,_this.id,_this.protocol,_this.remoteAddress,_this.username,_this.passwordSecretKey,_this.password,_this.displayName,_this.rootPath);
}

@override
String toString() {
  final _this = this as ConnectionRevisionDto;
  return 'ConnectionRevisionDto(id: ${_this.id}, protocol: ${_this.protocol}, remoteAddress: ${_this.remoteAddress}, username: ${_this.username}, passwordSecretKey: ${_this.passwordSecretKey}, password: ${_this.password}, displayName: ${_this.displayName}, rootPath: ${_this.rootPath})';
}


}

/// @nodoc
abstract mixin class $ConnectionRevisionDtoCopyWith<$Res>  {
  factory $ConnectionRevisionDtoCopyWith(ConnectionRevisionDto value, $Res Function(ConnectionRevisionDto) _then) = _$ConnectionRevisionDtoCopyWithImpl;
@useResult
$Res call({
 String id, NotRequiredValue<ConnectionProtocol>? protocol, NotRequiredValue<String>? remoteAddress, NotRequiredValue<String>? username, NotRequiredValue<String>? passwordSecretKey, NotRequiredValue<String>? password, NotRequiredValue<String>? displayName, NotRequiredValue<String>? rootPath
});


$NotRequiredValueCopyWith<ConnectionProtocol, $Res>? get protocol;$NotRequiredValueCopyWith<String, $Res>? get remoteAddress;$NotRequiredValueCopyWith<String, $Res>? get username;$NotRequiredValueCopyWith<String, $Res>? get passwordSecretKey;$NotRequiredValueCopyWith<String, $Res>? get password;$NotRequiredValueCopyWith<String, $Res>? get displayName;$NotRequiredValueCopyWith<String, $Res>? get rootPath;

}
/// @nodoc
class _$ConnectionRevisionDtoCopyWithImpl<$Res>
    implements $ConnectionRevisionDtoCopyWith<$Res> {
  _$ConnectionRevisionDtoCopyWithImpl(this._self, this._then);

  final ConnectionRevisionDto _self;
  final $Res Function(ConnectionRevisionDto) _then;

/// Create a copy of ConnectionRevisionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? protocol = freezed,Object? remoteAddress = freezed,Object? username = freezed,Object? passwordSecretKey = freezed,Object? password = freezed,Object? displayName = freezed,Object? rootPath = freezed,}) {
  return _then(ConnectionRevisionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,protocol: freezed == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as NotRequiredValue<ConnectionProtocol>?,remoteAddress: freezed == remoteAddress ? _self.remoteAddress : remoteAddress // ignore: cast_nullable_to_non_nullable
as NotRequiredValue<String>?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as NotRequiredValue<String>?,passwordSecretKey: freezed == passwordSecretKey ? _self.passwordSecretKey : passwordSecretKey // ignore: cast_nullable_to_non_nullable
as NotRequiredValue<String>?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as NotRequiredValue<String>?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as NotRequiredValue<String>?,rootPath: freezed == rootPath ? _self.rootPath : rootPath // ignore: cast_nullable_to_non_nullable
as NotRequiredValue<String>?,
  ));
}
/// Create a copy of ConnectionRevisionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotRequiredValueCopyWith<ConnectionProtocol, $Res>? get protocol {
    if (_self.protocol == null) {
    return null;
  }

  return $NotRequiredValueCopyWith<ConnectionProtocol, $Res>(_self.protocol!, (value) {
    return _then(_self.copyWith(protocol: value));
  });
}/// Create a copy of ConnectionRevisionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotRequiredValueCopyWith<String, $Res>? get remoteAddress {
    if (_self.remoteAddress == null) {
    return null;
  }

  return $NotRequiredValueCopyWith<String, $Res>(_self.remoteAddress!, (value) {
    return _then(_self.copyWith(remoteAddress: value));
  });
}/// Create a copy of ConnectionRevisionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotRequiredValueCopyWith<String, $Res>? get username {
    if (_self.username == null) {
    return null;
  }

  return $NotRequiredValueCopyWith<String, $Res>(_self.username!, (value) {
    return _then(_self.copyWith(username: value));
  });
}/// Create a copy of ConnectionRevisionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotRequiredValueCopyWith<String, $Res>? get passwordSecretKey {
    if (_self.passwordSecretKey == null) {
    return null;
  }

  return $NotRequiredValueCopyWith<String, $Res>(_self.passwordSecretKey!, (value) {
    return _then(_self.copyWith(passwordSecretKey: value));
  });
}/// Create a copy of ConnectionRevisionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotRequiredValueCopyWith<String, $Res>? get password {
    if (_self.password == null) {
    return null;
  }

  return $NotRequiredValueCopyWith<String, $Res>(_self.password!, (value) {
    return _then(_self.copyWith(password: value));
  });
}/// Create a copy of ConnectionRevisionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotRequiredValueCopyWith<String, $Res>? get displayName {
    if (_self.displayName == null) {
    return null;
  }

  return $NotRequiredValueCopyWith<String, $Res>(_self.displayName!, (value) {
    return _then(_self.copyWith(displayName: value));
  });
}/// Create a copy of ConnectionRevisionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotRequiredValueCopyWith<String, $Res>? get rootPath {
    if (_self.rootPath == null) {
    return null;
  }

  return $NotRequiredValueCopyWith<String, $Res>(_self.rootPath!, (value) {
    return _then(_self.copyWith(rootPath: value));
  });
}
}


/// Adds pattern-matching-related methods to [ConnectionRevisionDto].
extension ConnectionRevisionDtoPatterns on ConnectionRevisionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConnectionRevisionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConnectionRevisionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConnectionRevisionDto value)  $default,){
final _that = this;
switch (_that) {
case _ConnectionRevisionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConnectionRevisionDto value)?  $default,){
final _that = this;
switch (_that) {
case _ConnectionRevisionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  NotRequiredValue<ConnectionProtocol>? protocol,  NotRequiredValue<String>? remoteAddress,  NotRequiredValue<String>? username,  NotRequiredValue<String>? passwordSecretKey,  NotRequiredValue<String>? password,  NotRequiredValue<String>? displayName,  NotRequiredValue<String>? rootPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConnectionRevisionDto() when $default != null:
return $default(_that.id,_that.protocol,_that.remoteAddress,_that.username,_that.passwordSecretKey,_that.password,_that.displayName,_that.rootPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  NotRequiredValue<ConnectionProtocol>? protocol,  NotRequiredValue<String>? remoteAddress,  NotRequiredValue<String>? username,  NotRequiredValue<String>? passwordSecretKey,  NotRequiredValue<String>? password,  NotRequiredValue<String>? displayName,  NotRequiredValue<String>? rootPath)  $default,) {final _that = this;
switch (_that) {
case _ConnectionRevisionDto():
return $default(_that.id,_that.protocol,_that.remoteAddress,_that.username,_that.passwordSecretKey,_that.password,_that.displayName,_that.rootPath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  NotRequiredValue<ConnectionProtocol>? protocol,  NotRequiredValue<String>? remoteAddress,  NotRequiredValue<String>? username,  NotRequiredValue<String>? passwordSecretKey,  NotRequiredValue<String>? password,  NotRequiredValue<String>? displayName,  NotRequiredValue<String>? rootPath)?  $default,) {final _that = this;
switch (_that) {
case _ConnectionRevisionDto() when $default != null:
return $default(_that.id,_that.protocol,_that.remoteAddress,_that.username,_that.passwordSecretKey,_that.password,_that.displayName,_that.rootPath);case _:
  return null;

}
}

}

/// @nodoc


class _ConnectionRevisionDto extends ConnectionRevisionDto {
  const _ConnectionRevisionDto({required this.id, this.protocol, this.remoteAddress, this.username, this.passwordSecretKey, this.password, this.displayName, this.rootPath}): super._();
  

@override final  String id;
@override final  NotRequiredValue<ConnectionProtocol>? protocol;
@override final  NotRequiredValue<String>? remoteAddress;
@override final  NotRequiredValue<String>? username;
@override final  NotRequiredValue<String>? passwordSecretKey;
@override final  NotRequiredValue<String>? password;
@override final  NotRequiredValue<String>? displayName;
@override final  NotRequiredValue<String>? rootPath;

/// Create a copy of ConnectionRevisionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectionRevisionDtoCopyWith<_ConnectionRevisionDto> get copyWith => __$ConnectionRevisionDtoCopyWithImpl<_ConnectionRevisionDto>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionRevisionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.protocol, protocol) || other.protocol == protocol)&&(identical(other.remoteAddress, remoteAddress) || other.remoteAddress == remoteAddress)&&(identical(other.username, username) || other.username == username)&&(identical(other.passwordSecretKey, passwordSecretKey) || other.passwordSecretKey == passwordSecretKey)&&(identical(other.password, password) || other.password == password)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.rootPath, rootPath) || other.rootPath == rootPath));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,protocol,remoteAddress,username,passwordSecretKey,password,displayName,rootPath);
}

@override
String toString() {
    return 'ConnectionRevisionDto(id: $id, protocol: $protocol, remoteAddress: $remoteAddress, username: $username, passwordSecretKey: $passwordSecretKey, password: $password, displayName: $displayName, rootPath: $rootPath)';
}


}

/// @nodoc
abstract mixin class _$ConnectionRevisionDtoCopyWith<$Res> implements $ConnectionRevisionDtoCopyWith<$Res> {
  factory _$ConnectionRevisionDtoCopyWith(_ConnectionRevisionDto value, $Res Function(_ConnectionRevisionDto) _then) = __$ConnectionRevisionDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, NotRequiredValue<ConnectionProtocol>? protocol, NotRequiredValue<String>? remoteAddress, NotRequiredValue<String>? username, NotRequiredValue<String>? passwordSecretKey, NotRequiredValue<String>? password, NotRequiredValue<String>? displayName, NotRequiredValue<String>? rootPath
});


@override $NotRequiredValueCopyWith<ConnectionProtocol, $Res>? get protocol;@override $NotRequiredValueCopyWith<String, $Res>? get remoteAddress;@override $NotRequiredValueCopyWith<String, $Res>? get username;@override $NotRequiredValueCopyWith<String, $Res>? get passwordSecretKey;@override $NotRequiredValueCopyWith<String, $Res>? get password;@override $NotRequiredValueCopyWith<String, $Res>? get displayName;@override $NotRequiredValueCopyWith<String, $Res>? get rootPath;

}
/// @nodoc
class __$ConnectionRevisionDtoCopyWithImpl<$Res>
    implements _$ConnectionRevisionDtoCopyWith<$Res> {
  __$ConnectionRevisionDtoCopyWithImpl(this._self, this._then);

  final _ConnectionRevisionDto _self;
  final $Res Function(_ConnectionRevisionDto) _then;

/// Create a copy of ConnectionRevisionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? protocol = freezed,Object? remoteAddress = freezed,Object? username = freezed,Object? passwordSecretKey = freezed,Object? password = freezed,Object? displayName = freezed,Object? rootPath = freezed,}) {
  return _then(_ConnectionRevisionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,protocol: freezed == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as NotRequiredValue<ConnectionProtocol>?,remoteAddress: freezed == remoteAddress ? _self.remoteAddress : remoteAddress // ignore: cast_nullable_to_non_nullable
as NotRequiredValue<String>?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as NotRequiredValue<String>?,passwordSecretKey: freezed == passwordSecretKey ? _self.passwordSecretKey : passwordSecretKey // ignore: cast_nullable_to_non_nullable
as NotRequiredValue<String>?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as NotRequiredValue<String>?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as NotRequiredValue<String>?,rootPath: freezed == rootPath ? _self.rootPath : rootPath // ignore: cast_nullable_to_non_nullable
as NotRequiredValue<String>?,
  ));
}

/// Create a copy of ConnectionRevisionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotRequiredValueCopyWith<ConnectionProtocol, $Res>? get protocol {
    if (_self.protocol == null) {
    return null;
  }

  return $NotRequiredValueCopyWith<ConnectionProtocol, $Res>(_self.protocol!, (value) {
    return _then(_self.copyWith(protocol: value));
  });
}/// Create a copy of ConnectionRevisionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotRequiredValueCopyWith<String, $Res>? get remoteAddress {
    if (_self.remoteAddress == null) {
    return null;
  }

  return $NotRequiredValueCopyWith<String, $Res>(_self.remoteAddress!, (value) {
    return _then(_self.copyWith(remoteAddress: value));
  });
}/// Create a copy of ConnectionRevisionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotRequiredValueCopyWith<String, $Res>? get username {
    if (_self.username == null) {
    return null;
  }

  return $NotRequiredValueCopyWith<String, $Res>(_self.username!, (value) {
    return _then(_self.copyWith(username: value));
  });
}/// Create a copy of ConnectionRevisionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotRequiredValueCopyWith<String, $Res>? get passwordSecretKey {
    if (_self.passwordSecretKey == null) {
    return null;
  }

  return $NotRequiredValueCopyWith<String, $Res>(_self.passwordSecretKey!, (value) {
    return _then(_self.copyWith(passwordSecretKey: value));
  });
}/// Create a copy of ConnectionRevisionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotRequiredValueCopyWith<String, $Res>? get password {
    if (_self.password == null) {
    return null;
  }

  return $NotRequiredValueCopyWith<String, $Res>(_self.password!, (value) {
    return _then(_self.copyWith(password: value));
  });
}/// Create a copy of ConnectionRevisionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotRequiredValueCopyWith<String, $Res>? get displayName {
    if (_self.displayName == null) {
    return null;
  }

  return $NotRequiredValueCopyWith<String, $Res>(_self.displayName!, (value) {
    return _then(_self.copyWith(displayName: value));
  });
}/// Create a copy of ConnectionRevisionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotRequiredValueCopyWith<String, $Res>? get rootPath {
    if (_self.rootPath == null) {
    return null;
  }

  return $NotRequiredValueCopyWith<String, $Res>(_self.rootPath!, (value) {
    return _then(_self.copyWith(rootPath: value));
  });
}
}

// dart format on
