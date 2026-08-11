class AppError extends Error {
  constructor(message, statusCode = 400) {
    super(message);
    this.statusCode = statusCode;
  }
}

const ok = (res, data, message = 'Operação realizada com sucesso') => res.json({ success: true, message, data });
const created = (res, data, message = 'Registro criado com sucesso') => res.status(201).json({ success: true, message, data });
const isBlank = (value) => value === undefined || value === null || String(value).trim() === '';
const toPositiveNumber = (value) => {
  const parsed = Number(value);
  return Number.isFinite(parsed) && parsed > 0 ? parsed : null;
};

module.exports = { AppError, ok, created, isBlank, toPositiveNumber };
