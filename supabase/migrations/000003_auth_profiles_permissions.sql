create table public.profiles (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references public.tenants(id),
  name text not null,
  key text not null,
  description text null,
  is_system boolean not null default false,
  status text not null default 'active' check (status in ('active','inactive')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid null,
  updated_by uuid null,
  deleted_at timestamptz null,
  unique (tenant_id, key)
);

create table public.permissions (
  id uuid primary key default gen_random_uuid(),
  module text not null,
  action text not null,
  description text null,
  unique (module, action)
);

create table public.profile_permissions (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references public.tenants(id),
  profile_id uuid not null references public.profiles(id),
  permission_id uuid not null references public.permissions(id),
  created_at timestamptz not null default now(),
  created_by uuid null,
  unique (tenant_id, profile_id, permission_id)
);

create table public.users (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references public.tenants(id),
  auth_user_id uuid null,
  full_name text not null,
  email citext not null,
  status text not null default 'active' check (status in ('active','invited','inactive','blocked')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid null,
  updated_by uuid null,
  deleted_at timestamptz null,
  unique (tenant_id, email)
);

create table public.user_profiles (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references public.tenants(id),
  user_id uuid not null references public.users(id),
  profile_id uuid not null references public.profiles(id),
  created_at timestamptz not null default now(),
  created_by uuid null,
  unique (tenant_id, user_id, profile_id)
);

create table public.user_unit_access (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references public.tenants(id),
  user_id uuid not null references public.users(id),
  tenant_unit_id uuid not null references public.tenant_units(id),
  created_at timestamptz not null default now(),
  created_by uuid null,
  unique (tenant_id, user_id, tenant_unit_id)
);

create index idx_profiles_tenant_id on public.profiles(tenant_id);
create index idx_profile_permissions_tenant_id on public.profile_permissions(tenant_id);
create index idx_users_tenant_id on public.users(tenant_id);
create index idx_user_profiles_tenant_id on public.user_profiles(tenant_id);
create index idx_user_unit_access_tenant_id on public.user_unit_access(tenant_id);

create trigger profiles_touch_updated_at before update on public.profiles for each row execute function app.touch_updated_at();
create trigger users_touch_updated_at before update on public.users for each row execute function app.touch_updated_at();
