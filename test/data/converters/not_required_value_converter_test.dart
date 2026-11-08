import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/data/converters/not_required_value_converter.dart';
import 'package:sharehop/data/utils/not_required_value.dart';

void main() {
  group('NotRequiredValueConverter', () {
    test('fromJson wraps non-null value', () {
      const converter = NotRequiredValueConverter<String>();
      final result = converter.fromJson('hello');

      expect(result, const NotRequiredValue<String>('hello'));
      expect(result.value, 'hello');
    });

    test('fromJson wraps null value', () {
      const converter = NotRequiredValueConverter<String>();
      final result = converter.fromJson(null);

      expect(result, const NotRequiredValue<String>(null));
      expect(result.value, isNull);
    });

    test('toJson extracts non-null value', () {
      const converter = NotRequiredValueConverter<int>();
      final json = converter.toJson(const NotRequiredValue<int>(42));

      expect(json, 42);
    });

    test('toJson extracts null value', () {
      const converter = NotRequiredValueConverter<int>();
      final json = converter.toJson(const NotRequiredValue<int>(null));

      expect(json, isNull);
    });
  });
}
