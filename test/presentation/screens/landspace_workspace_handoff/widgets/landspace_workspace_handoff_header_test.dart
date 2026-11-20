import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/landspace_workspace_handoff/widgets/landspace_workspace_handoff_header.dart';
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
        ? const Scaffold(body: LandspaceWorkspaceHandoffHeader())
        : Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: FButton(
                  onPress: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const Scaffold(
                        body: LandspaceWorkspaceHandoffHeader(),
                      ),
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
  group('LandspaceWorkspaceHandoffHeader', () {
    testWidgets('renders title and subtitle', (tester) async {
      await tester.pumpWidget(_buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Split workspace'), findsOneWidget);
      expect(
        find.text('Browse and transfer side by side'),
        findsOneWidget,
      );
      expect(find.byIcon(FLucideIcons.chevronLeft), findsOneWidget);
    });

    testWidgets('navigates back when back button tapped', (tester) async {
      var popped = false;
      final observer = _SpyNavigatorObserver(onPopped: () => popped = true);
      await tester.pumpWidget(_buildTestWidget(observer: observer));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(FLucideIcons.chevronLeft));
      await tester.pumpAndSettle();
      expect(popped, isTrue);
    });
  });
}
