import { FastifyInstance } from 'fastify';
import { validateInput } from '../../core/validation/validate.js';
import {
  billingPlanSchema,
  chargeCancelSchema,
  chargeCreateSchema,
  financeListSchema,
  paramsIdSchema,
  paymentCreateSchema,
} from './finance.schemas.js';
import * as service from './finance.service.js';

export function registerFinanceRoutes(app: FastifyInstance) {
  app.get('/finance/dashboard', async (request) => service.getFinancialDashboard(request.tenant!));

  app.get('/finance/charges', async (request) => {
    const input = validateInput(financeListSchema, request.query);
    return service.listCharges(request.tenant!, input);
  });

  app.post('/finance/charges', async (request, reply) => {
    const input = validateInput(chargeCreateSchema, request.body);
    const output = await service.createCharge(request.tenant!, input);
    return reply.status(201).send(output);
  });

  app.post('/finance/billing-plans', async (request, reply) => {
    const input = validateInput(billingPlanSchema, request.body);
    const output = await service.createBillingPlan(request.tenant!, input);
    return reply.status(201).send(output);
  });

  app.post('/finance/payments', async (request, reply) => {
    const input = validateInput(paymentCreateSchema, request.body);
    const output = await service.registerPayment(request.tenant!, input);
    return reply.status(201).send({ data: output });
  });

  app.post('/finance/charges/:id/cancel', async (request) => {
    const { id } = validateInput(paramsIdSchema, request.params);
    const input = validateInput(chargeCancelSchema, request.body);
    return service.cancelCharge(request.tenant!, id, input);
  });

  app.post('/finance/charges/mark-overdue', async (request) => service.markOverdue(request.tenant!));
}
