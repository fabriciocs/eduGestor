import { supabaseAdmin } from '../../core/supabase/server-client.js';
import { PaginationInput, toRange } from '../../core/http/pagination.js';

export interface GuardianCreateInput {
  fullName: string;
  email?: string;
  phone?: string;
  documentNumber?: string;
  status?: 'active' | 'inactive';
}

export async function listGuardians(tenantId: string, pagination: PaginationInput) {
  const { from, to } = toRange(pagination);
  let query = supabaseAdmin
    .from('guardians')
    .select('id, full_name, email, phone, document_number, status, created_at', { count: 'exact' })
    .eq('tenant_id', tenantId)
    .is('deleted_at', null)
    .order('full_name')
    .range(from, to);

  if (pagination.search) query = query.ilike('full_name', `%${pagination.search}%`);

  const { data, error, count } = await query;
  if (error) throw error;
  return { data, count, page: pagination.page, pageSize: pagination.pageSize };
}

export async function createGuardian(tenantId: string, input: GuardianCreateInput, userId: string) {
  const { data, error } = await supabaseAdmin
    .from('guardians')
    .insert({
      tenant_id: tenantId,
      full_name: input.fullName,
      email: input.email ?? null,
      phone: input.phone ?? null,
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

export async function linkGuardian(input: {
  tenantId: string;
  studentId: string;
  guardianId: string;
  relationship: string;
  isFinancialResponsible: boolean;
  isPedagogicalResponsible: boolean;
  userId: string;
}) {
  const { data, error } = await supabaseAdmin
    .from('student_guardians')
    .insert({
      tenant_id: input.tenantId,
      student_id: input.studentId,
      guardian_id: input.guardianId,
      relationship: input.relationship,
      is_financial_responsible: input.isFinancialResponsible,
      is_pedagogical_responsible: input.isPedagogicalResponsible,
      created_by: input.userId,
      updated_by: input.userId,
    })
    .select()
    .single();

  if (error) throw error;
  return data;
}
