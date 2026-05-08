import 'package:edugestor_360/features/students/presentation/pages/student_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('formulário de aluno exige campos obrigatórios', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: StudentFormPage()));

    await tester.tap(find.text('Criar aluno'));
    await tester.pump();

    expect(find.text('Informe o nome completo.'), findsOneWidget);
    expect(find.text('Use o formato yyyy-mm-dd.'), findsOneWidget);
  });
}
