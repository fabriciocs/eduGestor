import { FastifyInstance } from 'fastify';
import { validateInput } from '../../core/validation/validate.js';
import { paginationSchema } from '../../core/http/pagination.js';
import { studentCreateSchema, studentIdParamsSchema, studentUpdateSchema } from './student.schemas.js';
import * as service from './student.service.js';

export function registerStudentRoutes(app: FastifyInstance) {
  app.get('/students', async (request) => {
    const pagination = { page: 1, pageSize: 20, ...validateInput(paginationSchema, request.query) };
    return service.listStudents(request.tenant!, pagination);
  });

  app.get('/students/:id', async (request) => {
    const params = validateInput(studentIdParamsSchema, request.params);
    return service.getStudent(request.tenant!, params.id);
  });

  app.post('/students', async (request, reply) => {
    const input = validateInput(studentCreateSchema, request.body);
    const student = await service.createStudent(request.tenant!, input);
    return reply.status(201).send(student);
  });

  app.patch('/students/:id', async (request) => {
    const params = validateInput(studentIdParamsSchema, request.params);
    const input = validateInput(studentUpdateSchema, request.body);
    return service.updateStudent(request.tenant!, params.id, input);
  });

  app.delete('/students/:id', async (request, reply) => {
    const params = validateInput(studentIdParamsSchema, request.params);
    await service.deleteStudent(request.tenant!, params.id);
    return reply.status(204).send();
  });
}
