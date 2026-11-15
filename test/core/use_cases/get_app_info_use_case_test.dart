import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/models/app_info_model.dart';
import 'package:sharehop/core/repositories/app_info_repository.dart';
import 'package:sharehop/core/use_cases/get_app_info_use_case.dart';

class MockAppInfoRepository implements AppInfoRepository {
  @override
  Future<AppInfoModel> getInfo() async {
    return const AppInfoModel(version: '1.0.0', buildNumber: '42');
  }
}

void main() {
  group('GetAppInfoUseCase', () {
    test('returns app info from repository', () async {
      final repository = MockAppInfoRepository();
      final useCase = GetAppInfoUseCase(appInfoRepository: repository);

      final result = await useCase.call();

      expect(result.version, '1.0.0');
      expect(result.buildNumber, '42');
      expect(result.display, '1.0.0 (42)');
    });
  });
}
