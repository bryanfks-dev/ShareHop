// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'file_transfer_history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FileTransferHistoryModel {

 String get id;@JsonKey(name: 'file_name') String get fileName;@JsonKey(name: 'file_size') int get fileSize;@JsonKey(name: 'file_mime_type') String get fileMimeType;@JsonKey(name: 'source_name') String get sourceName;@JsonKey(name: 'destination_name') String get destinationName; FileTransferStatus get status;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of FileTransferHistoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileTransferHistoryModelCopyWith<FileTransferHistoryModel> get copyWith => _$FileTransferHistoryModelCopyWithImpl<FileTransferHistoryModel>(this as FileTransferHistoryModel, _$identity);

  /// Serializes this FileTransferHistoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FileTransferHistoryModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileTransferHistoryModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.fileName, _this.fileName) || other.fileName == _this.fileName)&&(identical(other.fileSize, _this.fileSize) || other.fileSize == _this.fileSize)&&(identical(other.fileMimeType, _this.fileMimeType) || other.fileMimeType == _this.fileMimeType)&&(identical(other.sourceName, _this.sourceName) || other.sourceName == _this.sourceName)&&(identical(other.destinationName, _this.destinationName) || other.destinationName == _this.destinationName)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FileTransferHistoryModel;
  return Object.hash(runtimeType,_this.id,_this.fileName,_this.fileSize,_this.fileMimeType,_this.sourceName,_this.destinationName,_this.status,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as FileTransferHistoryModel;
  return 'FileTransferHistoryModel(id: ${_this.id}, fileName: ${_this.fileName}, fileSize: ${_this.fileSize}, fileMimeType: ${_this.fileMimeType}, sourceName: ${_this.sourceName}, destinationName: ${_this.destinationName}, status: ${_this.status}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $FileTransferHistoryModelCopyWith<$Res>  {
  factory $FileTransferHistoryModelCopyWith(FileTransferHistoryModel value, $Res Function(FileTransferHistoryModel) _then) = _$FileTransferHistoryModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'file_name') String fileName,@JsonKey(name: 'file_size') int fileSize,@JsonKey(name: 'file_mime_type') String fileMimeType,@JsonKey(name: 'source_name') String sourceName,@JsonKey(name: 'destination_name') String destinationName, FileTransferStatus status,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$FileTransferHistoryModelCopyWithImpl<$Res>
    implements $FileTransferHistoryModelCopyWith<$Res> {
  _$FileTransferHistoryModelCopyWithImpl(this._self, this._then);

  final FileTransferHistoryModel _self;
  final $Res Function(FileTransferHistoryModel) _then;

/// Create a copy of FileTransferHistoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fileName = null,Object? fileSize = null,Object? fileMimeType = null,Object? sourceName = null,Object? destinationName = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(FileTransferHistoryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,fileSize: null == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int,fileMimeType: null == fileMimeType ? _self.fileMimeType : fileMimeType // ignore: cast_nullable_to_non_nullable
as String,sourceName: null == sourceName ? _self.sourceName : sourceName // ignore: cast_nullable_to_non_nullable
as String,destinationName: null == destinationName ? _self.destinationName : destinationName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FileTransferStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FileTransferHistoryModel].
extension FileTransferHistoryModelPatterns on FileTransferHistoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FileTransferHistoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FileTransferHistoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FileTransferHistoryModel value)  $default,){
final _that = this;
switch (_that) {
case _FileTransferHistoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FileTransferHistoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _FileTransferHistoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'file_name')  String fileName, @JsonKey(name: 'file_size')  int fileSize, @JsonKey(name: 'file_mime_type')  String fileMimeType, @JsonKey(name: 'source_name')  String sourceName, @JsonKey(name: 'destination_name')  String destinationName,  FileTransferStatus status, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FileTransferHistoryModel() when $default != null:
return $default(_that.id,_that.fileName,_that.fileSize,_that.fileMimeType,_that.sourceName,_that.destinationName,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'file_name')  String fileName, @JsonKey(name: 'file_size')  int fileSize, @JsonKey(name: 'file_mime_type')  String fileMimeType, @JsonKey(name: 'source_name')  String sourceName, @JsonKey(name: 'destination_name')  String destinationName,  FileTransferStatus status, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _FileTransferHistoryModel():
return $default(_that.id,_that.fileName,_that.fileSize,_that.fileMimeType,_that.sourceName,_that.destinationName,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'file_name')  String fileName, @JsonKey(name: 'file_size')  int fileSize, @JsonKey(name: 'file_mime_type')  String fileMimeType, @JsonKey(name: 'source_name')  String sourceName, @JsonKey(name: 'destination_name')  String destinationName,  FileTransferStatus status, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _FileTransferHistoryModel() when $default != null:
return $default(_that.id,_that.fileName,_that.fileSize,_that.fileMimeType,_that.sourceName,_that.destinationName,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FileTransferHistoryModel extends FileTransferHistoryModel {
  const _FileTransferHistoryModel({required this.id, @JsonKey(name: 'file_name') required this.fileName, @JsonKey(name: 'file_size') required this.fileSize, @JsonKey(name: 'file_mime_type') required this.fileMimeType, @JsonKey(name: 'source_name') required this.sourceName, @JsonKey(name: 'destination_name') required this.destinationName, required this.status, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt}): super._();
  factory _FileTransferHistoryModel.fromJson(Map<String, dynamic> json) => _$FileTransferHistoryModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'file_name') final  String fileName;
@override@JsonKey(name: 'file_size') final  int fileSize;
@override@JsonKey(name: 'file_mime_type') final  String fileMimeType;
@override@JsonKey(name: 'source_name') final  String sourceName;
@override@JsonKey(name: 'destination_name') final  String destinationName;
@override final  FileTransferStatus status;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of FileTransferHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FileTransferHistoryModelCopyWith<_FileTransferHistoryModel> get copyWith => __$FileTransferHistoryModelCopyWithImpl<_FileTransferHistoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FileTransferHistoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FileTransferHistoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.fileMimeType, fileMimeType) || other.fileMimeType == fileMimeType)&&(identical(other.sourceName, sourceName) || other.sourceName == sourceName)&&(identical(other.destinationName, destinationName) || other.destinationName == destinationName)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,fileName,fileSize,fileMimeType,sourceName,destinationName,status,createdAt,updatedAt);
}

