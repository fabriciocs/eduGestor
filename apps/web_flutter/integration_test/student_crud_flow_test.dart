import 'package:edugestor_360/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('abre app shell', (tester) async {
    await tester.pumpWidget(const EduGestorApp());
    await tester.pumpAndSettle();
    expect(find.text('Painel inicial'), findsOneWidget);
  });
}
