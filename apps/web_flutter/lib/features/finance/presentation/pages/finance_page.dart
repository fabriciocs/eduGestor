import 'package:flutter/material.dart';

import '../../../../../core/http/api_client.dart';
import '../../../../../shared/forms/form_section.dart';
import '../../../../../shared/layout/responsive_scaffold.dart';
import '../../data/finance_repository.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  final _repository = FinanceRepository(ApiClient());
  final _searchController = TextEditingController();

  String? _situation;
  late Future<_FinanceState> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<_FinanceState> _load() async {
    final dashboard = await _repository.dashboard();
    final charges = await _repository.listCharges(
      search: _searchController.text,
      situation: _situation,
    );
    return _FinanceState(dashboard: dashboard, charges: charges);
  }

  void _reload() {
    setState(() {
      _future = _load();
    });
  }

  String _money(dynamic cents) {
    final value = (num.tryParse(cents?.toString() ?? '0') ?? 0) / 100;
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  Future<void> _markOverdue() async {
    try {
      await _repository.markOverdue();
      _reload();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cobranças vencidas atualizadas.')),
      );
    } on Object catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao processar inadimplência: $error')),
      );
    }
  }

  Future<void> _openPaymentDialog(Map<String, dynamic> charge) async {
    final amount = TextEditingController(
      text: (charge['valor_centavos'] ?? '').toString(),
    );
    final date = TextEditingController(
      text: DateTime.now().toIso8601String().substring(0, 10),
    );
    var method = 'PIX';

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('Baixar pagamento ${charge['codigo'] ?? ''}'),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: amount,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Valor pago em centavos',
                    helperText: 'Ex.: 150000 = R\$ 1.500,00',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: date,
                  decoration: const InputDecoration(labelText: 'Data do pagamento yyyy-mm-dd'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: method,
                  decoration: const InputDecoration(labelText: 'Meio de pagamento'),
                  items: const [
                    DropdownMenuItem(value: 'PIX', child: Text('PIX')),
                    DropdownMenuItem(value: 'BOLETO', child: Text('Boleto')),
                    DropdownMenuItem(value: 'CARTAO', child: Text('Cartão')),
                    DropdownMenuItem(value: 'DINHEIRO', child: Text('Dinheiro')),
                    DropdownMenuItem(value: 'TRANSFERENCIA', child: Text('Transferência')),
                    DropdownMenuItem(value: 'OUTRO', child: Text('Outro')),
                  ],
                  onChanged: (value) => setDialogState(() => method = value ?? 'PIX'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancelar')),
            FilledButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Registrar baixa')),
          ],
        ),
      ),
    );

    if (confirmed != true) return;

    try {
      await _repository.registerPayment(
        chargeId: charge['id'].toString(),
        amountInCents: int.parse(amount.text),
        paymentDate: date.text,
        method: method,
      );
      _reload();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pagamento registrado.')),
      );
    } on Object catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao baixar pagamento: $error')),
      );
    }
  }

  Future<void> _openCreateChargeDialog() async {
    final formKey = GlobalKey<FormState>();
    final enrollmentId = TextEditingController();
    final studentId = TextEditingController();
    final guardianId = TextEditingController();
    final description = TextEditingController(text: 'Mensalidade escolar');
    final amount = TextEditingController();
    final dueDate = TextEditingController();
    final competency = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nova cobrança'),
        content: SizedBox(
          width: 560,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(controller: description, decoration: const InputDecoration(labelText: 'Descrição'), validator: _required),
                  const SizedBox(height: 12),
                  TextFormField(controller: amount, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Valor em centavos'), validator: _required),
                  const SizedBox(height: 12),
                  TextFormField(controller: dueDate, decoration: const InputDecoration(labelText: 'Vencimento yyyy-mm-dd'), validator: _required),
                  const SizedBox(height: 12),
                  TextFormField(controller: competency, decoration: const InputDecoration(labelText: 'Competência yyyy-mm opcional')),
                  const SizedBox(height: 12),
                  TextFormField(controller: enrollmentId, decoration: const InputDecoration(labelText: 'ID da matrícula opcional')),
                  const SizedBox(height: 12),
                  TextFormField(controller: studentId, decoration: const InputDecoration(labelText: 'ID do aluno opcional')),
                  const SizedBox(height: 12),
                  TextFormField(controller: guardianId, decoration: const InputDecoration(labelText: 'ID do responsável opcional')),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancelar')),
          FilledButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) Navigator.of(context).pop(true);
            },
            child: const Text('Criar cobrança'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await _repository.createCharge(
        enrollmentId: enrollmentId.text.trim(),
        studentId: studentId.text.trim(),
        guardianId: guardianId.text.trim(),
        description: description.text.trim(),
        amountInCents: int.parse(amount.text.trim()),
        dueDate: dueDate.text.trim(),
        competency: competency.text.trim(),
      );
      _reload();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cobrança criada.')),
      );
    } on Object catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao criar cobrança: $error')),
      );
    }
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) return 'Campo obrigatório.';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: 'Financeiro',
      actions: [
        TextButton.icon(
          onPressed: _markOverdue,
          icon: const Icon(Icons.warning_amber_outlined),
          label: const Text('Atualizar vencidas'),
        ),
        const SizedBox(width: 8),
        FilledButton.icon(
          onPressed: _openCreateChargeDialog,
          icon: const Icon(Icons.add_card_outlined),
          label: const Text('Nova cobrança'),
        ),
        const SizedBox(width: 12),
      ],
      child: FutureBuilder<_FinanceState>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar financeiro: ${snapshot.error}'));
          }

          final data = snapshot.data!;
          final dashboard = data.dashboard;

          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                'Controle financeiro escolar: cobranças, parcelas, baixas e inadimplência.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _MetricCard(label: 'A receber', value: _money(dashboard['balanceInCents'])),
                  _MetricCard(label: 'Recebido', value: _money(dashboard['totalPaidInCents'])),
                  _MetricCard(label: 'Em atraso', value: _money(dashboard['overdueInCents'])),
                  _MetricCard(label: 'Abertas', value: '${dashboard['openCount'] ?? 0}'),
                  _MetricCard(label: 'Pagas', value: '${dashboard['paidCount'] ?? 0}'),
                ],
              ),
              const SizedBox(height: 24),
              FormSection(
                title: 'Cobranças',
                description: 'Filtre por texto e situação. A baixa financeira preserva histórico de pagamento.',
                children: [
                  Column(
                    children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(labelText: 'Buscar por código ou descrição'),
                            onSubmitted: (_) => _reload(),
                          ),
                        ),
                        const SizedBox(width: 12),
                        DropdownButton<String?>(
                          value: _situation,
                          hint: const Text('Situação'),
                          items: const [
                            DropdownMenuItem(value: null, child: Text('Todas')),
                            DropdownMenuItem(value: 'ABERTA', child: Text('Aberta')),
                            DropdownMenuItem(value: 'PAGA', child: Text('Paga')),
                            DropdownMenuItem(value: 'ATRASADA', child: Text('Atrasada')),
                            DropdownMenuItem(value: 'CANCELADA', child: Text('Cancelada')),
                          ],
                          onChanged: (value) {
                            setState(() => _situation = value);
                            _reload();
                          },
                        ),
                        const SizedBox(width: 12),
                        IconButton(onPressed: _reload, icon: const Icon(Icons.search)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    for (final charge in data.charges)
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.receipt_long_outlined),
                          title: Text(charge['nome']?.toString() ?? charge['codigo']?.toString() ?? 'Cobrança'),
                          subtitle: Text(
                            'Vencimento: ${charge['vencimento'] ?? charge['data_vencimento'] ?? '-'} • '
                            'Situação: ${charge['situacao_pagamento'] ?? charge['situacao'] ?? '-'} • '
                            'Valor: ${_money(charge['valor_centavos'])}',
                          ),
                          trailing: Wrap(
                            spacing: 8,
                            children: [
                              TextButton(
                                onPressed: () => _openPaymentDialog(charge),
                                child: const Text('Baixar'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (data.charges.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(24),
                        child: Text('Nenhuma cobrança encontrada.'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              Text(value, style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        ),
      ),
    );
  }
}

class _FinanceState {
  const _FinanceState({
    required this.dashboard,
    required this.charges,
  });

  final Map<String, dynamic> dashboard;
  final List<Map<String, dynamic>> charges;
}
