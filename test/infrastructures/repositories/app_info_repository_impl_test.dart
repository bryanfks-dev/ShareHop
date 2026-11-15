import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sharehop/infrastructures/repositories/app_info_repository_impl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppInfoRepositoryImpl', () {
    test(
      'getInfo returns AppInfoModel with version and build number',
      () async {
      PackageInfo.setMockInitialValues(
        appName: 'ShareHop',
        packageName: 'com.sharehop.app',
        version: '2.4.0',
        buildNumber: '108',
        buildSignature: '',
      );

      final repository = AppInfoRepositoryImpl();
      final appInfo = await repository.getInfo();

      expect(appInfo.version, '2.4.0');
      expect(appInfo.buildNumber, '108');
    });
  });
}
