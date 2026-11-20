import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/converters/uuid_value_converter.dart';
import 'package:uuid/uuid_value.dart';

void main() {
  const converter = UuidValueConverter();
  const testUuidStr = '019342f4-7f12-7890-a123-456789abcdef';

  group('UuidValueConverter', () {
    test('fromJson converts string to UuidValue', () {
      final result = converter.fromJson(testUuidStr);

      expect(result, isA<UuidValue>());
      expect(result.uuid, testUuidStr);
    });

    test('toJson converts UuidValue to string', () {
      final uuid = UuidValue.fromString(testUuidStr);
      final result = converter.toJson(uuid);

      expect(result, testUuidStr);
    });
  });
}
