import 'dotenv/config';
import { z } from 'zod';

const envSchema = z.object({
  APP_ENV: z.string().default('local'),
  API_PORT: z.coerce.number().int().positive().default(3000),
  API_LOG_LEVEL: z.string().default('info'),
  SUPABASE_URL: z.string().url(),
  SUPABASE_ANON_KEY: z.string().min(1),
  SUPABASE_SERVICE_ROLE_KEY: z.string().min(1),
  JWT_AUDIENCE: z.string().default('authenticated'),
  JWT_ISSUER: z.string().optional(),
  CORS_ALLOWED_ORIGINS: z
    .string()
    .default('http://localhost:8080,http://localhost:3000'),
});

export const env = envSchema.parse(process.env);

export const corsOrigins = env.CORS_ALLOWED_ORIGINS.split(',')
  .map((origin) => origin.trim())
  .filter(Boolean);
