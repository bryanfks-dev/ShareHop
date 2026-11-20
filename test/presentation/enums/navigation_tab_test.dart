import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/presentation/enums/navigation_tab.dart';

void main() {
  group('NavigationTab', () {
    test('contains expected tabs in correct order', () {
      expect(NavigationTab.values, [
        NavigationTab.connections,
        NavigationTab.transfers,
        NavigationTab.settings,
      ]);
    });
  });
}
