import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/widgets/primitives/scroll_down_button.dart';

Widget _buildTestWidget({required ScrollController controller}) {
  return MaterialApp(
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, c) => FTheme(
      data: lightTheme,
      child: c!,
    ),
    home: Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            controller: controller,
            itemCount: 100,
            itemBuilder: (context, index) => SizedBox(
              height: 50,
              child: Text('Item $index'),
            ),
          ),
          ScrollDownButton(scrollController: controller),
        ],
      ),
    ),
  );
}

void main() {
  group('ScrollDownButton', () {
    testWidgets('renders button and scrolls on press', (tester) async {
      final controller = ScrollController();

      await tester.pumpWidget(_buildTestWidget(controller: controller));
      await tester.pumpAndSettle();

      expect(find.byType(ScrollDownButton), findsOneWidget);
      expect(controller.offset, 0.0);

      // Tap the scroll down button
      await tester.tap(find.byType(ScrollDownButton));
      await tester.pumpAndSettle();

      expect(controller.offset, greaterThan(0.0));
      expect(controller.offset, controller.position.maxScrollExtent);
    });
  });
}
