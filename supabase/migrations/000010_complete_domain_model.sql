-- Modelo de dados completo gerado a partir da planilha 5-Modelo-de-Dados.

create extension if not exists "pgcrypto";

create extension if not exists "citext";

create table if not exists public."tenant" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "nome" varchar(150) null,
  "subdominio" varchar(80) null,
  "plano" varchar(50) null,
  "data_inicio_contrato" date null
);

create index if not exists idx_tenant_tenant_status on public."tenant" (tenant_id, status);

create index if not exists idx_tenant_tenant_created on public."tenant" (tenant_id, created_at desc);

drop trigger if exists tenant_touch_updated_at on public."tenant";

create trigger tenant_touch_updated_at before update on public."tenant" for each row execute function app.touch_updated_at();

alter table public."tenant" enable row level security;

drop policy if exists tenant_tenant_select on public."tenant";

create policy tenant_tenant_select on public."tenant" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists tenant_tenant_insert on public."tenant";

create policy tenant_tenant_insert on public."tenant" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists tenant_tenant_update on public."tenant";

create policy tenant_tenant_update on public."tenant" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists tenant_tenant_delete on public."tenant";

create policy tenant_tenant_delete on public."tenant" for delete using (app.has_role('admin_saas'));

drop trigger if exists tenant_audit on public."tenant";

create trigger tenant_audit after insert or update or delete on public."tenant" for each row execute function app.write_audit_event();

create table if not exists public."mantenedora" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "razao_social" varchar(200) null,
  "cnpj" varchar(14) null,
  "nome_fantasia" varchar(150) null
);

create index if not exists idx_mantenedora_tenant_status on public."mantenedora" (tenant_id, status);

create index if not exists idx_mantenedora_tenant_created on public."mantenedora" (tenant_id, created_at desc);

drop trigger if exists mantenedora_touch_updated_at on public."mantenedora";

create trigger mantenedora_touch_updated_at before update on public."mantenedora" for each row execute function app.touch_updated_at();

alter table public."mantenedora" enable row level security;

drop policy if exists mantenedora_tenant_select on public."mantenedora";

create policy mantenedora_tenant_select on public."mantenedora" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists mantenedora_tenant_insert on public."mantenedora";

create policy mantenedora_tenant_insert on public."mantenedora" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists mantenedora_tenant_update on public."mantenedora";

create policy mantenedora_tenant_update on public."mantenedora" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists mantenedora_tenant_delete on public."mantenedora";

create policy mantenedora_tenant_delete on public."mantenedora" for delete using (app.has_role('admin_saas'));

drop trigger if exists mantenedora_audit on public."mantenedora";

create trigger mantenedora_audit after insert or update or delete on public."mantenedora" for each row execute function app.write_audit_event();

create table if not exists public."unidade_escolar" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "nome" varchar(150) null,
  "codigo" varchar(30) null,
  "mantenedora_id" uuid null,
  "codigo_inep" varchar(20) null
);

create index if not exists idx_unidade_escolar_tenant_status on public."unidade_escolar" (tenant_id, status);

create index if not exists idx_unidade_escolar_tenant_created on public."unidade_escolar" (tenant_id, created_at desc);

drop trigger if exists unidade_escolar_touch_updated_at on public."unidade_escolar";

create trigger unidade_escolar_touch_updated_at before update on public."unidade_escolar" for each row execute function app.touch_updated_at();

alter table public."unidade_escolar" enable row level security;

drop policy if exists unidade_escolar_tenant_select on public."unidade_escolar";

create policy unidade_escolar_tenant_select on public."unidade_escolar" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists unidade_escolar_tenant_insert on public."unidade_escolar";

create policy unidade_escolar_tenant_insert on public."unidade_escolar" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists unidade_escolar_tenant_update on public."unidade_escolar";

create policy unidade_escolar_tenant_update on public."unidade_escolar" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists unidade_escolar_tenant_delete on public."unidade_escolar";

create policy unidade_escolar_tenant_delete on public."unidade_escolar" for delete using (app.has_role('admin_saas'));

drop trigger if exists unidade_escolar_audit on public."unidade_escolar";

create trigger unidade_escolar_audit after insert or update or delete on public."unidade_escolar" for each row execute function app.write_audit_event();

create table if not exists public."parametro_sistema" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_parametro_sistema_tenant_status on public."parametro_sistema" (tenant_id, status);

create index if not exists idx_parametro_sistema_tenant_created on public."parametro_sistema" (tenant_id, created_at desc);

drop trigger if exists parametro_sistema_touch_updated_at on public."parametro_sistema";

create trigger parametro_sistema_touch_updated_at before update on public."parametro_sistema" for each row execute function app.touch_updated_at();

alter table public."parametro_sistema" enable row level security;

drop policy if exists parametro_sistema_tenant_select on public."parametro_sistema";

create policy parametro_sistema_tenant_select on public."parametro_sistema" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists parametro_sistema_tenant_insert on public."parametro_sistema";

create policy parametro_sistema_tenant_insert on public."parametro_sistema" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists parametro_sistema_tenant_update on public."parametro_sistema";

create policy parametro_sistema_tenant_update on public."parametro_sistema" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists parametro_sistema_tenant_delete on public."parametro_sistema";

create policy parametro_sistema_tenant_delete on public."parametro_sistema" for delete using (app.has_role('admin_saas'));

drop trigger if exists parametro_sistema_audit on public."parametro_sistema";

create trigger parametro_sistema_audit after insert or update or delete on public."parametro_sistema" for each row execute function app.write_audit_event();

create table if not exists public."canal_oficial" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_canal_oficial_tenant_status on public."canal_oficial" (tenant_id, status);

create index if not exists idx_canal_oficial_tenant_created on public."canal_oficial" (tenant_id, created_at desc);

drop trigger if exists canal_oficial_touch_updated_at on public."canal_oficial";

create trigger canal_oficial_touch_updated_at before update on public."canal_oficial" for each row execute function app.touch_updated_at();

alter table public."canal_oficial" enable row level security;

drop policy if exists canal_oficial_tenant_select on public."canal_oficial";

create policy canal_oficial_tenant_select on public."canal_oficial" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists canal_oficial_tenant_insert on public."canal_oficial";

create policy canal_oficial_tenant_insert on public."canal_oficial" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists canal_oficial_tenant_update on public."canal_oficial";

create policy canal_oficial_tenant_update on public."canal_oficial" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists canal_oficial_tenant_delete on public."canal_oficial";

create policy canal_oficial_tenant_delete on public."canal_oficial" for delete using (app.has_role('admin_saas'));

drop trigger if exists canal_oficial_audit on public."canal_oficial";

create trigger canal_oficial_audit after insert or update or delete on public."canal_oficial" for each row execute function app.write_audit_event();

create table if not exists public."ano_letivo" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_ano_letivo_tenant_status on public."ano_letivo" (tenant_id, status);

create index if not exists idx_ano_letivo_tenant_created on public."ano_letivo" (tenant_id, created_at desc);

drop trigger if exists ano_letivo_touch_updated_at on public."ano_letivo";

create trigger ano_letivo_touch_updated_at before update on public."ano_letivo" for each row execute function app.touch_updated_at();

alter table public."ano_letivo" enable row level security;

drop policy if exists ano_letivo_tenant_select on public."ano_letivo";

create policy ano_letivo_tenant_select on public."ano_letivo" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists ano_letivo_tenant_insert on public."ano_letivo";

create policy ano_letivo_tenant_insert on public."ano_letivo" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists ano_letivo_tenant_update on public."ano_letivo";

create policy ano_letivo_tenant_update on public."ano_letivo" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists ano_letivo_tenant_delete on public."ano_letivo";

create policy ano_letivo_tenant_delete on public."ano_letivo" for delete using (app.has_role('admin_saas'));

drop trigger if exists ano_letivo_audit on public."ano_letivo";

create trigger ano_letivo_audit after insert or update or delete on public."ano_letivo" for each row execute function app.write_audit_event();

create table if not exists public."periodo_letivo" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_periodo_letivo_tenant_status on public."periodo_letivo" (tenant_id, status);

create index if not exists idx_periodo_letivo_tenant_created on public."periodo_letivo" (tenant_id, created_at desc);

drop trigger if exists periodo_letivo_touch_updated_at on public."periodo_letivo";

create trigger periodo_letivo_touch_updated_at before update on public."periodo_letivo" for each row execute function app.touch_updated_at();

alter table public."periodo_letivo" enable row level security;

drop policy if exists periodo_letivo_tenant_select on public."periodo_letivo";

create policy periodo_letivo_tenant_select on public."periodo_letivo" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists periodo_letivo_tenant_insert on public."periodo_letivo";

create policy periodo_letivo_tenant_insert on public."periodo_letivo" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists periodo_letivo_tenant_update on public."periodo_letivo";

create policy periodo_letivo_tenant_update on public."periodo_letivo" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists periodo_letivo_tenant_delete on public."periodo_letivo";

create policy periodo_letivo_tenant_delete on public."periodo_letivo" for delete using (app.has_role('admin_saas'));

drop trigger if exists periodo_letivo_audit on public."periodo_letivo";

create trigger periodo_letivo_audit after insert or update or delete on public."periodo_letivo" for each row execute function app.write_audit_event();

create table if not exists public."turno" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_turno_tenant_status on public."turno" (tenant_id, status);

create index if not exists idx_turno_tenant_created on public."turno" (tenant_id, created_at desc);

drop trigger if exists turno_touch_updated_at on public."turno";

create trigger turno_touch_updated_at before update on public."turno" for each row execute function app.touch_updated_at();

alter table public."turno" enable row level security;

drop policy if exists turno_tenant_select on public."turno";

create policy turno_tenant_select on public."turno" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists turno_tenant_insert on public."turno";

create policy turno_tenant_insert on public."turno" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists turno_tenant_update on public."turno";

create policy turno_tenant_update on public."turno" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists turno_tenant_delete on public."turno";

create policy turno_tenant_delete on public."turno" for delete using (app.has_role('admin_saas'));

drop trigger if exists turno_audit on public."turno";

create trigger turno_audit after insert or update or delete on public."turno" for each row execute function app.write_audit_event();

create table if not exists public."calendario_escolar" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_calendario_escolar_tenant_status on public."calendario_escolar" (tenant_id, status);

create index if not exists idx_calendario_escolar_tenant_created on public."calendario_escolar" (tenant_id, created_at desc);

drop trigger if exists calendario_escolar_touch_updated_at on public."calendario_escolar";

create trigger calendario_escolar_touch_updated_at before update on public."calendario_escolar" for each row execute function app.touch_updated_at();

alter table public."calendario_escolar" enable row level security;

drop policy if exists calendario_escolar_tenant_select on public."calendario_escolar";

create policy calendario_escolar_tenant_select on public."calendario_escolar" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists calendario_escolar_tenant_insert on public."calendario_escolar";

create policy calendario_escolar_tenant_insert on public."calendario_escolar" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists calendario_escolar_tenant_update on public."calendario_escolar";

create policy calendario_escolar_tenant_update on public."calendario_escolar" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists calendario_escolar_tenant_delete on public."calendario_escolar";

create policy calendario_escolar_tenant_delete on public."calendario_escolar" for delete using (app.has_role('admin_saas'));

drop trigger if exists calendario_escolar_audit on public."calendario_escolar";

create trigger calendario_escolar_audit after insert or update or delete on public."calendario_escolar" for each row execute function app.write_audit_event();

create table if not exists public."evento_calendario" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_evento_calendario_tenant_status on public."evento_calendario" (tenant_id, status);

create index if not exists idx_evento_calendario_tenant_created on public."evento_calendario" (tenant_id, created_at desc);

drop trigger if exists evento_calendario_touch_updated_at on public."evento_calendario";

create trigger evento_calendario_touch_updated_at before update on public."evento_calendario" for each row execute function app.touch_updated_at();

alter table public."evento_calendario" enable row level security;

drop policy if exists evento_calendario_tenant_select on public."evento_calendario";

create policy evento_calendario_tenant_select on public."evento_calendario" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists evento_calendario_tenant_insert on public."evento_calendario";

create policy evento_calendario_tenant_insert on public."evento_calendario" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists evento_calendario_tenant_update on public."evento_calendario";

create policy evento_calendario_tenant_update on public."evento_calendario" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists evento_calendario_tenant_delete on public."evento_calendario";

create policy evento_calendario_tenant_delete on public."evento_calendario" for delete using (app.has_role('admin_saas'));

drop trigger if exists evento_calendario_audit on public."evento_calendario";

create trigger evento_calendario_audit after insert or update or delete on public."evento_calendario" for each row execute function app.write_audit_event();

create table if not exists public."curso" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_curso_tenant_status on public."curso" (tenant_id, status);

create index if not exists idx_curso_tenant_created on public."curso" (tenant_id, created_at desc);

drop trigger if exists curso_touch_updated_at on public."curso";

create trigger curso_touch_updated_at before update on public."curso" for each row execute function app.touch_updated_at();

alter table public."curso" enable row level security;

drop policy if exists curso_tenant_select on public."curso";

create policy curso_tenant_select on public."curso" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists curso_tenant_insert on public."curso";

create policy curso_tenant_insert on public."curso" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists curso_tenant_update on public."curso";

create policy curso_tenant_update on public."curso" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists curso_tenant_delete on public."curso";

create policy curso_tenant_delete on public."curso" for delete using (app.has_role('admin_saas'));

drop trigger if exists curso_audit on public."curso";

create trigger curso_audit after insert or update or delete on public."curso" for each row execute function app.write_audit_event();

create table if not exists public."serie_etapa" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_serie_etapa_tenant_status on public."serie_etapa" (tenant_id, status);

create index if not exists idx_serie_etapa_tenant_created on public."serie_etapa" (tenant_id, created_at desc);

drop trigger if exists serie_etapa_touch_updated_at on public."serie_etapa";

create trigger serie_etapa_touch_updated_at before update on public."serie_etapa" for each row execute function app.touch_updated_at();

alter table public."serie_etapa" enable row level security;

drop policy if exists serie_etapa_tenant_select on public."serie_etapa";

create policy serie_etapa_tenant_select on public."serie_etapa" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists serie_etapa_tenant_insert on public."serie_etapa";

create policy serie_etapa_tenant_insert on public."serie_etapa" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists serie_etapa_tenant_update on public."serie_etapa";

create policy serie_etapa_tenant_update on public."serie_etapa" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists serie_etapa_tenant_delete on public."serie_etapa";

create policy serie_etapa_tenant_delete on public."serie_etapa" for delete using (app.has_role('admin_saas'));

drop trigger if exists serie_etapa_audit on public."serie_etapa";

create trigger serie_etapa_audit after insert or update or delete on public."serie_etapa" for each row execute function app.write_audit_event();

create table if not exists public."grade_curricular" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_grade_curricular_tenant_status on public."grade_curricular" (tenant_id, status);

create index if not exists idx_grade_curricular_tenant_created on public."grade_curricular" (tenant_id, created_at desc);

drop trigger if exists grade_curricular_touch_updated_at on public."grade_curricular";

create trigger grade_curricular_touch_updated_at before update on public."grade_curricular" for each row execute function app.touch_updated_at();

alter table public."grade_curricular" enable row level security;

drop policy if exists grade_curricular_tenant_select on public."grade_curricular";

create policy grade_curricular_tenant_select on public."grade_curricular" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists grade_curricular_tenant_insert on public."grade_curricular";

create policy grade_curricular_tenant_insert on public."grade_curricular" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists grade_curricular_tenant_update on public."grade_curricular";

create policy grade_curricular_tenant_update on public."grade_curricular" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists grade_curricular_tenant_delete on public."grade_curricular";

create policy grade_curricular_tenant_delete on public."grade_curricular" for delete using (app.has_role('admin_saas'));

drop trigger if exists grade_curricular_audit on public."grade_curricular";

create trigger grade_curricular_audit after insert or update or delete on public."grade_curricular" for each row execute function app.write_audit_event();

