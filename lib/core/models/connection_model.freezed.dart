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

 String get id; ConnectionProtocol get protocol;@JsonKey(name: 'display_name') String get displayName;@JsonKey(name: 'remote_address') String get remoteAddress; String get username; EncryptedValueModel get password;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;

  /// Serializes this ConnectionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ConnectionModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectionModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.protocol, _this.protocol) || other.protocol == _this.protocol)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.remoteAddress, _this.remoteAddress) || other.remoteAddress == _this.remoteAddress)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.password, _this.password) || other.password == _this.password)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ConnectionModel;
  return Object.hash(runtimeType,_this.id,_this.protocol,_this.displayName,_this.remoteAddress,_this.username,_this.password,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as ConnectionModel;
  return 'ConnectionModel(id: ${_this.id}, protocol: ${_this.protocol}, displayName: ${_this.displayName}, remoteAddress: ${_this.remoteAddress}, username: ${_this.username}, password: ${_this.password}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ConnectionProtocol protocol, @JsonKey(name: 'display_name')  String displayName, @JsonKey(name: 'remote_address')  String remoteAddress,  String username,  EncryptedValueModel password, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConnectionModel() when $default != null:
return $default(_that.id,_that.protocol,_that.displayName,_that.remoteAddress,_that.username,_that.password,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ConnectionProtocol protocol, @JsonKey(name: 'display_name')  String displayName, @JsonKey(name: 'remote_address')  String remoteAddress,  String username,  EncryptedValueModel password, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ConnectionModel():
return $default(_that.id,_that.protocol,_that.displayName,_that.remoteAddress,_that.username,_that.password,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ConnectionProtocol protocol, @JsonKey(name: 'display_name')  String displayName, @JsonKey(name: 'remote_address')  String remoteAddress,  String username,  EncryptedValueModel password, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ConnectionModel() when $default != null:
return $default(_that.id,_that.protocol,_that.displayName,_that.remoteAddress,_that.username,_that.password,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConnectionModel extends ConnectionModel {
  const _ConnectionModel({required this.id, required this.protocol, @JsonKey(name: 'display_name') required this.displayName, @JsonKey(name: 'remote_address') required this.remoteAddress, required this.username, required this.password, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt}): super._();
  factory _ConnectionModel.fromJson(Map<String, dynamic> json) => _$ConnectionModelFromJson(json);

@override final  String id;
@override final  ConnectionProtocol protocol;
@override@JsonKey(name: 'display_name') final  String displayName;
@override@JsonKey(name: 'remote_address') final  String remoteAddress;
@override final  String username;
@override final  EncryptedValueModel password;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;


@override
Map<String, dynamic> toJson() {
  return _$ConnectionModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.protocol, protocol) || other.protocol == protocol)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.remoteAddress, remoteAddress) || other.remoteAddress == remoteAddress)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,protocol,displayName,remoteAddress,username,password,createdAt,updatedAt);
}

@override
String toString() {
    return 'ConnectionModel(id: $id, protocol: $protocol, displayName: $displayName, remoteAddress: $remoteAddress, username: $username, password: $password, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}




// dart format on
