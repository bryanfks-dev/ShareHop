// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storage_status_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StorageStatusVO {

 double get maximumCapacity; double get usedCapacity;
/// Create a copy of StorageStatusVO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageStatusVOCopyWith<StorageStatusVO> get copyWith => _$StorageStatusVOCopyWithImpl<StorageStatusVO>(this as StorageStatusVO, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StorageStatusVO;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageStatusVO&&(identical(other.maximumCapacity, _this.maximumCapacity) || other.maximumCapacity == _this.maximumCapacity)&&(identical(other.usedCapacity, _this.usedCapacity) || other.usedCapacity == _this.usedCapacity));
}


@override
int get hashCode {
  final _this = this as StorageStatusVO;
  return Object.hash(runtimeType,_this.maximumCapacity,_this.usedCapacity);
}

@override
String toString() {
  final _this = this as StorageStatusVO;
  return 'StorageStatusVO(maximumCapacity: ${_this.maximumCapacity}, usedCapacity: ${_this.usedCapacity})';
}


}

/// @nodoc
abstract mixin class $StorageStatusVOCopyWith<$Res>  {
  factory $StorageStatusVOCopyWith(StorageStatusVO value, $Res Function(StorageStatusVO) _then) = _$StorageStatusVOCopyWithImpl;
@useResult
$Res call({
 double maximumCapacity, double usedCapacity
});




}
/// @nodoc
class _$StorageStatusVOCopyWithImpl<$Res>
    implements $StorageStatusVOCopyWith<$Res> {
  _$StorageStatusVOCopyWithImpl(this._self, this._then);

  final StorageStatusVO _self;
  final $Res Function(StorageStatusVO) _then;

/// Create a copy of StorageStatusVO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maximumCapacity = null,Object? usedCapacity = null,}) {
  return _then(StorageStatusVO(
maximumCapacity: null == maximumCapacity ? _self.maximumCapacity : maximumCapacity // ignore: cast_nullable_to_non_nullable
as double,usedCapacity: null == usedCapacity ? _self.usedCapacity : usedCapacity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [StorageStatusVO].
extension StorageStatusVOPatterns on StorageStatusVO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorageStatusVO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorageStatusVO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorageStatusVO value)  $default,){
final _that = this;
switch (_that) {
case _StorageStatusVO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorageStatusVO value)?  $default,){
final _that = this;
switch (_that) {
case _StorageStatusVO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double maximumCapacity,  double usedCapacity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorageStatusVO() when $default != null:
return $default(_that.maximumCapacity,_that.usedCapacity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double maximumCapacity,  double usedCapacity)  $default,) {final _that = this;
switch (_that) {
case _StorageStatusVO():
return $default(_that.maximumCapacity,_that.usedCapacity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double maximumCapacity,  double usedCapacity)?  $default,) {final _that = this;
switch (_that) {
case _StorageStatusVO() when $default != null:
return $default(_that.maximumCapacity,_that.usedCapacity);case _:
  return null;

}
}

}

/// @nodoc


class _StorageStatusVO extends StorageStatusVO {
  const _StorageStatusVO({required this.maximumCapacity, required this.usedCapacity}): super._();
  

@override final  double maximumCapacity;
@override final  double usedCapacity;

/// Create a copy of StorageStatusVO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorageStatusVOCopyWith<_StorageStatusVO> get copyWith => __$StorageStatusVOCopyWithImpl<_StorageStatusVO>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorageStatusVO&&(identical(other.maximumCapacity, maximumCapacity) || other.maximumCapacity == maximumCapacity)&&(identical(other.usedCapacity, usedCapacity) || other.usedCapacity == usedCapacity));
}


@override
int get hashCode {
    return Object.hash(runtimeType,maximumCapacity,usedCapacity);
}

@override
String toString() {
    return 'StorageStatusVO(maximumCapacity: $maximumCapacity, usedCapacity: $usedCapacity)';
}


}

/// @nodoc
abstract mixin class _$StorageStatusVOCopyWith<$Res> implements $StorageStatusVOCopyWith<$Res> {
  factory _$StorageStatusVOCopyWith(_StorageStatusVO value, $Res Function(_StorageStatusVO) _then) = __$StorageStatusVOCopyWithImpl;
@override @useResult
$Res call({
 double maximumCapacity, double usedCapacity
});




}
/// @nodoc
class __$StorageStatusVOCopyWithImpl<$Res>
    implements _$StorageStatusVOCopyWith<$Res> {
  __$StorageStatusVOCopyWithImpl(this._self, this._then);

  final _StorageStatusVO _self;
  final $Res Function(_StorageStatusVO) _then;

/// Create a copy of StorageStatusVO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maximumCapacity = null,Object? usedCapacity = null,}) {
  return _then(_StorageStatusVO(
maximumCapacity: null == maximumCapacity ? _self.maximumCapacity : maximumCapacity // ignore: cast_nullable_to_non_nullable
as double,usedCapacity: null == usedCapacity ? _self.usedCapacity : usedCapacity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
