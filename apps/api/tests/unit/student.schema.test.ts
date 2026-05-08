import { describe, expect, it } from 'vitest';
import { studentCreateSchema } from '../../src/modules/students/student.schemas.js';

describe('studentCreateSchema', () => {
  it('aceita payload mínimo válido', () => {
    const result = studentCreateSchema.safeParse({
      fullName: 'Maria Silva',
      birthDate: '2014-02-10',
    });

    expect(result.success).toBe(true);
  });

  it('recusa data fora do formato ISO yyyy-mm-dd', () => {
    const result = studentCreateSchema.safeParse({
      fullName: 'Maria Silva',
      birthDate: '10/02/2014',
    });

    expect(result.success).toBe(false);
  });
});
