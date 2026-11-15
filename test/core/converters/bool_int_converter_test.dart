import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/converters/bool_int_converter.dart';

void main() {
  group('BoolIntConverter', () {
    const converter = BoolIntConverter();

    test('fromJson returns true when json is 1', () {
      expect(converter.fromJson(1), isTrue);
    });

    test('fromJson returns false when json is not 1', () {
      expect(converter.fromJson(0), isFalse);
      expect(converter.fromJson(2), isFalse);
    });

    test('toJson returns 1 when true', () {
      expect(converter.toJson(true), 1);
    });

    test('toJson returns 0 when false', () {
      expect(converter.toJson(false), 0);
    });
  });
}
