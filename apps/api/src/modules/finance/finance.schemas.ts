import { z } from 'zod';

const dateSchema = z.string().regex(/^\d{4}-\d{2}-\d{2}$/, 'Use o formato yyyy-mm-dd.');
const uuidSchema = z.string().uuid();

export const financeListSchema = z.object({
  page: z.coerce.number().int().min(1).default(1),
  pageSize: z.coerce.number().int().min(1).max(100).default(20),
  search: z.string().trim().min(1).max(120).optional(),
  situation: z.enum(['ABERTA', 'PAGA', 'ATRASADA', 'CANCELADA']).optional(),
  dueFrom: dateSchema.optional(),
  dueTo: dateSchema.optional(),
});

export const chargeCreateSchema = z.object({
  enrollmentId: uuidSchema.optional(),
  studentId: uuidSchema.optional(),
  guardianId: uuidSchema.optional(),
  description: z.string().min(3).max(300),
  amountInCents: z.number().int().positive(),
  dueDate: dateSchema,
  competency: z.string().regex(/^\d{4}-\d{2}$/, 'Competência deve usar yyyy-mm.').optional(),
  externalReference: z.string().max(120).optional(),
});

export const paymentCreateSchema = z.object({
  chargeId: uuidSchema,
  amountInCents: z.number().int().positive(),
  paymentDate: dateSchema.default(() => new Date().toISOString().slice(0, 10)),
  method: z.enum(['DINHEIRO', 'PIX', 'CARTAO', 'BOLETO', 'TRANSFERENCIA', 'OUTRO']),
  externalReference: z.string().max(120).optional(),
  notes: z.string().max(500).optional(),
});

export const paramsIdSchema = z.object({
  id: uuidSchema,
});

export const chargeCancelSchema = z.object({
  reason: z.string().min(3).max(500),
});

export const billingPlanSchema = z.object({
  enrollmentId: uuidSchema,
  studentId: uuidSchema.optional(),
  guardianId: uuidSchema.optional(),
  description: z.string().min(3).max(200),
  installments: z.number().int().min(1).max(24),
  firstDueDate: dateSchema,
  amountInCents: z.number().int().positive(),
  competencyPrefix: z.string().regex(/^\d{4}$/, 'Informe o ano letivo no formato yyyy.').optional(),
});

export type FinanceListInput = z.infer<typeof financeListSchema>;
export type ChargeCreateInput = z.infer<typeof chargeCreateSchema>;
export type PaymentCreateInput = z.infer<typeof paymentCreateSchema>;
export type ChargeCancelInput = z.infer<typeof chargeCancelSchema>;
export type BillingPlanInput = z.infer<typeof billingPlanSchema>;
