const repo = require('../repositories/veiculoRepository');
const { AppError, isBlank, toPositiveNumber } = require('../utils');
function validate(data) { if (isBlank(data.placa)) throw new AppError('Placa do veículo é obrigatória'); if (isBlank(data.modelo)) throw new AppError('Modelo do veículo é obrigatório'); const cap = toPositiveNumber(data.capacidadeCarga); if (!cap) throw new AppError('Capacidade de carga deve ser maior que zero'); data.capacidadeCarga = cap; data.placa = String(data.placa).toUpperCase(); }
async function validarPlacaDuplicada(placa, ignoreId = null) { const found = await repo.findByPlaca(String(placa).toUpperCase()); if (found && String(found.id) !== String(ignoreId)) throw new AppError('Placa já cadastrada', 409); }
async function list() { return repo.findAll(); }
async function get(id) { const item = await repo.findById(id); if (!item) throw new AppError('Veículo não encontrado', 404); return item; }
async function create(data) { validate(data); await validarPlacaDuplicada(data.placa); return repo.create(data); }
async function update(id, data) { await get(id); validate(data); await validarPlacaDuplicada(data.placa, id); return repo.update(id, data); }
async function remove(id) { await get(id); return repo.remove(id); }
module.exports = { list, get, create, update, remove, validarPlacaDuplicada };
