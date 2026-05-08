import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/http/api_client.dart';
import '../../data/student_repository.dart';
import '../../../../../shared/forms/form_section.dart';
import '../../../../../shared/layout/responsive_scaffold.dart';

class StudentFormPage extends StatefulWidget {
  const StudentFormPage({this.studentId, super.key});

  final String? studentId;

  @override
  State<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _documentController = TextEditingController();
  late final StudentRepository _repository;
  bool _isSaving = false;

  bool get isEditing => widget.studentId != null;

  @override
  void initState() {
    super.initState();
    _repository = StudentRepository(ApiClient());
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _birthDateController.dispose();
    _documentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    try {
      if (isEditing) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Edição será conectada na próxima fatia.')),
        );
      } else {
        await _repository.createStudent(
          fullName: _fullNameController.text.trim(),
          birthDate: _birthDateController.text.trim(),
          documentNumber: _documentController.text.trim(),
        );
        if (mounted) context.go('/alunos');
      }
    } on Object catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar: $error')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: isEditing ? 'Editar aluno' : 'Novo aluno',
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            FormSection(
              title: 'Dados do aluno',
              description: 'Formulário em página dedicada, conforme diretriz UX.',
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(labelText: 'Nome completo'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().length < 2) {
                      return 'Informe o nome completo.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _birthDateController,
                  decoration: const InputDecoration(
                    labelText: 'Data de nascimento',
                    helperText: 'Formato: yyyy-mm-dd',
                  ),
                  validator: (value) {
                    final text = value?.trim() ?? '';
                    final valid = RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(text);
                    if (!valid) return 'Use o formato yyyy-mm-dd.';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _documentController,
                  decoration: const InputDecoration(
                    labelText: 'Documento',
                    helperText: 'Opcional. Evite dados desnecessários.',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                OutlinedButton(
                  onPressed: _isSaving ? null : () => context.go('/alunos'),
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: _isSaving ? null : _submit,
                  icon: _isSaving
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save_outlined),
                  label: Text(isEditing ? 'Salvar alterações' : 'Criar aluno'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
