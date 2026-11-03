import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/main.dart';

void main() {
  testWidgets('Application smoke test', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: Application()));
    await tester.pumpAndSettle();
    expect(find.byType(Application), findsOneWidget);
  });
}
