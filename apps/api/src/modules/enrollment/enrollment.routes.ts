import { FastifyInstance } from 'fastify';
import { paginationSchema } from '../../core/http/pagination.js';
import { validateInput } from '../../core/validation/validate.js';
import {
  enrollmentCreateSchema,
  enrollmentParamsSchema,
  enrollmentTransitionSchema,
} from './enrollment.schemas.js';
import * as service from './enrollment.service.js';

export function registerEnrollmentRoutes(app: FastifyInstance) {
  app.get('/enrollments/processes', async (request) => {
    const pagination = {
      page: 1,
      pageSize: 20,
      ...validateInput(paginationSchema, request.query),
    };

    return service.listEnrollmentProcesses(request.tenant!, pagination);
  });

  app.post('/enrollments/processes', async (request, reply) => {
    const input = validateInput(enrollmentCreateSchema, request.body);
    const output = await service.createEnrollmentProcess(request.tenant!, input);
    return reply.status(201).send({ data: output });
  });

  app.post('/enrollments/processes/:id/transitions', async (request) => {
    const { id } = validateInput(enrollmentParamsSchema, request.params);
    const input = validateInput(enrollmentTransitionSchema, request.body);
    return service.transitionEnrollmentProcess(request.tenant!, id, input);
  });
}
