import 'fastify';
import { TenantContext } from '../core/auth/tenant-context.js';

declare module 'fastify' {
  interface FastifyRequest {
    tenant?: TenantContext;
  }
}
