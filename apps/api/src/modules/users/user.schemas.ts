import { z } from 'zod';

export const userInviteSchema = z.object({
  email: z.string().email(),
  fullName: z.string().min(2).max(160),
  roles: z.array(z.string().min(2)).min(1),
  unitIds: z.array(z.string().uuid()).default([]),
});
