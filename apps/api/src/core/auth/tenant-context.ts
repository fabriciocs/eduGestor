export type AuthRole =
  | 'admin_saas'
  | 'mantenedor'
  | 'direcao'
  | 'secretaria'
  | 'financeiro'
  | 'coordenacao'
  | 'professor'
  | 'responsavel'
  | 'aluno'
  | 'suporte';

export interface TenantContext {
  id: string;
  roles: AuthRole[];
  unitIds: string[];
  userId: string;
  email?: string;
}

export function hasAnyRole(context: TenantContext, allowedRoles: AuthRole[]) {
  return context.roles.some((role) => allowedRoles.includes(role));
}
