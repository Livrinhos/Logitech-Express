const service = require('../services/motoristaService');
const { ok, created } = require('../utils');
exports.list = async (req, res, next) => { try { ok(res, await service.list(), 'Motoristas listados'); } catch (e) { next(e); } };
exports.get = async (req, res, next) => { try { ok(res, await service.get(req.params.id), 'Motorista localizado'); } catch (e) { next(e); } };
exports.create = async (req, res, next) => { try { created(res, await service.create(req.body), 'Motorista cadastrado com sucesso'); } catch (e) { next(e); } };
exports.update = async (req, res, next) => { try { ok(res, await service.update(req.params.id, req.body), 'Motorista atualizado com sucesso'); } catch (e) { next(e); } };
exports.remove = async (req, res, next) => { try { await service.remove(req.params.id); ok(res, null, 'Motorista excluído com sucesso'); } catch (e) { next(e); } };
