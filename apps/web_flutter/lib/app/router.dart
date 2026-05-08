import 'package:go_router/go_router.dart';
import '../features/auth/presentation/pages/auth_token_page.dart';
import '../features/catalog/presentation/pages/modules_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/entities/presentation/pages/entity_list_page.dart';
import '../features/enrollment/presentation/pages/enrollment_form_page.dart';
import '../features/enrollment/presentation/pages/enrollment_processes_page.dart';
import '../features/students/presentation/pages/student_form_page.dart';
import '../features/students/presentation/pages/students_list_page.dart';
import '../features/workflows/presentation/pages/workflows_page.dart';
final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(path: '/', name: 'dashboard', builder: (context, state) => const DashboardPage()),
  GoRoute(path: '/auth', name: 'auth-token', builder: (context, state) => const AuthTokenPage()),
  GoRoute(path: '/modulos', name: 'modules', builder: (context, state) => const ModulesPage()),
  GoRoute(path: '/modulos/:module', name: 'module-detail', builder: (context, state) => ModuleDetailPage(moduleName: Uri.decodeComponent(state.pathParameters['module'] ?? ''))),
  GoRoute(path: '/entidades/:table', name: 'entity-list', builder: (context, state) => EntityListPage(table: state.pathParameters['table'] ?? '')),
  GoRoute(path: '/fluxos', name: 'workflows', builder: (context, state) => const WorkflowsPage()),
  GoRoute(path: '/matriculas', name: 'enrollments', builder: (context, state) => const EnrollmentProcessesPage()),
  GoRoute(path: '/matriculas/novo', name: 'enrollment-new', builder: (context, state) => const EnrollmentFormPage()),
  GoRoute(path: '/alunos', name: 'students', builder: (context, state) => const StudentsListPage()),
  GoRoute(path: '/alunos/novo', name: 'student-new', builder: (context, state) => const StudentFormPage()),
  GoRoute(path: '/alunos/:id', name: 'student-edit', builder: (context, state) => StudentFormPage(studentId: state.pathParameters['id'])),
]);
