import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/models/app_info_model.dart';

void main() {
  group('AppInfoModel', () {
    test('instantiates and formats display string', () {
      const model = AppInfoModel(version: '1.2.3', buildNumber: '45');

      expect(model.version, '1.2.3');
      expect(model.buildNumber, '45');
      expect(model.display, '1.2.3 (45)');
      expect(
        model.toString(),
        'AppInfoModel(version: 1.2.3, buildNumber: 45)',
      );
    });

    test('equality and hashCode', () {
      const model1 = AppInfoModel(version: '1.0.0', buildNumber: '1');
      const model2 = AppInfoModel(version: '1.0.0', buildNumber: '1');
      const model3 = AppInfoModel(version: '2.0.0', buildNumber: '1');

      expect(model1, model2);
      expect(model1.hashCode, model2.hashCode);
      expect(model1, isNot(model3));
    });
  });
}
