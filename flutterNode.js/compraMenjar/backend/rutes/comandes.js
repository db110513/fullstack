const express = require('express');
const Comanda = require('../models/comanda');

const router = express.Router();

router.get('/', async (req, res) => {
  try {
    const comandes = await Comanda.find();
    res.json(comandes);
  } 
  catch (error) {
    console.error('Error en recuperar comandes:', error);
    res.status(500).json({ error: 'Error en recuperar les comandes' });
  }
});

router.post('/crea', async (req, res) => {
  try {

    console.log('Dades de la comanda: ', req.body);

    const { nomClient, direccio } = req.body;

    if (!nomClient || !direccio) {
      return res.status(400).json({ error: 'El nom del client i la direcció són obligatoris' });
    }

    const novaComanda = new Comanda(req.body);
    await novaComanda.save();
    
    res.status(201).json(novaComanda);
  } catch (error) {
    console.error('Error en crear comanda:', error);
    res.status(500).json({ error: 'Error en crear la comanda' });
  }
});

module.exports = router;