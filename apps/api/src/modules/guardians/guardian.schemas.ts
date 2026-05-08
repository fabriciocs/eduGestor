import { z } from 'zod';

export const guardianCreateSchema = z.object({
  fullName: z.string().min(2).max(180),
  email: z.string().email().optional(),
  phone: z.string().min(8).max(30).optional(),
  documentNumber: z.string().min(5).max(30).optional(),
  status: z.enum(['active', 'inactive']).default('active'),
});

export const guardianUpdateSchema = guardianCreateSchema.partial();

export const guardianIdParamsSchema = z.object({
  id: z.string().uuid(),
});

export const linkGuardianSchema = z.object({
  studentId: z.string().uuid(),
  guardianId: z.string().uuid(),
  relationship: z.string().min(2).max(80),
  isFinancialResponsible: z.boolean().default(false),
  isPedagogicalResponsible: z.boolean().default(true),
});
