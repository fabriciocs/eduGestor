import { FastifyInstance } from 'fastify';
import { paginationSchema } from '../../core/http/pagination.js';
import { validateInput } from '../../core/validation/validate.js';
import { listAuditEvents } from './audit.repository.js';

export function registerAuditRoutes(app: FastifyInstance) {
  app.get('/audit-events', async (request) => {
    const pagination = validateInput(paginationSchema, request.query);
    return listAuditEvents(request.tenant!.id, pagination);
  });
}
