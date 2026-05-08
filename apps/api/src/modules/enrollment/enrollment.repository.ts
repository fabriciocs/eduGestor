import { supabaseAdmin } from '../../core/supabase/server-client.js';
import { PaginationInput, toRange } from '../../core/http/pagination.js';
import { EnrollmentCreateInput, EnrollmentTransitionInput } from './enrollment.schemas.js';

interface TenantUser {
  tenantId: string;
  userId: string;
}

async function insertRow(table: string, payload: Record<string, unknown>) {
  const { data, error } = await supabaseAdmin.from(table).insert(payload).select().single();
  if (error) throw error;
  return data as Record<string, unknown>;
}

async function updateRow(table: string, tenantId: string, id: string, payload: Record<string, unknown>) {
  const { data, error } = await supabaseAdmin
    .from(table)
    .update(payload)
    .eq('tenant_id', tenantId)
    .eq('id', id)
    .is('deleted_at', null)
    .select()
    .single();

  if (error) throw error;
  return data as Record<string, unknown>;
}

export async function listEnrollmentProcesses(tenantId: string, pagination: PaginationInput) {
  const { from, to } = toRange(pagination);
  let query = supabaseAdmin
    .from('processo_matricula')
    .select('*', { count: 'exact' })
    .eq('tenant_id', tenantId)
    .is('deleted_at', null)
    .order('created_at', { ascending: false })
    .range(from, to);

  if (pagination.search) {
    query = query.or(`nome.ilike.%${pagination.search}%,codigo.ilike.%${pagination.search}%`);
  }

  const { data, error, count } = await query;
  if (error) throw error;
  return { data, count, page: pagination.page, pageSize: pagination.pageSize };
}

export async function createEnrollmentProcess(context: TenantUser, input: EnrollmentCreateInput) {
  const auditColumns = {
    tenant_id: context.tenantId,
    created_by: context.userId,
    updated_by: context.userId,
  };

  const student = input.student.id
    ? await updateRow('aluno', context.tenantId, input.student.id, {
        nome_completo: input.student.fullName,
        data_nascimento: input.student.birthDate,
        cpf: input.student.cpf ?? null,
        updated_by: context.userId,
      })
    : await insertRow('aluno', {
        ...auditColumns,
        nome_completo: input.student.fullName,
        data_nascimento: input.student.birthDate,
        cpf: input.student.cpf ?? null,
        status: 'ATIVO',
      });

  let guardian: Record<string, unknown> | null = null;
  let guardianLink: Record<string, unknown> | null = null;

  if (input.guardian) {
    guardian = input.guardian.id
      ? await updateRow('responsavel', context.tenantId, input.guardian.id, {
          nome_completo: input.guardian.fullName,
          cpf: input.guardian.cpf ?? null,
          email: input.guardian.email ?? null,
          celular: input.guardian.phone ?? null,
          updated_by: context.userId,
        })
      : await insertRow('responsavel', {
          ...auditColumns,
          nome_completo: input.guardian.fullName,
          cpf: input.guardian.cpf ?? null,
          email: input.guardian.email ?? null,
          celular: input.guardian.phone ?? null,
          status: 'ATIVO',
        });

    guardianLink = await insertRow('aluno_responsavel', {
      ...auditColumns,
      nome: input.guardian.relationship,
      descricao: 'Vínculo criado pelo fluxo de matrícula.',
      origem_id: student.id,
      destino_id: guardian.id,
      data_inicio: input.enrollment.enrollmentDate,
      status: 'ATIVO',
    });
  }

  const enrollment = await insertRow('matricula', {
    ...auditColumns,
    aluno_id: student.id,
    turma_id: input.enrollment.classId ?? null,
    ano_letivo_id: input.enrollment.schoolYearId,
    numero_matricula: input.enrollment.enrollmentNumber ?? null,
    situacao: input.enrollment.situation,
    data_matricula: input.enrollment.enrollmentDate,
    status: input.enrollment.situation === 'CANCELADO' ? 'INATIVO' : 'ATIVO',
  });

  const processCode = input.enrollment.enrollmentNumber ?? `MAT-${new Date().getFullYear()}-${String(enrollment.id).slice(0, 8)}`;
  const process = await insertRow('processo_matricula', {
    ...auditColumns,
    codigo: processCode,
    nome: `Matrícula - ${input.student.fullName}`,
    descricao: [
      `Aluno: ${input.student.fullName}`,
      input.guardian ? `Responsável: ${input.guardian.fullName}` : null,
      input.billing.generateInitialCharge ? 'Cobrança inicial solicitada.' : null,
    ].filter(Boolean).join(' | '),
    situacao_processamento: input.enrollment.situation,
    aluno_id: student.id,
    matricula_id: enrollment.id,
    responsavel_id: guardian?.id ?? null,
    status: 'ATIVO',
  });

  const contract = input.contract.generate
    ? await insertRow('contrato_educacional', {
        ...auditColumns,
        nome: input.contract.title,
        descricao: input.contract.description ?? `Contrato vinculado ao processo ${processCode}.`,
        processo_matricula_id: process.id,
        matricula_id: enrollment.id,
        aluno_id: student.id,
        status_assinatura: 'PENDENTE',
        status: 'ATIVO',
      })
    : null;

  const initialCharge = input.billing.generateInitialCharge
    ? await insertRow('parcela_cobranca', {
        ...auditColumns,
        codigo: `COB-${String(process.id).slice(0, 8)}`,
        nome: input.billing.description ?? `Cobrança inicial da matrícula ${processCode}`,
        descricao: 'Cobrança gerada automaticamente pelo fluxo de matrícula.',
        processo_matricula_id: process.id,
        matricula_id: enrollment.id,
        aluno_id: student.id,
        responsavel_id: guardian?.id ?? null,
        valor_centavos: input.billing.amountInCents ?? null,
        vencimento: input.billing.dueDate ?? null,
        situacao_pagamento: 'ABERTA',
        status: 'ATIVO',
      })
    : null;

  return {
    process,
    student,
    guardian,
    guardianLink,
    enrollment,
    contract,
    initialCharge,
    nextSteps: [
      contract ? 'coletar_assinatura_contrato' : 'avaliar_necessidade_contrato',
      input.billing.generateInitialCharge ? 'acompanhar_pagamento_inicial' : 'definir_plano_financeiro',
      'conferir_documentos_obrigatorios',
    ],
  };
}

export async function transitionEnrollmentProcess(
  context: TenantUser,
  id: string,
  input: EnrollmentTransitionInput,
) {
  const process = await updateRow('processo_matricula', context.tenantId, id, {
    situacao_processamento: input.nextSituation,
    mensagem_erro: input.reason ?? null,
    updated_by: context.userId,
  });

  if (process.matricula_id) {
    await updateRow('matricula', context.tenantId, String(process.matricula_id), {
      situacao: input.nextSituation,
      status: input.nextSituation === 'CANCELADO' ? 'INATIVO' : 'ATIVO',
      updated_by: context.userId,
    });
  }

  return {
    process,
    status: 'transicao_registrada',
    humanReviewRequired: ['CANCELADO', 'CONCLUIDO'].includes(input.nextSituation),
  };
}
