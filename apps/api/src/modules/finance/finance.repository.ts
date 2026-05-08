import { supabaseAdmin } from '../../core/supabase/server-client.js';
import { toRange } from '../../core/http/pagination.js';
import {
  BillingPlanInput,
  ChargeCancelInput,
  ChargeCreateInput,
  FinanceListInput,
  PaymentCreateInput,
} from './finance.schemas.js';

interface TenantUser {
  tenantId: string;
  userId: string;
}

function centsToDecimal(amountInCents: number) {
  return Number((amountInCents / 100).toFixed(2));
}

function addMonths(dateText: string, months: number) {
  const [year, month, day] = dateText.split('-').map(Number);
  const date = new Date(Date.UTC(year, month - 1 + months, day));
  return date.toISOString().slice(0, 10);
}

async function insertRow(table: string, payload: Record<string, unknown>) {
  const { data, error } = await supabaseAdmin.from(table).insert(payload).select().single();
  if (error) throw error;
  return data as Record<string, unknown>;
}

async function updateCharge(tenantId: string, id: string, payload: Record<string, unknown>) {
  const { data, error } = await supabaseAdmin
    .from('parcela_cobranca')
    .update(payload)
    .eq('tenant_id', tenantId)
    .eq('id', id)
    .is('deleted_at', null)
    .select()
    .single();

  if (error) throw error;
  return data as Record<string, unknown>;
}

export async function listCharges(tenantId: string, input: FinanceListInput) {
  const { from, to } = toRange(input);

  let query = supabaseAdmin
    .from('parcela_cobranca')
    .select('*', { count: 'exact' })
    .eq('tenant_id', tenantId)
    .is('deleted_at', null)
    .order('vencimento', { ascending: true })
    .range(from, to);

  if (input.situation) query = query.eq('situacao_pagamento', input.situation);
  if (input.dueFrom) query = query.gte('vencimento', input.dueFrom);
  if (input.dueTo) query = query.lte('vencimento', input.dueTo);
  if (input.search) query = query.or(`nome.ilike.%${input.search}%,codigo.ilike.%${input.search}%`);

  const { data, error, count } = await query;
  if (error) throw error;
  return { data, count, page: input.page, pageSize: input.pageSize };
}

export async function getFinancialDashboard(tenantId: string) {
  const { data, error } = await supabaseAdmin
    .from('parcela_cobranca')
    .select('id, valor_centavos, valor_pago_centavos, vencimento, situacao_pagamento')
    .eq('tenant_id', tenantId)
    .is('deleted_at', null);

  if (error) throw error;

  const today = new Date().toISOString().slice(0, 10);
  const rows = data ?? [];

  const totals = rows.reduce(
    (acc, row) => {
      const amount = Number(row.valor_centavos ?? 0);
      const paid = Number(row.valor_pago_centavos ?? 0);
      const situation = String(row.situacao_pagamento ?? 'ABERTA');

      acc.totalReceivableInCents += amount;
      acc.totalPaidInCents += paid;

      if (situation === 'PAGA') acc.paidCount += 1;
      if (situation === 'ABERTA') acc.openCount += 1;
      if (situation === 'ATRASADA' || (situation === 'ABERTA' && row.vencimento && String(row.vencimento) < today)) {
        acc.overdueCount += 1;
        acc.overdueInCents += Math.max(amount - paid, 0);
      }

      return acc;
    },
    {
      totalReceivableInCents: 0,
      totalPaidInCents: 0,
      overdueInCents: 0,
      openCount: 0,
      paidCount: 0,
      overdueCount: 0,
    },
  );

  return {
    ...totals,
    balanceInCents: Math.max(totals.totalReceivableInCents - totals.totalPaidInCents, 0),
    generatedAt: new Date().toISOString(),
  };
}

export async function createCharge(context: TenantUser, input: ChargeCreateInput) {
  const row = await insertRow('parcela_cobranca', {
    tenant_id: context.tenantId,
    created_by: context.userId,
    updated_by: context.userId,
    codigo: input.externalReference ?? `FIN-${Date.now()}`,
    nome: input.description,
    descricao: input.description,
    matricula_id: input.enrollmentId ?? null,
    aluno_id: input.studentId ?? null,
    responsavel_id: input.guardianId ?? null,
    valor_centavos: input.amountInCents,
    valor_original: centsToDecimal(input.amountInCents),
    valor_pago_centavos: 0,
    vencimento: input.dueDate,
    data_vencimento: input.dueDate,
    competencia: input.competency ?? null,
    situacao_pagamento: 'ABERTA',
    situacao: 'ABERTA',
    status: 'ATIVO',
  });

  return { data: row };
}

