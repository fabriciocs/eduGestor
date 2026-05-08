import { z } from 'zod';

export const tenantCreateSchema = z.object({
  legalName: z.string().min(2).max(180),
  tradeName: z.string().min(2).max(120),
  documentNumber: z.string().min(8).max(30),
});

export const tenantUnitCreateSchema = z.object({
  tenantId: z.string().uuid(),
  name: z.string().min(2).max(120),
  code: z.string().min(2).max(30),
});
