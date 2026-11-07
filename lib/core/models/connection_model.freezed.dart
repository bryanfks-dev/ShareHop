// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConnectionModel {

 String get id; ConnectionProtocol get protocol;@JsonKey(name: 'display_name') String get displayName;@JsonKey(name: 'remote_address') String get remoteAddress; String get username;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;@JsonKey(name: 'password') String get passwordId;@JsonKey(name: 'root_path') String get rootPath;@JsonKey(includeFromJson: false, includeToJson: false) EncryptedValueModel? get password;
/// Create a copy of ConnectionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectionModelCopyWith<ConnectionModel> get copyWith => _$ConnectionModelCopyWithImpl<ConnectionModel>(this as ConnectionModel, _$identity);

  /// Serializes this ConnectionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ConnectionModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectionModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.protocol, _this.protocol) || other.protocol == _this.protocol)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.remoteAddress, _this.remoteAddress) || other.remoteAddress == _this.remoteAddress)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.passwordId, _this.passwordId) || other.passwordId == _this.passwordId)&&(identical(other.rootPath, _this.rootPath) || other.rootPath == _this.rootPath)&&(identical(other.password, _this.password) || other.password == _this.password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ConnectionModel;
  return Object.hash(runtimeType,_this.id,_this.protocol,_this.displayName,_this.remoteAddress,_this.username,_this.createdAt,_this.updatedAt,_this.passwordId,_this.rootPath,_this.password);
}

@override
String toString() {
  final _this = this as ConnectionModel;
  return 'ConnectionModel(id: ${_this.id}, protocol: ${_this.protocol}, displayName: ${_this.displayName}, remoteAddress: ${_this.remoteAddress}, username: ${_this.username}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, passwordId: ${_this.passwordId}, rootPath: ${_this.rootPath}, password: ${_this.password})';
}


}

/// @nodoc
abstract mixin class $ConnectionModelCopyWith<$Res>  {
  factory $ConnectionModelCopyWith(ConnectionModel value, $Res Function(ConnectionModel) _then) = _$ConnectionModelCopyWithImpl;
@useResult
$Res call({
 String id, ConnectionProtocol protocol,@JsonKey(name: 'display_name') String displayName,@JsonKey(name: 'remote_address') String remoteAddress, String username,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt,@JsonKey(name: 'password') String passwordId,@JsonKey(name: 'root_path') String rootPath,@JsonKey(includeFromJson: false, includeToJson: false) EncryptedValueModel? password
});


$EncryptedValueModelCopyWith<$Res>? get password;

}
/// @nodoc
class _$ConnectionModelCopyWithImpl<$Res>
    implements $ConnectionModelCopyWith<$Res> {
  _$ConnectionModelCopyWithImpl(this._self, this._then);

  final ConnectionModel _self;
  final $Res Function(ConnectionModel) _then;

/// Create a copy of ConnectionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? protocol = null,Object? displayName = null,Object? remoteAddress = null,Object? username = null,Object? createdAt = null,Object? updatedAt = null,Object? passwordId = null,Object? rootPath = null,Object? password = freezed,}) {
  return _then(ConnectionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,protocol: null == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as ConnectionProtocol,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,remoteAddress: null == remoteAddress ? _self.remoteAddress : remoteAddress // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,passwordId: null == passwordId ? _self.passwordId : passwordId // ignore: cast_nullable_to_non_nullable
as String,rootPath: null == rootPath ? _self.rootPath : rootPath // ignore: cast_nullable_to_non_nullable
as String,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as EncryptedValueModel?,
  ));
}
/// Create a copy of ConnectionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EncryptedValueModelCopyWith<$Res>? get password {
    if (_self.password == null) {
    return null;
  }

  return $EncryptedValueModelCopyWith<$Res>(_self.password!, (value) {
    return _then(_self.copyWith(password: value));
  });
}
}


