import 'package:edugestor_360/features/students/presentation/pages/student_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('formulÃ¡rio de aluno exige campos obrigatÃ³rios', (tester) async {
    final router = GoRouter(
      initialLocation: '/alunos/novo',
      routes: [
        GoRoute(
          path: '/alunos/novo',
          builder: (context, state) => const StudentFormPage(),
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    final formState = tester.state<FormState>(find.byType(Form));
    expect(formState.validate(), isFalse);
    await tester.pump();

    expect(find.text('Informe o nome completo.'), findsOneWidget);
    expect(find.text('Use o formato yyyy-mm-dd.'), findsOneWidget);
  });
}
