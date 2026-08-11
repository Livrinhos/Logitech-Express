const service = require('../services/entregaService');
const { ok, created } = require('../utils');
exports.list = async (req, res, next) => { try { ok(res, await service.list(), 'Entregas listadas'); } catch (e) { next(e); } };
exports.get = async (req, res, next) => { try { ok(res, await service.get(req.params.id), 'Entrega localizada'); } catch (e) { next(e); } };
exports.create = async (req, res, next) => { try { created(res, await service.create(req.body), 'Entrega cadastrada com sucesso'); } catch (e) { next(e); } };
exports.update = async (req, res, next) => { try { ok(res, await service.update(req.params.id, req.body), 'Entrega atualizada com sucesso'); } catch (e) { next(e); } };
exports.remove = async (req, res, next) => { try { await service.remove(req.params.id); ok(res, null, 'Entrega excluída com sucesso'); } catch (e) { next(e); } };
