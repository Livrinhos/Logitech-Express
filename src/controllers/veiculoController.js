const service = require('../services/veiculoService');
const { ok, created } = require('../utils');
exports.list = async (req, res, next) => { try { ok(res, await service.list(), 'Veículos listados'); } catch (e) { next(e); } };
exports.get = async (req, res, next) => { try { ok(res, await service.get(req.params.id), 'Veículo localizado'); } catch (e) { next(e); } };
exports.create = async (req, res, next) => { try { created(res, await service.create(req.body), 'Veículo cadastrado com sucesso'); } catch (e) { next(e); } };
exports.update = async (req, res, next) => { try { ok(res, await service.update(req.params.id, req.body), 'Veículo atualizado com sucesso'); } catch (e) { next(e); } };
exports.remove = async (req, res, next) => { try { await service.remove(req.params.id); ok(res, null, 'Veículo excluído com sucesso'); } catch (e) { next(e); } };