@override
String toString() {
    return 'FileTransferHistoryModel(id: $id, fileName: $fileName, fileSize: $fileSize, fileMimeType: $fileMimeType, sourceName: $sourceName, destinationName: $destinationName, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$FileTransferHistoryModelCopyWith<$Res> implements $FileTransferHistoryModelCopyWith<$Res> {
  factory _$FileTransferHistoryModelCopyWith(_FileTransferHistoryModel value, $Res Function(_FileTransferHistoryModel) _then) = __$FileTransferHistoryModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'file_name') String fileName,@JsonKey(name: 'file_size') int fileSize,@JsonKey(name: 'file_mime_type') String fileMimeType,@JsonKey(name: 'source_name') String sourceName,@JsonKey(name: 'destination_name') String destinationName, FileTransferStatus status,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$FileTransferHistoryModelCopyWithImpl<$Res>
    implements _$FileTransferHistoryModelCopyWith<$Res> {
  __$FileTransferHistoryModelCopyWithImpl(this._self, this._then);

  final _FileTransferHistoryModel _self;
  final $Res Function(_FileTransferHistoryModel) _then;

/// Create a copy of FileTransferHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fileName = null,Object? fileSize = null,Object? fileMimeType = null,Object? sourceName = null,Object? destinationName = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_FileTransferHistoryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,fileSize: null == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int,fileMimeType: null == fileMimeType ? _self.fileMimeType : fileMimeType // ignore: cast_nullable_to_non_nullable
as String,sourceName: null == sourceName ? _self.sourceName : sourceName // ignore: cast_nullable_to_non_nullable
as String,destinationName: null == destinationName ? _self.destinationName : destinationName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FileTransferStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
