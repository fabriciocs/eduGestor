import 'package:go_router/go_router.dart';

import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/students/presentation/pages/student_form_page.dart';
import '../features/students/presentation/pages/students_list_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'dashboard',
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: '/alunos',
      name: 'students',
      builder: (context, state) => const StudentsListPage(),
    ),
    GoRoute(
      path: '/alunos/novo',
      name: 'student-new',
      builder: (context, state) => const StudentFormPage(),
    ),
    GoRoute(
      path: '/alunos/:id',
      name: 'student-edit',
      builder: (context, state) => StudentFormPage(
        studentId: state.pathParameters['id'],
      ),
    ),
  ],
);
