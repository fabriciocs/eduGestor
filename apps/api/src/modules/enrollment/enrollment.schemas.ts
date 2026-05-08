import { z } from 'zod';

const dateSchema = z.string().regex(/^\d{4}-\d{2}-\d{2}$/, 'Use o formato yyyy-mm-dd.');
const uuidSchema = z.string().uuid();

export const enrollmentCreateSchema = z.object({
  student: z.object({
    id: uuidSchema.optional(),
    fullName: z.string().min(2).max(200),
    birthDate: dateSchema,
    cpf: z.string().regex(/^\d{11}$/, 'CPF deve conter 11 dígitos.').optional(),
  }),
  guardian: z.object({
    id: uuidSchema.optional(),
    fullName: z.string().min(2).max(200),
    cpf: z.string().regex(/^\d{11}$/, 'CPF deve conter 11 dígitos.').optional(),
    email: z.string().email().optional(),
    phone: z.string().min(8).max(20).optional(),
    relationship: z.string().min(2).max(80).default('Responsável financeiro'),
  }).optional(),
  enrollment: z.object({
    schoolYearId: uuidSchema,
    classId: uuidSchema.optional(),
    enrollmentNumber: z.string().min(3).max(50).optional(),
    enrollmentDate: dateSchema.default(() => new Date().toISOString().slice(0, 10)),
    situation: z.enum(['PRE_MATRICULA', 'MATRICULADO', 'AGUARDANDO_DOCUMENTOS']).default('PRE_MATRICULA'),
  }),
  contract: z.object({
    generate: z.boolean().default(true),
    title: z.string().min(3).max(180).default('Contrato educacional'),
    description: z.string().max(1000).optional(),
  }).default({ generate: true, title: 'Contrato educacional' }),
  billing: z.object({
    generateInitialCharge: z.boolean().default(false),
    amountInCents: z.number().int().positive().optional(),
    dueDate: dateSchema.optional(),
    description: z.string().max(300).optional(),
  }).default({ generateInitialCharge: false }),
});

export const enrollmentParamsSchema = z.object({
  id: uuidSchema,
});

export const enrollmentTransitionSchema = z.object({
  nextSituation: z.enum(['PRE_MATRICULA', 'MATRICULADO', 'AGUARDANDO_DOCUMENTOS', 'CANCELADO', 'CONCLUIDO']),
  reason: z.string().min(3).max(500).optional(),
});

export type EnrollmentCreateInput = z.infer<typeof enrollmentCreateSchema>;
export type EnrollmentTransitionInput = z.infer<typeof enrollmentTransitionSchema>;
