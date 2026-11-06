// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'encrypted_value_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EncryptedValueModel {

 String get id; String get salt; String get nonce;@JsonKey(name: 'cipher_text') String get cipherText; String get mac;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of EncryptedValueModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EncryptedValueModelCopyWith<EncryptedValueModel> get copyWith => _$EncryptedValueModelCopyWithImpl<EncryptedValueModel>(this as EncryptedValueModel, _$identity);

  /// Serializes this EncryptedValueModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EncryptedValueModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EncryptedValueModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.salt, _this.salt) || other.salt == _this.salt)&&(identical(other.nonce, _this.nonce) || other.nonce == _this.nonce)&&(identical(other.cipherText, _this.cipherText) || other.cipherText == _this.cipherText)&&(identical(other.mac, _this.mac) || other.mac == _this.mac)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EncryptedValueModel;
  return Object.hash(runtimeType,_this.id,_this.salt,_this.nonce,_this.cipherText,_this.mac,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as EncryptedValueModel;
  return 'EncryptedValueModel(id: ${_this.id}, salt: ${_this.salt}, nonce: ${_this.nonce}, cipherText: ${_this.cipherText}, mac: ${_this.mac}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $EncryptedValueModelCopyWith<$Res>  {
  factory $EncryptedValueModelCopyWith(EncryptedValueModel value, $Res Function(EncryptedValueModel) _then) = _$EncryptedValueModelCopyWithImpl;
@useResult
$Res call({
 String id, String salt, String nonce,@JsonKey(name: 'cipher_text') String cipherText, String mac,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$EncryptedValueModelCopyWithImpl<$Res>
    implements $EncryptedValueModelCopyWith<$Res> {
  _$EncryptedValueModelCopyWithImpl(this._self, this._then);

  final EncryptedValueModel _self;
  final $Res Function(EncryptedValueModel) _then;

/// Create a copy of EncryptedValueModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? salt = null,Object? nonce = null,Object? cipherText = null,Object? mac = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(EncryptedValueModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,salt: null == salt ? _self.salt : salt // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,cipherText: null == cipherText ? _self.cipherText : cipherText // ignore: cast_nullable_to_non_nullable
as String,mac: null == mac ? _self.mac : mac // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [EncryptedValueModel].
extension EncryptedValueModelPatterns on EncryptedValueModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EncryptedValueModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EncryptedValueModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EncryptedValueModel value)  $default,){
final _that = this;
switch (_that) {
case _EncryptedValueModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EncryptedValueModel value)?  $default,){
final _that = this;
switch (_that) {
case _EncryptedValueModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String salt,  String nonce, @JsonKey(name: 'cipher_text')  String cipherText,  String mac, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EncryptedValueModel() when $default != null:
return $default(_that.id,_that.salt,_that.nonce,_that.cipherText,_that.mac,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String salt,  String nonce, @JsonKey(name: 'cipher_text')  String cipherText,  String mac, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _EncryptedValueModel():
return $default(_that.id,_that.salt,_that.nonce,_that.cipherText,_that.mac,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String salt,  String nonce, @JsonKey(name: 'cipher_text')  String cipherText,  String mac, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _EncryptedValueModel() when $default != null:
return $default(_that.id,_that.salt,_that.nonce,_that.cipherText,_that.mac,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EncryptedValueModel extends EncryptedValueModel {
  const _EncryptedValueModel({required this.id, required this.salt, required this.nonce, @JsonKey(name: 'cipher_text') required this.cipherText, required this.mac, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt}): super._();
  factory _EncryptedValueModel.fromJson(Map<String, dynamic> json) => _$EncryptedValueModelFromJson(json);

@override final  String id;
@override final  String salt;
@override final  String nonce;
@override@JsonKey(name: 'cipher_text') final  String cipherText;
@override final  String mac;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of EncryptedValueModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EncryptedValueModelCopyWith<_EncryptedValueModel> get copyWith => __$EncryptedValueModelCopyWithImpl<_EncryptedValueModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EncryptedValueModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EncryptedValueModel&&(identical(other.id, id) || other.id == id)&&(identical(other.salt, salt) || other.salt == salt)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.cipherText, cipherText) || other.cipherText == cipherText)&&(identical(other.mac, mac) || other.mac == mac)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,salt,nonce,cipherText,mac,createdAt,updatedAt);
}

@override
String toString() {
    return 'EncryptedValueModel(id: $id, salt: $salt, nonce: $nonce, cipherText: $cipherText, mac: $mac, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$EncryptedValueModelCopyWith<$Res> implements $EncryptedValueModelCopyWith<$Res> {
  factory _$EncryptedValueModelCopyWith(_EncryptedValueModel value, $Res Function(_EncryptedValueModel) _then) = __$EncryptedValueModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String salt, String nonce,@JsonKey(name: 'cipher_text') String cipherText, String mac,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$EncryptedValueModelCopyWithImpl<$Res>
    implements _$EncryptedValueModelCopyWith<$Res> {
  __$EncryptedValueModelCopyWithImpl(this._self, this._then);

  final _EncryptedValueModel _self;
  final $Res Function(_EncryptedValueModel) _then;

/// Create a copy of EncryptedValueModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? salt = null,Object? nonce = null,Object? cipherText = null,Object? mac = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_EncryptedValueModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,salt: null == salt ? _self.salt : salt // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,cipherText: null == cipherText ? _self.cipherText : cipherText // ignore: cast_nullable_to_non_nullable
as String,mac: null == mac ? _self.mac : mac // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
