import { describe, expect, it } from 'vitest';
import { hasAnyRole } from '../../src/core/auth/tenant-context.js';

describe('hasAnyRole', () => {
  it('retorna true quando perfil está autorizado', () => {
    expect(
      hasAnyRole(
        { id: 'tenant', userId: 'user', roles: ['secretaria'], unitIds: [] },
        ['direcao', 'secretaria'],
      ),
    ).toBe(true);
  });

  it('retorna false quando perfil não está autorizado', () => {
    expect(
      hasAnyRole(
        { id: 'tenant', userId: 'user', roles: ['professor'], unitIds: [] },
        ['financeiro'],
      ),
    ).toBe(false);
  });
});
