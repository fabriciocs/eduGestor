import { describe, expect, it } from 'vitest';
import { entities, fields, modules, requirements, assertKnownTable } from '../../src/generated/catalog.js';
describe('generated catalog', () => {
  it('covers the complete functional model', () => { expect(requirements).toHaveLength(134); expect(modules).toHaveLength(20); expect(entities).toHaveLength(98); expect(fields.length).toBeGreaterThanOrEqual(1150); });
  it('does not allow arbitrary tables', () => { expect(() => assertKnownTable('aluno')).not.toThrow(); expect(() => assertKnownTable('pg_authid')).toThrow(); });
});
