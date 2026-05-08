import { beforeEach, describe, expect, it, vi } from 'vitest';

describe('logger', () => {
  beforeEach(() => {
    vi.resetModules();
    vi.stubEnv('SUPABASE_URL', 'https://example.supabase.co');
    vi.stubEnv('SUPABASE_ANON_KEY', 'anon-key');
    vi.stubEnv('SUPABASE_SERVICE_ROLE_KEY', 'service-role-key');
  });

  it('possui configuraÃ§Ã£o de logger inicializada', async () => {
    const { logger } = await import('../../src/core/logging/logger.js');
    expect(logger.level).toBeDefined();
  });
});
