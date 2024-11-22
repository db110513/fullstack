const express = require('express');
const jwt = require('jsonwebtoken');
const Usuari = require('../models/usuari');

const router = express.Router();
const SECRET_KEY = 'compra-menjar'; 

router.post('/registre', async (req, res) => {
  try {
    const { nom, correu, contrasenya } = req.body;
    const usuariExist = await Usuari.findOne({ correu });

    if (usuariExist) {
      return res.status(400).send({ error: 'Aquest correu ja està registrat' });
    }

    const nouUsuari = new Usuari({ nom, correu, contrasenya });
    await nouUsuari.save();

    res.status(201).send({ message: 'Usuari registrat correctament' });
  } catch (error) {
    res.status(400).send(error);
  }
});


router.post('/login', async (req, res) => {
  try {
    const { correu, contrasenya } = req.body;
    const usuari = await Usuari.findOne({ correu });

    if (!usuari || !(await usuari.verificarContrasenya(contrasenya))) {
      return res.status(400).send({ error: 'Correu o contrasenya incorrectes' });
    }

    const token = jwt.sign({ id: usuari._id, correu: usuari.correu }, SECRET_KEY, {
      expiresIn: '1h', 
    });

    res.send({ message: 'Login correcte', token });
  } catch (error) {
    res.status(400).send(error);
  }
});

module.exports = router;
