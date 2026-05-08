alter table public.tenants enable row level security;
alter table public.tenant_units enable row level security;
alter table public.profiles enable row level security;
alter table public.permissions enable row level security;
alter table public.profile_permissions enable row level security;
alter table public.users enable row level security;
alter table public.user_profiles enable row level security;
alter table public.user_unit_access enable row level security;
alter table public.audit_events enable row level security;
alter table public.students enable row level security;
alter table public.guardians enable row level security;
alter table public.student_guardians enable row level security;

create policy tenants_admin_saas_select on public.tenants
for select using (app.has_role('admin_saas') or id = app.current_tenant_id());

create policy tenants_admin_saas_insert on public.tenants
for insert with check (app.has_role('admin_saas'));

create policy tenants_own_update on public.tenants
for update using (app.has_role('admin_saas') or id = app.current_tenant_id())
with check (app.has_role('admin_saas') or id = app.current_tenant_id());

create policy permissions_authenticated_select on public.permissions
for select using (auth.role() = 'authenticated');

create policy tenant_units_isolation_select on public.tenant_units
for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

create policy tenant_units_isolation_insert on public.tenant_units
for insert with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

create policy tenant_units_isolation_update on public.tenant_units
for update using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'))
with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

create policy profiles_isolation_all on public.profiles
for all using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'))
with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

create policy profile_permissions_isolation_all on public.profile_permissions
for all using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'))
with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

create policy users_isolation_all on public.users
for all using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'))
with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

create policy user_profiles_isolation_all on public.user_profiles
for all using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'))
with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

create policy user_unit_access_isolation_all on public.user_unit_access
for all using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'))
with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

create policy audit_events_isolation_select on public.audit_events
for select using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

create policy students_isolation_all on public.students
for all using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'))
with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

create policy guardians_isolation_all on public.guardians
for all using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'))
with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));

create policy student_guardians_isolation_all on public.student_guardians
for all using (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'))
with check (tenant_id = app.current_tenant_id() or app.has_role('admin_saas'));