export async function createBillingPlan(context: TenantUser, input: BillingPlanInput) {
  const created = [];

  for (let index = 0; index < input.installments; index += 1) {
    const dueDate = addMonths(input.firstDueDate, index);
    const installmentNumber = index + 1;
    const code = `FIN-${String(input.enrollmentId).slice(0, 8)}-${String(installmentNumber).padStart(2, '0')}`;

    created.push(await insertRow('parcela_cobranca', {
      tenant_id: context.tenantId,
      created_by: context.userId,
      updated_by: context.userId,
      codigo: code,
      nome: `${input.description} ${installmentNumber}/${input.installments}`,
      descricao: `Parcela ${installmentNumber} de ${input.installments} gerada pelo plano financeiro.`,
      matricula_id: input.enrollmentId,
      aluno_id: input.studentId ?? null,
      responsavel_id: input.guardianId ?? null,
      valor_centavos: input.amountInCents,
      valor_original: centsToDecimal(input.amountInCents),
      valor_pago_centavos: 0,
      vencimento: dueDate,
      data_vencimento: dueDate,
      competencia: input.competencyPrefix ? `${input.competencyPrefix}-${String(installmentNumber).padStart(2, '0')}` : null,
      situacao_pagamento: 'ABERTA',
      situacao: 'ABERTA',
      status: 'ATIVO',
    }));
  }

  return { data: created, count: created.length };
}

export async function registerPayment(context: TenantUser, input: PaymentCreateInput) {
  const { data: charge, error: chargeError } = await supabaseAdmin
    .from('parcela_cobranca')
    .select('*')
    .eq('tenant_id', context.tenantId)
    .eq('id', input.chargeId)
    .is('deleted_at', null)
    .single();

  if (chargeError) throw chargeError;

  const previousPaid = Number(charge.valor_pago_centavos ?? 0);
  const original = Number(charge.valor_centavos ?? 0);
  const nextPaid = previousPaid + input.amountInCents;
  const nextSituation = nextPaid >= original ? 'PAGA' : 'ABERTA';

  const payment = await insertRow('pagamento', {
    tenant_id: context.tenantId,
    created_by: context.userId,
    updated_by: context.userId,
    conta_receber_id: input.chargeId,
    parcela_cobranca_id: input.chargeId,
    valor_pago: centsToDecimal(input.amountInCents),
    valor_pago_centavos: input.amountInCents,
    data_pagamento: input.paymentDate,
    meio_pagamento: input.method,
    referencia_externa: input.externalReference ?? null,
    observacoes: input.notes ?? null,
    status: 'ATIVO',
  });

  const updatedCharge = await updateCharge(context.tenantId, input.chargeId, {
    valor_pago_centavos: nextPaid,
    situacao_pagamento: nextSituation,
    situacao: nextSituation,
    data_ultimo_pagamento: input.paymentDate,
    updated_by: context.userId,
  });

  return {
    payment,
    charge: updatedCharge,
    status: nextSituation === 'PAGA' ? 'quitada' : 'baixa_parcial',
    remainingInCents: Math.max(original - nextPaid, 0),
  };
}

export async function cancelCharge(context: TenantUser, id: string, input: ChargeCancelInput) {
  const updatedCharge = await updateCharge(context.tenantId, id, {
    situacao_pagamento: 'CANCELADA',
    situacao: 'CANCELADA',
    motivo_cancelamento: input.reason,
    updated_by: context.userId,
  });

  return { data: updatedCharge };
}

export async function markOverdue(context: TenantUser) {
  const today = new Date().toISOString().slice(0, 10);

  const { data, error } = await supabaseAdmin
    .from('parcela_cobranca')
    .update({
      situacao_pagamento: 'ATRASADA',
      situacao: 'ATRASADA',
      updated_by: context.userId,
    })
    .eq('tenant_id', context.tenantId)
    .eq('situacao_pagamento', 'ABERTA')
    .lt('vencimento', today)
    .is('deleted_at', null)
    .select();

  if (error) throw error;

  return {
    data: data ?? [],
    count: data?.length ?? 0,
    processedAt: new Date().toISOString(),
  };
}
