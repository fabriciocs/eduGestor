import { FastifyInstance } from 'fastify';
import { z } from 'zod';
import { validateInput } from '../../core/validation/validate.js';
import { requirements, entities } from '../../generated/catalog.js';
import * as generic from '../generic/generic.service.js';
const payloadSchema = z.record(z.unknown()); const idSchema = z.object({ id: z.string().uuid() });
export function registerWorkflowRoutes(app: FastifyInstance) {
  app.post('/matriculas/processos', async (request, reply) => reply.status(201).send({ data: await generic.createRow(request.tenant!, 'processo_matricula', validateInput(payloadSchema, request.body)), nextSteps: ['anexar_documentos','gerar_contrato','gerar_cobranca'] }));
  app.post('/matriculas/:id/confirmar', async (request) => generic.updateRow(request.tenant!, 'processo_matricula', validateInput(idSchema, request.params).id, { status: 'CONFIRMADO' }));
  app.post('/financeiro/cobrancas', async (request, reply) => reply.status(201).send({ data: await generic.createRow(request.tenant!, 'conta_receber', validateInput(payloadSchema, request.body)), audit: 'cobranca_criada' }));
  app.post('/financeiro/recebimentos', async (request, reply) => reply.status(201).send({ data: await generic.createRow(request.tenant!, 'pagamento', validateInput(payloadSchema, request.body)), audit: 'pagamento_registrado' }));
  app.post('/frequencia/chamadas', async (request, reply) => reply.status(201).send({ data: await generic.createRow(request.tenant!, 'frequencia_aula', validateInput(payloadSchema, request.body)), nextSteps: ['registrar_frequencia_aluno'] }));
  app.post('/avaliacoes/lancamentos', async (request, reply) => reply.status(201).send({ data: await generic.createRow(request.tenant!, 'nota_aluno', validateInput(payloadSchema, request.body)), status: 'rascunho_lancado' }));
  app.post('/comunicacao/mensagens', async (request, reply) => reply.status(201).send({ data: await generic.createRow(request.tenant!, 'comunicado', validateInput(payloadSchema, request.body)), delivery: 'fila_interna_registrada' }));
  app.post('/documentos/solicitacoes', async (request, reply) => reply.status(201).send({ data: await generic.createRow(request.tenant!, 'solicitacao_secretaria', validateInput(payloadSchema, request.body)) }));
  app.post('/implantacao/importacoes', async (request, reply) => reply.status(201).send({ data: await generic.createRow(request.tenant!, 'importacao_dados', validateInput(payloadSchema, request.body)), validationMode: 'dry_run_por_padrao' }));
  app.post('/lgpd/solicitacoes-titular', async (request, reply) => reply.status(201).send({ data: await generic.createRow(request.tenant!, 'solicitacao_titular_lgpd', validateInput(payloadSchema, request.body)), requiresDpoReview: true }));
  app.post('/ia/alertas-assistivos', async (request, reply) => reply.status(201).send({ data: await generic.createRow(request.tenant!, 'alerta_assistivo_ia', { ...validateInput(payloadSchema, request.body), revisao_humana_obrigatoria: true }), policy: 'assistivo_sem_decisao_automatica' }));
  app.get('/relatorios/cobertura-funcional', async () => ({ data: { totalRequirements: requirements.length, totalModules: new Set(requirements.map((r) => r.module)).size, totalEntities: entities.length, implementedBy: 'catalogo + CRUD multi-tenant + workflows setoriais', externalPending: ['integração bancária real','WhatsApp/SMS/email transacional','emissão fiscal municipal','modelo IA treinado e validado'] } }));
}
