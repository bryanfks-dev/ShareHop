import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/data/utils/not_required_value.dart';
import 'package:sharehop/infrastructures/database/utils/not_required_value_map_util.dart';

enum _TestPlainEnum { first }

void main() {
  group('forEachNotRequiredValueMap', () {
    test('skips id, handles BaseEnum and plain Enum, and ignores non-values',
        () {
      final input = <String, dynamic>{
        'id': 'conn-123',
        'display_name': const NotRequiredValue('My Connection'),
        'protocol': const NotRequiredValue(ConnectionProtocol.webdav),
        'plain_enum': const NotRequiredValue(_TestPlainEnum.first),
        'unwrapped': 'ignored',
        'null_not_required': const NotRequiredValue<String>(null),
        'null_field': null,
      };

      final result = <String, dynamic>{};
      forEachNotRequiredValueMap(input, (key, value) {
        result[key] = value;
      });

      expect(result, {
        'display_name': 'My Connection',
        'protocol': 'webdav',
        'plain_enum': 'first',
      });
      expect(result.containsKey('id'), isFalse);
      expect(result.containsKey('unwrapped'), isFalse);
      expect(result.containsKey('null_not_required'), isFalse);
      expect(result.containsKey('null_field'), isFalse);
    });

    test('preserves id when skipId is false', () {
      final input = <String, dynamic>{
        'id': const NotRequiredValue('custom-id'),
        'name': const NotRequiredValue('Test'),
      };

      final result = <String, dynamic>{};
      forEachNotRequiredValueMap(input, (key, value) {
        result[key] = value;
      }, skipId: false);

      expect(result, {
        'id': 'custom-id',
        'name': 'Test',
      });
    });
  });
}
