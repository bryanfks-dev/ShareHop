import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/transfer_actvities/widgets/connection_filter_dropdown.dart';
import 'package:sharehop/presentation/theme/theme.dart';

Widget _buildTestWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, c) => FTheme(
      data: lightTheme,
      child: FToaster(child: c!),
    ),
    home: FScaffold(child: child),
  );
}

void main() {
  group('ConnectionFilterDropdown', () {
    testWidgets('renders filter label and default all connections value', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          ConnectionFilterDropdown(
            connections: const ['Server Alpha', 'Server Beta'],
            selectedConnection: null,
            onChangeConnection: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Filter by Connection'), findsOneWidget);
      expect(find.text('All Connections'), findsOneWidget);
    });

    testWidgets('displays selected connection when provided', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          ConnectionFilterDropdown(
            connections: const ['Server Alpha', 'Server Beta'],
            selectedConnection: 'Server Alpha',
            onChangeConnection: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Server Alpha'), findsOneWidget);
    });
  });
}
