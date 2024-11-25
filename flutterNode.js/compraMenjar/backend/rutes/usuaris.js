const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const Usuari = require('../models/usuari');

const router = express.Router();
const SECRET_KEY = process.env.SECRET_KEY || 'compra-menjar'; 

router.post('/registre', async (req, res) => {
  try {
    const { nomUsuari, contrassenya } = req.body;

    console.log('Dades rebudes pel registre:', { nomUsuari, contrassenya });

    if (!nomUsuari || !contrassenya) {
      return res.status(400).send({ error: 'Tots els camps són obligatoris' });
    }

    const usuariExisteix = await Usuari.findOne({ nomUsuari });
    if (usuariExisteix) {
      return res.status(409).send({ error: 'Aquest usuari ja està registrat' });
    }

    const contrassenyaEncriptada = await bcrypt.hash(contrassenya, 10);
    const nouUsuari = new Usuari({
      nomUsuari,
      contrassenya: contrassenyaEncriptada,
    });

    await nouUsuari.save();
    res.status(201).send({ success: true, message: 'Usuari registrat correctament' });
  } 
  
  catch (error) {
    res.status(400).json({ error: 'Missatge d\'error' });
  }

});

router.post('/login', async (req, res) => {
  try {

    const { nomUsuari, contrassenya } = req.body;

    console.log('Dades rebudes pel login:', { nomUsuari, contrassenya });

    if (!nomUsuari || !contrassenya) {
      return res.status(400).send({ error: 'Tots els camps són obligatoris' });
    }

    const usuari = await Usuari.findOne({ nomUsuari });
    if (!usuari) {
      return res.status(400).send({ error: 'Nom d\'usuari o contrassenya incorrectes' });
    }

    const contrasenyaValida = await bcrypt.compare(contrassenya, usuari.contrassenya);
    if (!contrasenyaValida) {
      return res.status(400).send({ error: 'Nom d\'usuari o contrassenya incorrectes' });
    }

    const token = jwt.sign({ id: usuari._id }, SECRET_KEY, { expiresIn: '1h' });

    res.send({ success: true, message: 'Login correcte', token, usuari: nomUsuari });
  } catch (error) {
    res.status(500).send({ error: 'Error del servidor', details: error.message });
  }
});


module.exports = router;
