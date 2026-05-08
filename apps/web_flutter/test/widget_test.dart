import 'package:edugestor_360/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app inicializa shell principal', (tester) async {
    await tester.pumpWidget(const EduGestorApp());
    await tester.pump();

    expect(find.text('Dashboard'), findsWidgets);
  });
}
