import { randomUUID } from 'node:crypto';
import cors from '@fastify/cors';
import helmet from '@fastify/helmet';
import Fastify from 'fastify';
import { corsOrigins } from './config/env.js';
import { logger } from './core/logging/logger.js';
import { errorHandler } from './core/errors/error-handler.js';
import { authenticate } from './core/auth/auth.middleware.js';
import { registerTenantRoutes } from './modules/tenants/tenant.routes.js';
import { registerUserRoutes } from './modules/users/user.routes.js';
import { registerStudentRoutes } from './modules/students/student.routes.js';
import { registerGuardianRoutes } from './modules/guardians/guardian.routes.js';
import { registerAuditRoutes } from './modules/audit/audit.routes.js';
import { registerCatalogRoutes } from './modules/catalog/catalog.routes.js';
import { registerGenericEntityRoutes } from './modules/generic/generic.routes.js';
import { registerWorkflowRoutes } from './modules/workflows/workflow.routes.js';

export function buildApp() {
  const app = Fastify({
    logger,
    genReqId: (request) => request.headers['x-request-id']?.toString() ?? randomUUID(),
  });

  app.register(helmet);
  app.register(cors, { origin: corsOrigins });

  app.setErrorHandler(errorHandler);

  app.get('/health', async () => ({
    status: 'ok',
    service: 'edugestor-api',
  }));

  app.register(async (secured) => {
    secured.addHook('preHandler', authenticate);
    registerTenantRoutes(secured);
    registerUserRoutes(secured);
    registerStudentRoutes(secured);
    registerGuardianRoutes(secured);
    registerAuditRoutes(secured);
    registerCatalogRoutes(secured);
    registerGenericEntityRoutes(secured);
    registerWorkflowRoutes(secured);
  }, { prefix: '/v1' });

  return app;
}
