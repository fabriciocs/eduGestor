create table public.tenants (
  id uuid primary key default gen_random_uuid(),
  legal_name text not null,
  trade_name text not null,
  document_number text not null unique,
  status text not null default 'active' check (status in ('active','suspended','inactive')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid null,
  updated_by uuid null,
  deleted_at timestamptz null
);

create trigger tenants_touch_updated_at
before update on public.tenants
for each row execute function app.touch_updated_at();

create table public.tenant_units (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references public.tenants(id),
  name text not null,
  code text not null,
  status text not null default 'active' check (status in ('active','inactive')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid null,
  updated_by uuid null,
  deleted_at timestamptz null,
  unique (tenant_id, code)
);

create index idx_tenant_units_tenant_id on public.tenant_units(tenant_id);

create trigger tenant_units_touch_updated_at
before update on public.tenant_units
for each row execute function app.touch_updated_at();
