import 'package:flutter/material.dart';

import '../../../../shared/layout/responsive_scaffold.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: 'EduGestor 360',
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Painel inicial',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Núcleo seguro implementado: tenant, usuários, auditoria, alunos e responsáveis.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: const [
              _MetricCard(title: 'RFs mapeados', value: '134'),
              _MetricCard(title: 'Módulos', value: '20'),
              _MetricCard(title: 'Entidades', value: '98'),
              _MetricCard(title: 'Campos', value: '1.150'),
            ],
          ),
          const SizedBox(height: 24),
          const _ImplementationChecklist(),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              Text(value, style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImplementationChecklist extends StatelessWidget {
  const _ImplementationChecklist();

  @override
  Widget build(BuildContext context) {
    final items = [
      'RLS habilitada no núcleo multi-tenant',
      'Service role ausente do frontend',
      'Formulários complexos em páginas dedicadas',
      'Logs estruturados com redaction no backend',
      'Auditoria SQL para cadastros centrais',
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Checklist técnico',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            for (final item in items)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.check_circle_outline),
                title: Text(item),
              ),
          ],
        ),
      ),
    );
  }
}
