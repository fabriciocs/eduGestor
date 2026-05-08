-- Incremento funcional 002: financeiro escolar.
-- Fluxo: cobranças, plano de parcelas, baixa de pagamento e inadimplência.

alter table if exists public."parcela_cobranca"
  add column if not exists valor_original numeric(14,2) null,
  add column if not exists data_vencimento date null,
  add column if not exists competencia varchar(7) null,
  add column if not exists valor_pago_centavos integer not null default 0,
  add column if not exists data_ultimo_pagamento date null,
  add column if not exists motivo_cancelamento text null;

alter table if exists public."pagamento"
  add column if not exists parcela_cobranca_id uuid null,
  add column if not exists valor_pago_centavos integer null,
  add column if not exists referencia_externa varchar(120) null,
  add column if not exists observacoes text null;

create index if not exists idx_parcela_cobranca_financeiro_situacao
  on public."parcela_cobranca" (tenant_id, situacao_pagamento, vencimento);

create index if not exists idx_parcela_cobranca_matricula
  on public."parcela_cobranca" (tenant_id, matricula_id);

create index if not exists idx_parcela_cobranca_responsavel
  on public."parcela_cobranca" (tenant_id, responsavel_id);

create index if not exists idx_pagamento_parcela
  on public."pagamento" (tenant_id, parcela_cobranca_id, data_pagamento);

alter table if exists public."parcela_cobranca"
  drop constraint if exists parcela_cobranca_valor_centavos_check;

alter table if exists public."parcela_cobranca"
  add constraint parcela_cobranca_valor_centavos_check
  check (valor_centavos is null or valor_centavos > 0);

alter table if exists public."parcela_cobranca"
  drop constraint if exists parcela_cobranca_valor_pago_centavos_check;

alter table if exists public."parcela_cobranca"
  add constraint parcela_cobranca_valor_pago_centavos_check
  check (valor_pago_centavos >= 0);

alter table if exists public."pagamento"
  drop constraint if exists pagamento_valor_pago_centavos_check;

alter table if exists public."pagamento"
  add constraint pagamento_valor_pago_centavos_check
  check (valor_pago_centavos is null or valor_pago_centavos > 0);