create table if not exists public."disciplina" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_disciplina_tenant_status on public."disciplina" (tenant_id, status);

create index if not exists idx_disciplina_tenant_created on public."disciplina" (tenant_id, created_at desc);

drop trigger if exists disciplina_touch_updated_at on public."disciplina";

create trigger disciplina_touch_updated_at before update on public."disciplina" for each row execute function app.touch_updated_at();

alter table public."disciplina" enable row level security;

drop policy if exists disciplina_tenant_select on public."disciplina";

create policy disciplina_tenant_select on public."disciplina" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists disciplina_tenant_insert on public."disciplina";

create policy disciplina_tenant_insert on public."disciplina" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists disciplina_tenant_update on public."disciplina";

create policy disciplina_tenant_update on public."disciplina" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists disciplina_tenant_delete on public."disciplina";

create policy disciplina_tenant_delete on public."disciplina" for delete using (app.has_role('admin_saas'));

drop trigger if exists disciplina_audit on public."disciplina";

create trigger disciplina_audit after insert or update or delete on public."disciplina" for each row execute function app.write_audit_event();

create table if not exists public."turma" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_turma_tenant_status on public."turma" (tenant_id, status);

create index if not exists idx_turma_tenant_created on public."turma" (tenant_id, created_at desc);

drop trigger if exists turma_touch_updated_at on public."turma";

create trigger turma_touch_updated_at before update on public."turma" for each row execute function app.touch_updated_at();

alter table public."turma" enable row level security;

drop policy if exists turma_tenant_select on public."turma";

create policy turma_tenant_select on public."turma" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists turma_tenant_insert on public."turma";

create policy turma_tenant_insert on public."turma" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists turma_tenant_update on public."turma";

create policy turma_tenant_update on public."turma" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists turma_tenant_delete on public."turma";

create policy turma_tenant_delete on public."turma" for delete using (app.has_role('admin_saas'));

drop trigger if exists turma_audit on public."turma";

create trigger turma_audit after insert or update or delete on public."turma" for each row execute function app.write_audit_event();

create table if not exists public."turma_disciplina" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "nome" varchar(180) null,
  "descricao" text null,
  "origem_id" uuid null,
  "destino_id" uuid null,
  "data_inicio" date null,
  "data_fim" date null
);

create index if not exists idx_turma_disciplina_tenant_status on public."turma_disciplina" (tenant_id, status);

create index if not exists idx_turma_disciplina_tenant_created on public."turma_disciplina" (tenant_id, created_at desc);

drop trigger if exists turma_disciplina_touch_updated_at on public."turma_disciplina";

create trigger turma_disciplina_touch_updated_at before update on public."turma_disciplina" for each row execute function app.touch_updated_at();

alter table public."turma_disciplina" enable row level security;

drop policy if exists turma_disciplina_tenant_select on public."turma_disciplina";

create policy turma_disciplina_tenant_select on public."turma_disciplina" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists turma_disciplina_tenant_insert on public."turma_disciplina";

create policy turma_disciplina_tenant_insert on public."turma_disciplina" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists turma_disciplina_tenant_update on public."turma_disciplina";

create policy turma_disciplina_tenant_update on public."turma_disciplina" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists turma_disciplina_tenant_delete on public."turma_disciplina";

create policy turma_disciplina_tenant_delete on public."turma_disciplina" for delete using (app.has_role('admin_saas'));

drop trigger if exists turma_disciplina_audit on public."turma_disciplina";

create trigger turma_disciplina_audit after insert or update or delete on public."turma_disciplina" for each row execute function app.write_audit_event();

create table if not exists public."professor" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_professor_tenant_status on public."professor" (tenant_id, status);

create index if not exists idx_professor_tenant_created on public."professor" (tenant_id, created_at desc);

drop trigger if exists professor_touch_updated_at on public."professor";

create trigger professor_touch_updated_at before update on public."professor" for each row execute function app.touch_updated_at();

alter table public."professor" enable row level security;

drop policy if exists professor_tenant_select on public."professor";

create policy professor_tenant_select on public."professor" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists professor_tenant_insert on public."professor";

create policy professor_tenant_insert on public."professor" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists professor_tenant_update on public."professor";

create policy professor_tenant_update on public."professor" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists professor_tenant_delete on public."professor";

create policy professor_tenant_delete on public."professor" for delete using (app.has_role('admin_saas'));

drop trigger if exists professor_audit on public."professor";

create trigger professor_audit after insert or update or delete on public."professor" for each row execute function app.write_audit_event();

create table if not exists public."professor_disciplina" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "nome" varchar(180) null,
  "descricao" text null,
  "origem_id" uuid null,
  "destino_id" uuid null,
  "data_inicio" date null,
  "data_fim" date null
);

create index if not exists idx_professor_disciplina_tenant_status on public."professor_disciplina" (tenant_id, status);

create index if not exists idx_professor_disciplina_tenant_created on public."professor_disciplina" (tenant_id, created_at desc);

drop trigger if exists professor_disciplina_touch_updated_at on public."professor_disciplina";

create trigger professor_disciplina_touch_updated_at before update on public."professor_disciplina" for each row execute function app.touch_updated_at();

alter table public."professor_disciplina" enable row level security;

drop policy if exists professor_disciplina_tenant_select on public."professor_disciplina";

create policy professor_disciplina_tenant_select on public."professor_disciplina" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists professor_disciplina_tenant_insert on public."professor_disciplina";

create policy professor_disciplina_tenant_insert on public."professor_disciplina" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists professor_disciplina_tenant_update on public."professor_disciplina";

create policy professor_disciplina_tenant_update on public."professor_disciplina" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists professor_disciplina_tenant_delete on public."professor_disciplina";

create policy professor_disciplina_tenant_delete on public."professor_disciplina" for delete using (app.has_role('admin_saas'));

drop trigger if exists professor_disciplina_audit on public."professor_disciplina";

create trigger professor_disciplina_audit after insert or update or delete on public."professor_disciplina" for each row execute function app.write_audit_event();

create table if not exists public."horario_aula" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null,
  "situacao_processamento" varchar(30) null,
  "mensagem_erro" text null
);

create index if not exists idx_horario_aula_tenant_status on public."horario_aula" (tenant_id, status);

create index if not exists idx_horario_aula_tenant_created on public."horario_aula" (tenant_id, created_at desc);

drop trigger if exists horario_aula_touch_updated_at on public."horario_aula";

create trigger horario_aula_touch_updated_at before update on public."horario_aula" for each row execute function app.touch_updated_at();

alter table public."horario_aula" enable row level security;

drop policy if exists horario_aula_tenant_select on public."horario_aula";

create policy horario_aula_tenant_select on public."horario_aula" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists horario_aula_tenant_insert on public."horario_aula";

create policy horario_aula_tenant_insert on public."horario_aula" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists horario_aula_tenant_update on public."horario_aula";

create policy horario_aula_tenant_update on public."horario_aula" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists horario_aula_tenant_delete on public."horario_aula";

create policy horario_aula_tenant_delete on public."horario_aula" for delete using (app.has_role('admin_saas'));

drop trigger if exists horario_aula_audit on public."horario_aula";

create trigger horario_aula_audit after insert or update or delete on public."horario_aula" for each row execute function app.write_audit_event();

create table if not exists public."sala_ambiente" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_sala_ambiente_tenant_status on public."sala_ambiente" (tenant_id, status);

create index if not exists idx_sala_ambiente_tenant_created on public."sala_ambiente" (tenant_id, created_at desc);

drop trigger if exists sala_ambiente_touch_updated_at on public."sala_ambiente";

create trigger sala_ambiente_touch_updated_at before update on public."sala_ambiente" for each row execute function app.touch_updated_at();

alter table public."sala_ambiente" enable row level security;

drop policy if exists sala_ambiente_tenant_select on public."sala_ambiente";

create policy sala_ambiente_tenant_select on public."sala_ambiente" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists sala_ambiente_tenant_insert on public."sala_ambiente";

create policy sala_ambiente_tenant_insert on public."sala_ambiente" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists sala_ambiente_tenant_update on public."sala_ambiente";

create policy sala_ambiente_tenant_update on public."sala_ambiente" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists sala_ambiente_tenant_delete on public."sala_ambiente";

create policy sala_ambiente_tenant_delete on public."sala_ambiente" for delete using (app.has_role('admin_saas'));

drop trigger if exists sala_ambiente_audit on public."sala_ambiente";

create trigger sala_ambiente_audit after insert or update or delete on public."sala_ambiente" for each row execute function app.write_audit_event();

create table if not exists public."aluno" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "nome_completo" varchar(200) null,
  "data_nascimento" date null,
  "cpf" varchar(11) null,
  "genero" varchar(30) null,
  "foto_url" varchar(500) null
);

create index if not exists idx_aluno_tenant_status on public."aluno" (tenant_id, status);

create index if not exists idx_aluno_tenant_created on public."aluno" (tenant_id, created_at desc);

drop trigger if exists aluno_touch_updated_at on public."aluno";

create trigger aluno_touch_updated_at before update on public."aluno" for each row execute function app.touch_updated_at();

alter table public."aluno" enable row level security;

drop policy if exists aluno_tenant_select on public."aluno";

create policy aluno_tenant_select on public."aluno" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists aluno_tenant_insert on public."aluno";

create policy aluno_tenant_insert on public."aluno" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists aluno_tenant_update on public."aluno";

create policy aluno_tenant_update on public."aluno" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists aluno_tenant_delete on public."aluno";

create policy aluno_tenant_delete on public."aluno" for delete using (app.has_role('admin_saas'));

drop trigger if exists aluno_audit on public."aluno";

create trigger aluno_audit after insert or update or delete on public."aluno" for each row execute function app.write_audit_event();

create table if not exists public."responsavel" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "nome_completo" varchar(200) null,
  "cpf" varchar(11) null,
  "email" varchar(180) null,
  "celular" varchar(20) null
);

create index if not exists idx_responsavel_tenant_status on public."responsavel" (tenant_id, status);

create index if not exists idx_responsavel_tenant_created on public."responsavel" (tenant_id, created_at desc);

drop trigger if exists responsavel_touch_updated_at on public."responsavel";

create trigger responsavel_touch_updated_at before update on public."responsavel" for each row execute function app.touch_updated_at();

alter table public."responsavel" enable row level security;

drop policy if exists responsavel_tenant_select on public."responsavel";

create policy responsavel_tenant_select on public."responsavel" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists responsavel_tenant_insert on public."responsavel";

create policy responsavel_tenant_insert on public."responsavel" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists responsavel_tenant_update on public."responsavel";

create policy responsavel_tenant_update on public."responsavel" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists responsavel_tenant_delete on public."responsavel";

create policy responsavel_tenant_delete on public."responsavel" for delete using (app.has_role('admin_saas'));

drop trigger if exists responsavel_audit on public."responsavel";

create trigger responsavel_audit after insert or update or delete on public."responsavel" for each row execute function app.write_audit_event();

create table if not exists public."aluno_responsavel" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "nome" varchar(180) null,
  "descricao" text null,
  "origem_id" uuid null,
  "destino_id" uuid null,
  "data_inicio" date null,
  "data_fim" date null
);

create index if not exists idx_aluno_responsavel_tenant_status on public."aluno_responsavel" (tenant_id, status);

create index if not exists idx_aluno_responsavel_tenant_created on public."aluno_responsavel" (tenant_id, created_at desc);

drop trigger if exists aluno_responsavel_touch_updated_at on public."aluno_responsavel";

create trigger aluno_responsavel_touch_updated_at before update on public."aluno_responsavel" for each row execute function app.touch_updated_at();

alter table public."aluno_responsavel" enable row level security;

drop policy if exists aluno_responsavel_tenant_select on public."aluno_responsavel";

create policy aluno_responsavel_tenant_select on public."aluno_responsavel" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists aluno_responsavel_tenant_insert on public."aluno_responsavel";

create policy aluno_responsavel_tenant_insert on public."aluno_responsavel" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists aluno_responsavel_tenant_update on public."aluno_responsavel";

create policy aluno_responsavel_tenant_update on public."aluno_responsavel" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists aluno_responsavel_tenant_delete on public."aluno_responsavel";

create policy aluno_responsavel_tenant_delete on public."aluno_responsavel" for delete using (app.has_role('admin_saas'));

drop trigger if exists aluno_responsavel_audit on public."aluno_responsavel";

create trigger aluno_responsavel_audit after insert or update or delete on public."aluno_responsavel" for each row execute function app.write_audit_event();

create table if not exists public."endereco" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_endereco_tenant_status on public."endereco" (tenant_id, status);

create index if not exists idx_endereco_tenant_created on public."endereco" (tenant_id, created_at desc);

drop trigger if exists endereco_touch_updated_at on public."endereco";

create trigger endereco_touch_updated_at before update on public."endereco" for each row execute function app.touch_updated_at();

alter table public."endereco" enable row level security;

drop policy if exists endereco_tenant_select on public."endereco";

create policy endereco_tenant_select on public."endereco" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists endereco_tenant_insert on public."endereco";

create policy endereco_tenant_insert on public."endereco" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists endereco_tenant_update on public."endereco";

create policy endereco_tenant_update on public."endereco" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists endereco_tenant_delete on public."endereco";

create policy endereco_tenant_delete on public."endereco" for delete using (app.has_role('admin_saas'));

drop trigger if exists endereco_audit on public."endereco";

create trigger endereco_audit after insert or update or delete on public."endereco" for each row execute function app.write_audit_event();

create table if not exists public."contato" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_contato_tenant_status on public."contato" (tenant_id, status);

create index if not exists idx_contato_tenant_created on public."contato" (tenant_id, created_at desc);

drop trigger if exists contato_touch_updated_at on public."contato";

create trigger contato_touch_updated_at before update on public."contato" for each row execute function app.touch_updated_at();

alter table public."contato" enable row level security;

drop policy if exists contato_tenant_select on public."contato";

create policy contato_tenant_select on public."contato" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists contato_tenant_insert on public."contato";

create policy contato_tenant_insert on public."contato" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists contato_tenant_update on public."contato";

create policy contato_tenant_update on public."contato" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists contato_tenant_delete on public."contato";

create policy contato_tenant_delete on public."contato" for delete using (app.has_role('admin_saas'));

drop trigger if exists contato_audit on public."contato";

create trigger contato_audit after insert or update or delete on public."contato" for each row execute function app.write_audit_event();

create table if not exists public."documento_pessoa" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_documento_pessoa_tenant_status on public."documento_pessoa" (tenant_id, status);

create index if not exists idx_documento_pessoa_tenant_created on public."documento_pessoa" (tenant_id, created_at desc);

drop trigger if exists documento_pessoa_touch_updated_at on public."documento_pessoa";

create trigger documento_pessoa_touch_updated_at before update on public."documento_pessoa" for each row execute function app.touch_updated_at();

alter table public."documento_pessoa" enable row level security;

drop policy if exists documento_pessoa_tenant_select on public."documento_pessoa";

create policy documento_pessoa_tenant_select on public."documento_pessoa" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists documento_pessoa_tenant_insert on public."documento_pessoa";

create policy documento_pessoa_tenant_insert on public."documento_pessoa" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists documento_pessoa_tenant_update on public."documento_pessoa";

create policy documento_pessoa_tenant_update on public."documento_pessoa" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists documento_pessoa_tenant_delete on public."documento_pessoa";

create policy documento_pessoa_tenant_delete on public."documento_pessoa" for delete using (app.has_role('admin_saas'));

drop trigger if exists documento_pessoa_audit on public."documento_pessoa";

create trigger documento_pessoa_audit after insert or update or delete on public."documento_pessoa" for each row execute function app.write_audit_event();

create table if not exists public."necessidade_especial" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_necessidade_especial_tenant_status on public."necessidade_especial" (tenant_id, status);

create index if not exists idx_necessidade_especial_tenant_created on public."necessidade_especial" (tenant_id, created_at desc);

drop trigger if exists necessidade_especial_touch_updated_at on public."necessidade_especial";

create trigger necessidade_especial_touch_updated_at before update on public."necessidade_especial" for each row execute function app.touch_updated_at();

