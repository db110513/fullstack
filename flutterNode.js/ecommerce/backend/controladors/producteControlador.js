const Producte = require('../models/producteModel');

exports.crearProducte = async (req, res) => {
  try {
    const producte = new Producte(req.body);
    await producte.save();
    res.status(201).json(producte);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

exports.obtenirProductes = async (req, res) => {
  try {
    const productes = await Producte.find();
    res.status(200).json(productes);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};
