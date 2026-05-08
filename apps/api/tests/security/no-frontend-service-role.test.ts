import { describe, expect, it } from 'vitest';
import { readFileSync, readdirSync, statSync } from 'node:fs';
import { join } from 'node:path';
function files(dir: string): string[] { return readdirSync(dir).flatMap((name) => { const path = join(dir, name); return statSync(path).isDirectory() ? files(path) : [path]; }); }
describe('secret boundaries', () => { it('does not expose service role usage in Flutter frontend', () => { const frontendFiles = files(new URL('../../../web_flutter/lib', import.meta.url).pathname); const content = frontendFiles.map((file) => readFileSync(file, 'utf8')).join('\n'); expect(content).not.toContain('SUPABASE_SERVICE_ROLE_KEY'); expect(content).not.toContain('service_role'); }); });
