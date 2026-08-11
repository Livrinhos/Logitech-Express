const express = require('express');
const controller = require('../controllers/veiculoController');
const router = express.Router();
router.get('/veiculos', controller.list);
router.get('/veiculos/:id', controller.get);
router.post('/veiculos', controller.create);
router.put('/veiculos/:id', controller.update);
router.delete('/veiculos/:id', controller.remove);
module.exports = router;
