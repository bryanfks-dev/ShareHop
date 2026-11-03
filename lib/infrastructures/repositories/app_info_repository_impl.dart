import 'dart:developer';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:sharehop/core/models/app_info_model.dart';
import 'package:sharehop/core/repositories/app_info_repository.dart';

class AppInfoRepositoryImpl implements AppInfoRepository {
  @override
  Future<AppInfoModel> getInfo() async {
    log('Get app info started', name: 'AppInfoRepositoryImpl.getInfo');

    final packageInfo = await PackageInfo.fromPlatform();
    return AppInfoModel(
      version: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
    );
  }
}
