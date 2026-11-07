// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pinned_connection_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PinnedConnectionModel {

 String get id;@JsonKey(name: 'connection_id') String get connectionId;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;@JsonKey(includeFromJson: false, includeToJson: false) ConnectionModel? get connection;
/// Create a copy of PinnedConnectionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PinnedConnectionModelCopyWith<PinnedConnectionModel> get copyWith => _$PinnedConnectionModelCopyWithImpl<PinnedConnectionModel>(this as PinnedConnectionModel, _$identity);

  /// Serializes this PinnedConnectionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PinnedConnectionModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PinnedConnectionModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.connectionId, _this.connectionId) || other.connectionId == _this.connectionId)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.connection, _this.connection) || other.connection == _this.connection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PinnedConnectionModel;
  return Object.hash(runtimeType,_this.id,_this.connectionId,_this.createdAt,_this.updatedAt,_this.connection);
}

@override
String toString() {
  final _this = this as PinnedConnectionModel;
  return 'PinnedConnectionModel(id: ${_this.id}, connectionId: ${_this.connectionId}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, connection: ${_this.connection})';
}


}

/// @nodoc
abstract mixin class $PinnedConnectionModelCopyWith<$Res>  {
  factory $PinnedConnectionModelCopyWith(PinnedConnectionModel value, $Res Function(PinnedConnectionModel) _then) = _$PinnedConnectionModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'connection_id') String connectionId,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt,@JsonKey(includeFromJson: false, includeToJson: false) ConnectionModel? connection
});


$ConnectionModelCopyWith<$Res>? get connection;

}
/// @nodoc
class _$PinnedConnectionModelCopyWithImpl<$Res>
    implements $PinnedConnectionModelCopyWith<$Res> {
  _$PinnedConnectionModelCopyWithImpl(this._self, this._then);

  final PinnedConnectionModel _self;
  final $Res Function(PinnedConnectionModel) _then;

/// Create a copy of PinnedConnectionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? connectionId = null,Object? createdAt = null,Object? updatedAt = null,Object? connection = freezed,}) {
  return _then(PinnedConnectionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,connectionId: null == connectionId ? _self.connectionId : connectionId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,connection: freezed == connection ? _self.connection : connection // ignore: cast_nullable_to_non_nullable
as ConnectionModel?,
  ));
}
/// Create a copy of PinnedConnectionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectionModelCopyWith<$Res>? get connection {
    if (_self.connection == null) {
    return null;
  }

  return $ConnectionModelCopyWith<$Res>(_self.connection!, (value) {
    return _then(_self.copyWith(connection: value));
  });
}
}


/// Adds pattern-matching-related methods to [PinnedConnectionModel].
extension PinnedConnectionModelPatterns on PinnedConnectionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PinnedConnectionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PinnedConnectionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PinnedConnectionModel value)  $default,){
final _that = this;
switch (_that) {
case _PinnedConnectionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PinnedConnectionModel value)?  $default,){
final _that = this;
switch (_that) {
case _PinnedConnectionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'connection_id')  String connectionId, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(includeFromJson: false, includeToJson: false)  ConnectionModel? connection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PinnedConnectionModel() when $default != null:
return $default(_that.id,_that.connectionId,_that.createdAt,_that.updatedAt,_that.connection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'connection_id')  String connectionId, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(includeFromJson: false, includeToJson: false)  ConnectionModel? connection)  $default,) {final _that = this;
switch (_that) {
case _PinnedConnectionModel():
return $default(_that.id,_that.connectionId,_that.createdAt,_that.updatedAt,_that.connection);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'connection_id')  String connectionId, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(includeFromJson: false, includeToJson: false)  ConnectionModel? connection)?  $default,) {final _that = this;
switch (_that) {
case _PinnedConnectionModel() when $default != null:
return $default(_that.id,_that.connectionId,_that.createdAt,_that.updatedAt,_that.connection);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PinnedConnectionModel extends PinnedConnectionModel {
  const _PinnedConnectionModel({required this.id, @JsonKey(name: 'connection_id') required this.connectionId, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, @JsonKey(includeFromJson: false, includeToJson: false) this.connection}): super._();
  factory _PinnedConnectionModel.fromJson(Map<String, dynamic> json) => _$PinnedConnectionModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'connection_id') final  String connectionId;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  ConnectionModel? connection;

/// Create a copy of PinnedConnectionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PinnedConnectionModelCopyWith<_PinnedConnectionModel> get copyWith => __$PinnedConnectionModelCopyWithImpl<_PinnedConnectionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PinnedConnectionModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PinnedConnectionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.connectionId, connectionId) || other.connectionId == connectionId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.connection, connection) || other.connection == connection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,connectionId,createdAt,updatedAt,connection);
}

@override
String toString() {
    return 'PinnedConnectionModel(id: $id, connectionId: $connectionId, createdAt: $createdAt, updatedAt: $updatedAt, connection: $connection)';
}


}

/// @nodoc
abstract mixin class _$PinnedConnectionModelCopyWith<$Res> implements $PinnedConnectionModelCopyWith<$Res> {
  factory _$PinnedConnectionModelCopyWith(_PinnedConnectionModel value, $Res Function(_PinnedConnectionModel) _then) = __$PinnedConnectionModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'connection_id') String connectionId,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt,@JsonKey(includeFromJson: false, includeToJson: false) ConnectionModel? connection
});


@override $ConnectionModelCopyWith<$Res>? get connection;

}
/// @nodoc
class __$PinnedConnectionModelCopyWithImpl<$Res>
    implements _$PinnedConnectionModelCopyWith<$Res> {
  __$PinnedConnectionModelCopyWithImpl(this._self, this._then);

  final _PinnedConnectionModel _self;
  final $Res Function(_PinnedConnectionModel) _then;

/// Create a copy of PinnedConnectionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? connectionId = null,Object? createdAt = null,Object? updatedAt = null,Object? connection = freezed,}) {
  return _then(_PinnedConnectionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,connectionId: null == connectionId ? _self.connectionId : connectionId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,connection: freezed == connection ? _self.connection : connection // ignore: cast_nullable_to_non_nullable
as ConnectionModel?,
  ));
}

/// Create a copy of PinnedConnectionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectionModelCopyWith<$Res>? get connection {
    if (_self.connection == null) {
    return null;
  }

  return $ConnectionModelCopyWith<$Res>(_self.connection!, (value) {
    return _then(_self.copyWith(connection: value));
  });
}
}

// dart format on
