import { supabaseAdmin } from '../../core/supabase/server-client.js';
import { PaginationInput, toRange } from '../../core/http/pagination.js';

export async function listAuditEvents(
  tenantId: string,
  pagination: PaginationInput,
) {
  const { from, to } = toRange(pagination);
  const { data, error, count } = await supabaseAdmin
    .from('audit_events')
    .select(
      'id, actor_user_id, action, entity_type, entity_id, created_at, metadata',
      { count: 'exact' },
    )
    .eq('tenant_id', tenantId)
    .order('created_at', { ascending: false })
    .range(from, to);

  if (error) throw error;
  return { data, count, page: pagination.page, pageSize: pagination.pageSize };
}
