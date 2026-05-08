create extension if not exists "pgcrypto";
create extension if not exists "citext";
create schema if not exists app;

create or replace function app.current_tenant_id()
returns uuid
language sql
stable
as $$
  select nullif(auth.jwt() -> 'app_metadata' ->> 'tenant_id', '')::uuid;
$$;

create or replace function app.current_roles()
returns text[]
language sql
stable
as $$
  select coalesce(
    array(select jsonb_array_elements_text(auth.jwt() -> 'app_metadata' -> 'roles')),
    array[]::text[]
  );
$$;

create or replace function app.has_role(role_name text)
returns boolean
language sql
stable
as $$
  select role_name = any(app.current_roles());
$$;

create or replace function app.touch_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;