alter table public."necessidade_especial" enable row level security;

drop policy if exists necessidade_especial_tenant_select on public."necessidade_especial";

create policy necessidade_especial_tenant_select on public."necessidade_especial" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists necessidade_especial_tenant_insert on public."necessidade_especial";

create policy necessidade_especial_tenant_insert on public."necessidade_especial" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists necessidade_especial_tenant_update on public."necessidade_especial";

create policy necessidade_especial_tenant_update on public."necessidade_especial" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists necessidade_especial_tenant_delete on public."necessidade_especial";

create policy necessidade_especial_tenant_delete on public."necessidade_especial" for delete using (app.has_role('admin_saas'));

drop trigger if exists necessidade_especial_audit on public."necessidade_especial";

create trigger necessidade_especial_audit after insert or update or delete on public."necessidade_especial" for each row execute function app.write_audit_event();

create table if not exists public."ficha_saude" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_ficha_saude_tenant_status on public."ficha_saude" (tenant_id, status);

create index if not exists idx_ficha_saude_tenant_created on public."ficha_saude" (tenant_id, created_at desc);

drop trigger if exists ficha_saude_touch_updated_at on public."ficha_saude";

create trigger ficha_saude_touch_updated_at before update on public."ficha_saude" for each row execute function app.touch_updated_at();

alter table public."ficha_saude" enable row level security;

drop policy if exists ficha_saude_tenant_select on public."ficha_saude";

create policy ficha_saude_tenant_select on public."ficha_saude" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists ficha_saude_tenant_insert on public."ficha_saude";

create policy ficha_saude_tenant_insert on public."ficha_saude" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists ficha_saude_tenant_update on public."ficha_saude";

create policy ficha_saude_tenant_update on public."ficha_saude" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists ficha_saude_tenant_delete on public."ficha_saude";

create policy ficha_saude_tenant_delete on public."ficha_saude" for delete using (app.has_role('admin_saas'));

drop trigger if exists ficha_saude_audit on public."ficha_saude";

create trigger ficha_saude_audit after insert or update or delete on public."ficha_saude" for each row execute function app.write_audit_event();

create table if not exists public."matricula" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "aluno_id" uuid null,
  "turma_id" uuid null,
  "ano_letivo_id" uuid null,
  "numero_matricula" varchar(50) null,
  "situacao" varchar(30) null,
  "data_matricula" date null
);

create index if not exists idx_matricula_tenant_status on public."matricula" (tenant_id, status);

create index if not exists idx_matricula_tenant_created on public."matricula" (tenant_id, created_at desc);

drop trigger if exists matricula_touch_updated_at on public."matricula";

create trigger matricula_touch_updated_at before update on public."matricula" for each row execute function app.touch_updated_at();

alter table public."matricula" enable row level security;

drop policy if exists matricula_tenant_select on public."matricula";

create policy matricula_tenant_select on public."matricula" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists matricula_tenant_insert on public."matricula";

create policy matricula_tenant_insert on public."matricula" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists matricula_tenant_update on public."matricula";

create policy matricula_tenant_update on public."matricula" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists matricula_tenant_delete on public."matricula";

create policy matricula_tenant_delete on public."matricula" for delete using (app.has_role('admin_saas'));

drop trigger if exists matricula_audit on public."matricula";

create trigger matricula_audit after insert or update or delete on public."matricula" for each row execute function app.write_audit_event();

create table if not exists public."processo_matricula" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null,
  "situacao_processamento" varchar(30) null,
  "mensagem_erro" text null
);

create index if not exists idx_processo_matricula_tenant_status on public."processo_matricula" (tenant_id, status);

create index if not exists idx_processo_matricula_tenant_created on public."processo_matricula" (tenant_id, created_at desc);

drop trigger if exists processo_matricula_touch_updated_at on public."processo_matricula";

create trigger processo_matricula_touch_updated_at before update on public."processo_matricula" for each row execute function app.touch_updated_at();

alter table public."processo_matricula" enable row level security;

drop policy if exists processo_matricula_tenant_select on public."processo_matricula";

create policy processo_matricula_tenant_select on public."processo_matricula" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists processo_matricula_tenant_insert on public."processo_matricula";

create policy processo_matricula_tenant_insert on public."processo_matricula" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists processo_matricula_tenant_update on public."processo_matricula";

create policy processo_matricula_tenant_update on public."processo_matricula" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists processo_matricula_tenant_delete on public."processo_matricula";

create policy processo_matricula_tenant_delete on public."processo_matricula" for delete using (app.has_role('admin_saas'));

drop trigger if exists processo_matricula_audit on public."processo_matricula";

create trigger processo_matricula_audit after insert or update or delete on public."processo_matricula" for each row execute function app.write_audit_event();

create table if not exists public."contrato_educacional" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_contrato_educacional_tenant_status on public."contrato_educacional" (tenant_id, status);

create index if not exists idx_contrato_educacional_tenant_created on public."contrato_educacional" (tenant_id, created_at desc);

drop trigger if exists contrato_educacional_touch_updated_at on public."contrato_educacional";

create trigger contrato_educacional_touch_updated_at before update on public."contrato_educacional" for each row execute function app.touch_updated_at();

alter table public."contrato_educacional" enable row level security;

drop policy if exists contrato_educacional_tenant_select on public."contrato_educacional";

create policy contrato_educacional_tenant_select on public."contrato_educacional" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists contrato_educacional_tenant_insert on public."contrato_educacional";

create policy contrato_educacional_tenant_insert on public."contrato_educacional" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists contrato_educacional_tenant_update on public."contrato_educacional";

create policy contrato_educacional_tenant_update on public."contrato_educacional" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists contrato_educacional_tenant_delete on public."contrato_educacional";

create policy contrato_educacional_tenant_delete on public."contrato_educacional" for delete using (app.has_role('admin_saas'));

drop trigger if exists contrato_educacional_audit on public."contrato_educacional";

create trigger contrato_educacional_audit after insert or update or delete on public."contrato_educacional" for each row execute function app.write_audit_event();

create table if not exists public."documento_escolar" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_documento_escolar_tenant_status on public."documento_escolar" (tenant_id, status);

create index if not exists idx_documento_escolar_tenant_created on public."documento_escolar" (tenant_id, created_at desc);

drop trigger if exists documento_escolar_touch_updated_at on public."documento_escolar";

create trigger documento_escolar_touch_updated_at before update on public."documento_escolar" for each row execute function app.touch_updated_at();

alter table public."documento_escolar" enable row level security;

drop policy if exists documento_escolar_tenant_select on public."documento_escolar";

create policy documento_escolar_tenant_select on public."documento_escolar" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists documento_escolar_tenant_insert on public."documento_escolar";

create policy documento_escolar_tenant_insert on public."documento_escolar" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists documento_escolar_tenant_update on public."documento_escolar";

create policy documento_escolar_tenant_update on public."documento_escolar" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists documento_escolar_tenant_delete on public."documento_escolar";

create policy documento_escolar_tenant_delete on public."documento_escolar" for delete using (app.has_role('admin_saas'));

drop trigger if exists documento_escolar_audit on public."documento_escolar";

create trigger documento_escolar_audit after insert or update or delete on public."documento_escolar" for each row execute function app.write_audit_event();

create table if not exists public."assinatura_digital" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null,
  "situacao_processamento" varchar(30) null,
  "mensagem_erro" text null
);

create index if not exists idx_assinatura_digital_tenant_status on public."assinatura_digital" (tenant_id, status);

create index if not exists idx_assinatura_digital_tenant_created on public."assinatura_digital" (tenant_id, created_at desc);

drop trigger if exists assinatura_digital_touch_updated_at on public."assinatura_digital";

create trigger assinatura_digital_touch_updated_at before update on public."assinatura_digital" for each row execute function app.touch_updated_at();

alter table public."assinatura_digital" enable row level security;

drop policy if exists assinatura_digital_tenant_select on public."assinatura_digital";

create policy assinatura_digital_tenant_select on public."assinatura_digital" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists assinatura_digital_tenant_insert on public."assinatura_digital";

create policy assinatura_digital_tenant_insert on public."assinatura_digital" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists assinatura_digital_tenant_update on public."assinatura_digital";

create policy assinatura_digital_tenant_update on public."assinatura_digital" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists assinatura_digital_tenant_delete on public."assinatura_digital";

create policy assinatura_digital_tenant_delete on public."assinatura_digital" for delete using (app.has_role('admin_saas'));

drop trigger if exists assinatura_digital_audit on public."assinatura_digital";

create trigger assinatura_digital_audit after insert or update or delete on public."assinatura_digital" for each row execute function app.write_audit_event();

create table if not exists public."solicitacao_secretaria" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null,
  "situacao_processamento" varchar(30) null,
  "mensagem_erro" text null
);

create index if not exists idx_solicitacao_secretaria_tenant_status on public."solicitacao_secretaria" (tenant_id, status);

create index if not exists idx_solicitacao_secretaria_tenant_created on public."solicitacao_secretaria" (tenant_id, created_at desc);

drop trigger if exists solicitacao_secretaria_touch_updated_at on public."solicitacao_secretaria";

create trigger solicitacao_secretaria_touch_updated_at before update on public."solicitacao_secretaria" for each row execute function app.touch_updated_at();

alter table public."solicitacao_secretaria" enable row level security;

drop policy if exists solicitacao_secretaria_tenant_select on public."solicitacao_secretaria";

create policy solicitacao_secretaria_tenant_select on public."solicitacao_secretaria" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists solicitacao_secretaria_tenant_insert on public."solicitacao_secretaria";

create policy solicitacao_secretaria_tenant_insert on public."solicitacao_secretaria" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists solicitacao_secretaria_tenant_update on public."solicitacao_secretaria";

create policy solicitacao_secretaria_tenant_update on public."solicitacao_secretaria" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists solicitacao_secretaria_tenant_delete on public."solicitacao_secretaria";

create policy solicitacao_secretaria_tenant_delete on public."solicitacao_secretaria" for delete using (app.has_role('admin_saas'));

drop trigger if exists solicitacao_secretaria_audit on public."solicitacao_secretaria";

create trigger solicitacao_secretaria_audit after insert or update or delete on public."solicitacao_secretaria" for each row execute function app.write_audit_event();

create table if not exists public."vaga_oferta" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null,
  "situacao_processamento" varchar(30) null,
  "mensagem_erro" text null
);

create index if not exists idx_vaga_oferta_tenant_status on public."vaga_oferta" (tenant_id, status);

create index if not exists idx_vaga_oferta_tenant_created on public."vaga_oferta" (tenant_id, created_at desc);

drop trigger if exists vaga_oferta_touch_updated_at on public."vaga_oferta";

create trigger vaga_oferta_touch_updated_at before update on public."vaga_oferta" for each row execute function app.touch_updated_at();

alter table public."vaga_oferta" enable row level security;

drop policy if exists vaga_oferta_tenant_select on public."vaga_oferta";

create policy vaga_oferta_tenant_select on public."vaga_oferta" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists vaga_oferta_tenant_insert on public."vaga_oferta";

create policy vaga_oferta_tenant_insert on public."vaga_oferta" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists vaga_oferta_tenant_update on public."vaga_oferta";

create policy vaga_oferta_tenant_update on public."vaga_oferta" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists vaga_oferta_tenant_delete on public."vaga_oferta";

create policy vaga_oferta_tenant_delete on public."vaga_oferta" for delete using (app.has_role('admin_saas'));

drop trigger if exists vaga_oferta_audit on public."vaga_oferta";

create trigger vaga_oferta_audit after insert or update or delete on public."vaga_oferta" for each row execute function app.write_audit_event();

create table if not exists public."lista_espera" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null,
  "situacao_processamento" varchar(30) null,
  "mensagem_erro" text null
);

create index if not exists idx_lista_espera_tenant_status on public."lista_espera" (tenant_id, status);

create index if not exists idx_lista_espera_tenant_created on public."lista_espera" (tenant_id, created_at desc);

drop trigger if exists lista_espera_touch_updated_at on public."lista_espera";

create trigger lista_espera_touch_updated_at before update on public."lista_espera" for each row execute function app.touch_updated_at();

alter table public."lista_espera" enable row level security;

drop policy if exists lista_espera_tenant_select on public."lista_espera";

create policy lista_espera_tenant_select on public."lista_espera" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists lista_espera_tenant_insert on public."lista_espera";

create policy lista_espera_tenant_insert on public."lista_espera" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists lista_espera_tenant_update on public."lista_espera";

create policy lista_espera_tenant_update on public."lista_espera" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists lista_espera_tenant_delete on public."lista_espera";

create policy lista_espera_tenant_delete on public."lista_espera" for delete using (app.has_role('admin_saas'));

drop trigger if exists lista_espera_audit on public."lista_espera";

create trigger lista_espera_audit after insert or update or delete on public."lista_espera" for each row execute function app.write_audit_event();

create table if not exists public."lead_prospect" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_lead_prospect_tenant_status on public."lead_prospect" (tenant_id, status);

create index if not exists idx_lead_prospect_tenant_created on public."lead_prospect" (tenant_id, created_at desc);

drop trigger if exists lead_prospect_touch_updated_at on public."lead_prospect";

create trigger lead_prospect_touch_updated_at before update on public."lead_prospect" for each row execute function app.touch_updated_at();

alter table public."lead_prospect" enable row level security;

drop policy if exists lead_prospect_tenant_select on public."lead_prospect";

create policy lead_prospect_tenant_select on public."lead_prospect" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists lead_prospect_tenant_insert on public."lead_prospect";

create policy lead_prospect_tenant_insert on public."lead_prospect" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists lead_prospect_tenant_update on public."lead_prospect";

create policy lead_prospect_tenant_update on public."lead_prospect" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists lead_prospect_tenant_delete on public."lead_prospect";

create policy lead_prospect_tenant_delete on public."lead_prospect" for delete using (app.has_role('admin_saas'));

drop trigger if exists lead_prospect_audit on public."lead_prospect";

create trigger lead_prospect_audit after insert or update or delete on public."lead_prospect" for each row execute function app.write_audit_event();

create table if not exists public."atendimento_lead" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_atendimento_lead_tenant_status on public."atendimento_lead" (tenant_id, status);

create index if not exists idx_atendimento_lead_tenant_created on public."atendimento_lead" (tenant_id, created_at desc);

drop trigger if exists atendimento_lead_touch_updated_at on public."atendimento_lead";

create trigger atendimento_lead_touch_updated_at before update on public."atendimento_lead" for each row execute function app.touch_updated_at();

alter table public."atendimento_lead" enable row level security;

drop policy if exists atendimento_lead_tenant_select on public."atendimento_lead";

create policy atendimento_lead_tenant_select on public."atendimento_lead" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists atendimento_lead_tenant_insert on public."atendimento_lead";

create policy atendimento_lead_tenant_insert on public."atendimento_lead" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists atendimento_lead_tenant_update on public."atendimento_lead";

create policy atendimento_lead_tenant_update on public."atendimento_lead" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists atendimento_lead_tenant_delete on public."atendimento_lead";

create policy atendimento_lead_tenant_delete on public."atendimento_lead" for delete using (app.has_role('admin_saas'));

drop trigger if exists atendimento_lead_audit on public."atendimento_lead";

create trigger atendimento_lead_audit after insert or update or delete on public."atendimento_lead" for each row execute function app.write_audit_event();

create table if not exists public."campanha_captacao" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_campanha_captacao_tenant_status on public."campanha_captacao" (tenant_id, status);

create index if not exists idx_campanha_captacao_tenant_created on public."campanha_captacao" (tenant_id, created_at desc);

drop trigger if exists campanha_captacao_touch_updated_at on public."campanha_captacao";

create trigger campanha_captacao_touch_updated_at before update on public."campanha_captacao" for each row execute function app.touch_updated_at();

alter table public."campanha_captacao" enable row level security;

drop policy if exists campanha_captacao_tenant_select on public."campanha_captacao";

