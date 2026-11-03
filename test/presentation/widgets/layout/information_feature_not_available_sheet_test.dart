import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:sharehop/presentation/theme/theme.dart';
import 'package:sharehop/presentation/widgets/layout/information_feature_not_available_sheet.dart';

void main() {
  testWidgets('showInformationFeatureNotAvailableSheet renders illustration '
      'and dismisses', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          ...FLocalizations.localizationsDelegates,
        ],
        builder: (context, child) => FTheme(
          data: lightTheme,
          child: FToaster(child: child!),
        ),
        home: Builder(
          builder: (context) {
            Future<void> handleOnPress() async {
              await showInformationFeatureNotAvailableSheet(context);
            }

            return Center(
              child: FButton(
                onPress: handleOnPress,
                child: const Text('Open Sheet'),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open Sheet'));
    await tester.pumpAndSettle();

    expect(find.text('Feature Not Available'), findsOneWidget);
    expect(
      find.text(
        'This feature is not available yet. '
        'Please ask the developer to implement it.',
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SvgPicture &&
            widget.bytesLoader is SvgAssetLoader &&
            (widget.bytesLoader as SvgAssetLoader).assetName ==
                'assets/images/feature_not_available_illustration.svg',
      ),
      findsOneWidget,
    );
    expect(find.text('OK'), findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('Feature Not Available'), findsNothing);
  });
}
