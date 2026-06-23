// Define as rotas da API relacionadas aos veículos.
// Organiza os endpoints utilizados pelo sistema.
// Define as rotas da API relacionadas aos veículos.

const express = require('express');
const router = express.Router();

router.get('/veiculos');
router.get('/veiculos/:id');
router.post('/veiculos');
router.put('/veiculos/:id');
router.delete('/veiculos/:id');

module.exports = router;
