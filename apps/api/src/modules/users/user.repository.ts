import { supabaseAdmin } from '../../core/supabase/server-client.js';

export async function listUsers(tenantId: string) {
  const { data, error } = await supabaseAdmin
    .from('users')
    .select('id, auth_user_id, full_name, email, status, created_at')
    .eq('tenant_id', tenantId)
    .is('deleted_at', null)
    .order('full_name');

  if (error) throw error;
  return data;
}

export async function createLocalUser(input: {
  tenantId: string;
  authUserId: string | null;
  fullName: string;
  email: string;
  createdBy: string;
}) {
  const { data, error } = await supabaseAdmin
    .from('users')
    .insert({
      tenant_id: input.tenantId,
      auth_user_id: input.authUserId,
      full_name: input.fullName,
      email: input.email,
      created_by: input.createdBy,
      updated_by: input.createdBy,
    })
    .select()
    .single();

  if (error) throw error;
  return data;
}
