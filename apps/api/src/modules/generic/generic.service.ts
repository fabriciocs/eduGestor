import { AuthRole, TenantContext, hasAnyRole } from '../../core/auth/tenant-context.js';
import { AppError } from '../../core/errors/app-error.js';
import { PaginationInput } from '../../core/http/pagination.js';
import * as repo from './generic.repository.js';
const readRoles: AuthRole[] = ['admin_saas','mantenedor','direcao','secretaria','financeiro','coordenacao','professor','responsavel','aluno','suporte'];
const writeRoles: AuthRole[] = ['admin_saas','mantenedor','direcao','secretaria','financeiro','coordenacao','professor','suporte'];
const deleteRoles: AuthRole[] = ['admin_saas','mantenedor','direcao','secretaria','suporte'];
function requireRole(context: TenantContext, roles: AuthRole[]) { if (!hasAnyRole(context, roles)) throw AppError.forbidden('Perfil sem permissão para esta ação.'); }
export async function listRows(context: TenantContext, table: string, pagination: PaginationInput) { requireRole(context, readRoles); return repo.listRows(table, context.id, pagination); }
export async function getRow(context: TenantContext, table: string, id: string) { requireRole(context, readRoles); return repo.getRow(table, context.id, id); }
export async function createRow(context: TenantContext, table: string, input: Record<string, unknown>) { requireRole(context, writeRoles); return repo.createRow(table, context.id, input, context.userId); }
export async function updateRow(context: TenantContext, table: string, id: string, input: Record<string, unknown>) { requireRole(context, writeRoles); return repo.updateRow(table, context.id, id, input, context.userId); }
export async function deleteRow(context: TenantContext, table: string, id: string) { requireRole(context, deleteRoles); return repo.softDeleteRow(table, context.id, id, context.userId); }