create policy campanha_captacao_tenant_select on public."campanha_captacao" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists campanha_captacao_tenant_insert on public."campanha_captacao";

create policy campanha_captacao_tenant_insert on public."campanha_captacao" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists campanha_captacao_tenant_update on public."campanha_captacao";

create policy campanha_captacao_tenant_update on public."campanha_captacao" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists campanha_captacao_tenant_delete on public."campanha_captacao";

create policy campanha_captacao_tenant_delete on public."campanha_captacao" for delete using (app.has_role('admin_saas'));

drop trigger if exists campanha_captacao_audit on public."campanha_captacao";

create trigger campanha_captacao_audit after insert or update or delete on public."campanha_captacao" for each row execute function app.write_audit_event();

create table if not exists public."frequencia_aula" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_frequencia_aula_tenant_status on public."frequencia_aula" (tenant_id, status);

create index if not exists idx_frequencia_aula_tenant_created on public."frequencia_aula" (tenant_id, created_at desc);

drop trigger if exists frequencia_aula_touch_updated_at on public."frequencia_aula";

create trigger frequencia_aula_touch_updated_at before update on public."frequencia_aula" for each row execute function app.touch_updated_at();

alter table public."frequencia_aula" enable row level security;

drop policy if exists frequencia_aula_tenant_select on public."frequencia_aula";

create policy frequencia_aula_tenant_select on public."frequencia_aula" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists frequencia_aula_tenant_insert on public."frequencia_aula";

create policy frequencia_aula_tenant_insert on public."frequencia_aula" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists frequencia_aula_tenant_update on public."frequencia_aula";

create policy frequencia_aula_tenant_update on public."frequencia_aula" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists frequencia_aula_tenant_delete on public."frequencia_aula";

create policy frequencia_aula_tenant_delete on public."frequencia_aula" for delete using (app.has_role('admin_saas'));

drop trigger if exists frequencia_aula_audit on public."frequencia_aula";

create trigger frequencia_aula_audit after insert or update or delete on public."frequencia_aula" for each row execute function app.write_audit_event();

create table if not exists public."frequencia_aluno" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "nome" varchar(180) null,
  "descricao" text null,
  "origem_id" uuid null,
  "destino_id" uuid null,
  "data_inicio" date null,
  "data_fim" date null
);

create index if not exists idx_frequencia_aluno_tenant_status on public."frequencia_aluno" (tenant_id, status);

create index if not exists idx_frequencia_aluno_tenant_created on public."frequencia_aluno" (tenant_id, created_at desc);

drop trigger if exists frequencia_aluno_touch_updated_at on public."frequencia_aluno";

create trigger frequencia_aluno_touch_updated_at before update on public."frequencia_aluno" for each row execute function app.touch_updated_at();

alter table public."frequencia_aluno" enable row level security;

drop policy if exists frequencia_aluno_tenant_select on public."frequencia_aluno";

create policy frequencia_aluno_tenant_select on public."frequencia_aluno" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists frequencia_aluno_tenant_insert on public."frequencia_aluno";

create policy frequencia_aluno_tenant_insert on public."frequencia_aluno" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists frequencia_aluno_tenant_update on public."frequencia_aluno";

create policy frequencia_aluno_tenant_update on public."frequencia_aluno" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists frequencia_aluno_tenant_delete on public."frequencia_aluno";

create policy frequencia_aluno_tenant_delete on public."frequencia_aluno" for delete using (app.has_role('admin_saas'));

drop trigger if exists frequencia_aluno_audit on public."frequencia_aluno";

create trigger frequencia_aluno_audit after insert or update or delete on public."frequencia_aluno" for each row execute function app.write_audit_event();

create table if not exists public."justificativa_falta" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_justificativa_falta_tenant_status on public."justificativa_falta" (tenant_id, status);

create index if not exists idx_justificativa_falta_tenant_created on public."justificativa_falta" (tenant_id, created_at desc);

drop trigger if exists justificativa_falta_touch_updated_at on public."justificativa_falta";

create trigger justificativa_falta_touch_updated_at before update on public."justificativa_falta" for each row execute function app.touch_updated_at();

alter table public."justificativa_falta" enable row level security;

drop policy if exists justificativa_falta_tenant_select on public."justificativa_falta";

create policy justificativa_falta_tenant_select on public."justificativa_falta" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists justificativa_falta_tenant_insert on public."justificativa_falta";

create policy justificativa_falta_tenant_insert on public."justificativa_falta" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists justificativa_falta_tenant_update on public."justificativa_falta";

create policy justificativa_falta_tenant_update on public."justificativa_falta" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists justificativa_falta_tenant_delete on public."justificativa_falta";

create policy justificativa_falta_tenant_delete on public."justificativa_falta" for delete using (app.has_role('admin_saas'));

drop trigger if exists justificativa_falta_audit on public."justificativa_falta";

create trigger justificativa_falta_audit after insert or update or delete on public."justificativa_falta" for each row execute function app.write_audit_event();

create table if not exists public."ocorrencia_pedagogica" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_ocorrencia_pedagogica_tenant_status on public."ocorrencia_pedagogica" (tenant_id, status);

create index if not exists idx_ocorrencia_pedagogica_tenant_created on public."ocorrencia_pedagogica" (tenant_id, created_at desc);

drop trigger if exists ocorrencia_pedagogica_touch_updated_at on public."ocorrencia_pedagogica";

create trigger ocorrencia_pedagogica_touch_updated_at before update on public."ocorrencia_pedagogica" for each row execute function app.touch_updated_at();

alter table public."ocorrencia_pedagogica" enable row level security;

drop policy if exists ocorrencia_pedagogica_tenant_select on public."ocorrencia_pedagogica";

create policy ocorrencia_pedagogica_tenant_select on public."ocorrencia_pedagogica" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists ocorrencia_pedagogica_tenant_insert on public."ocorrencia_pedagogica";

create policy ocorrencia_pedagogica_tenant_insert on public."ocorrencia_pedagogica" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists ocorrencia_pedagogica_tenant_update on public."ocorrencia_pedagogica";

create policy ocorrencia_pedagogica_tenant_update on public."ocorrencia_pedagogica" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists ocorrencia_pedagogica_tenant_delete on public."ocorrencia_pedagogica";

create policy ocorrencia_pedagogica_tenant_delete on public."ocorrencia_pedagogica" for delete using (app.has_role('admin_saas'));

drop trigger if exists ocorrencia_pedagogica_audit on public."ocorrencia_pedagogica";

create trigger ocorrencia_pedagogica_audit after insert or update or delete on public."ocorrencia_pedagogica" for each row execute function app.write_audit_event();

create table if not exists public."conteudo_aula" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_conteudo_aula_tenant_status on public."conteudo_aula" (tenant_id, status);

create index if not exists idx_conteudo_aula_tenant_created on public."conteudo_aula" (tenant_id, created_at desc);

drop trigger if exists conteudo_aula_touch_updated_at on public."conteudo_aula";

create trigger conteudo_aula_touch_updated_at before update on public."conteudo_aula" for each row execute function app.touch_updated_at();

alter table public."conteudo_aula" enable row level security;

drop policy if exists conteudo_aula_tenant_select on public."conteudo_aula";

create policy conteudo_aula_tenant_select on public."conteudo_aula" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists conteudo_aula_tenant_insert on public."conteudo_aula";

create policy conteudo_aula_tenant_insert on public."conteudo_aula" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists conteudo_aula_tenant_update on public."conteudo_aula";

create policy conteudo_aula_tenant_update on public."conteudo_aula" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists conteudo_aula_tenant_delete on public."conteudo_aula";

create policy conteudo_aula_tenant_delete on public."conteudo_aula" for delete using (app.has_role('admin_saas'));

drop trigger if exists conteudo_aula_audit on public."conteudo_aula";

create trigger conteudo_aula_audit after insert or update or delete on public."conteudo_aula" for each row execute function app.write_audit_event();

create table if not exists public."avaliacao" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_avaliacao_tenant_status on public."avaliacao" (tenant_id, status);

create index if not exists idx_avaliacao_tenant_created on public."avaliacao" (tenant_id, created_at desc);

drop trigger if exists avaliacao_touch_updated_at on public."avaliacao";

create trigger avaliacao_touch_updated_at before update on public."avaliacao" for each row execute function app.touch_updated_at();

alter table public."avaliacao" enable row level security;

drop policy if exists avaliacao_tenant_select on public."avaliacao";

create policy avaliacao_tenant_select on public."avaliacao" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists avaliacao_tenant_insert on public."avaliacao";

create policy avaliacao_tenant_insert on public."avaliacao" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists avaliacao_tenant_update on public."avaliacao";

create policy avaliacao_tenant_update on public."avaliacao" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists avaliacao_tenant_delete on public."avaliacao";

create policy avaliacao_tenant_delete on public."avaliacao" for delete using (app.has_role('admin_saas'));

drop trigger if exists avaliacao_audit on public."avaliacao";

create trigger avaliacao_audit after insert or update or delete on public."avaliacao" for each row execute function app.write_audit_event();

create table if not exists public."nota_aluno" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_nota_aluno_tenant_status on public."nota_aluno" (tenant_id, status);

create index if not exists idx_nota_aluno_tenant_created on public."nota_aluno" (tenant_id, created_at desc);

drop trigger if exists nota_aluno_touch_updated_at on public."nota_aluno";

create trigger nota_aluno_touch_updated_at before update on public."nota_aluno" for each row execute function app.touch_updated_at();

alter table public."nota_aluno" enable row level security;

drop policy if exists nota_aluno_tenant_select on public."nota_aluno";

create policy nota_aluno_tenant_select on public."nota_aluno" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists nota_aluno_tenant_insert on public."nota_aluno";

create policy nota_aluno_tenant_insert on public."nota_aluno" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists nota_aluno_tenant_update on public."nota_aluno";

create policy nota_aluno_tenant_update on public."nota_aluno" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists nota_aluno_tenant_delete on public."nota_aluno";

create policy nota_aluno_tenant_delete on public."nota_aluno" for delete using (app.has_role('admin_saas'));

drop trigger if exists nota_aluno_audit on public."nota_aluno";

create trigger nota_aluno_audit after insert or update or delete on public."nota_aluno" for each row execute function app.write_audit_event();

create table if not exists public."formula_avaliacao" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_formula_avaliacao_tenant_status on public."formula_avaliacao" (tenant_id, status);

create index if not exists idx_formula_avaliacao_tenant_created on public."formula_avaliacao" (tenant_id, created_at desc);

drop trigger if exists formula_avaliacao_touch_updated_at on public."formula_avaliacao";

create trigger formula_avaliacao_touch_updated_at before update on public."formula_avaliacao" for each row execute function app.touch_updated_at();

alter table public."formula_avaliacao" enable row level security;

drop policy if exists formula_avaliacao_tenant_select on public."formula_avaliacao";

create policy formula_avaliacao_tenant_select on public."formula_avaliacao" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists formula_avaliacao_tenant_insert on public."formula_avaliacao";

create policy formula_avaliacao_tenant_insert on public."formula_avaliacao" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists formula_avaliacao_tenant_update on public."formula_avaliacao";

create policy formula_avaliacao_tenant_update on public."formula_avaliacao" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists formula_avaliacao_tenant_delete on public."formula_avaliacao";

create policy formula_avaliacao_tenant_delete on public."formula_avaliacao" for delete using (app.has_role('admin_saas'));

drop trigger if exists formula_avaliacao_audit on public."formula_avaliacao";

create trigger formula_avaliacao_audit after insert or update or delete on public."formula_avaliacao" for each row execute function app.write_audit_event();

create table if not exists public."boletim" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null,
  "situacao_processamento" varchar(30) null,
  "mensagem_erro" text null
);

create index if not exists idx_boletim_tenant_status on public."boletim" (tenant_id, status);

create index if not exists idx_boletim_tenant_created on public."boletim" (tenant_id, created_at desc);

drop trigger if exists boletim_touch_updated_at on public."boletim";

create trigger boletim_touch_updated_at before update on public."boletim" for each row execute function app.touch_updated_at();

alter table public."boletim" enable row level security;

drop policy if exists boletim_tenant_select on public."boletim";

create policy boletim_tenant_select on public."boletim" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists boletim_tenant_insert on public."boletim";

create policy boletim_tenant_insert on public."boletim" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists boletim_tenant_update on public."boletim";

create policy boletim_tenant_update on public."boletim" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists boletim_tenant_delete on public."boletim";

create policy boletim_tenant_delete on public."boletim" for delete using (app.has_role('admin_saas'));

drop trigger if exists boletim_audit on public."boletim";

create trigger boletim_audit after insert or update or delete on public."boletim" for each row execute function app.write_audit_event();

create table if not exists public."historico_academico" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_historico_academico_tenant_status on public."historico_academico" (tenant_id, status);

create index if not exists idx_historico_academico_tenant_created on public."historico_academico" (tenant_id, created_at desc);

drop trigger if exists historico_academico_touch_updated_at on public."historico_academico";

create trigger historico_academico_touch_updated_at before update on public."historico_academico" for each row execute function app.touch_updated_at();

alter table public."historico_academico" enable row level security;

drop policy if exists historico_academico_tenant_select on public."historico_academico";

create policy historico_academico_tenant_select on public."historico_academico" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists historico_academico_tenant_insert on public."historico_academico";

create policy historico_academico_tenant_insert on public."historico_academico" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists historico_academico_tenant_update on public."historico_academico";

create policy historico_academico_tenant_update on public."historico_academico" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists historico_academico_tenant_delete on public."historico_academico";

create policy historico_academico_tenant_delete on public."historico_academico" for delete using (app.has_role('admin_saas'));

drop trigger if exists historico_academico_audit on public."historico_academico";

create trigger historico_academico_audit after insert or update or delete on public."historico_academico" for each row execute function app.write_audit_event();

create table if not exists public."plano_financeiro" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_plano_financeiro_tenant_status on public."plano_financeiro" (tenant_id, status);

create index if not exists idx_plano_financeiro_tenant_created on public."plano_financeiro" (tenant_id, created_at desc);

drop trigger if exists plano_financeiro_touch_updated_at on public."plano_financeiro";

create trigger plano_financeiro_touch_updated_at before update on public."plano_financeiro" for each row execute function app.touch_updated_at();

alter table public."plano_financeiro" enable row level security;

drop policy if exists plano_financeiro_tenant_select on public."plano_financeiro";

create policy plano_financeiro_tenant_select on public."plano_financeiro" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists plano_financeiro_tenant_insert on public."plano_financeiro";

create policy plano_financeiro_tenant_insert on public."plano_financeiro" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists plano_financeiro_tenant_update on public."plano_financeiro";

create policy plano_financeiro_tenant_update on public."plano_financeiro" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists plano_financeiro_tenant_delete on public."plano_financeiro";

create policy plano_financeiro_tenant_delete on public."plano_financeiro" for delete using (app.has_role('admin_saas'));

drop trigger if exists plano_financeiro_audit on public."plano_financeiro";

create trigger plano_financeiro_audit after insert or update or delete on public."plano_financeiro" for each row execute function app.write_audit_event();

create table if not exists public."conta_receber" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "responsavel_id" uuid null,
  "matricula_id" uuid null,
  "valor_original" numeric(14,2) null,
  "data_vencimento" date null,
  "situacao" varchar(30) null
);

create index if not exists idx_conta_receber_tenant_status on public."conta_receber" (tenant_id, status);

create index if not exists idx_conta_receber_tenant_created on public."conta_receber" (tenant_id, created_at desc);

drop trigger if exists conta_receber_touch_updated_at on public."conta_receber";

create trigger conta_receber_touch_updated_at before update on public."conta_receber" for each row execute function app.touch_updated_at();

alter table public."conta_receber" enable row level security;

drop policy if exists conta_receber_tenant_select on public."conta_receber";

create policy conta_receber_tenant_select on public."conta_receber" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists conta_receber_tenant_insert on public."conta_receber";

create policy conta_receber_tenant_insert on public."conta_receber" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists conta_receber_tenant_update on public."conta_receber";

