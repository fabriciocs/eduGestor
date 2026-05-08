import { TenantContext } from '../../core/auth/tenant-context.js';
import { AppError } from '../../core/errors/app-error.js';
import * as repo from './user.repository.js';

const allowedAdminRoles = ['admin_saas', 'direcao', 'secretaria', 'suporte'];

export async function listUsers(context: TenantContext) {
  if (!context.roles.some((role) => allowedAdminRoles.includes(role))) {
    throw AppError.forbidden('Perfil sem permissão para listar usuários.');
  }
  return repo.listUsers(context.id);
}

export async function registerLocalUser(context: TenantContext, input: { email: string; fullName: string }) {
  if (!context.roles.some((role) => allowedAdminRoles.includes(role))) {
    throw AppError.forbidden('Perfil sem permissão para cadastrar usuários.');
  }
  return repo.createLocalUser({
    tenantId: context.id,
    authUserId: null,
    fullName: input.fullName,
    email: input.email,
    createdBy: context.userId,
  });
}
