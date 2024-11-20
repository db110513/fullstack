const express = require('express');
const router = express.Router();
const { crearProducte, obtenirProductes } = require('../controladors/producteControlador');

router.post('/productes', crearProducte);
router.get('/productes', obtenirProductes);

module.exports = router;
