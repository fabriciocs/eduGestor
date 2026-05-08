import { FastifyInstance } from 'fastify';
import { z } from 'zod';
import { paginationSchema } from '../../core/http/pagination.js';
import { validateInput } from '../../core/validation/validate.js';
import { AppError } from '../../core/errors/app-error.js';
import * as service from './generic.service.js';
const paramsSchema = z.object({ table: z.string().regex(/^[a-z0-9_]+$/) });
const rowParamsSchema = paramsSchema.extend({ id: z.string().uuid() });
const payloadSchema = z.record(z.unknown());
export function registerGenericEntityRoutes(app: FastifyInstance) {
  app.get('/entities/:table', async (request) => { const { table } = validateInput(paramsSchema, request.params); const pagination = { page: 1, pageSize: 20, ...validateInput(paginationSchema, request.query) }; try { return await service.listRows(request.tenant!, table, pagination); } catch (error) { if (error instanceof Error && error.name === 'UNKNOWN_ENTITY') throw AppError.notFound(error.message); throw error; } });
  app.get('/entities/:table/:id', async (request) => { const { table, id } = validateInput(rowParamsSchema, request.params); return service.getRow(request.tenant!, table, id); });
  app.post('/entities/:table', async (request, reply) => { const { table } = validateInput(paramsSchema, request.params); const input = validateInput(payloadSchema, request.body); const row = await service.createRow(request.tenant!, table, input); return reply.status(201).send(row); });
  app.patch('/entities/:table/:id', async (request) => { const { table, id } = validateInput(rowParamsSchema, request.params); const input = validateInput(payloadSchema, request.body); return service.updateRow(request.tenant!, table, id, input); });
  app.delete('/entities/:table/:id', async (request, reply) => { const { table, id } = validateInput(rowParamsSchema, request.params); await service.deleteRow(request.tenant!, table, id); return reply.status(204).send(); });
}
