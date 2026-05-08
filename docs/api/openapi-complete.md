# API completa — EduGestor 360

## Catálogo
- `GET /v1/catalog/modules`
- `GET /v1/catalog/requirements`
- `GET /v1/catalog/entities`
- `GET /v1/catalog/fields`

## CRUD universal multi-tenant
- `GET /v1/entities/{table}`
- `GET /v1/entities/{table}/{id}`
- `POST /v1/entities/{table}`
- `PATCH /v1/entities/{table}/{id}`
- `DELETE /v1/entities/{table}/{id}`

## Workflows
- `POST /v1/matriculas/processos`
- `POST /v1/matriculas/{id}/confirmar`
- `POST /v1/financeiro/cobrancas`
- `POST /v1/financeiro/recebimentos`
- `POST /v1/frequencia/chamadas`
- `POST /v1/avaliacoes/lancamentos`
- `POST /v1/comunicacao/mensagens`
- `POST /v1/documentos/solicitacoes`
- `POST /v1/implantacao/importacoes`
- `POST /v1/lgpd/solicitacoes-titular`
- `POST /v1/ia/alertas-assistivos`
- `GET /v1/relatorios/cobertura-funcional`
