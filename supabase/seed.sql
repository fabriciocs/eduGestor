insert into public.tenants (id, legal_name, trade_name, document_number, status)
values
  ('00000000-0000-0000-0000-000000000001', 'Escola Alfa Ltda', 'Escola Alfa', '11111111000191', 'active'),
  ('00000000-0000-0000-0000-000000000002', 'Escola Beta Ltda', 'Escola Beta', '22222222000192', 'active')
on conflict (document_number) do nothing;

insert into public.tenant_units (tenant_id, name, code)
values
  ('00000000-0000-0000-0000-000000000001', 'Unidade Centro', 'CENTRO'),
  ('00000000-0000-0000-0000-000000000002', 'Unidade Norte', 'NORTE')
on conflict (tenant_id, code) do nothing;

insert into public.permissions (module, action, description)
values
  ('students', 'read', 'Listar e visualizar alunos'),
  ('students', 'write', 'Criar e editar alunos'),
  ('guardians', 'read', 'Listar e visualizar responsáveis'),
  ('guardians', 'write', 'Criar e editar responsáveis'),
  ('audit', 'read', 'Visualizar auditoria')
on conflict (module, action) do nothing;

insert into public.students (tenant_id, full_name, birth_date, status)
values
  ('00000000-0000-0000-0000-000000000001', 'Ana Souza', '2014-01-10', 'active'),
  ('00000000-0000-0000-0000-000000000002', 'Bruno Lima', '2013-04-22', 'active');

insert into public.guardians (tenant_id, full_name, email, phone, status)
values
  ('00000000-0000-0000-0000-000000000001', 'Carla Souza', 'carla@example.com', '+5511999990001', 'active'),
  ('00000000-0000-0000-0000-000000000002', 'Daniel Lima', 'daniel@example.com', '+5511999990002', 'active');
