import { FastifyInstance } from 'fastify';
import { z } from 'zod';
import { validateInput } from '../../core/validation/validate.js';
import * as service from './user.service.js';

const localUserSchema = z.object({
  email: z.string().email(),
  fullName: z.string().min(2).max(160),
});

export function registerUserRoutes(app: FastifyInstance) {
  app.get('/users', async (request) => service.listUsers(request.tenant!));

  app.post('/users', async (request, reply) => {
    const input = validateInput(localUserSchema, request.body);
    const user = await service.registerLocalUser(request.tenant!, input);
    return reply.status(201).send(user);
  });
}
