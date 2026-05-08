-- Teste orientativo para Supabase CLI/pgTAP: conferir RLS em tabelas do modelo completo.
select schemaname, tablename, rowsecurity from pg_tables where schemaname='public' and tablename in ('aluno','matricula','conta_receber','comunicado','log_auditoria','alerta_assistivo_ia');
