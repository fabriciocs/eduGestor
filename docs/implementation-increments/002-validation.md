# Validação do Incremento 002

## Validações estáticas realizadas

- Arquivos backend de financeiro criados.
- `registerFinanceRoutes` incluído no app Fastify.
- Migration `000012_finance_feature.sql` criada.
- Frontend com rota `/financeiro`.
- Navegação lateral aponta para `/financeiro`.
- Fluxo financeiro marcado como implementado em `/fluxos`.
- ZIP gerado somente com arquivos alterados/criados.

## Validações não executadas neste ambiente

- `npm install`, `npm test` e `npm run build`.
- `flutter pub get`, `flutter analyze` e build web.
- Execução real contra Supabase.

## Critérios de aceite funcionais

- Financeiro visualiza métricas consolidadas.
- Financeiro cria cobranças.
- Financeiro gera plano de parcelas por matrícula.
- Financeiro registra baixa de pagamento.
- Sistema marca vencidas como atrasadas.
- Usuário sem perfil financeiro/escrita não opera mutações.
