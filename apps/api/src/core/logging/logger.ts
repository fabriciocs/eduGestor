import pino from 'pino';
import { env } from '../../config/env.js';

const redact = [
  'req.headers.authorization',
  'authorization',
  'password',
  'token',
  'access_token',
  'refresh_token',
  'SUPABASE_SERVICE_ROLE_KEY',
  '*.cpf',
  '*.document_number',
];

export const logger = pino({
  level: env.API_LOG_LEVEL,
  redact,
  base: { service: 'edugestor-api' },
});
