import { ZodSchema } from 'zod';
import { AppError } from '../errors/app-error.js';

export function validateInput<T>(schema: ZodSchema<T>, input: unknown): T {
  const result = schema.safeParse(input);
  if (!result.success) {
    throw AppError.validation('Payload inválido.', result.error.flatten());
  }
  return result.data;
}
