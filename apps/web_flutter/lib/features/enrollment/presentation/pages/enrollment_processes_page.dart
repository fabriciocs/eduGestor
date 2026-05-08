import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/http/api_client.dart';
import '../../../../../shared/layout/responsive_scaffold.dart';
import '../../data/enrollment_repository.dart';

class EnrollmentProcessesPage extends StatefulWidget {
  const EnrollmentProcessesPage({super.key});

  @override
  State<EnrollmentProcessesPage> createState() => _EnrollmentProcessesPageState();
}

class _EnrollmentProcessesPageState extends State<EnrollmentProcessesPage> {
  final _repository = EnrollmentRepository(ApiClient());
  final _searchController = TextEditingController();
  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _future = _repository.listProcesses();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _reload() {
    setState(() {
      _future = _repository.listProcesses(search: _searchController.text);
    });
  }

  Future<void> _transition(Map<String, dynamic> row, String nextSituation) async {
    try {
      await _repository.transitionProcess(
        id: row['id'].toString(),
        nextSituation: nextSituation,
        reason: 'Transição registrada pela interface web.',
      );
      _reload();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Processo atualizado para $nextSituation.')),
      );
    } on Object catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: 'Matrículas e rematrículas',
      actions: [
        FilledButton.icon(
          onPressed: () => context.go('/matriculas/novo'),
          icon: const Icon(Icons.person_add_alt_1_outlined),
          label: const Text('Novo processo'),
        ),
        const SizedBox(width: 12),
      ],
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Fluxo completo de secretaria: aluno, responsável, matrícula, contrato e cobrança inicial.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Buscar por aluno, código ou processo',
              suffixIcon: IconButton(
                onPressed: _reload,
                icon: const Icon(Icons.search),
              ),
            ),
            onSubmitted: (_) => _reload(),
          ),
          const SizedBox(height: 16),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (snapshot.hasError) {
                return _StateCard(
                  icon: Icons.lock_outline,
                  title: 'Não foi possível carregar matrículas',
                  message: 'Verifique autenticação, backend e RLS. Erro: ${snapshot.error}',
                );
              }

              final rows = snapshot.data ?? const [];
              if (rows.isEmpty) {
                return const _StateCard(
                  icon: Icons.assignment_ind_outlined,
                  title: 'Nenhum processo encontrado',
                  message: 'Crie uma matrícula para iniciar o acompanhamento operacional.',
                );
              }

              return Card(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Código')),
                      DataColumn(label: Text('Processo')),
                      DataColumn(label: Text('Situação')),
                      DataColumn(label: Text('Criado em')),
                      DataColumn(label: Text('Ações')),
                    ],
                    rows: [
                      for (final row in rows)
                        DataRow(
                          cells: [
                            DataCell(Text(row['codigo']?.toString() ?? '-')),
                            DataCell(Text(row['nome']?.toString() ?? '-')),
                            DataCell(Chip(label: Text(row['situacao_processamento']?.toString() ?? 'PENDENTE'))),
                            DataCell(Text(row['created_at']?.toString() ?? '-')),
                            DataCell(
                              Wrap(
                                spacing: 8,
                                children: [
                                  TextButton(
                                    onPressed: () => _transition(row, 'MATRICULADO'),
                                    child: const Text('Confirmar'),
                                  ),
                                  TextButton(
                                    onPressed: () => _transition(row, 'AGUARDANDO_DOCUMENTOS'),
                                    child: const Text('Docs'),
                                  ),
                                  TextButton(
                                    onPressed: () => _transition(row, 'CANCELADO'),
                                    child: const Text('Cancelar'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StateCard extends StatelessWidget {
  const _StateCard({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(icon, size: 48),
            const SizedBox(height: 12),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(message, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
