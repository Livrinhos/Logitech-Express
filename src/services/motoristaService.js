const repo = require('../repositories/motoristaRepository');
const { AppError, isBlank } = require('../utils');
function validate(data) { if (isBlank(data.nome)) throw new AppError('Nome do motorista é obrigatório'); if (isBlank(data.cpf)) throw new AppError('CPF do motorista é obrigatório'); if (isBlank(data.telefone)) throw new AppError('Telefone do motorista é obrigatório'); }
async function validarCpfDuplicado(cpf, ignoreId = null) { const found = await repo.findByCpf(cpf); if (found && String(found.id) !== String(ignoreId)) throw new AppError('CPF já cadastrado', 409); }
async function list() { return repo.findAll(); }
async function get(id) { const item = await repo.findById(id); if (!item) throw new AppError('Motorista não encontrado', 404); return item; }
async function create(data) { validate(data); await validarCpfDuplicado(data.cpf); return repo.create(data); }
async function update(id, data) { await get(id); validate(data); await validarCpfDuplicado(data.cpf, id); return repo.update(id, data); }
async function remove(id) { await get(id); return repo.remove(id); }
module.exports = { list, get, create, update, remove, validarCpfDuplicado };
