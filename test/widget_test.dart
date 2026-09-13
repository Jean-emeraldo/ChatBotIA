import 'package:flutter_test/flutter_test.dart';
import 'package:bolo_ai/main.dart';

void main() {
  testWidgets('MyApp displays the dashboard title', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Dashboard Entreprise'), findsWidgets);
    expect(find.text('Goly - Assistant IA'), findsOneWidget);
  });
}
