# Plano de implementação incremental

## Análise consolidada

Fontes analisadas:

- `06-EduGestor-360(5).md`
- especificações funcionais e técnicas em Markdown
- planilha de funcionalidades
- planilha de modelo de dados
- diretrizes de UX e estética

Achados principais:

- Produto SaaS B2B multi-tenant.
- 134 requisitos funcionais, 20 requisitos não funcionais, 20 módulos, 98 entidades e 1.150 campos.
- MVP deve começar por segurança, tenant, usuários, cadastros, matrículas, financeiro básico, frequência, portais, relatórios e auditoria.
- O primeiro incremento deve ser um núcleo seguro e testável, não a implementação simultânea de todos os módulos.

## Etapas

### Etapa 0 — Fundação do repositório

Criar monorepo, documentação, scripts e contratos mínimos.

Status: implementada neste pacote.

### Etapa 1 — Núcleo Supabase e RLS

Criar tabelas multi-tenant, policies, funções auxiliares, triggers e testes de isolamento.

Status: implementada neste pacote.

### Etapa 2 — Backend base

Criar API Node.js/TypeScript com autenticação Supabase JWT, tenant context, validação, logs, erros e módulos iniciais.

Status: implementada neste pacote.

### Etapa 3 — Frontend shell

Criar Flutter Web com Material Design 3, rotas, layout responsivo, dashboard e páginas de alunos.

Status: implementada neste pacote.

### Etapa 4 — Cadastros centrais

Implementar alunos, responsáveis e vínculos com CRUD inicial.

Status: base implementada no backend e frontend para alunos; responsáveis implementados no backend; telas completas de responsáveis ainda pendentes.

### Próximas etapas

1. Completar telas de responsáveis.
2. Implementar edição real conectada a API.
3. Implementar importação por planilha.
4. Criar matrículas, turmas, frequência e financeiro básico.
5. Expandir autorização por unidade, turma e vínculo.
6. Criar testes E2E.
