const repo = require('../repositories/entregaRepository');
const motoristaService = require('./motoristaService');
const veiculoService = require('./veiculoService');
const { AppError, isBlank } = require('../utils');
const STATUS = ['Pendente', 'Em Transporte', 'Entregue', 'Cancelada'];
async function validarEntrega(data) { if (isBlank(data.origem)) throw new AppError('Origem é obrigatória'); if (isBlank(data.destino)) throw new AppError('Destino é obrigatório'); if (isBlank(data.motoristaId)) throw new AppError('Motorista é obrigatório'); if (isBlank(data.veiculoId)) throw new AppError('Veículo é obrigatório'); if (data.status && !STATUS.includes(data.status)) throw new AppError('Status inválido'); await motoristaService.get(data.motoristaId); await veiculoService.get(data.veiculoId); }
async function list() { return repo.findAll(); }
async function get(id) { const item = await repo.findById(id); if (!item) throw new AppError('Entrega não encontrada', 404); return item; }
async function create(data) { await validarEntrega(data); return repo.create(data); }
async function update(id, data) { await get(id); await validarEntrega(data); return repo.update(id, data); }
async function updateStatus(id, status) { await get(id); if (!STATUS.includes(status)) throw new AppError('Status inválido'); return repo.updateStatus(id, status); }
async function remove(id) { await get(id); return repo.remove(id); }
module.exports = { list, get, create, update, updateStatus, remove, validarEntrega, STATUS };
