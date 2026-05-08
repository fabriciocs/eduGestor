import { FastifyReply, FastifyRequest } from 'fastify';
import { supabaseAdmin } from '../supabase/server-client.js';
import { AppError } from '../errors/app-error.js';
import { AuthRole, TenantContext } from './tenant-context.js';

function parseRoles(value: unknown): AuthRole[] {
  if (!Array.isArray(value)) return [];
  return value.filter((role): role is AuthRole => typeof role === 'string') as AuthRole[];
}

function parseUnitIds(value: unknown): string[] {
  if (!Array.isArray(value)) return [];
  return value.filter((unit): unit is string => typeof unit === 'string');
}

export async function authenticate(request: FastifyRequest, _reply: FastifyReply) {
  const authHeader = request.headers.authorization;
  if (!authHeader?.startsWith('Bearer ')) {
    throw AppError.unauthenticated();
  }

  const token = authHeader.replace('Bearer ', '').trim();
  const { data, error } = await supabaseAdmin.auth.getUser(token);

  if (error || !data.user) {
    throw AppError.unauthenticated('Token inválido ou expirado.');
  }

  const metadata = data.user.app_metadata ?? {};
  const tenantId = typeof metadata.tenant_id === 'string' ? metadata.tenant_id : undefined;
  if (!tenantId) {
    throw AppError.forbidden('Usuário sem tenant associado.');
  }

  const context: TenantContext = {
    id: tenantId,
    roles: parseRoles(metadata.roles),
    unitIds: parseUnitIds(metadata.unit_ids),
    userId: data.user.id,
    email: data.user.email ?? undefined,
  };

  request.tenant = context;
}

export function requireRoles(allowedRoles: AuthRole[]) {
  return async function requireRolesMiddleware(request: FastifyRequest, _reply: FastifyReply) {
    const context = request.tenant;
    if (!context) throw AppError.unauthenticated();
    if (!context.roles.some((role) => allowedRoles.includes(role))) {
      throw AppError.forbidden('Perfil sem permissão para esta ação.');
    }
  };
}
