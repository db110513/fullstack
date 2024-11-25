const express = require('express');
const Comanda = require('../models/comanda');

const router = express.Router();

router.get('/', async (req, res) => {
  const comandes = await Comanda.find().populate('menjarId');
  res.send(comandes);
});

router.post('/crea', async (req, res) => {
  try {
    const novaComanda = new Comanda(req.body);
    await novaComanda.save();
    res.status(201).send(novaComanda);
  } 
  catch (error) {
    res.status(400).send(error);
  }
});

module.exports = router;
