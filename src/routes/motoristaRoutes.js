// Responsável pelas operações de banco de dados dos veículos.
// Realiza consultas e manipulação dos registros.
// Define as rotas da API relacionadas aos motoristas.

const express = require('express');
const router = express.Router();

// Listar motoristas
router.get('/motoristas');

// Buscar motorista por ID
router.get('/motoristas/:id');

// Cadastrar motorista
router.post('/motoristas');

// Atualizar motorista
router.put('/motoristas/:id');

// Excluir motorista
router.delete('/motoristas/:id');

module.exports = router;
