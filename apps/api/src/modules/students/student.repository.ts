import { supabaseAdmin } from '../../core/supabase/server-client.js';
import { PaginationInput, toRange } from '../../core/http/pagination.js';

export interface StudentCreateInput {
  fullName: string;
  birthDate: string;
  documentNumber?: string;
  status?: 'active' | 'inactive';
}

export async function listStudents(tenantId: string, pagination: PaginationInput) {
  const { from, to } = toRange(pagination);

  let query = supabaseAdmin
    .from('students')
    .select('id, full_name, birth_date, document_number, status, created_at', { count: 'exact' })
    .eq('tenant_id', tenantId)
    .is('deleted_at', null)
    .order('full_name')
    .range(from, to);

  if (pagination.search) {
    query = query.ilike('full_name', `%${pagination.search}%`);
  }

  const { data, error, count } = await query;
  if (error) throw error;
  return { data, count, page: pagination.page, pageSize: pagination.pageSize };
}

export async function getStudent(tenantId: string, id: string) {
  const { data, error } = await supabaseAdmin
    .from('students')
    .select('*')
    .eq('tenant_id', tenantId)
    .eq('id', id)
    .is('deleted_at', null)
    .single();

  if (error) throw error;
  return data;
}

export async function createStudent(tenantId: string, input: StudentCreateInput, userId: string) {
  const { data, error } = await supabaseAdmin
    .from('students')
    .insert({
      tenant_id: tenantId,
      full_name: input.fullName,
      birth_date: input.birthDate,
      document_number: input.documentNumber ?? null,
      status: input.status ?? 'active',
      created_by: userId,
      updated_by: userId,
    })
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function updateStudent(
  tenantId: string,
  id: string,
  input: Partial<StudentCreateInput>,
  userId: string,
) {
  const { data, error } = await supabaseAdmin
    .from('students')
    .update({
      full_name: input.fullName,
      birth_date: input.birthDate,
      document_number: input.documentNumber,
      status: input.status,
      updated_by: userId,
    })
    .eq('tenant_id', tenantId)
    .eq('id', id)
    .is('deleted_at', null)
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function softDeleteStudent(tenantId: string, id: string, userId: string) {
  const { data, error } = await supabaseAdmin
    .from('students')
    .update({ deleted_at: new Date().toISOString(), updated_by: userId })
    .eq('tenant_id', tenantId)
    .eq('id', id)
    .is('deleted_at', null)
    .select('id')
    .single();

  if (error) throw error;
  return data;
}
