import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/http/api_client.dart';
import '../../../../../shared/forms/form_section.dart';
import '../../../../../shared/layout/responsive_scaffold.dart';
import '../../data/enrollment_repository.dart';

class EnrollmentFormPage extends StatefulWidget {
  const EnrollmentFormPage({super.key});

  @override
  State<EnrollmentFormPage> createState() => _EnrollmentFormPageState();
}

class _EnrollmentFormPageState extends State<EnrollmentFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _repository = EnrollmentRepository(ApiClient());

  final _studentName = TextEditingController();
  final _studentBirthDate = TextEditingController();
  final _studentCpf = TextEditingController();
  final _guardianName = TextEditingController();
  final _guardianCpf = TextEditingController();
  final _guardianEmail = TextEditingController();
  final _guardianPhone = TextEditingController();
  final _schoolYearId = TextEditingController();
  final _classId = TextEditingController();
  final _enrollmentNumber = TextEditingController();
  final _enrollmentDate = TextEditingController();
  final _amount = TextEditingController();
  final _dueDate = TextEditingController();

  bool _generateContract = true;
  bool _generateInitialCharge = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _enrollmentDate.text = DateTime.now().toIso8601String().substring(0, 10);
  }

  @override
  void dispose() {
    for (final controller in [
      _studentName,
      _studentBirthDate,
      _studentCpf,
      _guardianName,
      _guardianCpf,
      _guardianEmail,
      _guardianPhone,
      _schoolYearId,
      _classId,
      _enrollmentNumber,
      _enrollmentDate,
      _amount,
      _dueDate,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  String? _requiredText(String? value, String label) {
    if (value == null || value.trim().isEmpty) return 'Informe $label.';
    return null;
  }

  String? _dateValidator(String? value, String label) {
    final text = value?.trim() ?? '';
    if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(text)) {
      return '$label deve usar yyyy-mm-dd.';
    }
    return null;
  }

  String? _uuidValidator(String? value, String label) {
    final text = value?.trim() ?? '';
    if (!RegExp(r'^[0-9a-fA-F-]{36}$').hasMatch(text)) {
      return '$label deve ser um UUID válido.';
    }
    return null;
  }

  int? _amountInCents() {
    final text = _amount.text.trim().replaceAll('.', '').replaceAll(',', '.');
    if (text.isEmpty) return null;
    final parsed = double.tryParse(text);
    if (parsed == null) return null;
    return (parsed * 100).round();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_generateInitialCharge && (_amountInCents() == null || _dueDate.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe valor e vencimento para gerar cobrança inicial.')),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      await _repository.createProcess(
        studentName: _studentName.text.trim(),
        birthDate: _studentBirthDate.text.trim(),
        studentCpf: _studentCpf.text.trim(),
        guardianName: _guardianName.text.trim(),
        guardianCpf: _guardianCpf.text.trim(),
        guardianEmail: _guardianEmail.text.trim(),
        guardianPhone: _guardianPhone.text.trim(),
        schoolYearId: _schoolYearId.text.trim(),
        classId: _classId.text.trim(),
        enrollmentNumber: _enrollmentNumber.text.trim(),
        enrollmentDate: _enrollmentDate.text.trim(),
        generateContract: _generateContract,
        generateInitialCharge: _generateInitialCharge,
        amountInCents: _amountInCents(),
        dueDate: _dueDate.text.trim(),
      );

      if (!mounted) return;
      context.go('/matriculas');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processo de matrícula criado.')),
      );
    } on Object catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao criar matrícula: $error')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: 'Novo processo de matrícula',
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            FormSection(
              title: 'Aluno',
              description: 'Dados mínimos necessários para abrir o processo. Evite coletar dados sensíveis sem finalidade.',
              children: [
                TextFormField(
                  controller: _studentName,
                  decoration: const InputDecoration(labelText: 'Nome completo do aluno'),
                  validator: (value) => _requiredText(value, 'o nome do aluno'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _studentBirthDate,
                  decoration: const InputDecoration(labelText: 'Data de nascimento', helperText: 'yyyy-mm-dd'),
                  validator: (value) => _dateValidator(value, 'Data de nascimento'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _studentCpf,
                  decoration: const InputDecoration(labelText: 'CPF do aluno', helperText: 'Opcional, somente números'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FormSection(
              title: 'Responsável',
              description: 'Responsável financeiro ou legal vinculado ao aluno.',
              children: [
                TextFormField(
                  controller: _guardianName,
                  decoration: const InputDecoration(labelText: 'Nome do responsável'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _guardianEmail,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _guardianPhone,
                  decoration: const InputDecoration(labelText: 'Celular'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _guardianCpf,
                  decoration: const InputDecoration(labelText: 'CPF do responsável', helperText: 'Opcional, somente números'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FormSection(
              title: 'Matrícula',
              description: 'Vinculação acadêmica inicial. O ano letivo é obrigatório para manter rastreabilidade.',
              children: [
                TextFormField(
                  controller: _schoolYearId,
                  decoration: const InputDecoration(labelText: 'ID do ano letivo', helperText: 'UUID cadastrado em ano_letivo'),
                  validator: (value) => _uuidValidator(value, 'Ano letivo'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _classId,
                  decoration: const InputDecoration(labelText: 'ID da turma', helperText: 'Opcional'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _enrollmentNumber,
                  decoration: const InputDecoration(labelText: 'Número de matrícula', helperText: 'Opcional'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _enrollmentDate,
                  decoration: const InputDecoration(labelText: 'Data da matrícula', helperText: 'yyyy-mm-dd'),
                  validator: (value) => _dateValidator(value, 'Data da matrícula'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FormSection(
              title: 'Contrato e cobrança inicial',
              description: 'Geração operacional. Integrações bancárias e assinatura digital real exigem credenciais homologadas.',
              children: [
                SwitchListTile(
                  value: _generateContract,
                  onChanged: (value) => setState(() => _generateContract = value),
                  title: const Text('Gerar contrato educacional pendente de assinatura'),
                ),
                SwitchListTile(
                  value: _generateInitialCharge,
                  onChanged: (value) => setState(() => _generateInitialCharge = value),
                  title: const Text('Gerar cobrança inicial'),
                ),
                if (_generateInitialCharge) ...[
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _amount,
                    decoration: const InputDecoration(labelText: 'Valor', helperText: 'Ex.: 1200,00'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _dueDate,
                    decoration: const InputDecoration(labelText: 'Vencimento', helperText: 'yyyy-mm-dd'),
                    validator: (value) => _generateInitialCharge ? _dateValidator(value, 'Vencimento') : null,
                  ),
                ],
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                OutlinedButton(
                  onPressed: _saving ? null : () => context.go('/matriculas'),
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: _saving ? null : _submit,
                  icon: _saving
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.save_outlined),
                  label: Text(_saving ? 'Salvando...' : 'Criar matrícula'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
