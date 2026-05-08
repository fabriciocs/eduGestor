import { FastifyInstance } from 'fastify';
import { paginationSchema } from '../../core/http/pagination.js';
import { validateInput } from '../../core/validation/validate.js';
import {
  guardianCreateSchema,
  linkGuardianSchema,
} from './guardian.schemas.js';
import * as service from './guardian.service.js';

export function registerGuardianRoutes(app: FastifyInstance) {
  app.get('/guardians', async (request) => {
    const pagination = validateInput(paginationSchema, request.query);
    return service.listGuardians(request.tenant!, pagination);
  });

  app.post('/guardians', async (request, reply) => {
    const input = validateInput(guardianCreateSchema, request.body);
    const guardian = await service.createGuardian(request.tenant!, input);
    return reply.status(201).send(guardian);
  });

  app.post('/student-guardians', async (request, reply) => {
    const input = validateInput(linkGuardianSchema, request.body);
    const link = await service.linkGuardian(request.tenant!, input);
    return reply.status(201).send(link);
  });
}
