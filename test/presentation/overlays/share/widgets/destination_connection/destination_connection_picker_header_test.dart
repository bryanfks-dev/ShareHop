import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/overlays/share/widgets/destination_connection/destination_connection_picker_header.dart';
import 'package:sharehop/presentation/theme/theme.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: const [
        ...FLocalizations.localizationsDelegates,
      ],
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('DestinationConnectionPickerHeader', () {
    testWidgets('renders title and subtitle', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const DestinationConnectionPickerHeader()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Select Destination'), findsOneWidget);
      expect(
        find.text('Choose a connection to transfer files'),
        findsOneWidget,
      );
    });
  });
}
