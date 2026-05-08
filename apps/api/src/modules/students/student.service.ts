import { TenantContext } from '../../core/auth/tenant-context.js';
import { AppError } from '../../core/errors/app-error.js';
import { PaginationInput } from '../../core/http/pagination.js';
import * as repo from './student.repository.js';

const writeRoles = ['admin_saas', 'direcao', 'secretaria', 'coordenacao'];

export async function listStudents(context: TenantContext, pagination: PaginationInput) {
  return repo.listStudents(context.id, pagination);
}

export async function getStudent(context: TenantContext, id: string) {
  return repo.getStudent(context.id, id);
}

export async function createStudent(context: TenantContext, input: repo.StudentCreateInput) {
  if (!context.roles.some((role) => writeRoles.includes(role))) {
    throw AppError.forbidden('Perfil sem permissão para cadastrar alunos.');
  }
  return repo.createStudent(context.id, input, context.userId);
}

export async function updateStudent(context: TenantContext, id: string, input: Partial<repo.StudentCreateInput>) {
  if (!context.roles.some((role) => writeRoles.includes(role))) {
    throw AppError.forbidden('Perfil sem permissão para editar alunos.');
  }
  return repo.updateStudent(context.id, id, input, context.userId);
}

export async function deleteStudent(context: TenantContext, id: string) {
  if (!context.roles.some((role) => writeRoles.includes(role))) {
    throw AppError.forbidden('Perfil sem permissão para inativar alunos.');
  }
  return repo.softDeleteStudent(context.id, id, context.userId);
}
