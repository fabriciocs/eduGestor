import { FastifyInstance } from 'fastify';
import { validateInput } from '../../core/validation/validate.js';
import { tenantCreateSchema, tenantUnitCreateSchema } from './tenant.schemas.js';
import * as service from './tenant.service.js';

export function registerTenantRoutes(app: FastifyInstance) {
  app.get('/tenants', async (request) => service.listTenants(request.tenant!));

  app.post('/tenants', async (request, reply) => {
    const input = validateInput(tenantCreateSchema, request.body);
    const tenant = await service.createTenant(request.tenant!, input);
    return reply.status(201).send(tenant);
  });

  app.post('/tenant-units', async (request, reply) => {
    const input = validateInput(tenantUnitCreateSchema, request.body);
    const unit = await service.createTenantUnit(request.tenant!, input);
    return reply.status(201).send(unit);
  });
}
