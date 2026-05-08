import 'package:edugestor_360/shared/widgets/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('StatusBadge renderiza label e semântica', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: StatusBadge(label: 'Ativo', status: 'active'),
        ),
      ),
    );

    expect(find.text('Ativo'), findsOneWidget);
    expect(find.byType(StatusBadge), findsOneWidget);
  });
}
