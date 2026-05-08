# Incremento 001 — Matrícula, rematrícula e secretaria digital

## Funcionalidade implementada

Implementação dedicada do fluxo de matrícula/rematrícula, substituindo o endpoint genérico anterior por uma operação transacional de domínio em camadas.

## Backend

Arquivos adicionados:

- `apps/api/src/modules/enrollment/enrollment.schemas.ts`
- `apps/api/src/modules/enrollment/enrollment.repository.ts`
- `apps/api/src/modules/enrollment/enrollment.service.ts`
- `apps/api/src/modules/enrollment/enrollment.routes.ts`

Rotas:

- `GET /v1/enrollments/processes`
- `POST /v1/enrollments/processes`
- `POST /v1/enrollments/processes/:id/transitions`

O fluxo cria ou atualiza:

- `aluno`
- `responsavel`
- `aluno_responsavel`
- `matricula`
- `processo_matricula`
- `contrato_educacional`
- `parcela_cobranca`, quando cobrança inicial é solicitada

## Banco de dados

Migration adicionada:

- `supabase/migrations/000011_enrollment_feature.sql`

Complementos aplicados:

- campos operacionais em `processo_matricula`
- campos de contrato em `contrato_educacional`
- campos financeiros em `parcela_cobranca`
- índices multi-tenant
- constraints de situação

## Frontend

Arquivos adicionados:

- `apps/web_flutter/lib/features/enrollment/data/enrollment_repository.dart`
- `apps/web_flutter/lib/features/enrollment/presentation/pages/enrollment_processes_page.dart`
- `apps/web_flutter/lib/features/enrollment/presentation/pages/enrollment_form_page.dart`

Arquivos alterados:

- `apps/web_flutter/lib/app/router.dart`
- `apps/web_flutter/lib/shared/layout/responsive_scaffold.dart`
- `apps/web_flutter/lib/features/workflows/presentation/pages/workflows_page.dart`

Fluxos de UI:

- listar processos de matrícula
- abrir formulário em página dedicada
- cadastrar aluno/responsável/matrícula
- gerar contrato pendente
- gerar cobrança inicial opcional
- transicionar processo para `MATRICULADO`, `AGUARDANDO_DOCUMENTOS` ou `CANCELADO`

## Segurança e LGPD

- Não há service role no frontend.
- Backend exige JWT e tenant context.
- Permissões de escrita restritas a perfis administrativos/secretaria/suporte.
- CPF é opcional e validado quando informado.
- Dados sensíveis não são exibidos em logs pela implementação.
- Integrações externas de assinatura, banco e cobrança real continuam pendentes de homologação.

## Pendências humanas

- Validar juridicamente contrato educacional.
- Homologar assinatura digital.
- Homologar integração bancária.
- Confirmar política de retenção documental.
