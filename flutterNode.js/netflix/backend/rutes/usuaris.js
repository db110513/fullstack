const router = require('express').Router();
const Usuari = require('../models/Usuari');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

router.post('/creaUsuari', async (req, res) => {
  try {
    const salt = await bcrypt.genSalt(10);
    const contrasenyaXifrada = await bcrypt.hash(req.body.contrasenya, salt);

    const nouUsuari = new Usuari({
      nomUsuari: req.body.nomUsuari,
      contrasenya: contrasenyaXifrada,
    });

    const usuari = await nouUsuari.save();
    res.status(201).json(usuari);
  } catch (err) {
    res.status(500).json(err);
  }
});

router.post('/login', async (req, res) => {
  try {
    const usuari = await Usuari.findOne({ correu: req.body.correu });
    if (!usuari) return res.status(401).json('Credencials incorrectes');

    const contrasenyaVàlida = await bcrypt.compare(req.body.contrasenya, usuari.contrasenya);
    if (!contrasenyaVàlida) return res.status(401).json('Credencials incorrectes');

    const token = jwt.sign(
      { id: usuari._id, esAdmin: usuari.esAdmin },
      process.env.JWT_SECRET,
      { expiresIn: '5d' }
    );

    const { contrasenya, ...info } = usuari._doc;
    res.status(200).json({ ...info, token });
  } 
  catch (err) {
    res.status(500).json(err);
  }
});

module.exports = router;
