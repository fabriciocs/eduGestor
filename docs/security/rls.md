# Estratégia de Row Level Security

## Objetivo

Impedir vazamento entre tenants mesmo se houver erro no backend.

## Claims esperadas

O JWT autenticado deve conter, em `app_metadata` ou claim equivalente:

- `tenant_id`
- `roles`
- `unit_ids` quando aplicável

## Funções SQL

- `app.current_tenant_id()`
- `app.has_role(role_name text)`
- `app.touch_updated_at()`

## Policies

- `tenant_isolation_select`
- `tenant_isolation_insert`
- `tenant_isolation_update`
- `tenant_isolation_delete`

## Regras

- `tenant_id` do registro precisa corresponder ao tenant do JWT.
- Inserts não podem escolher tenant diferente.
- Soft delete é preferido para entidades operacionais.
- Service role só deve ser usada no servidor ou rotinas administrativas controladas.
