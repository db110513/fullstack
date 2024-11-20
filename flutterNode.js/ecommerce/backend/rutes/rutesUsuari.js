const express = require('express');
const router = express.Router();
const { registrarUsuari, iniciarSessio } = require('../controladors/usuariControlador');

router.post('/registre', registrarUsuari);
router.post('/inici', iniciarSessio);

module.exports = router;
