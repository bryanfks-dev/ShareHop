import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/connection_detail/widgets/storage_usage_card.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/view_models/storage_status_view_model.dart';

Widget _buildTestWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, c) => FTheme(
      data: lightTheme,
      child: c!,
    ),
    home: Scaffold(
      body: SingleChildScrollView(child: child),
    ),
  );
}

void main() {
  group('StorageUsageCard', () {
    testWidgets('renders fallback storage info when storageStatus is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const StorageUsageCard(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Remote Storage'), findsOneWidget);
      expect(find.text('436 GB used'), findsOneWidget);
      expect(find.text('64 GB'), findsOneWidget);
      expect(
        find.text('87% of 500 GB used · updated just now'),
        findsOneWidget,
      );
    });

    testWidgets('renders formatted info with given storageStatus', (
      tester,
    ) async {
      final status = StorageStatusViewModel(
        maximumCapacity: 1000 * 1024 * 1024 * 1024,
        usedCapacity: 500 * 1024 * 1024 * 1024,
      );

      await tester.pumpWidget(
        _buildTestWidget(
          StorageUsageCard(storageStatus: status),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('500 GB used'), findsOneWidget);
      expect(find.text('500 GB'), findsOneWidget);
      expect(
        find.text('50% of 1000 GB used · updated just now'),
        findsOneWidget,
      );
    });

    testWidgets('calls onRefresh when refresh button is tapped', (
      tester,
    ) async {
      var refreshed = false;
      await tester.pumpWidget(
        _buildTestWidget(
          StorageUsageCard(
            onRefresh: () => refreshed = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final refreshBtn = find.bySemanticsLabel('Refresh storage');
      expect(refreshBtn, findsOneWidget);

      await tester.tap(refreshBtn);
      await tester.pumpAndSettle();
      expect(refreshed, isTrue);
    });

    testWidgets('shows loading indicator when isLoading is true', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          StorageUsageCard(
            isLoading: true,
            onRefresh: () {},
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(FProgress), findsOneWidget);
    });
  });
}
