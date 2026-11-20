import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/landspace_workspace_handoff/screen.dart';
import 'package:sharehop/presentation/theme/theme.dart';

class _SpyNavigatorObserver extends NavigatorObserver {
  new({required this.onPopped});

  final VoidCallback onPopped;

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    onPopped();
  }
}

Widget _buildTestWidget({NavigatorObserver? observer}) {
  return MaterialApp(
    navigatorObservers: [?observer],
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, c) => FTheme(
      data: lightTheme,
      child: c!,
    ),
    home: observer == null
        ? const LandspaceWorkspaceHandoffScreen()
        : Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: FButton(
                  onPress: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const LandspaceWorkspaceHandoffScreen(),
                    ),
                  ),
                  child: const Text('Open'),
                ),
              ),
            ),
          ),
  );
}

void main() {
  group('LandspaceWorkspaceHandoffScreen', () {
    testWidgets('renders all screen sections, tiles, and actions', (
      tester,
    ) async {
      await tester.pumpWidget(_buildTestWidget());
      await tester.pumpAndSettle();

      expect(
        find.text('Turn your Phone. Work both sides.'),
        findsOneWidget,
      );
      expect(find.text('Device stays on the left'), findsOneWidget);
      expect(find.text('Production stays on the right'), findsOneWidget);
      expect(find.text('Transfer in either direction'), findsOneWidget);
      expect(find.text('Open landspace workspace'), findsOneWidget);
      expect(find.text('Not now'), findsOneWidget);
    });

    testWidgets('pops screen when Not now button is tapped', (tester) async {
      var popped = false;
      final observer = _SpyNavigatorObserver(onPopped: () => popped = true);
      await tester.pumpWidget(_buildTestWidget(observer: observer));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Not now'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Not now'));
      await tester.pumpAndSettle();
      expect(popped, isTrue);
    });
  });
}
