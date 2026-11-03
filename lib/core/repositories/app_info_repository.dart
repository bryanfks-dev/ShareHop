import 'package:sharehop/core/models/app_info_model.dart';

abstract interface class AppInfoRepository {
  Future<AppInfoModel> getInfo();
}
