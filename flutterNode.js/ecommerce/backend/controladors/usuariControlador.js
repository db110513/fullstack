const Usuari = require('../models/usuariModel');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

exports.registrarUsuari = async (req, res) => {
  try {
    console.log('Dades rebudes per al registre:', req.body);

    const { nom, contrassenya } = req.body;

    const nouUsuari = new Usuari({ nom, contrassenya });
    await nouUsuari.save();

    res.status(201).json(nouUsuari);
  } 
  catch (error) {
    res.status(400).json({ error: error.message });
  }
};

exports.iniciarSessio = async (req, res) => {
  try {
    const { nom, contrassenya } = req.body;

    const usuari = await Usuari.findOne({ nom });
    if (!usuari) {
      return res.status(400).json({ error: 'Nom o contrassenya incorrecta' });
    }

    const esCorrecte = await bcrypt.compare(contrassenya, usuari.contrassenya);
    if (!esCorrecte) {
      return res.status(400).json({ error: 'Nom o contrassenya incorrecta' });
    }

    const token = jwt.sign({ id: usuari._id }, 'clau_secreta', { expiresIn: '1h' });

    res.status(200).json({ token });
  } 
  catch (error) {
    res.status(400).json({ error: error.message });
  }
};