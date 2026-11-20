import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/extensions/primitives/map_extension.dart';

void main() {
  group('MapExtension', () {
    test('resolveNulls maps all entries correctly', () {
      final map = <dynamic, dynamic>{'a': 1, 'b': null, 'c': 'text'};
      final result = map.resolveNulls();

      expect(result, {'a': 1, 'b': null, 'c': 'text'});
    });
  });
}
