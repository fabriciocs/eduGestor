import { TenantContext } from '../../core/auth/tenant-context.js';
import { AppError } from '../../core/errors/app-error.js';
import { PaginationInput } from '../../core/http/pagination.js';
import * as repo from './guardian.repository.js';

const writeRoles = ['admin_saas', 'direcao', 'secretaria', 'coordenacao'];

export async function listGuardians(
  context: TenantContext,
  pagination: PaginationInput,
) {
  return repo.listGuardians(context.id, pagination);
}

export async function createGuardian(
  context: TenantContext,
  input: repo.GuardianCreateInput,
) {
  if (!context.roles.some((role) => writeRoles.includes(role))) {
    throw AppError.forbidden(
      'Perfil sem permissão para cadastrar responsáveis.',
    );
  }
  return repo.createGuardian(context.id, input, context.userId);
}

export async function linkGuardian(
  context: TenantContext,
  input: {
    studentId: string;
    guardianId: string;
    relationship: string;
    isFinancialResponsible: boolean;
    isPedagogicalResponsible: boolean;
  },
) {
  if (!context.roles.some((role) => writeRoles.includes(role))) {
    throw AppError.forbidden(
      'Perfil sem permissão para vincular responsáveis.',
    );
  }
  return repo.linkGuardian({
    ...input,
    tenantId: context.id,
    userId: context.userId,
  });
}
