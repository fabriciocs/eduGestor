import { describe, expect, it } from 'vitest';
import { readFileSync } from 'node:fs';
import YAML from 'yaml';

describe('OpenAPI', () => {
  it('declara rotas principais do MVP núcleo', () => {
    const document = YAML.parse(
      readFileSync('src/openapi/openapi.yaml', 'utf8'),
    );
    expect(document.paths['/v1/students']).toBeDefined();
    expect(document.paths['/v1/guardians']).toBeDefined();
    expect(document.components.securitySchemes.bearerAuth).toBeDefined();
  });
});
