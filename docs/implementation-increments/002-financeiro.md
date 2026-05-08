# Incremento 002 — Financeiro escolar

## Funcionalidade implementada

Implementa o fluxo financeiro operacional de ponta a ponta:

- dashboard financeiro;
- listagem e filtro de cobranças;
- criação manual de cobrança;
- geração de plano de parcelas;
- baixa de pagamento total ou parcial;
- atualização de parcelas vencidas para inadimplência;
- cancelamento auditável de cobrança;
- rotas frontend dedicadas em `/financeiro`;
- migration incremental para colunas financeiras de parcelas e pagamentos.

## Backend

Rotas adicionadas sob `/v1/finance`:

- `GET /dashboard`
- `GET /charges`
- `POST /charges`
- `POST /billing-plans`
- `POST /payments`
- `POST /charges/:id/cancel`
- `POST /charges/mark-overdue`

## Segurança

- Autenticação obrigatória via middleware global.
- Autorização por perfil.
- Leitura permitida para administração, direção, financeiro, secretaria, mantenedor e suporte.
- Escrita permitida para administração, direção, financeiro, mantenedor e suporte.
- Uso de tenant context em todas as queries.
- Não há service role no frontend.

## LGPD

O fluxo financeiro trata dados pessoais indiretos e dados econômico-financeiros. Pendências para validação humana antes de produção:

- bases legais e política de retenção de cobranças/pagamentos;
- revisão de integrações com boleto, Pix, adquirente e nota fiscal;
- revisão DPO/jurídica de comunicação de inadimplência;
- homologação fiscal municipal quando houver emissão de NFS-e.

## Próxima funcionalidade sugerida

Incremento 003 — Frequência/chamada escolar.
