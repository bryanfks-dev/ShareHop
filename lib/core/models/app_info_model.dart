import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_info_model.freezed.dart';

@freezed
class AppInfoModel with _$AppInfoModel {
  const new({required this.version, required this.buildNumber});

  final String version;
  final String buildNumber;

  String get display => '$version ($buildNumber)';

  @override
  String toString() =>
      'AppInfoModel(version: $version, buildNumber: $buildNumber)';
}
