import { AuthRole, TenantContext, hasAnyRole } from '../../core/auth/tenant-context.js';
import { AppError } from '../../core/errors/app-error.js';
import {
  BillingPlanInput,
  ChargeCancelInput,
  ChargeCreateInput,
  FinanceListInput,
  PaymentCreateInput,
} from './finance.schemas.js';
import * as repository from './finance.repository.js';

const financeReadRoles: AuthRole[] = ['admin_saas', 'mantenedor', 'direcao', 'financeiro', 'secretaria', 'suporte'];
const financeWriteRoles: AuthRole[] = ['admin_saas', 'mantenedor', 'direcao', 'financeiro', 'suporte'];

function requireAnyRole(context: TenantContext, roles: AuthRole[]) {
  if (!hasAnyRole(context, roles)) {
    throw AppError.forbidden('Perfil sem permissão para operar financeiro.');
  }
}

export async function listCharges(context: TenantContext, input: FinanceListInput) {
  requireAnyRole(context, financeReadRoles);
  return repository.listCharges(context.id, input);
}

export async function getFinancialDashboard(context: TenantContext) {
  requireAnyRole(context, financeReadRoles);
  return repository.getFinancialDashboard(context.id);
}

export async function createCharge(context: TenantContext, input: ChargeCreateInput) {
  requireAnyRole(context, financeWriteRoles);
  if (!input.enrollmentId && !input.studentId && !input.guardianId) {
    throw AppError.validation('Informe ao menos matrícula, aluno ou responsável para vincular a cobrança.');
  }
  return repository.createCharge({ tenantId: context.id, userId: context.userId }, input);
}

export async function createBillingPlan(context: TenantContext, input: BillingPlanInput) {
  requireAnyRole(context, financeWriteRoles);
  return repository.createBillingPlan({ tenantId: context.id, userId: context.userId }, input);
}

export async function registerPayment(context: TenantContext, input: PaymentCreateInput) {
  requireAnyRole(context, financeWriteRoles);
  return repository.registerPayment({ tenantId: context.id, userId: context.userId }, input);
}

export async function cancelCharge(context: TenantContext, id: string, input: ChargeCancelInput) {
  requireAnyRole(context, financeWriteRoles);
  return repository.cancelCharge({ tenantId: context.id, userId: context.userId }, id, input);
}

export async function markOverdue(context: TenantContext) {
  requireAnyRole(context, financeWriteRoles);
  return repository.markOverdue({ tenantId: context.id, userId: context.userId });
}
