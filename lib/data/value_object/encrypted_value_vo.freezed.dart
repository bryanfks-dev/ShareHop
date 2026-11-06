// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'encrypted_value_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EncryptedValueVo {

 String get salt; String get nonce;@JsonKey(name: 'cipher_text') String get cipherText; String get mac;
/// Create a copy of EncryptedValueVo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EncryptedValueVoCopyWith<EncryptedValueVo> get copyWith => _$EncryptedValueVoCopyWithImpl<EncryptedValueVo>(this as EncryptedValueVo, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EncryptedValueVo;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EncryptedValueVo&&(identical(other.salt, _this.salt) || other.salt == _this.salt)&&(identical(other.nonce, _this.nonce) || other.nonce == _this.nonce)&&(identical(other.cipherText, _this.cipherText) || other.cipherText == _this.cipherText)&&(identical(other.mac, _this.mac) || other.mac == _this.mac));
}


@override
int get hashCode {
  final _this = this as EncryptedValueVo;
  return Object.hash(runtimeType,_this.salt,_this.nonce,_this.cipherText,_this.mac);
}

@override
String toString() {
  final _this = this as EncryptedValueVo;
  return 'EncryptedValueVo(salt: ${_this.salt}, nonce: ${_this.nonce}, cipherText: ${_this.cipherText}, mac: ${_this.mac})';
}


}

/// @nodoc
abstract mixin class $EncryptedValueVoCopyWith<$Res>  {
  factory $EncryptedValueVoCopyWith(EncryptedValueVo value, $Res Function(EncryptedValueVo) _then) = _$EncryptedValueVoCopyWithImpl;
@useResult
$Res call({
 String salt, String nonce,@JsonKey(name: 'cipher_text') String cipherText, String mac
});




}
/// @nodoc
class _$EncryptedValueVoCopyWithImpl<$Res>
    implements $EncryptedValueVoCopyWith<$Res> {
  _$EncryptedValueVoCopyWithImpl(this._self, this._then);

  final EncryptedValueVo _self;
  final $Res Function(EncryptedValueVo) _then;

/// Create a copy of EncryptedValueVo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? salt = null,Object? nonce = null,Object? cipherText = null,Object? mac = null,}) {
  return _then(EncryptedValueVo(
salt: null == salt ? _self.salt : salt // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,cipherText: null == cipherText ? _self.cipherText : cipherText // ignore: cast_nullable_to_non_nullable
as String,mac: null == mac ? _self.mac : mac // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EncryptedValueVo].
extension EncryptedValueVoPatterns on EncryptedValueVo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EncryptedValueVo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EncryptedValueVo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EncryptedValueVo value)  $default,){
final _that = this;
switch (_that) {
case _EncryptedValueVo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EncryptedValueVo value)?  $default,){
final _that = this;
switch (_that) {
case _EncryptedValueVo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String salt,  String nonce, @JsonKey(name: 'cipher_text')  String cipherText,  String mac)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EncryptedValueVo() when $default != null:
return $default(_that.salt,_that.nonce,_that.cipherText,_that.mac);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String salt,  String nonce, @JsonKey(name: 'cipher_text')  String cipherText,  String mac)  $default,) {final _that = this;
switch (_that) {
case _EncryptedValueVo():
return $default(_that.salt,_that.nonce,_that.cipherText,_that.mac);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String salt,  String nonce, @JsonKey(name: 'cipher_text')  String cipherText,  String mac)?  $default,) {final _that = this;
switch (_that) {
case _EncryptedValueVo() when $default != null:
return $default(_that.salt,_that.nonce,_that.cipherText,_that.mac);case _:
  return null;

}
}

}

/// @nodoc


class _EncryptedValueVo implements EncryptedValueVo {
  const _EncryptedValueVo({required this.salt, required this.nonce, @JsonKey(name: 'cipher_text') required this.cipherText, required this.mac});
  

@override final  String salt;
@override final  String nonce;
@override@JsonKey(name: 'cipher_text') final  String cipherText;
@override final  String mac;

/// Create a copy of EncryptedValueVo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EncryptedValueVoCopyWith<_EncryptedValueVo> get copyWith => __$EncryptedValueVoCopyWithImpl<_EncryptedValueVo>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EncryptedValueVo&&(identical(other.salt, salt) || other.salt == salt)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.cipherText, cipherText) || other.cipherText == cipherText)&&(identical(other.mac, mac) || other.mac == mac));
}


@override
int get hashCode {
    return Object.hash(runtimeType,salt,nonce,cipherText,mac);
}

@override
String toString() {
    return 'EncryptedValueVo(salt: $salt, nonce: $nonce, cipherText: $cipherText, mac: $mac)';
}


}

/// @nodoc
abstract mixin class _$EncryptedValueVoCopyWith<$Res> implements $EncryptedValueVoCopyWith<$Res> {
  factory _$EncryptedValueVoCopyWith(_EncryptedValueVo value, $Res Function(_EncryptedValueVo) _then) = __$EncryptedValueVoCopyWithImpl;
@override @useResult
$Res call({
 String salt, String nonce,@JsonKey(name: 'cipher_text') String cipherText, String mac
});




}
/// @nodoc
class __$EncryptedValueVoCopyWithImpl<$Res>
    implements _$EncryptedValueVoCopyWith<$Res> {
  __$EncryptedValueVoCopyWithImpl(this._self, this._then);

  final _EncryptedValueVo _self;
  final $Res Function(_EncryptedValueVo) _then;

/// Create a copy of EncryptedValueVo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? salt = null,Object? nonce = null,Object? cipherText = null,Object? mac = null,}) {
  return _then(_EncryptedValueVo(
salt: null == salt ? _self.salt : salt // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,cipherText: null == cipherText ? _self.cipherText : cipherText // ignore: cast_nullable_to_non_nullable
as String,mac: null == mac ? _self.mac : mac // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
