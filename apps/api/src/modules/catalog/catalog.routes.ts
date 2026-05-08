import { FastifyInstance } from 'fastify';
import { entities, fields, modules, requirements } from '../../generated/catalog.js';
export function registerCatalogRoutes(app: FastifyInstance) {
  app.get('/catalog/modules', async () => ({ data: modules }));
  app.get('/catalog/requirements', async (request) => { const q = request.query as { module?: string; priority?: string }; return { data: requirements.filter((r) => (!q.module || r.module === q.module) && (!q.priority || r.priority === q.priority)) }; });
  app.get('/catalog/entities', async (request) => { const q = request.query as { module?: string }; return { data: entities.filter((e) => !q.module || e.module === q.module) }; });
  app.get('/catalog/fields', async (request) => { const q = request.query as { table?: string }; return { data: fields.filter((f) => !q.table || f.table === q.table) }; });
}
