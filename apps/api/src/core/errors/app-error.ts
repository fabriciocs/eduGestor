export type AppErrorCode =
  | 'UNAUTHENTICATED'
  | 'FORBIDDEN'
  | 'NOT_FOUND'
  | 'VALIDATION_ERROR'
  | 'CONFLICT'
  | 'INTERNAL_ERROR';

export class AppError extends Error {
  public readonly statusCode: number;
  public readonly code: AppErrorCode;
  public readonly details?: unknown;

  constructor(
    code: AppErrorCode,
    message: string,
    statusCode: number,
    details?: unknown,
  ) {
    super(message);
    this.name = 'AppError';
    this.code = code;
    this.statusCode = statusCode;
    this.details = details;
  }

  static unauthenticated(message = 'Autenticação obrigatória.') {
    return new AppError('UNAUTHENTICATED', message, 401);
  }

  static forbidden(message = 'Acesso negado.') {
    return new AppError('FORBIDDEN', message, 403);
  }

  static notFound(message = 'Recurso não encontrado.') {
    return new AppError('NOT_FOUND', message, 404);
  }

  static validation(message = 'Payload inválido.', details?: unknown) {
    return new AppError('VALIDATION_ERROR', message, 400, details);
  }

  static conflict(message = 'Conflito de dados.', details?: unknown) {
    return new AppError('CONFLICT', message, 409, details);
  }
}
