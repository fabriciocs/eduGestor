-- Incremento funcional: matrícula/rematrícula e secretaria digital.
-- Complementa o modelo gerado com vínculos operacionais necessários ao fluxo end-to-end.

alter table if exists public."processo_matricula"
  add column if not exists aluno_id uuid null,
  add column if not exists matricula_id uuid null,
  add column if not exists responsavel_id uuid null,
  add column if not exists origem text not null default 'manual',
  add column if not exists observacoes text null;

alter table if exists public."contrato_educacional"
  add column if not exists processo_matricula_id uuid null,
  add column if not exists matricula_id uuid null,
  add column if not exists aluno_id uuid null,
  add column if not exists status_assinatura text not null default 'PENDENTE',
  add column if not exists data_geracao timestamptz not null default now();

alter table if exists public."parcela_cobranca"
  add column if not exists processo_matricula_id uuid null,
  add column if not exists matricula_id uuid null,
  add column if not exists aluno_id uuid null,
  add column if not exists responsavel_id uuid null,
  add column if not exists valor_centavos integer null,
  add column if not exists vencimento date null,
  add column if not exists situacao_pagamento text not null default 'ABERTA';

create index if not exists idx_processo_matricula_aluno on public."processo_matricula" (tenant_id, aluno_id);
create index if not exists idx_processo_matricula_matricula on public."processo_matricula" (tenant_id, matricula_id);
create index if not exists idx_contrato_educacional_processo on public."contrato_educacional" (tenant_id, processo_matricula_id);
create index if not exists idx_parcela_cobranca_processo on public."parcela_cobranca" (tenant_id, processo_matricula_id);
create index if not exists idx_parcela_cobranca_vencimento on public."parcela_cobranca" (tenant_id, vencimento, situacao_pagamento);

alter table if exists public."processo_matricula"
  add constraint processo_matricula_situacao_check
  check (situacao_processamento is null or situacao_processamento in (
    'PRE_MATRICULA',
    'MATRICULADO',
    'AGUARDANDO_DOCUMENTOS',
    'CANCELADO',
    'CONCLUIDO'
  ));

alter table if exists public."matricula"
  add constraint matricula_situacao_check
  check (situacao is null or situacao in (
    'PRE_MATRICULA',
    'MATRICULADO',
    'AGUARDANDO_DOCUMENTOS',
    'CANCELADO',
    'CONCLUIDO'
  ));

alter table if exists public."contrato_educacional"
  add constraint contrato_status_assinatura_check
  check (status_assinatura in ('PENDENTE', 'ENVIADO', 'ASSINADO', 'RECUSADO', 'CANCELADO'));

alter table if exists public."parcela_cobranca"
  add constraint parcela_cobranca_situacao_pagamento_check
  check (situacao_pagamento in ('ABERTA', 'PAGA', 'ATRASADA', 'CANCELADA'));