create policy conta_receber_tenant_update on public."conta_receber" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists conta_receber_tenant_delete on public."conta_receber";

create policy conta_receber_tenant_delete on public."conta_receber" for delete using (app.has_role('admin_saas'));

drop trigger if exists conta_receber_audit on public."conta_receber";

create trigger conta_receber_audit after insert or update or delete on public."conta_receber" for each row execute function app.write_audit_event();

create table if not exists public."parcela_cobranca" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_parcela_cobranca_tenant_status on public."parcela_cobranca" (tenant_id, status);

create index if not exists idx_parcela_cobranca_tenant_created on public."parcela_cobranca" (tenant_id, created_at desc);

drop trigger if exists parcela_cobranca_touch_updated_at on public."parcela_cobranca";

create trigger parcela_cobranca_touch_updated_at before update on public."parcela_cobranca" for each row execute function app.touch_updated_at();

alter table public."parcela_cobranca" enable row level security;

drop policy if exists parcela_cobranca_tenant_select on public."parcela_cobranca";

create policy parcela_cobranca_tenant_select on public."parcela_cobranca" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists parcela_cobranca_tenant_insert on public."parcela_cobranca";

create policy parcela_cobranca_tenant_insert on public."parcela_cobranca" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists parcela_cobranca_tenant_update on public."parcela_cobranca";

create policy parcela_cobranca_tenant_update on public."parcela_cobranca" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists parcela_cobranca_tenant_delete on public."parcela_cobranca";

create policy parcela_cobranca_tenant_delete on public."parcela_cobranca" for delete using (app.has_role('admin_saas'));

drop trigger if exists parcela_cobranca_audit on public."parcela_cobranca";

create trigger parcela_cobranca_audit after insert or update or delete on public."parcela_cobranca" for each row execute function app.write_audit_event();

create table if not exists public."boleto" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null,
  "situacao_processamento" varchar(30) null,
  "mensagem_erro" text null
);

create index if not exists idx_boleto_tenant_status on public."boleto" (tenant_id, status);

create index if not exists idx_boleto_tenant_created on public."boleto" (tenant_id, created_at desc);

drop trigger if exists boleto_touch_updated_at on public."boleto";

create trigger boleto_touch_updated_at before update on public."boleto" for each row execute function app.touch_updated_at();

alter table public."boleto" enable row level security;

drop policy if exists boleto_tenant_select on public."boleto";

create policy boleto_tenant_select on public."boleto" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists boleto_tenant_insert on public."boleto";

create policy boleto_tenant_insert on public."boleto" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists boleto_tenant_update on public."boleto";

create policy boleto_tenant_update on public."boleto" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists boleto_tenant_delete on public."boleto";

create policy boleto_tenant_delete on public."boleto" for delete using (app.has_role('admin_saas'));

drop trigger if exists boleto_audit on public."boleto";

create trigger boleto_audit after insert or update or delete on public."boleto" for each row execute function app.write_audit_event();

create table if not exists public."pagamento" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "conta_receber_id" uuid null,
  "valor_pago" numeric(14,2) null,
  "data_pagamento" date null,
  "meio_pagamento" varchar(30) null
);

create index if not exists idx_pagamento_tenant_status on public."pagamento" (tenant_id, status);

create index if not exists idx_pagamento_tenant_created on public."pagamento" (tenant_id, created_at desc);

drop trigger if exists pagamento_touch_updated_at on public."pagamento";

create trigger pagamento_touch_updated_at before update on public."pagamento" for each row execute function app.touch_updated_at();

alter table public."pagamento" enable row level security;

drop policy if exists pagamento_tenant_select on public."pagamento";

create policy pagamento_tenant_select on public."pagamento" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists pagamento_tenant_insert on public."pagamento";

create policy pagamento_tenant_insert on public."pagamento" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists pagamento_tenant_update on public."pagamento";

create policy pagamento_tenant_update on public."pagamento" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists pagamento_tenant_delete on public."pagamento";

create policy pagamento_tenant_delete on public."pagamento" for delete using (app.has_role('admin_saas'));

drop trigger if exists pagamento_audit on public."pagamento";

create trigger pagamento_audit after insert or update or delete on public."pagamento" for each row execute function app.write_audit_event();

create table if not exists public."baixa_financeira" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null,
  "situacao_processamento" varchar(30) null,
  "mensagem_erro" text null
);

create index if not exists idx_baixa_financeira_tenant_status on public."baixa_financeira" (tenant_id, status);

create index if not exists idx_baixa_financeira_tenant_created on public."baixa_financeira" (tenant_id, created_at desc);

drop trigger if exists baixa_financeira_touch_updated_at on public."baixa_financeira";

create trigger baixa_financeira_touch_updated_at before update on public."baixa_financeira" for each row execute function app.touch_updated_at();

alter table public."baixa_financeira" enable row level security;

drop policy if exists baixa_financeira_tenant_select on public."baixa_financeira";

create policy baixa_financeira_tenant_select on public."baixa_financeira" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists baixa_financeira_tenant_insert on public."baixa_financeira";

create policy baixa_financeira_tenant_insert on public."baixa_financeira" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists baixa_financeira_tenant_update on public."baixa_financeira";

create policy baixa_financeira_tenant_update on public."baixa_financeira" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists baixa_financeira_tenant_delete on public."baixa_financeira";

create policy baixa_financeira_tenant_delete on public."baixa_financeira" for delete using (app.has_role('admin_saas'));

drop trigger if exists baixa_financeira_audit on public."baixa_financeira";

create trigger baixa_financeira_audit after insert or update or delete on public."baixa_financeira" for each row execute function app.write_audit_event();

create table if not exists public."inadimplencia" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null,
  "situacao_processamento" varchar(30) null,
  "mensagem_erro" text null
);

create index if not exists idx_inadimplencia_tenant_status on public."inadimplencia" (tenant_id, status);

create index if not exists idx_inadimplencia_tenant_created on public."inadimplencia" (tenant_id, created_at desc);

drop trigger if exists inadimplencia_touch_updated_at on public."inadimplencia";

create trigger inadimplencia_touch_updated_at before update on public."inadimplencia" for each row execute function app.touch_updated_at();

alter table public."inadimplencia" enable row level security;

drop policy if exists inadimplencia_tenant_select on public."inadimplencia";

create policy inadimplencia_tenant_select on public."inadimplencia" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists inadimplencia_tenant_insert on public."inadimplencia";

create policy inadimplencia_tenant_insert on public."inadimplencia" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists inadimplencia_tenant_update on public."inadimplencia";

create policy inadimplencia_tenant_update on public."inadimplencia" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists inadimplencia_tenant_delete on public."inadimplencia";

create policy inadimplencia_tenant_delete on public."inadimplencia" for delete using (app.has_role('admin_saas'));

drop trigger if exists inadimplencia_audit on public."inadimplencia";

create trigger inadimplencia_audit after insert or update or delete on public."inadimplencia" for each row execute function app.write_audit_event();

create table if not exists public."renegociacao" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null,
  "situacao_processamento" varchar(30) null,
  "mensagem_erro" text null
);

create index if not exists idx_renegociacao_tenant_status on public."renegociacao" (tenant_id, status);

create index if not exists idx_renegociacao_tenant_created on public."renegociacao" (tenant_id, created_at desc);

drop trigger if exists renegociacao_touch_updated_at on public."renegociacao";

create trigger renegociacao_touch_updated_at before update on public."renegociacao" for each row execute function app.touch_updated_at();

alter table public."renegociacao" enable row level security;

drop policy if exists renegociacao_tenant_select on public."renegociacao";

create policy renegociacao_tenant_select on public."renegociacao" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists renegociacao_tenant_insert on public."renegociacao";

create policy renegociacao_tenant_insert on public."renegociacao" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists renegociacao_tenant_update on public."renegociacao";

create policy renegociacao_tenant_update on public."renegociacao" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists renegociacao_tenant_delete on public."renegociacao";

create policy renegociacao_tenant_delete on public."renegociacao" for delete using (app.has_role('admin_saas'));

drop trigger if exists renegociacao_audit on public."renegociacao";

create trigger renegociacao_audit after insert or update or delete on public."renegociacao" for each row execute function app.write_audit_event();

create table if not exists public."desconto_bolsa" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_desconto_bolsa_tenant_status on public."desconto_bolsa" (tenant_id, status);

create index if not exists idx_desconto_bolsa_tenant_created on public."desconto_bolsa" (tenant_id, created_at desc);

drop trigger if exists desconto_bolsa_touch_updated_at on public."desconto_bolsa";

create trigger desconto_bolsa_touch_updated_at before update on public."desconto_bolsa" for each row execute function app.touch_updated_at();

alter table public."desconto_bolsa" enable row level security;

drop policy if exists desconto_bolsa_tenant_select on public."desconto_bolsa";

create policy desconto_bolsa_tenant_select on public."desconto_bolsa" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists desconto_bolsa_tenant_insert on public."desconto_bolsa";

create policy desconto_bolsa_tenant_insert on public."desconto_bolsa" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists desconto_bolsa_tenant_update on public."desconto_bolsa";

create policy desconto_bolsa_tenant_update on public."desconto_bolsa" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists desconto_bolsa_tenant_delete on public."desconto_bolsa";

create policy desconto_bolsa_tenant_delete on public."desconto_bolsa" for delete using (app.has_role('admin_saas'));

drop trigger if exists desconto_bolsa_audit on public."desconto_bolsa";

create trigger desconto_bolsa_audit after insert or update or delete on public."desconto_bolsa" for each row execute function app.write_audit_event();

create table if not exists public."conta_contabil_categoria" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_conta_contabil_categoria_tenant_status on public."conta_contabil_categoria" (tenant_id, status);

create index if not exists idx_conta_contabil_categoria_tenant_created on public."conta_contabil_categoria" (tenant_id, created_at desc);

drop trigger if exists conta_contabil_categoria_touch_updated_at on public."conta_contabil_categoria";

create trigger conta_contabil_categoria_touch_updated_at before update on public."conta_contabil_categoria" for each row execute function app.touch_updated_at();

alter table public."conta_contabil_categoria" enable row level security;

drop policy if exists conta_contabil_categoria_tenant_select on public."conta_contabil_categoria";

create policy conta_contabil_categoria_tenant_select on public."conta_contabil_categoria" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists conta_contabil_categoria_tenant_insert on public."conta_contabil_categoria";

create policy conta_contabil_categoria_tenant_insert on public."conta_contabil_categoria" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists conta_contabil_categoria_tenant_update on public."conta_contabil_categoria";

create policy conta_contabil_categoria_tenant_update on public."conta_contabil_categoria" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists conta_contabil_categoria_tenant_delete on public."conta_contabil_categoria";

create policy conta_contabil_categoria_tenant_delete on public."conta_contabil_categoria" for delete using (app.has_role('admin_saas'));

drop trigger if exists conta_contabil_categoria_audit on public."conta_contabil_categoria";

create trigger conta_contabil_categoria_audit after insert or update or delete on public."conta_contabil_categoria" for each row execute function app.write_audit_event();

create table if not exists public."nota_fiscal_servico" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "numero_nfse" varchar(50) null,
  "codigo_servico" varchar(30) null,
  "aliquota_iss" numeric(14,2) null
);

create index if not exists idx_nota_fiscal_servico_tenant_status on public."nota_fiscal_servico" (tenant_id, status);

create index if not exists idx_nota_fiscal_servico_tenant_created on public."nota_fiscal_servico" (tenant_id, created_at desc);

drop trigger if exists nota_fiscal_servico_touch_updated_at on public."nota_fiscal_servico";

create trigger nota_fiscal_servico_touch_updated_at before update on public."nota_fiscal_servico" for each row execute function app.touch_updated_at();

alter table public."nota_fiscal_servico" enable row level security;

drop policy if exists nota_fiscal_servico_tenant_select on public."nota_fiscal_servico";

create policy nota_fiscal_servico_tenant_select on public."nota_fiscal_servico" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists nota_fiscal_servico_tenant_insert on public."nota_fiscal_servico";

create policy nota_fiscal_servico_tenant_insert on public."nota_fiscal_servico" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists nota_fiscal_servico_tenant_update on public."nota_fiscal_servico";

create policy nota_fiscal_servico_tenant_update on public."nota_fiscal_servico" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists nota_fiscal_servico_tenant_delete on public."nota_fiscal_servico";

create policy nota_fiscal_servico_tenant_delete on public."nota_fiscal_servico" for delete using (app.has_role('admin_saas'));

drop trigger if exists nota_fiscal_servico_audit on public."nota_fiscal_servico";

create trigger nota_fiscal_servico_audit after insert or update or delete on public."nota_fiscal_servico" for each row execute function app.write_audit_event();

create table if not exists public."configuracao_fiscal" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null,
  "municipio_competencia" varchar(100) null,
  "regime_tributario" varchar(50) null
);

create index if not exists idx_configuracao_fiscal_tenant_status on public."configuracao_fiscal" (tenant_id, status);

create index if not exists idx_configuracao_fiscal_tenant_created on public."configuracao_fiscal" (tenant_id, created_at desc);

drop trigger if exists configuracao_fiscal_touch_updated_at on public."configuracao_fiscal";

create trigger configuracao_fiscal_touch_updated_at before update on public."configuracao_fiscal" for each row execute function app.touch_updated_at();

alter table public."configuracao_fiscal" enable row level security;

drop policy if exists configuracao_fiscal_tenant_select on public."configuracao_fiscal";

create policy configuracao_fiscal_tenant_select on public."configuracao_fiscal" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists configuracao_fiscal_tenant_insert on public."configuracao_fiscal";

create policy configuracao_fiscal_tenant_insert on public."configuracao_fiscal" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists configuracao_fiscal_tenant_update on public."configuracao_fiscal";

create policy configuracao_fiscal_tenant_update on public."configuracao_fiscal" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists configuracao_fiscal_tenant_delete on public."configuracao_fiscal";

create policy configuracao_fiscal_tenant_delete on public."configuracao_fiscal" for delete using (app.has_role('admin_saas'));

drop trigger if exists configuracao_fiscal_audit on public."configuracao_fiscal";

create trigger configuracao_fiscal_audit after insert or update or delete on public."configuracao_fiscal" for each row execute function app.write_audit_event();

create table if not exists public."comunicado" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "titulo" varchar(180) null,
  "conteudo" text null,
  "canal" varchar(30) null,
  "data_envio" timestamptz null
);

create index if not exists idx_comunicado_tenant_status on public."comunicado" (tenant_id, status);

create index if not exists idx_comunicado_tenant_created on public."comunicado" (tenant_id, created_at desc);

drop trigger if exists comunicado_touch_updated_at on public."comunicado";

create trigger comunicado_touch_updated_at before update on public."comunicado" for each row execute function app.touch_updated_at();

alter table public."comunicado" enable row level security;

drop policy if exists comunicado_tenant_select on public."comunicado";

create policy comunicado_tenant_select on public."comunicado" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists comunicado_tenant_insert on public."comunicado";

create policy comunicado_tenant_insert on public."comunicado" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists comunicado_tenant_update on public."comunicado";

create policy comunicado_tenant_update on public."comunicado" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists comunicado_tenant_delete on public."comunicado";

create policy comunicado_tenant_delete on public."comunicado" for delete using (app.has_role('admin_saas'));

drop trigger if exists comunicado_audit on public."comunicado";

create trigger comunicado_audit after insert or update or delete on public."comunicado" for each row execute function app.write_audit_event();

create table if not exists public."mensagem" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_mensagem_tenant_status on public."mensagem" (tenant_id, status);

create index if not exists idx_mensagem_tenant_created on public."mensagem" (tenant_id, created_at desc);

drop trigger if exists mensagem_touch_updated_at on public."mensagem";

create trigger mensagem_touch_updated_at before update on public."mensagem" for each row execute function app.touch_updated_at();

alter table public."mensagem" enable row level security;

drop policy if exists mensagem_tenant_select on public."mensagem";

create policy mensagem_tenant_select on public."mensagem" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists mensagem_tenant_insert on public."mensagem";

