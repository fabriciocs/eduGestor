create table public.students (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references public.tenants(id),
  full_name text not null,
  birth_date date not null,
  document_number text null,
  status text not null default 'active' check (status in ('active','inactive')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid null,
  updated_by uuid null,
  deleted_at timestamptz null
);

create table public.guardians (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references public.tenants(id),
  full_name text not null,
  email citext null,
  phone text null,
  document_number text null,
  status text not null default 'active' check (status in ('active','inactive')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid null,
  updated_by uuid null,
  deleted_at timestamptz null
);

create table public.student_guardians (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references public.tenants(id),
  student_id uuid not null references public.students(id),
  guardian_id uuid not null references public.guardians(id),
  relationship text not null,
  is_financial_responsible boolean not null default false,
  is_pedagogical_responsible boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid null,
  updated_by uuid null,
  deleted_at timestamptz null,
  unique (tenant_id, student_id, guardian_id)
);

create index idx_students_tenant_status on public.students(tenant_id, status) where deleted_at is null;
create index idx_students_name on public.students using btree (tenant_id, full_name);
create index idx_guardians_tenant_status on public.guardians(tenant_id, status) where deleted_at is null;
create index idx_student_guardians_student on public.student_guardians(tenant_id, student_id);
create index idx_student_guardians_guardian on public.student_guardians(tenant_id, guardian_id);

create trigger students_touch_updated_at before update on public.students for each row execute function app.touch_updated_at();
create trigger guardians_touch_updated_at before update on public.guardians for each row execute function app.touch_updated_at();
create trigger student_guardians_touch_updated_at before update on public.student_guardians for each row execute function app.touch_updated_at();

create trigger students_audit after insert or update or delete on public.students for each row execute function app.write_audit_event();
create trigger guardians_audit after insert or update or delete on public.guardians for each row execute function app.write_audit_event();
create trigger student_guardians_audit after insert or update or delete on public.student_guardians for each row execute function app.write_audit_event();
