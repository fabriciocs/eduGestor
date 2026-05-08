import { describe, expect, it, vi } from 'vitest';
import { AppError } from '../../src/core/errors/app-error.js';

vi.mock('../../src/modules/finance/finance.repository.js', () => ({
  listCharges: vi.fn(),
  getFinancialDashboard: vi.fn(),
  createCharge: vi.fn(),
  createBillingPlan: vi.fn(),
  registerPayment: vi.fn(),
  cancelCharge: vi.fn(),
  markOverdue: vi.fn(),
}));

describe('finance service authorization', async () => {
  const service = await import('../../src/modules/finance/finance.service.js');

  it('blocks charge creation without finance write role', async () => {
    await expect(service.createCharge(
      {
        id: 'tenant-id',
        userId: 'user-id',
        roles: ['professor'],
        unitIds: [],
      },
      {
        studentId: '00000000-0000-0000-0000-000000000001',
        description: 'Mensalidade',
        amountInCents: 10000,
        dueDate: '2026-02-10',
      },
    )).rejects.toBeInstanceOf(AppError);
  });

  it('requires financial charge linkage', async () => {
    await expect(service.createCharge(
      {
        id: 'tenant-id',
        userId: 'user-id',
        roles: ['financeiro'],
        unitIds: [],
      },
      {
        description: 'Mensalidade',
        amountInCents: 10000,
        dueDate: '2026-02-10',
      },
    )).rejects.toBeInstanceOf(AppError);
  });
});