create policy mensagem_tenant_insert on public."mensagem" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists mensagem_tenant_update on public."mensagem";

create policy mensagem_tenant_update on public."mensagem" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists mensagem_tenant_delete on public."mensagem";

create policy mensagem_tenant_delete on public."mensagem" for delete using (app.has_role('admin_saas'));

drop trigger if exists mensagem_audit on public."mensagem";

create trigger mensagem_audit after insert or update or delete on public."mensagem" for each row execute function app.write_audit_event();

create table if not exists public."conversa" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_conversa_tenant_status on public."conversa" (tenant_id, status);

create index if not exists idx_conversa_tenant_created on public."conversa" (tenant_id, created_at desc);

drop trigger if exists conversa_touch_updated_at on public."conversa";

create trigger conversa_touch_updated_at before update on public."conversa" for each row execute function app.touch_updated_at();

alter table public."conversa" enable row level security;

drop policy if exists conversa_tenant_select on public."conversa";

create policy conversa_tenant_select on public."conversa" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists conversa_tenant_insert on public."conversa";

create policy conversa_tenant_insert on public."conversa" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists conversa_tenant_update on public."conversa";

create policy conversa_tenant_update on public."conversa" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists conversa_tenant_delete on public."conversa";

create policy conversa_tenant_delete on public."conversa" for delete using (app.has_role('admin_saas'));

drop trigger if exists conversa_audit on public."conversa";

create trigger conversa_audit after insert or update or delete on public."conversa" for each row execute function app.write_audit_event();

create table if not exists public."destinatario_comunicacao" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "nome" varchar(180) null,
  "descricao" text null,
  "origem_id" uuid null,
  "destino_id" uuid null,
  "data_inicio" date null,
  "data_fim" date null
);

create index if not exists idx_destinatario_comunicacao_tenant_status on public."destinatario_comunicacao" (tenant_id, status);

create index if not exists idx_destinatario_comunicacao_tenant_created on public."destinatario_comunicacao" (tenant_id, created_at desc);

drop trigger if exists destinatario_comunicacao_touch_updated_at on public."destinatario_comunicacao";

create trigger destinatario_comunicacao_touch_updated_at before update on public."destinatario_comunicacao" for each row execute function app.touch_updated_at();

alter table public."destinatario_comunicacao" enable row level security;

drop policy if exists destinatario_comunicacao_tenant_select on public."destinatario_comunicacao";

create policy destinatario_comunicacao_tenant_select on public."destinatario_comunicacao" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists destinatario_comunicacao_tenant_insert on public."destinatario_comunicacao";

create policy destinatario_comunicacao_tenant_insert on public."destinatario_comunicacao" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists destinatario_comunicacao_tenant_update on public."destinatario_comunicacao";

create policy destinatario_comunicacao_tenant_update on public."destinatario_comunicacao" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists destinatario_comunicacao_tenant_delete on public."destinatario_comunicacao";

create policy destinatario_comunicacao_tenant_delete on public."destinatario_comunicacao" for delete using (app.has_role('admin_saas'));

drop trigger if exists destinatario_comunicacao_audit on public."destinatario_comunicacao";

create trigger destinatario_comunicacao_audit after insert or update or delete on public."destinatario_comunicacao" for each row execute function app.write_audit_event();

create table if not exists public."confirmacao_leitura" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "nome" varchar(180) null,
  "descricao" text null,
  "evento" varchar(80) null
);

create index if not exists idx_confirmacao_leitura_tenant_status on public."confirmacao_leitura" (tenant_id, status);

create index if not exists idx_confirmacao_leitura_tenant_created on public."confirmacao_leitura" (tenant_id, created_at desc);

drop trigger if exists confirmacao_leitura_touch_updated_at on public."confirmacao_leitura";

create trigger confirmacao_leitura_touch_updated_at before update on public."confirmacao_leitura" for each row execute function app.touch_updated_at();

alter table public."confirmacao_leitura" enable row level security;

drop policy if exists confirmacao_leitura_tenant_select on public."confirmacao_leitura";

create policy confirmacao_leitura_tenant_select on public."confirmacao_leitura" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists confirmacao_leitura_tenant_insert on public."confirmacao_leitura";

create policy confirmacao_leitura_tenant_insert on public."confirmacao_leitura" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists confirmacao_leitura_tenant_update on public."confirmacao_leitura";

create policy confirmacao_leitura_tenant_update on public."confirmacao_leitura" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists confirmacao_leitura_tenant_delete on public."confirmacao_leitura";

create policy confirmacao_leitura_tenant_delete on public."confirmacao_leitura" for delete using (app.has_role('admin_saas'));

drop trigger if exists confirmacao_leitura_audit on public."confirmacao_leitura";

create trigger confirmacao_leitura_audit after insert or update or delete on public."confirmacao_leitura" for each row execute function app.write_audit_event();

create table if not exists public."template_mensagem" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_template_mensagem_tenant_status on public."template_mensagem" (tenant_id, status);

create index if not exists idx_template_mensagem_tenant_created on public."template_mensagem" (tenant_id, created_at desc);

drop trigger if exists template_mensagem_touch_updated_at on public."template_mensagem";

create trigger template_mensagem_touch_updated_at before update on public."template_mensagem" for each row execute function app.touch_updated_at();

alter table public."template_mensagem" enable row level security;

drop policy if exists template_mensagem_tenant_select on public."template_mensagem";

create policy template_mensagem_tenant_select on public."template_mensagem" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists template_mensagem_tenant_insert on public."template_mensagem";

create policy template_mensagem_tenant_insert on public."template_mensagem" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists template_mensagem_tenant_update on public."template_mensagem";

create policy template_mensagem_tenant_update on public."template_mensagem" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists template_mensagem_tenant_delete on public."template_mensagem";

create policy template_mensagem_tenant_delete on public."template_mensagem" for delete using (app.has_role('admin_saas'));

drop trigger if exists template_mensagem_audit on public."template_mensagem";

create trigger template_mensagem_audit after insert or update or delete on public."template_mensagem" for each row execute function app.write_audit_event();

create table if not exists public."preferencia_comunicacao" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_preferencia_comunicacao_tenant_status on public."preferencia_comunicacao" (tenant_id, status);

create index if not exists idx_preferencia_comunicacao_tenant_created on public."preferencia_comunicacao" (tenant_id, created_at desc);

drop trigger if exists preferencia_comunicacao_touch_updated_at on public."preferencia_comunicacao";

create trigger preferencia_comunicacao_touch_updated_at before update on public."preferencia_comunicacao" for each row execute function app.touch_updated_at();

alter table public."preferencia_comunicacao" enable row level security;

drop policy if exists preferencia_comunicacao_tenant_select on public."preferencia_comunicacao";

create policy preferencia_comunicacao_tenant_select on public."preferencia_comunicacao" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists preferencia_comunicacao_tenant_insert on public."preferencia_comunicacao";

create policy preferencia_comunicacao_tenant_insert on public."preferencia_comunicacao" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists preferencia_comunicacao_tenant_update on public."preferencia_comunicacao";

create policy preferencia_comunicacao_tenant_update on public."preferencia_comunicacao" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists preferencia_comunicacao_tenant_delete on public."preferencia_comunicacao";

create policy preferencia_comunicacao_tenant_delete on public."preferencia_comunicacao" for delete using (app.has_role('admin_saas'));

drop trigger if exists preferencia_comunicacao_audit on public."preferencia_comunicacao";

create trigger preferencia_comunicacao_audit after insert or update or delete on public."preferencia_comunicacao" for each row execute function app.write_audit_event();

create table if not exists public."usuario" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "nome" varchar(150) null,
  "email" varchar(180) null,
  "senha_hash" varchar(255) null,
  "mfa_habilitado" boolean default false null
);

create index if not exists idx_usuario_tenant_status on public."usuario" (tenant_id, status);

create index if not exists idx_usuario_tenant_created on public."usuario" (tenant_id, created_at desc);

drop trigger if exists usuario_touch_updated_at on public."usuario";

create trigger usuario_touch_updated_at before update on public."usuario" for each row execute function app.touch_updated_at();

alter table public."usuario" enable row level security;

drop policy if exists usuario_tenant_select on public."usuario";

create policy usuario_tenant_select on public."usuario" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists usuario_tenant_insert on public."usuario";

create policy usuario_tenant_insert on public."usuario" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists usuario_tenant_update on public."usuario";

create policy usuario_tenant_update on public."usuario" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists usuario_tenant_delete on public."usuario";

create policy usuario_tenant_delete on public."usuario" for delete using (app.has_role('admin_saas'));

drop trigger if exists usuario_audit on public."usuario";

create trigger usuario_audit after insert or update or delete on public."usuario" for each row execute function app.write_audit_event();

create table if not exists public."perfil_acesso" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_perfil_acesso_tenant_status on public."perfil_acesso" (tenant_id, status);

create index if not exists idx_perfil_acesso_tenant_created on public."perfil_acesso" (tenant_id, created_at desc);

drop trigger if exists perfil_acesso_touch_updated_at on public."perfil_acesso";

create trigger perfil_acesso_touch_updated_at before update on public."perfil_acesso" for each row execute function app.touch_updated_at();

alter table public."perfil_acesso" enable row level security;

drop policy if exists perfil_acesso_tenant_select on public."perfil_acesso";

create policy perfil_acesso_tenant_select on public."perfil_acesso" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists perfil_acesso_tenant_insert on public."perfil_acesso";

create policy perfil_acesso_tenant_insert on public."perfil_acesso" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists perfil_acesso_tenant_update on public."perfil_acesso";

create policy perfil_acesso_tenant_update on public."perfil_acesso" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists perfil_acesso_tenant_delete on public."perfil_acesso";

create policy perfil_acesso_tenant_delete on public."perfil_acesso" for delete using (app.has_role('admin_saas'));

drop trigger if exists perfil_acesso_audit on public."perfil_acesso";

create trigger perfil_acesso_audit after insert or update or delete on public."perfil_acesso" for each row execute function app.write_audit_event();

create table if not exists public."permissao" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_permissao_tenant_status on public."permissao" (tenant_id, status);

create index if not exists idx_permissao_tenant_created on public."permissao" (tenant_id, created_at desc);

drop trigger if exists permissao_touch_updated_at on public."permissao";

create trigger permissao_touch_updated_at before update on public."permissao" for each row execute function app.touch_updated_at();

alter table public."permissao" enable row level security;

drop policy if exists permissao_tenant_select on public."permissao";

create policy permissao_tenant_select on public."permissao" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists permissao_tenant_insert on public."permissao";

create policy permissao_tenant_insert on public."permissao" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists permissao_tenant_update on public."permissao";

create policy permissao_tenant_update on public."permissao" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists permissao_tenant_delete on public."permissao";

create policy permissao_tenant_delete on public."permissao" for delete using (app.has_role('admin_saas'));

drop trigger if exists permissao_audit on public."permissao";

create trigger permissao_audit after insert or update or delete on public."permissao" for each row execute function app.write_audit_event();

create table if not exists public."usuario_perfil" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "nome" varchar(180) null,
  "descricao" text null,
  "origem_id" uuid null,
  "destino_id" uuid null,
  "data_inicio" date null,
  "data_fim" date null
);

create index if not exists idx_usuario_perfil_tenant_status on public."usuario_perfil" (tenant_id, status);

create index if not exists idx_usuario_perfil_tenant_created on public."usuario_perfil" (tenant_id, created_at desc);

drop trigger if exists usuario_perfil_touch_updated_at on public."usuario_perfil";

create trigger usuario_perfil_touch_updated_at before update on public."usuario_perfil" for each row execute function app.touch_updated_at();

alter table public."usuario_perfil" enable row level security;

drop policy if exists usuario_perfil_tenant_select on public."usuario_perfil";

create policy usuario_perfil_tenant_select on public."usuario_perfil" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists usuario_perfil_tenant_insert on public."usuario_perfil";

create policy usuario_perfil_tenant_insert on public."usuario_perfil" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists usuario_perfil_tenant_update on public."usuario_perfil";

create policy usuario_perfil_tenant_update on public."usuario_perfil" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists usuario_perfil_tenant_delete on public."usuario_perfil";

create policy usuario_perfil_tenant_delete on public."usuario_perfil" for delete using (app.has_role('admin_saas'));

drop trigger if exists usuario_perfil_audit on public."usuario_perfil";

create trigger usuario_perfil_audit after insert or update or delete on public."usuario_perfil" for each row execute function app.write_audit_event();

create table if not exists public."sessao_usuario" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_sessao_usuario_tenant_status on public."sessao_usuario" (tenant_id, status);

create index if not exists idx_sessao_usuario_tenant_created on public."sessao_usuario" (tenant_id, created_at desc);

drop trigger if exists sessao_usuario_touch_updated_at on public."sessao_usuario";

create trigger sessao_usuario_touch_updated_at before update on public."sessao_usuario" for each row execute function app.touch_updated_at();

alter table public."sessao_usuario" enable row level security;

drop policy if exists sessao_usuario_tenant_select on public."sessao_usuario";

create policy sessao_usuario_tenant_select on public."sessao_usuario" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists sessao_usuario_tenant_insert on public."sessao_usuario";

create policy sessao_usuario_tenant_insert on public."sessao_usuario" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists sessao_usuario_tenant_update on public."sessao_usuario";

create policy sessao_usuario_tenant_update on public."sessao_usuario" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists sessao_usuario_tenant_delete on public."sessao_usuario";

create policy sessao_usuario_tenant_delete on public."sessao_usuario" for delete using (app.has_role('admin_saas'));

drop trigger if exists sessao_usuario_audit on public."sessao_usuario";

create trigger sessao_usuario_audit after insert or update or delete on public."sessao_usuario" for each row execute function app.write_audit_event();

create table if not exists public."convite_usuario" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null,
  "situacao_processamento" varchar(30) null,
  "mensagem_erro" text null
);

create index if not exists idx_convite_usuario_tenant_status on public."convite_usuario" (tenant_id, status);

create index if not exists idx_convite_usuario_tenant_created on public."convite_usuario" (tenant_id, created_at desc);

drop trigger if exists convite_usuario_touch_updated_at on public."convite_usuario";

create trigger convite_usuario_touch_updated_at before update on public."convite_usuario" for each row execute function app.touch_updated_at();

alter table public."convite_usuario" enable row level security;

drop policy if exists convite_usuario_tenant_select on public."convite_usuario";

create policy convite_usuario_tenant_select on public."convite_usuario" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists convite_usuario_tenant_insert on public."convite_usuario";

create policy convite_usuario_tenant_insert on public."convite_usuario" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists convite_usuario_tenant_update on public."convite_usuario";

create policy convite_usuario_tenant_update on public."convite_usuario" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists convite_usuario_tenant_delete on public."convite_usuario";

create policy convite_usuario_tenant_delete on public."convite_usuario" for delete using (app.has_role('admin_saas'));

drop trigger if exists convite_usuario_audit on public."convite_usuario";

create trigger convite_usuario_audit after insert or update or delete on public."convite_usuario" for each row execute function app.write_audit_event();

create table if not exists public."termo_consentimento" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "tipo" varchar(50) null,
  "versao" varchar(20) null,
  "texto" text null
);

create index if not exists idx_termo_consentimento_tenant_status on public."termo_consentimento" (tenant_id, status);

create index if not exists idx_termo_consentimento_tenant_created on public."termo_consentimento" (tenant_id, created_at desc);

drop trigger if exists termo_consentimento_touch_updated_at on public."termo_consentimento";

create trigger termo_consentimento_touch_updated_at before update on public."termo_consentimento" for each row execute function app.touch_updated_at();

alter table public."termo_consentimento" enable row level security;

drop policy if exists termo_consentimento_tenant_select on public."termo_consentimento";

create policy termo_consentimento_tenant_select on public."termo_consentimento" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists termo_consentimento_tenant_insert on public."termo_consentimento";

create policy termo_consentimento_tenant_insert on public."termo_consentimento" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists termo_consentimento_tenant_update on public."termo_consentimento";

