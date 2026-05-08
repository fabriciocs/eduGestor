import { readFileSync } from 'node:fs';
import YAML from 'yaml';

const document = YAML.parse(readFileSync(new URL('../src/openapi/openapi.yaml', import.meta.url), 'utf8'));

if (!document.openapi || !document.info || !document.paths) {
  throw new Error('OpenAPI inválido: campos obrigatórios ausentes.');
}

console.log('OpenAPI válido.');
