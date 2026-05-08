# API — Incremento 002 Financeiro

Todas as rotas exigem `Authorization: Bearer <jwt>`.

## GET `/v1/finance/dashboard`

Retorna totais a receber, recebido, saldo, vencidas, abertas e pagas.

## GET `/v1/finance/charges`

Query params:

- `page`
- `pageSize`
- `search`
- `situation`
- `dueFrom`
- `dueTo`

## POST `/v1/finance/charges`

Cria cobrança avulsa.

```json
{
  "studentId": "uuid",
  "description": "Mensalidade escolar",
  "amountInCents": 150000,
  "dueDate": "2026-02-10",
  "competency": "2026-02"
}
```

## POST `/v1/finance/billing-plans`

Gera parcelas recorrentes por matrícula.

```json
{
  "enrollmentId": "uuid",
  "description": "Mensalidade 2026",
  "installments": 12,
  "firstDueDate": "2026-02-10",
  "amountInCents": 150000,
  "competencyPrefix": "2026"
}
```

## POST `/v1/finance/payments`

Registra baixa total ou parcial.

```json
{
  "chargeId": "uuid",
  "amountInCents": 150000,
  "paymentDate": "2026-02-10",
  "method": "PIX"
}
```

## POST `/v1/finance/charges/:id/cancel`

Cancela cobrança com motivo.

## POST `/v1/finance/charges/mark-overdue`

Marca cobranças abertas vencidas como atrasadas.
