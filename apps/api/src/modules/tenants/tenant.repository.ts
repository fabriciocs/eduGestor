import { supabaseAdmin } from '../../core/supabase/server-client.js';

export interface TenantCreate {
  legalName: string;
  tradeName: string;
  documentNumber: string;
}

export async function createTenant(input: TenantCreate, userId: string) {
  const { data, error } = await supabaseAdmin
    .from('tenants')
    .insert({
      legal_name: input.legalName,
      trade_name: input.tradeName,
      document_number: input.documentNumber,
      created_by: userId,
      updated_by: userId,
    })
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function listTenants() {
  const { data, error } = await supabaseAdmin
    .from('tenants')
    .select('id, legal_name, trade_name, status, created_at')
    .order('created_at', { ascending: false });

  if (error) throw error;
  return data;
}

export async function createTenantUnit(input: { tenantId: string; name: string; code: string }, userId: string) {
  const { data, error } = await supabaseAdmin
    .from('tenant_units')
    .insert({
      tenant_id: input.tenantId,
      name: input.name,
      code: input.code,
      created_by: userId,
      updated_by: userId,
    })
    .select()
    .single();

  if (error) throw error;
  return data;
}
