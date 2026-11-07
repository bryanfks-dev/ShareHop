import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/core/models/app_info_model.dart';
import 'package:sharehop/core/repositories/app_info_repository.dart';
import 'package:sharehop/di/app_info_di.dart';
import 'package:sharehop/presentation/controllers/app_info_controller.dart';

class FakeAppInfoRepository implements AppInfoRepository {
  new({
    this.model = const AppInfoModel(version: '1.2.3', buildNumber: '42'),
  });

  final AppInfoModel model;

  @override
  Future<AppInfoModel> getInfo() async => model;
}

void main() {
  group('AppInfoController', () {
    test('build loads app info from repository via use case', () async {
      final fakeRepo = FakeAppInfoRepository();
      final container = ProviderContainer(
        overrides: [appInfoRepositoryProvider.overrideWithValue(fakeRepo)],
      );

      final future = container.read(appInfoControllerProvider.future);
      final result = await future;

      expect(result.version, '1.2.3');
      expect(result.buildNumber, '42');
    });
  });
}
