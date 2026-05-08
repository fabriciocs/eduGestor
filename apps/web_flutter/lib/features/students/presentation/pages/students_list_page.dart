import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/http/api_client.dart';
import '../../data/student_model.dart';
import '../../data/student_repository.dart';
import '../../../../../shared/layout/responsive_scaffold.dart';
import '../../../../../shared/widgets/status_badge.dart';

class StudentsListPage extends StatefulWidget {
  const StudentsListPage({super.key});

  @override
  State<StudentsListPage> createState() => _StudentsListPageState();
}

class _StudentsListPageState extends State<StudentsListPage> {
  final _searchController = TextEditingController();
  late final StudentRepository _repository;
  late Future<List<Student>> _studentsFuture;

  @override
  void initState() {
    super.initState();
    _repository = StudentRepository(ApiClient());
    _studentsFuture = _repository.listStudents();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search() {
    setState(() {
      _studentsFuture =
          _repository.listStudents(search: _searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: 'Alunos',
      actions: [
        FilledButton.icon(
          onPressed: () => context.go('/alunos/novo'),
          icon: const Icon(Icons.add),
          label: const Text('Novo aluno'),
        ),
        const SizedBox(width: 12),
      ],
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Cadastro central de alunos',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text(
              'CRUD inicial com isolamento por tenant, soft delete e auditoria.'),
          const SizedBox(height: 20),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Buscar aluno',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: _search,
                icon: const Icon(Icons.arrow_forward),
              ),
            ),
            onSubmitted: (_) => _search(),
          ),
          const SizedBox(height: 20),
          FutureBuilder<List<Student>>(
            future: _studentsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const _StudentsSkeleton();
              }

              if (snapshot.hasError) {
                return _ErrorState(message: snapshot.error.toString());
              }

              final students = snapshot.data ?? [];
              if (students.isEmpty) {
                return const _EmptyState();
              }

              return Card(
                child: Column(
                  children: [
                    for (final student in students)
                      ListTile(
                        leading: CircleAvatar(
                          child: Text(student.fullName.characters.first),
                        ),
                        title: Text(student.fullName),
                        subtitle: Text('Nascimento: ${student.birthDate}'),
                        trailing: StatusBadge(
                          label:
                              student.status == 'active' ? 'Ativo' : 'Inativo',
                          status: student.status,
                        ),
                        onTap: () => context.go('/alunos/${student.id}'),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StudentsSkeleton extends StatelessWidget {
  const _StudentsSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Icon(Icons.school_outlined, size: 48),
            const SizedBox(height: 12),
            Text('Nenhum aluno encontrado',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            const Text('Cadastre o primeiro aluno em uma página dedicada.'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.go('/alunos/novo'),
              child: const Text('Cadastrar aluno'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text('Não foi possível carregar alunos: $message'),
      ),
    );
  }
}
