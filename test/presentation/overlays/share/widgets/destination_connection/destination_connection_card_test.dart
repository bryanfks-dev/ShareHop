import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/overlays/share/models/share_integration_data.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_connection/destination_connection_card.dart';
import 'package:sharehop/presentation/theme/theme.dart';

Widget _buildTestWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    builder: (context, c) => FTheme(
      data: lightTheme,
      child: FToaster(child: c!),
    ),
    home: Scaffold(
      body: child,
    ),
  );
}

void main() {
  const destination = ShareIntegrationDestination(
    name: 'Production Server',
    protocol: ConnectionProtocol.webdav,
    destinationPath: '/remote',
  );

  group('DestinationConnectionCard', () {
    testWidgets('renders destination details and change button', (
      tester,
    ) async {
      var tapped = false;
      await tester.pumpWidget(
        _buildTestWidget(
          DestinationConnectionCard(
            destination: destination,
            onTap: () => tapped = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Production Server'), findsOneWidget);
      expect(find.text('prod.relaydock.io'), findsOneWidget);
      expect(find.byIcon(FLucideIcons.chevronDown), findsOneWidget);

      await tester.tap(find.byType(DestinationConnectionCard));
      await tester.pumpAndSettle();
      expect(tapped, isTrue);
    });
  });
}
