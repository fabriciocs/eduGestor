import { z } from 'zod';
import { AppError } from '../errors/app-error.js';

export function validateInput<TSchema extends z.ZodTypeAny>(
  schema: TSchema,
  input: unknown,
): z.output<TSchema> {
  const result = schema.safeParse(input);
  if (!result.success) {
    throw AppError.validation('Payload invÃ¡lido.', result.error.flatten());
  }
  return result.data;
}
