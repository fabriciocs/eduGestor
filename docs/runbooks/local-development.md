# Runbook — Desenvolvimento local

## Pré-requisitos

- Node.js 20+
- npm
- Flutter stable
- Supabase CLI
- PowerShell

## Setup

```powershell
Copy-Item .env.example .env
.\scripts\install.ps1
.\scripts\setup-local.ps1
```

## Subir ambiente

```powershell
.\scripts\dev.ps1
```

## Validar

```powershell
.\scripts\validate.ps1
```

## Observações

- Não usar service role no frontend.
- Não commitar `.env`.
- Seeds são apenas para ambiente local.
