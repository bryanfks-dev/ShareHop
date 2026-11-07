import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/presentation/extensions/router/navigator_extension.dart';

void main() {
  group('NavigatorExtention', () {
    testWidgets('navigator getter retrieves NavigatorState from context',
        (tester) async {
      late NavigatorState navigatorState;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              navigatorState = context.navigator;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(navigatorState, isA<NavigatorState>());
    });
  });
}
