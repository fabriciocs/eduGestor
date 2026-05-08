import { describe, expect, it } from 'vitest';
import { enrollmentCreateSchema } from '../../src/modules/enrollment/enrollment.schemas.js';

describe('enrollmentCreateSchema', () => {
  it('valida matrícula com cobrança inicial completa', () => {
    const result = enrollmentCreateSchema.parse({
      student: {
        fullName: 'Maria Eduarda Silva',
        birthDate: '2017-03-20',
      },
      guardian: {
        fullName: 'João Silva',
        email: 'joao@example.com',
        phone: '11999999999',
      },
      enrollment: {
        schoolYearId: '11111111-1111-4111-8111-111111111111',
        enrollmentNumber: '2026-0001',
      },
      billing: {
        generateInitialCharge: true,
        amountInCents: 120000,
        dueDate: '2026-01-10',
      },
    });

    expect(result.student.fullName).toBe('Maria Eduarda Silva');
    expect(result.enrollment.situation).toBe('PRE_MATRICULA');
  });

  it('rejeita CPF em formato inválido', () => {
    expect(() => enrollmentCreateSchema.parse({
      student: {
        fullName: 'Aluno Teste',
        birthDate: '2018-01-01',
        cpf: '123',
      },
      enrollment: {
        schoolYearId: '11111111-1111-4111-8111-111111111111',
      },
    })).toThrow();
  });
});
