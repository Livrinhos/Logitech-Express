const express = require('express');
const controller = require('../controllers/motoristaController');
const router = express.Router();
router.get('/motoristas', controller.list);
router.get('/motoristas/:id', controller.get);
router.post('/motoristas', controller.create);
router.put('/motoristas/:id', controller.update);
router.delete('/motoristas/:id', controller.remove);
module.exports = router;
