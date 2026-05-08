# Arquitetura — EduGestor 360

## Visão

O EduGestor 360 usa arquitetura modular em camadas:

- Flutter Web/App para interface.
- Node.js/TypeScript como API de domínio e orquestração.
- Supabase/PostgreSQL para Auth, dados, RLS, Storage e logs.
- Migrations SQL versionadas.
- Auditoria como infraestrutura transversal.

## Diretrizes

- Toda tabela operacional usa `tenant_id`.
- RLS é obrigatória em todas as tabelas multi-tenant.
- O backend valida autenticação, tenant e autorização.
- Formulários complexos abrem em páginas, nunca em modais.
- Logs estruturados não devem conter segredos nem dados sensíveis em claro.
- Service role key nunca deve estar no frontend.

## Camadas backend

- routes: entrada HTTP.
- schemas: validação.
- services: regras de aplicação.
- repositories: acesso ao Supabase/Postgres.
- core: autenticação, erros, logs, validação, supabase.

## Camadas frontend

- app: router e tema.
- core: config, http, auth e erros.
- shared: layout, widgets e forms.
- features: módulos por domínio.
