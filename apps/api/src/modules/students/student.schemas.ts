import { z } from 'zod';

export const studentCreateSchema = z.object({
  fullName: z.string().min(2).max(180),
  birthDate: z.string().regex(/^\d{4}-\d{2}-\d{2}$/),
  documentNumber: z.string().min(5).max(30).optional(),
  status: z.enum(['active', 'inactive']).default('active'),
});

export const studentUpdateSchema = studentCreateSchema.partial();

export const studentIdParamsSchema = z.object({
  id: z.string().uuid(),
});
