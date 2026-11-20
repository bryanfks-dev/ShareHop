import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/screens/settings/widgets/settings_header.dart';
import 'package:sharehop/presentation/screens/settings/widgets/settings_section.dart';
import 'package:sharehop/presentation/theme/theme.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: const [
        ...FLocalizations.localizationsDelegates,
      ],
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: Scaffold(body: SingleChildScrollView(child: child)),
    );
  }

  group('SettingsHeader', () {
    testWidgets('renders title and subtitle', (tester) async {
      await tester.pumpWidget(buildTestWidget(const SettingsHeader()));
      await tester.pumpAndSettle();

      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Make ShareHop work your way'), findsOneWidget);
    });
  });

  group('SettingsSection', () {
    testWidgets('renders section title and switch suffix tile', (tester) async {
      var switchVal = true;

      await tester.pumpWidget(
        buildTestWidget(
          SettingsSection(
            title: 'Test Section',
            children: [
              SettingsSectionTileWithSwitchSuffix(
                title: 'Wi-Fi only transfers',
                subtitle: 'Only transfer over Wi-Fi',
                value: switchVal,
                onChange: (v) => switchVal = v,
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Test Section'), findsOneWidget);
      expect(find.text('Wi-Fi only transfers'), findsOneWidget);
      expect(find.text('Only transfer over Wi-Fi'), findsOneWidget);

      await tester.tap(find.text('Wi-Fi only transfers'));
      await tester.pumpAndSettle();

      expect(switchVal, isFalse);
    });

    testWidgets('renders text suffix tile and handles onPress', (tester) async {
      var isTapped = false;

      await tester.pumpWidget(
        buildTestWidget(
          SettingsSection(
            title: 'Preferences',
            children: [
              SettingsSectionTileWithTextSuffix(
                title: 'Simultaneous transfers',
                suffixText: '3 transfers',
                subtitle: 'Max parallel jobs',
                onPress: () => isTapped = true,
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Simultaneous transfers'), findsOneWidget);
      expect(find.text('3 transfers'), findsOneWidget);
      expect(find.text('Max parallel jobs'), findsOneWidget);

      await tester.tap(find.text('Simultaneous transfers'));
      await tester.pumpAndSettle();

      expect(isTapped, isTrue);
    });
  });
}
