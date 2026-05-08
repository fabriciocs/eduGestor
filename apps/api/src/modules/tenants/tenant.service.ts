import { AppError } from '../../core/errors/app-error.js';
import { TenantContext } from '../../core/auth/tenant-context.js';
import * as repo from './tenant.repository.js';

export async function listTenants(context: TenantContext) {
  if (!context.roles.includes('admin_saas') && !context.roles.includes('suporte')) {
    throw AppError.forbidden('Apenas suporte/admin SaaS pode listar tenants.');
  }
  return repo.listTenants();
}

export async function createTenant(context: TenantContext, input: repo.TenantCreate) {
  if (!context.roles.includes('admin_saas')) {
    throw AppError.forbidden('Apenas admin SaaS pode criar tenants.');
  }
  return repo.createTenant(input, context.userId);
}

export async function createTenantUnit(context: TenantContext, input: { tenantId: string; name: string; code: string }) {
  if (!context.roles.includes('admin_saas') && context.id !== input.tenantId) {
    throw AppError.forbidden('Tenant inválido para criação de unidade.');
  }
  return repo.createTenantUnit(input, context.userId);
}
