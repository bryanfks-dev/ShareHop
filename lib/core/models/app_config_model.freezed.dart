// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_config_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppConfigModel {


/// Create a copy of AppConfigModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigModelCopyWith<AppConfigModel> get copyWith => _$AppConfigModelCopyWithImpl<AppConfigModel>(this as AppConfigModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AppConfigModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfigModel&&(identical(other.isWifiOnlyTransfersEnabled, _this.isWifiOnlyTransfersEnabled) || other.isWifiOnlyTransfersEnabled == _this.isWifiOnlyTransfersEnabled)&&(identical(other.isBackgroundTransfersEnabled, _this.isBackgroundTransfersEnabled) || other.isBackgroundTransfersEnabled == _this.isBackgroundTransfersEnabled)&&(identical(other.simultaneousTransfersLimit, _this.simultaneousTransfersLimit) || other.simultaneousTransfersLimit == _this.simultaneousTransfersLimit)&&(identical(other.onFileConflictsResolution, _this.onFileConflictsResolution) || other.onFileConflictsResolution == _this.onFileConflictsResolution)&&(identical(other.isBiometricLockEnabled, _this.isBiometricLockEnabled) || other.isBiometricLockEnabled == _this.isBiometricLockEnabled)&&(identical(other.downloadDestinationPath, _this.downloadDestinationPath) || other.downloadDestinationPath == _this.downloadDestinationPath)&&(identical(other.appAppearance, _this.appAppearance) || other.appAppearance == _this.appAppearance));
}


@override
int get hashCode {
  final _this = this as AppConfigModel;
  return Object.hash(runtimeType,_this.isWifiOnlyTransfersEnabled,_this.isBackgroundTransfersEnabled,_this.simultaneousTransfersLimit,_this.onFileConflictsResolution,_this.isBiometricLockEnabled,_this.downloadDestinationPath,_this.appAppearance);
}

@override
String toString() {
  final _this = this as AppConfigModel;
  return 'AppConfigModel(isWifiOnlyTransfersEnabled: ${_this.isWifiOnlyTransfersEnabled}, isBackgroundTransfersEnabled: ${_this.isBackgroundTransfersEnabled}, simultaneousTransfersLimit: ${_this.simultaneousTransfersLimit}, onFileConflictsResolution: ${_this.onFileConflictsResolution}, isBiometricLockEnabled: ${_this.isBiometricLockEnabled}, downloadDestinationPath: ${_this.downloadDestinationPath}, appAppearance: ${_this.appAppearance})';
}


}

/// @nodoc
abstract mixin class $AppConfigModelCopyWith<$Res>  {
  factory $AppConfigModelCopyWith(AppConfigModel value, $Res Function(AppConfigModel) _then) = _$AppConfigModelCopyWithImpl;
@useResult
$Res call({
 bool? isWifiOnlyTransfersEnabled, bool? isBackgroundTransfersEnabled, int? simultaneousTransfersLimit, OnFileConflictsResolution? onFileConflictsResolution, bool? isBiometricLockEnabled, String? downloadDestinationPath, AppTheme? appAppearance
});




}
/// @nodoc
class _$AppConfigModelCopyWithImpl<$Res>
    implements $AppConfigModelCopyWith<$Res> {
  _$AppConfigModelCopyWithImpl(this._self, this._then);

  final AppConfigModel _self;
  final $Res Function(AppConfigModel) _then;

/// Create a copy of AppConfigModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isWifiOnlyTransfersEnabled = freezed,Object? isBackgroundTransfersEnabled = freezed,Object? simultaneousTransfersLimit = freezed,Object? onFileConflictsResolution = freezed,Object? isBiometricLockEnabled = freezed,Object? downloadDestinationPath = freezed,Object? appAppearance = freezed,}) {
  return _then(AppConfigModel(
isWifiOnlyTransfersEnabled: freezed == isWifiOnlyTransfersEnabled ? _self.isWifiOnlyTransfersEnabled! : isWifiOnlyTransfersEnabled // ignore: cast_nullable_to_non_nullable
as bool?,isBackgroundTransfersEnabled: freezed == isBackgroundTransfersEnabled ? _self.isBackgroundTransfersEnabled! : isBackgroundTransfersEnabled // ignore: cast_nullable_to_non_nullable
as bool?,simultaneousTransfersLimit: freezed == simultaneousTransfersLimit ? _self.simultaneousTransfersLimit! : simultaneousTransfersLimit // ignore: cast_nullable_to_non_nullable
as int?,onFileConflictsResolution: freezed == onFileConflictsResolution ? _self.onFileConflictsResolution! : onFileConflictsResolution // ignore: cast_nullable_to_non_nullable
as OnFileConflictsResolution?,isBiometricLockEnabled: freezed == isBiometricLockEnabled ? _self.isBiometricLockEnabled! : isBiometricLockEnabled // ignore: cast_nullable_to_non_nullable
as bool?,downloadDestinationPath: freezed == downloadDestinationPath ? _self.downloadDestinationPath! : downloadDestinationPath // ignore: cast_nullable_to_non_nullable
as String?,appAppearance: freezed == appAppearance ? _self.appAppearance! : appAppearance // ignore: cast_nullable_to_non_nullable
as AppTheme?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfigModel].
extension AppConfigModelPatterns on AppConfigModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
