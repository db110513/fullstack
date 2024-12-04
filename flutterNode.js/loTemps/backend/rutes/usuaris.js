const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const Usuari = require('../models/usuari');

const router = express.Router();
const SECRET_KEY = process.env.SECRET_KEY || 'SECRET_KEY'; 

router.post('/registre', async (req, res) => {
  try {
    const { nomUsuari, contrassenya } = req.body;

    console.log(`Dades del registre rebudes: `, req.body);

    if (nomUsuari.length < 3) {
      return res.status(400).json({ error: 'El nom d\'usuari ha de tenir almenys 3 caràcters' });
    }
    if (contrassenya.length < 6) {
      return res.status(400).json({ error: 'La contrasenya ha de tenir almenys 6 caràcters' });
    }

    const usuariExisteix = await Usuari.findOne({ nomUsuari });
    if (usuariExisteix) {
      return res.status(409).json({ error: 'Usuari ja registrat' });
    }

    const contrassenyaEncriptada = await bcrypt.hash(contrassenya, 10);
    const nouUsuari = new Usuari({
      nomUsuari,
      contrassenya: contrassenyaEncriptada,
    });

    await nouUsuari.save();
    res.status(201).json({ success: true, message: 'Usuari registrat correctament' });
  }
  catch (error) {
    console.error('Error en el registre d\'usuari:', error);
    res.status(500).json({ error: 'Error intern del servidor' });
  }
});

router.post('/login', async (req, res) => {
  try {
    const { nomUsuari, contrassenya } = req.body;

    console.log(`Dades del login rebudes: `, req.body);

    if (!nomUsuari || !contrassenya) {
      return res.status(400).json({ error: 'Tots els camps són obligatoris' });
    }

    const usuari = await Usuari.findOne({ nomUsuari });
    if (!usuari) {
      return res.status(400).json({ error: 'Nom d\'usuari o contrassenya incorrectes' });
    }

    const contrasenyaValida = await bcrypt.compare(contrassenya, usuari.contrassenya);
    if (!contrasenyaValida) {
      return res.status(400).json({ error: 'Nom d\'usuari o contrassenya incorrectes' });
    }

    const token = jwt.sign({ id: usuari._id }, SECRET_KEY, { expiresIn: '1h' });

    res.json({ success: true, message: 'Login correcte', token, usuari: nomUsuari });
  } catch (error) {
    console.error('Error en el login d\'usuari:', error);
    res.status(500).json({ error: 'Error intern del servidor' });
  }
});

module.exports = router;