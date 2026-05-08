# EduGestor 360

Plataforma SaaS B2B multi-tenant para gestão escolar privada, implementada conforme o plano técnico `06 — Plano Técnico Final — EduGestor 360`.

## Premissas deste incremento

- Não havia repositório base enviado; este pacote cria um monorepo inicial.
- Stack-alvo: Flutter Web + Material Design 3, Node.js/TypeScript, Supabase/PostgreSQL.
- O incremento implementa a fundação e o núcleo seguro inicial: scripts, documentação, migrations, RLS, API base e shell Flutter.
- A chave `SUPABASE_SERVICE_ROLE_KEY` é usada apenas no backend. O frontend usa somente configuração pública.

## Estrutura

```text
apps/api            API Node.js TypeScript
apps/web_flutter    App Flutter Web-first
supabase            Migrations, seed e testes SQL de RLS
docs                Arquitetura, segurança, runbooks e planejamento
scripts             Scripts PowerShell de instalação, teste, lint e build
```

## Execução local

```powershell
Copy-Item .env.example .env
.\scripts\install.ps1
.\scripts\setup-local.ps1
.\scripts\dev.ps1
```

## Validação

```powershell
.\scripts\validate.ps1
```

## Status funcional

Implementado neste pacote:

- Fundação do repositório.
- Núcleo Supabase com tenants, unidades, perfis, permissões, usuários, auditoria, alunos, responsáveis e RLS.
- Backend base com autenticação, contexto de tenant, validação, logs, erros, módulos tenants/users/students/guardians/audit e OpenAPI inicial.
- Frontend shell Flutter com Material Design 3, rotas, dashboard e páginas de alunos.
- Testes de unidade/contrato básicos no backend, widget tests no Flutter e testes SQL de RLS.

Ainda pendente para produção:

- Validação DPO/jurídica da matriz LGPD.
- Escolha de gateway financeiro, comunicação e cloud.
- Implementação completa dos 134 requisitos funcionais.
- Execução real dos comandos em ambiente com Node, Flutter e Supabase CLI instalados.
