// Define as rotas da API relacionadas às entregas.
// Responsável pelo mapeamento dos endpoints de entregas.
// Define as rotas da API relacionadas às entregas.

const express = require('express');
const router = express.Router();

router.get('/entregas');
router.get('/entregas/:id');
router.post('/entregas');
router.put('/entregas/:id');
router.delete('/entregas/:id');

module.exports = router;
