import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/layout/responsive_scaffold.dart';

class WorkflowsPage extends StatelessWidget {
  const WorkflowsPage({super.key});

  static const workflows = [
    _Workflow(
      title: 'Matrícula e rematrícula',
      description: 'Aluno, responsável, vínculo acadêmico, contrato e cobrança inicial.',
      path: '/matriculas',
      implemented: true,
    ),
    _Workflow(
      title: 'Financeiro',
      description: 'Planos, parcelas, boletos, pagamentos, baixas e inadimplência.',
      path: '/financeiro',
      implemented: true,
    ),
    _Workflow(
      title: 'Frequência',
      description: 'Chamada por aula, frequência por aluno e justificativas.',
      path: '/entidades/frequencia_aluno',
    ),
    _Workflow(
      title: 'Avaliações',
      description: 'Instrumentos, notas, fórmula, boletim e histórico.',
      path: '/entidades/nota_aluno',
    ),
    _Workflow(
      title: 'Comunicação',
      description: 'Comunicados, conversas, leitura e preferências.',
      path: '/entidades/comunicado',
    ),
    _Workflow(
      title: 'LGPD',
      description: 'Consentimentos, inventário, exportação e solicitação de titular.',
      path: '/entidades/solicitacao_titular_lgpd',
    ),
    _Workflow(
      title: 'Implantação',
      description: 'Importação, validação, erros e tarefas de onboarding.',
      path: '/entidades/importacao_dados',
    ),
    _Workflow(
      title: 'IA assistiva',
      description: 'Alertas explicáveis, revisáveis e não decisórios.',
      path: '/entidades/alerta_assistivo_ia',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: 'Fluxos operacionais',
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Funcionalidades implementadas uma por vez',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text(
            'Matrícula e rematrícula agora possui fluxo específico backend/frontend. Os demais fluxos seguem disponíveis por CRUD catalogado até receberem incremento dedicado.',
          ),
          const SizedBox(height: 24),
          for (final workflow in workflows)
            Card(
              child: ListTile(
                leading: Icon(workflow.implemented ? Icons.check_circle_outline : Icons.construction_outlined),
                title: Text(workflow.title),
                subtitle: Text(workflow.description),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.go(workflow.path),
              ),
            ),
        ],
      ),
    );
  }
}

class _Workflow {
  const _Workflow({
    required this.title,
    required this.description,
    required this.path,
    this.implemented = false,
  });

  final String title;
  final String description;
  final String path;
  final bool implemented;
}