create policy termo_consentimento_tenant_update on public."termo_consentimento" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists termo_consentimento_tenant_delete on public."termo_consentimento";

create policy termo_consentimento_tenant_delete on public."termo_consentimento" for delete using (app.has_role('admin_saas'));

drop trigger if exists termo_consentimento_audit on public."termo_consentimento";

create trigger termo_consentimento_audit after insert or update or delete on public."termo_consentimento" for each row execute function app.write_audit_event();

create table if not exists public."registro_consentimento" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "titular_id" uuid null,
  "responsavel_id" uuid null,
  "termo_consentimento_id" uuid null,
  "aceito" boolean default false null,
  "data_resposta" timestamptz null
);

create index if not exists idx_registro_consentimento_tenant_status on public."registro_consentimento" (tenant_id, status);

create index if not exists idx_registro_consentimento_tenant_created on public."registro_consentimento" (tenant_id, created_at desc);

drop trigger if exists registro_consentimento_touch_updated_at on public."registro_consentimento";

create trigger registro_consentimento_touch_updated_at before update on public."registro_consentimento" for each row execute function app.touch_updated_at();

alter table public."registro_consentimento" enable row level security;

drop policy if exists registro_consentimento_tenant_select on public."registro_consentimento";

create policy registro_consentimento_tenant_select on public."registro_consentimento" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists registro_consentimento_tenant_insert on public."registro_consentimento";

create policy registro_consentimento_tenant_insert on public."registro_consentimento" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists registro_consentimento_tenant_update on public."registro_consentimento";

create policy registro_consentimento_tenant_update on public."registro_consentimento" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists registro_consentimento_tenant_delete on public."registro_consentimento";

create policy registro_consentimento_tenant_delete on public."registro_consentimento" for delete using (app.has_role('admin_saas'));

drop trigger if exists registro_consentimento_audit on public."registro_consentimento";

create trigger registro_consentimento_audit after insert or update or delete on public."registro_consentimento" for each row execute function app.write_audit_event();

create table if not exists public."solicitacao_titular_lgpd" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_solicitacao_titular_lgpd_tenant_status on public."solicitacao_titular_lgpd" (tenant_id, status);

create index if not exists idx_solicitacao_titular_lgpd_tenant_created on public."solicitacao_titular_lgpd" (tenant_id, created_at desc);

drop trigger if exists solicitacao_titular_lgpd_touch_updated_at on public."solicitacao_titular_lgpd";

create trigger solicitacao_titular_lgpd_touch_updated_at before update on public."solicitacao_titular_lgpd" for each row execute function app.touch_updated_at();

alter table public."solicitacao_titular_lgpd" enable row level security;

drop policy if exists solicitacao_titular_lgpd_tenant_select on public."solicitacao_titular_lgpd";

create policy solicitacao_titular_lgpd_tenant_select on public."solicitacao_titular_lgpd" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists solicitacao_titular_lgpd_tenant_insert on public."solicitacao_titular_lgpd";

create policy solicitacao_titular_lgpd_tenant_insert on public."solicitacao_titular_lgpd" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists solicitacao_titular_lgpd_tenant_update on public."solicitacao_titular_lgpd";

create policy solicitacao_titular_lgpd_tenant_update on public."solicitacao_titular_lgpd" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists solicitacao_titular_lgpd_tenant_delete on public."solicitacao_titular_lgpd";

create policy solicitacao_titular_lgpd_tenant_delete on public."solicitacao_titular_lgpd" for delete using (app.has_role('admin_saas'));

drop trigger if exists solicitacao_titular_lgpd_audit on public."solicitacao_titular_lgpd";

create trigger solicitacao_titular_lgpd_audit after insert or update or delete on public."solicitacao_titular_lgpd" for each row execute function app.write_audit_event();

create table if not exists public."inventario_dados" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_inventario_dados_tenant_status on public."inventario_dados" (tenant_id, status);

create index if not exists idx_inventario_dados_tenant_created on public."inventario_dados" (tenant_id, created_at desc);

drop trigger if exists inventario_dados_touch_updated_at on public."inventario_dados";

create trigger inventario_dados_touch_updated_at before update on public."inventario_dados" for each row execute function app.touch_updated_at();

alter table public."inventario_dados" enable row level security;

drop policy if exists inventario_dados_tenant_select on public."inventario_dados";

create policy inventario_dados_tenant_select on public."inventario_dados" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists inventario_dados_tenant_insert on public."inventario_dados";

create policy inventario_dados_tenant_insert on public."inventario_dados" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists inventario_dados_tenant_update on public."inventario_dados";

create policy inventario_dados_tenant_update on public."inventario_dados" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists inventario_dados_tenant_delete on public."inventario_dados";

create policy inventario_dados_tenant_delete on public."inventario_dados" for delete using (app.has_role('admin_saas'));

drop trigger if exists inventario_dados_audit on public."inventario_dados";

create trigger inventario_dados_audit after insert or update or delete on public."inventario_dados" for each row execute function app.write_audit_event();

create table if not exists public."log_auditoria" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "entidade" varchar(100) null,
  "registro_id" uuid null,
  "acao" varchar(30) null,
  "ip_origem" varchar(45) null
);

create index if not exists idx_log_auditoria_tenant_status on public."log_auditoria" (tenant_id, status);

create index if not exists idx_log_auditoria_tenant_created on public."log_auditoria" (tenant_id, created_at desc);

drop trigger if exists log_auditoria_touch_updated_at on public."log_auditoria";

create trigger log_auditoria_touch_updated_at before update on public."log_auditoria" for each row execute function app.touch_updated_at();

alter table public."log_auditoria" enable row level security;

drop policy if exists log_auditoria_tenant_select on public."log_auditoria";

create policy log_auditoria_tenant_select on public."log_auditoria" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists log_auditoria_tenant_insert on public."log_auditoria";

create policy log_auditoria_tenant_insert on public."log_auditoria" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists log_auditoria_tenant_update on public."log_auditoria";

create policy log_auditoria_tenant_update on public."log_auditoria" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists log_auditoria_tenant_delete on public."log_auditoria";

create policy log_auditoria_tenant_delete on public."log_auditoria" for delete using (app.has_role('admin_saas'));

drop trigger if exists log_auditoria_audit on public."log_auditoria";

create trigger log_auditoria_audit after insert or update or delete on public."log_auditoria" for each row execute function app.write_audit_event();

create table if not exists public."exportacao_dados" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "nome" varchar(180) null,
  "descricao" text null,
  "evento" varchar(80) null
);

create index if not exists idx_exportacao_dados_tenant_status on public."exportacao_dados" (tenant_id, status);

create index if not exists idx_exportacao_dados_tenant_created on public."exportacao_dados" (tenant_id, created_at desc);

drop trigger if exists exportacao_dados_touch_updated_at on public."exportacao_dados";

create trigger exportacao_dados_touch_updated_at before update on public."exportacao_dados" for each row execute function app.touch_updated_at();

alter table public."exportacao_dados" enable row level security;

drop policy if exists exportacao_dados_tenant_select on public."exportacao_dados";

create policy exportacao_dados_tenant_select on public."exportacao_dados" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists exportacao_dados_tenant_insert on public."exportacao_dados";

create policy exportacao_dados_tenant_insert on public."exportacao_dados" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists exportacao_dados_tenant_update on public."exportacao_dados";

create policy exportacao_dados_tenant_update on public."exportacao_dados" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists exportacao_dados_tenant_delete on public."exportacao_dados";

create policy exportacao_dados_tenant_delete on public."exportacao_dados" for delete using (app.has_role('admin_saas'));

drop trigger if exists exportacao_dados_audit on public."exportacao_dados";

create trigger exportacao_dados_audit after insert or update or delete on public."exportacao_dados" for each row execute function app.write_audit_event();

create table if not exists public."integracao_externa" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null,
  "situacao_processamento" varchar(30) null,
  "mensagem_erro" text null
);

create index if not exists idx_integracao_externa_tenant_status on public."integracao_externa" (tenant_id, status);

create index if not exists idx_integracao_externa_tenant_created on public."integracao_externa" (tenant_id, created_at desc);

drop trigger if exists integracao_externa_touch_updated_at on public."integracao_externa";

create trigger integracao_externa_touch_updated_at before update on public."integracao_externa" for each row execute function app.touch_updated_at();

alter table public."integracao_externa" enable row level security;

drop policy if exists integracao_externa_tenant_select on public."integracao_externa";

create policy integracao_externa_tenant_select on public."integracao_externa" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists integracao_externa_tenant_insert on public."integracao_externa";

create policy integracao_externa_tenant_insert on public."integracao_externa" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists integracao_externa_tenant_update on public."integracao_externa";

create policy integracao_externa_tenant_update on public."integracao_externa" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists integracao_externa_tenant_delete on public."integracao_externa";

create policy integracao_externa_tenant_delete on public."integracao_externa" for delete using (app.has_role('admin_saas'));

drop trigger if exists integracao_externa_audit on public."integracao_externa";

create trigger integracao_externa_audit after insert or update or delete on public."integracao_externa" for each row execute function app.write_audit_event();

create table if not exists public."evento_integracao" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null,
  "situacao_processamento" varchar(30) null,
  "mensagem_erro" text null
);

create index if not exists idx_evento_integracao_tenant_status on public."evento_integracao" (tenant_id, status);

create index if not exists idx_evento_integracao_tenant_created on public."evento_integracao" (tenant_id, created_at desc);

drop trigger if exists evento_integracao_touch_updated_at on public."evento_integracao";

create trigger evento_integracao_touch_updated_at before update on public."evento_integracao" for each row execute function app.touch_updated_at();

alter table public."evento_integracao" enable row level security;

drop policy if exists evento_integracao_tenant_select on public."evento_integracao";

create policy evento_integracao_tenant_select on public."evento_integracao" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists evento_integracao_tenant_insert on public."evento_integracao";

create policy evento_integracao_tenant_insert on public."evento_integracao" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists evento_integracao_tenant_update on public."evento_integracao";

create policy evento_integracao_tenant_update on public."evento_integracao" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists evento_integracao_tenant_delete on public."evento_integracao";

create policy evento_integracao_tenant_delete on public."evento_integracao" for delete using (app.has_role('admin_saas'));

drop trigger if exists evento_integracao_audit on public."evento_integracao";

create trigger evento_integracao_audit after insert or update or delete on public."evento_integracao" for each row execute function app.write_audit_event();

create table if not exists public."credencial_integracao" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null,
  "situacao_processamento" varchar(30) null,
  "mensagem_erro" text null
);

create index if not exists idx_credencial_integracao_tenant_status on public."credencial_integracao" (tenant_id, status);

create index if not exists idx_credencial_integracao_tenant_created on public."credencial_integracao" (tenant_id, created_at desc);

drop trigger if exists credencial_integracao_touch_updated_at on public."credencial_integracao";

create trigger credencial_integracao_touch_updated_at before update on public."credencial_integracao" for each row execute function app.touch_updated_at();

alter table public."credencial_integracao" enable row level security;

drop policy if exists credencial_integracao_tenant_select on public."credencial_integracao";

create policy credencial_integracao_tenant_select on public."credencial_integracao" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists credencial_integracao_tenant_insert on public."credencial_integracao";

create policy credencial_integracao_tenant_insert on public."credencial_integracao" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists credencial_integracao_tenant_update on public."credencial_integracao";

create policy credencial_integracao_tenant_update on public."credencial_integracao" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists credencial_integracao_tenant_delete on public."credencial_integracao";

create policy credencial_integracao_tenant_delete on public."credencial_integracao" for delete using (app.has_role('admin_saas'));

drop trigger if exists credencial_integracao_audit on public."credencial_integracao";

create trigger credencial_integracao_audit after insert or update or delete on public."credencial_integracao" for each row execute function app.write_audit_event();

create table if not exists public."importacao_dados" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null,
  "situacao_processamento" varchar(30) null,
  "mensagem_erro" text null
);

create index if not exists idx_importacao_dados_tenant_status on public."importacao_dados" (tenant_id, status);

create index if not exists idx_importacao_dados_tenant_created on public."importacao_dados" (tenant_id, created_at desc);

drop trigger if exists importacao_dados_touch_updated_at on public."importacao_dados";

create trigger importacao_dados_touch_updated_at before update on public."importacao_dados" for each row execute function app.touch_updated_at();

alter table public."importacao_dados" enable row level security;

drop policy if exists importacao_dados_tenant_select on public."importacao_dados";

create policy importacao_dados_tenant_select on public."importacao_dados" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists importacao_dados_tenant_insert on public."importacao_dados";

create policy importacao_dados_tenant_insert on public."importacao_dados" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists importacao_dados_tenant_update on public."importacao_dados";

create policy importacao_dados_tenant_update on public."importacao_dados" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists importacao_dados_tenant_delete on public."importacao_dados";

create policy importacao_dados_tenant_delete on public."importacao_dados" for delete using (app.has_role('admin_saas'));

drop trigger if exists importacao_dados_audit on public."importacao_dados";

create trigger importacao_dados_audit after insert or update or delete on public."importacao_dados" for each row execute function app.write_audit_event();

create table if not exists public."erro_importacao" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null,
  "situacao_processamento" varchar(30) null,
  "mensagem_erro" text null
);

create index if not exists idx_erro_importacao_tenant_status on public."erro_importacao" (tenant_id, status);

create index if not exists idx_erro_importacao_tenant_created on public."erro_importacao" (tenant_id, created_at desc);

drop trigger if exists erro_importacao_touch_updated_at on public."erro_importacao";

create trigger erro_importacao_touch_updated_at before update on public."erro_importacao" for each row execute function app.touch_updated_at();

alter table public."erro_importacao" enable row level security;

drop policy if exists erro_importacao_tenant_select on public."erro_importacao";

create policy erro_importacao_tenant_select on public."erro_importacao" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists erro_importacao_tenant_insert on public."erro_importacao";

create policy erro_importacao_tenant_insert on public."erro_importacao" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists erro_importacao_tenant_update on public."erro_importacao";

create policy erro_importacao_tenant_update on public."erro_importacao" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists erro_importacao_tenant_delete on public."erro_importacao";

create policy erro_importacao_tenant_delete on public."erro_importacao" for delete using (app.has_role('admin_saas'));

drop trigger if exists erro_importacao_audit on public."erro_importacao";

create trigger erro_importacao_audit after insert or update or delete on public."erro_importacao" for each row execute function app.write_audit_event();

create table if not exists public."tarefa_implantacao" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null,
  "situacao_processamento" varchar(30) null,
  "mensagem_erro" text null
);

create index if not exists idx_tarefa_implantacao_tenant_status on public."tarefa_implantacao" (tenant_id, status);

create index if not exists idx_tarefa_implantacao_tenant_created on public."tarefa_implantacao" (tenant_id, created_at desc);

drop trigger if exists tarefa_implantacao_touch_updated_at on public."tarefa_implantacao";

create trigger tarefa_implantacao_touch_updated_at before update on public."tarefa_implantacao" for each row execute function app.touch_updated_at();

alter table public."tarefa_implantacao" enable row level security;

drop policy if exists tarefa_implantacao_tenant_select on public."tarefa_implantacao";

create policy tarefa_implantacao_tenant_select on public."tarefa_implantacao" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists tarefa_implantacao_tenant_insert on public."tarefa_implantacao";

create policy tarefa_implantacao_tenant_insert on public."tarefa_implantacao" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists tarefa_implantacao_tenant_update on public."tarefa_implantacao";

create policy tarefa_implantacao_tenant_update on public."tarefa_implantacao" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists tarefa_implantacao_tenant_delete on public."tarefa_implantacao";

create policy tarefa_implantacao_tenant_delete on public."tarefa_implantacao" for delete using (app.has_role('admin_saas'));

drop trigger if exists tarefa_implantacao_audit on public."tarefa_implantacao";

create trigger tarefa_implantacao_audit after insert or update or delete on public."tarefa_implantacao" for each row execute function app.write_audit_event();

create table if not exists public."relatorio" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_relatorio_tenant_status on public."relatorio" (tenant_id, status);

