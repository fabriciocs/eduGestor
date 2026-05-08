import { AuthRole, TenantContext, hasAnyRole } from '../../core/auth/tenant-context.js';
import { AppError } from '../../core/errors/app-error.js';
import { PaginationInput } from '../../core/http/pagination.js';
import {
  EnrollmentCreateInput,
  EnrollmentTransitionInput,
} from './enrollment.schemas.js';
import * as repository from './enrollment.repository.js';

const enrollmentReadRoles: AuthRole[] = ['admin_saas', 'mantenedor', 'direcao', 'secretaria', 'financeiro', 'coordenacao', 'suporte'];
const enrollmentWriteRoles: AuthRole[] = ['admin_saas', 'mantenedor', 'direcao', 'secretaria', 'suporte'];

function requireAnyRole(context: TenantContext, roles: AuthRole[]) {
  if (!hasAnyRole(context, roles)) {
    throw AppError.forbidden('Perfil sem permissão para operar matrícula.');
  }
}

export async function listEnrollmentProcesses(context: TenantContext, pagination: PaginationInput) {
  requireAnyRole(context, enrollmentReadRoles);
  return repository.listEnrollmentProcesses(context.id, pagination);
}

export async function createEnrollmentProcess(context: TenantContext, input: EnrollmentCreateInput) {
  requireAnyRole(context, enrollmentWriteRoles);

  if (input.billing.generateInitialCharge && (!input.billing.amountInCents || !input.billing.dueDate)) {
    throw AppError.validation('Para gerar cobrança inicial, informe valor e vencimento.');
  }

  return repository.createEnrollmentProcess(
    { tenantId: context.id, userId: context.userId },
    input,
  );
}

export async function transitionEnrollmentProcess(
  context: TenantContext,
  id: string,
  input: EnrollmentTransitionInput,
) {
  requireAnyRole(context, enrollmentWriteRoles);
  return repository.transitionEnrollmentProcess(
    { tenantId: context.id, userId: context.userId },
    id,
    input,
  );
}