/// Adds pattern-matching-related methods to [ConnectionModel].
extension ConnectionModelPatterns on ConnectionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConnectionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConnectionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConnectionModel value)  $default,){
final _that = this;
switch (_that) {
case _ConnectionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConnectionModel value)?  $default,){
final _that = this;
switch (_that) {
case _ConnectionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ConnectionProtocol protocol, @JsonKey(name: 'display_name')  String displayName, @JsonKey(name: 'remote_address')  String remoteAddress,  String username, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'password')  String passwordId, @JsonKey(name: 'root_path')  String rootPath, @JsonKey(includeFromJson: false, includeToJson: false)  EncryptedValueModel? password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConnectionModel() when $default != null:
return $default(_that.id,_that.protocol,_that.displayName,_that.remoteAddress,_that.username,_that.createdAt,_that.updatedAt,_that.passwordId,_that.rootPath,_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ConnectionProtocol protocol, @JsonKey(name: 'display_name')  String displayName, @JsonKey(name: 'remote_address')  String remoteAddress,  String username, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'password')  String passwordId, @JsonKey(name: 'root_path')  String rootPath, @JsonKey(includeFromJson: false, includeToJson: false)  EncryptedValueModel? password)  $default,) {final _that = this;
switch (_that) {
case _ConnectionModel():
return $default(_that.id,_that.protocol,_that.displayName,_that.remoteAddress,_that.username,_that.createdAt,_that.updatedAt,_that.passwordId,_that.rootPath,_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ConnectionProtocol protocol, @JsonKey(name: 'display_name')  String displayName, @JsonKey(name: 'remote_address')  String remoteAddress,  String username, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'password')  String passwordId, @JsonKey(name: 'root_path')  String rootPath, @JsonKey(includeFromJson: false, includeToJson: false)  EncryptedValueModel? password)?  $default,) {final _that = this;
switch (_that) {
case _ConnectionModel() when $default != null:
return $default(_that.id,_that.protocol,_that.displayName,_that.remoteAddress,_that.username,_that.createdAt,_that.updatedAt,_that.passwordId,_that.rootPath,_that.password);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConnectionModel extends ConnectionModel {
  const _ConnectionModel({required this.id, required this.protocol, @JsonKey(name: 'display_name') required this.displayName, @JsonKey(name: 'remote_address') required this.remoteAddress, required this.username, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, @JsonKey(name: 'password') this.passwordId = '', @JsonKey(name: 'root_path') this.rootPath = '/', @JsonKey(includeFromJson: false, includeToJson: false) this.password}): super._();
  factory _ConnectionModel.fromJson(Map<String, dynamic> json) => _$ConnectionModelFromJson(json);

@override final  String id;
@override final  ConnectionProtocol protocol;
@override@JsonKey(name: 'display_name') final  String displayName;
@override@JsonKey(name: 'remote_address') final  String remoteAddress;
@override final  String username;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;
@override@JsonKey(name: 'password') final  String passwordId;
@override@JsonKey(name: 'root_path') final  String rootPath;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  EncryptedValueModel? password;

/// Create a copy of ConnectionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectionModelCopyWith<_ConnectionModel> get copyWith => __$ConnectionModelCopyWithImpl<_ConnectionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConnectionModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.protocol, protocol) || other.protocol == protocol)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.remoteAddress, remoteAddress) || other.remoteAddress == remoteAddress)&&(identical(other.username, username) || other.username == username)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.passwordId, passwordId) || other.passwordId == passwordId)&&(identical(other.rootPath, rootPath) || other.rootPath == rootPath)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,protocol,displayName,remoteAddress,username,createdAt,updatedAt,passwordId,rootPath,password);
}

@override
String toString() {
    return 'ConnectionModel(id: $id, protocol: $protocol, displayName: $displayName, remoteAddress: $remoteAddress, username: $username, createdAt: $createdAt, updatedAt: $updatedAt, passwordId: $passwordId, rootPath: $rootPath, password: $password)';
}


}

/// @nodoc
abstract mixin class _$ConnectionModelCopyWith<$Res> implements $ConnectionModelCopyWith<$Res> {
  factory _$ConnectionModelCopyWith(_ConnectionModel value, $Res Function(_ConnectionModel) _then) = __$ConnectionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, ConnectionProtocol protocol,@JsonKey(name: 'display_name') String displayName,@JsonKey(name: 'remote_address') String remoteAddress, String username,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt,@JsonKey(name: 'password') String passwordId,@JsonKey(name: 'root_path') String rootPath,@JsonKey(includeFromJson: false, includeToJson: false) EncryptedValueModel? password
});


@override $EncryptedValueModelCopyWith<$Res>? get password;

}
/// @nodoc
class __$ConnectionModelCopyWithImpl<$Res>
    implements _$ConnectionModelCopyWith<$Res> {
  __$ConnectionModelCopyWithImpl(this._self, this._then);

  final _ConnectionModel _self;
  final $Res Function(_ConnectionModel) _then;

/// Create a copy of ConnectionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? protocol = null,Object? displayName = null,Object? remoteAddress = null,Object? username = null,Object? createdAt = null,Object? updatedAt = null,Object? passwordId = null,Object? rootPath = null,Object? password = freezed,}) {
  return _then(_ConnectionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,protocol: null == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as ConnectionProtocol,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,remoteAddress: null == remoteAddress ? _self.remoteAddress : remoteAddress // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,passwordId: null == passwordId ? _self.passwordId : passwordId // ignore: cast_nullable_to_non_nullable
as String,rootPath: null == rootPath ? _self.rootPath : rootPath // ignore: cast_nullable_to_non_nullable
as String,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as EncryptedValueModel?,
  ));
}

/// Create a copy of ConnectionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EncryptedValueModelCopyWith<$Res>? get password {
    if (_self.password == null) {
    return null;
  }

  return $EncryptedValueModelCopyWith<$Res>(_self.password!, (value) {
    return _then(_self.copyWith(password: value));
  });
}
}

// dart format on