create index if not exists idx_relatorio_tenant_created on public."relatorio" (tenant_id, created_at desc);

drop trigger if exists relatorio_touch_updated_at on public."relatorio";

create trigger relatorio_touch_updated_at before update on public."relatorio" for each row execute function app.touch_updated_at();

alter table public."relatorio" enable row level security;

drop policy if exists relatorio_tenant_select on public."relatorio";

create policy relatorio_tenant_select on public."relatorio" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists relatorio_tenant_insert on public."relatorio";

create policy relatorio_tenant_insert on public."relatorio" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists relatorio_tenant_update on public."relatorio";

create policy relatorio_tenant_update on public."relatorio" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists relatorio_tenant_delete on public."relatorio";

create policy relatorio_tenant_delete on public."relatorio" for delete using (app.has_role('admin_saas'));

drop trigger if exists relatorio_audit on public."relatorio";

create trigger relatorio_audit after insert or update or delete on public."relatorio" for each row execute function app.write_audit_event();

create table if not exists public."dashboard" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_dashboard_tenant_status on public."dashboard" (tenant_id, status);

create index if not exists idx_dashboard_tenant_created on public."dashboard" (tenant_id, created_at desc);

drop trigger if exists dashboard_touch_updated_at on public."dashboard";

create trigger dashboard_touch_updated_at before update on public."dashboard" for each row execute function app.touch_updated_at();

alter table public."dashboard" enable row level security;

drop policy if exists dashboard_tenant_select on public."dashboard";

create policy dashboard_tenant_select on public."dashboard" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists dashboard_tenant_insert on public."dashboard";

create policy dashboard_tenant_insert on public."dashboard" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists dashboard_tenant_update on public."dashboard";

create policy dashboard_tenant_update on public."dashboard" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists dashboard_tenant_delete on public."dashboard";

create policy dashboard_tenant_delete on public."dashboard" for delete using (app.has_role('admin_saas'));

drop trigger if exists dashboard_audit on public."dashboard";

create trigger dashboard_audit after insert or update or delete on public."dashboard" for each row execute function app.write_audit_event();

create table if not exists public."indicador_kpi" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_indicador_kpi_tenant_status on public."indicador_kpi" (tenant_id, status);

create index if not exists idx_indicador_kpi_tenant_created on public."indicador_kpi" (tenant_id, created_at desc);

drop trigger if exists indicador_kpi_touch_updated_at on public."indicador_kpi";

create trigger indicador_kpi_touch_updated_at before update on public."indicador_kpi" for each row execute function app.touch_updated_at();

alter table public."indicador_kpi" enable row level security;

drop policy if exists indicador_kpi_tenant_select on public."indicador_kpi";

create policy indicador_kpi_tenant_select on public."indicador_kpi" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists indicador_kpi_tenant_insert on public."indicador_kpi";

create policy indicador_kpi_tenant_insert on public."indicador_kpi" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists indicador_kpi_tenant_update on public."indicador_kpi";

create policy indicador_kpi_tenant_update on public."indicador_kpi" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists indicador_kpi_tenant_delete on public."indicador_kpi";

create policy indicador_kpi_tenant_delete on public."indicador_kpi" for delete using (app.has_role('admin_saas'));

drop trigger if exists indicador_kpi_audit on public."indicador_kpi";

create trigger indicador_kpi_audit after insert or update or delete on public."indicador_kpi" for each row execute function app.write_audit_event();

create table if not exists public."snapshot_indicador" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_snapshot_indicador_tenant_status on public."snapshot_indicador" (tenant_id, status);

create index if not exists idx_snapshot_indicador_tenant_created on public."snapshot_indicador" (tenant_id, created_at desc);

drop trigger if exists snapshot_indicador_touch_updated_at on public."snapshot_indicador";

create trigger snapshot_indicador_touch_updated_at before update on public."snapshot_indicador" for each row execute function app.touch_updated_at();

alter table public."snapshot_indicador" enable row level security;

drop policy if exists snapshot_indicador_tenant_select on public."snapshot_indicador";

create policy snapshot_indicador_tenant_select on public."snapshot_indicador" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists snapshot_indicador_tenant_insert on public."snapshot_indicador";

create policy snapshot_indicador_tenant_insert on public."snapshot_indicador" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists snapshot_indicador_tenant_update on public."snapshot_indicador";

create policy snapshot_indicador_tenant_update on public."snapshot_indicador" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists snapshot_indicador_tenant_delete on public."snapshot_indicador";

create policy snapshot_indicador_tenant_delete on public."snapshot_indicador" for delete using (app.has_role('admin_saas'));

drop trigger if exists snapshot_indicador_audit on public."snapshot_indicador";

create trigger snapshot_indicador_audit after insert or update or delete on public."snapshot_indicador" for each row execute function app.write_audit_event();

create table if not exists public."curso_livre_oferta" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_curso_livre_oferta_tenant_status on public."curso_livre_oferta" (tenant_id, status);

create index if not exists idx_curso_livre_oferta_tenant_created on public."curso_livre_oferta" (tenant_id, created_at desc);

drop trigger if exists curso_livre_oferta_touch_updated_at on public."curso_livre_oferta";

create trigger curso_livre_oferta_touch_updated_at before update on public."curso_livre_oferta" for each row execute function app.touch_updated_at();

alter table public."curso_livre_oferta" enable row level security;

drop policy if exists curso_livre_oferta_tenant_select on public."curso_livre_oferta";

create policy curso_livre_oferta_tenant_select on public."curso_livre_oferta" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists curso_livre_oferta_tenant_insert on public."curso_livre_oferta";

create policy curso_livre_oferta_tenant_insert on public."curso_livre_oferta" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists curso_livre_oferta_tenant_update on public."curso_livre_oferta";

create policy curso_livre_oferta_tenant_update on public."curso_livre_oferta" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists curso_livre_oferta_tenant_delete on public."curso_livre_oferta";

create policy curso_livre_oferta_tenant_delete on public."curso_livre_oferta" for delete using (app.has_role('admin_saas'));

drop trigger if exists curso_livre_oferta_audit on public."curso_livre_oferta";

create trigger curso_livre_oferta_audit after insert or update or delete on public."curso_livre_oferta" for each row execute function app.write_audit_event();

create table if not exists public."modulo_curso" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_modulo_curso_tenant_status on public."modulo_curso" (tenant_id, status);

create index if not exists idx_modulo_curso_tenant_created on public."modulo_curso" (tenant_id, created_at desc);

drop trigger if exists modulo_curso_touch_updated_at on public."modulo_curso";

create trigger modulo_curso_touch_updated_at before update on public."modulo_curso" for each row execute function app.touch_updated_at();

alter table public."modulo_curso" enable row level security;

drop policy if exists modulo_curso_tenant_select on public."modulo_curso";

create policy modulo_curso_tenant_select on public."modulo_curso" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists modulo_curso_tenant_insert on public."modulo_curso";

create policy modulo_curso_tenant_insert on public."modulo_curso" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists modulo_curso_tenant_update on public."modulo_curso";

create policy modulo_curso_tenant_update on public."modulo_curso" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists modulo_curso_tenant_delete on public."modulo_curso";

create policy modulo_curso_tenant_delete on public."modulo_curso" for delete using (app.has_role('admin_saas'));

drop trigger if exists modulo_curso_audit on public."modulo_curso";

create trigger modulo_curso_audit after insert or update or delete on public."modulo_curso" for each row execute function app.write_audit_event();

create table if not exists public."certificado" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_certificado_tenant_status on public."certificado" (tenant_id, status);

create index if not exists idx_certificado_tenant_created on public."certificado" (tenant_id, created_at desc);

drop trigger if exists certificado_touch_updated_at on public."certificado";

create trigger certificado_touch_updated_at before update on public."certificado" for each row execute function app.touch_updated_at();

alter table public."certificado" enable row level security;

drop policy if exists certificado_tenant_select on public."certificado";

create policy certificado_tenant_select on public."certificado" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists certificado_tenant_insert on public."certificado";

create policy certificado_tenant_insert on public."certificado" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists certificado_tenant_update on public."certificado";

create policy certificado_tenant_update on public."certificado" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists certificado_tenant_delete on public."certificado";

create policy certificado_tenant_delete on public."certificado" for delete using (app.has_role('admin_saas'));

drop trigger if exists certificado_audit on public."certificado";

create trigger certificado_audit after insert or update or delete on public."certificado" for each row execute function app.write_audit_event();

create table if not exists public."diario_infantil" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_diario_infantil_tenant_status on public."diario_infantil" (tenant_id, status);

create index if not exists idx_diario_infantil_tenant_created on public."diario_infantil" (tenant_id, created_at desc);

drop trigger if exists diario_infantil_touch_updated_at on public."diario_infantil";

create trigger diario_infantil_touch_updated_at before update on public."diario_infantil" for each row execute function app.touch_updated_at();

alter table public."diario_infantil" enable row level security;

drop policy if exists diario_infantil_tenant_select on public."diario_infantil";

create policy diario_infantil_tenant_select on public."diario_infantil" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists diario_infantil_tenant_insert on public."diario_infantil";

create policy diario_infantil_tenant_insert on public."diario_infantil" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists diario_infantil_tenant_update on public."diario_infantil";

create policy diario_infantil_tenant_update on public."diario_infantil" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists diario_infantil_tenant_delete on public."diario_infantil";

create policy diario_infantil_tenant_delete on public."diario_infantil" for delete using (app.has_role('admin_saas'));

drop trigger if exists diario_infantil_audit on public."diario_infantil";

create trigger diario_infantil_audit after insert or update or delete on public."diario_infantil" for each row execute function app.write_audit_event();

create table if not exists public."rotina_infantil" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_rotina_infantil_tenant_status on public."rotina_infantil" (tenant_id, status);

create index if not exists idx_rotina_infantil_tenant_created on public."rotina_infantil" (tenant_id, created_at desc);

drop trigger if exists rotina_infantil_touch_updated_at on public."rotina_infantil";

create trigger rotina_infantil_touch_updated_at before update on public."rotina_infantil" for each row execute function app.touch_updated_at();

alter table public."rotina_infantil" enable row level security;

drop policy if exists rotina_infantil_tenant_select on public."rotina_infantil";

create policy rotina_infantil_tenant_select on public."rotina_infantil" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists rotina_infantil_tenant_insert on public."rotina_infantil";

create policy rotina_infantil_tenant_insert on public."rotina_infantil" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists rotina_infantil_tenant_update on public."rotina_infantil";

create policy rotina_infantil_tenant_update on public."rotina_infantil" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists rotina_infantil_tenant_delete on public."rotina_infantil";

create policy rotina_infantil_tenant_delete on public."rotina_infantil" for delete using (app.has_role('admin_saas'));

drop trigger if exists rotina_infantil_audit on public."rotina_infantil";

create trigger rotina_infantil_audit after insert or update or delete on public."rotina_infantil" for each row execute function app.write_audit_event();

create table if not exists public."autorizacao_retirada" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_autorizacao_retirada_tenant_status on public."autorizacao_retirada" (tenant_id, status);

create index if not exists idx_autorizacao_retirada_tenant_created on public."autorizacao_retirada" (tenant_id, created_at desc);

drop trigger if exists autorizacao_retirada_touch_updated_at on public."autorizacao_retirada";

create trigger autorizacao_retirada_touch_updated_at before update on public."autorizacao_retirada" for each row execute function app.touch_updated_at();

alter table public."autorizacao_retirada" enable row level security;

drop policy if exists autorizacao_retirada_tenant_select on public."autorizacao_retirada";

create policy autorizacao_retirada_tenant_select on public."autorizacao_retirada" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists autorizacao_retirada_tenant_insert on public."autorizacao_retirada";

create policy autorizacao_retirada_tenant_insert on public."autorizacao_retirada" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists autorizacao_retirada_tenant_update on public."autorizacao_retirada";

create policy autorizacao_retirada_tenant_update on public."autorizacao_retirada" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists autorizacao_retirada_tenant_delete on public."autorizacao_retirada";

create policy autorizacao_retirada_tenant_delete on public."autorizacao_retirada" for delete using (app.has_role('admin_saas'));

drop trigger if exists autorizacao_retirada_audit on public."autorizacao_retirada";

create trigger autorizacao_retirada_audit after insert or update or delete on public."autorizacao_retirada" for each row execute function app.write_audit_event();

create table if not exists public."alerta_assistivo_ia" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null,
  "situacao_processamento" varchar(30) null,
  "mensagem_erro" text null
);

create index if not exists idx_alerta_assistivo_ia_tenant_status on public."alerta_assistivo_ia" (tenant_id, status);

create index if not exists idx_alerta_assistivo_ia_tenant_created on public."alerta_assistivo_ia" (tenant_id, created_at desc);

drop trigger if exists alerta_assistivo_ia_touch_updated_at on public."alerta_assistivo_ia";

create trigger alerta_assistivo_ia_touch_updated_at before update on public."alerta_assistivo_ia" for each row execute function app.touch_updated_at();

alter table public."alerta_assistivo_ia" enable row level security;

drop policy if exists alerta_assistivo_ia_tenant_select on public."alerta_assistivo_ia";

create policy alerta_assistivo_ia_tenant_select on public."alerta_assistivo_ia" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists alerta_assistivo_ia_tenant_insert on public."alerta_assistivo_ia";

create policy alerta_assistivo_ia_tenant_insert on public."alerta_assistivo_ia" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists alerta_assistivo_ia_tenant_update on public."alerta_assistivo_ia";

create policy alerta_assistivo_ia_tenant_update on public."alerta_assistivo_ia" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists alerta_assistivo_ia_tenant_delete on public."alerta_assistivo_ia";

create policy alerta_assistivo_ia_tenant_delete on public."alerta_assistivo_ia" for delete using (app.has_role('admin_saas'));

drop trigger if exists alerta_assistivo_ia_audit on public."alerta_assistivo_ia";

create trigger alerta_assistivo_ia_audit after insert or update or delete on public."alerta_assistivo_ia" for each row execute function app.write_audit_event();

create table if not exists public."modelo_predicao_ia" (
  "id" uuid primary key default gen_random_uuid(),
  "tenant_id" uuid not null references public.tenants(id),
  "status" text not null default 'ATIVO',
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "deleted_at" timestamptz null,
  "created_by" uuid null,
  "updated_by" uuid null,
  "deleted_by" uuid null,
  "row_version" integer null,
  "codigo" varchar(50) null,
  "nome" varchar(180) null,
  "descricao" text null
);

create index if not exists idx_modelo_predicao_ia_tenant_status on public."modelo_predicao_ia" (tenant_id, status);

create index if not exists idx_modelo_predicao_ia_tenant_created on public."modelo_predicao_ia" (tenant_id, created_at desc);

drop trigger if exists modelo_predicao_ia_touch_updated_at on public."modelo_predicao_ia";

create trigger modelo_predicao_ia_touch_updated_at before update on public."modelo_predicao_ia" for each row execute function app.touch_updated_at();

alter table public."modelo_predicao_ia" enable row level security;

drop policy if exists modelo_predicao_ia_tenant_select on public."modelo_predicao_ia";

create policy modelo_predicao_ia_tenant_select on public."modelo_predicao_ia" for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists modelo_predicao_ia_tenant_insert on public."modelo_predicao_ia";

create policy modelo_predicao_ia_tenant_insert on public."modelo_predicao_ia" for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists modelo_predicao_ia_tenant_update on public."modelo_predicao_ia";

create policy modelo_predicao_ia_tenant_update on public."modelo_predicao_ia" for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas')) with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

drop policy if exists modelo_predicao_ia_tenant_delete on public."modelo_predicao_ia";

create policy modelo_predicao_ia_tenant_delete on public."modelo_predicao_ia" for delete using (app.has_role('admin_saas'));

drop trigger if exists modelo_predicao_ia_audit on public."modelo_predicao_ia";

create trigger modelo_predicao_ia_audit after insert or update or delete on public."modelo_predicao_ia" for each row execute function app.write_audit_event();