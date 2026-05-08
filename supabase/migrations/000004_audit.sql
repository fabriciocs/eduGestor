create table public.audit_events (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references public.tenants(id),
  actor_user_id uuid null,
  action text not null,
  entity_type text not null,
  entity_id uuid null,
  metadata jsonb not null default '{}'::jsonb,
  ip_address inet null,
  user_agent text null,
  created_at timestamptz not null default now()
);

create index idx_audit_events_tenant_created on public.audit_events(tenant_id, created_at desc);
create index idx_audit_events_entity on public.audit_events(entity_type, entity_id);

create or replace function app.write_audit_event()
returns trigger
language plpgsql
security definer
set search_path = public, app
as $$
declare
  v_tenant_id uuid;
  v_entity_id uuid;
begin
  v_tenant_id := coalesce(new.tenant_id, old.tenant_id);
  v_entity_id := coalesce(new.id, old.id);

  insert into public.audit_events (
    tenant_id,
    actor_user_id,
    action,
    entity_type,
    entity_id,
    metadata
  )
  values (
    v_tenant_id,
    auth.uid(),
    tg_op,
    tg_table_name,
    v_entity_id,
    jsonb_build_object('old', to_jsonb(old), 'new', to_jsonb(new))
  );

  return coalesce(new, old);
end;
$$;
