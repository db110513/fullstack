const router = require('express').Router();
const Pel·lícula = require('../models/Peli');

router.post('/creaPeli', async (req, res) => {
  try {
    const novaPel·lícula = new Pel·lícula(req.body);
    const pel·lículaDesada = await novaPel·lícula.save();
    res.status(201).json(pel·lículaDesada);
  } 
  catch (err) {
    res.status(500).json(err);
  }
});

router.get('/pelis', async (req, res) => {
  try {
    const pel·lícules = await Pel·lícula.find();
    res.status(200).json(pel·lícules);
  } 
  catch (err) {
    res.status(500).json(err);
  }
});

router.get('/obtePeli/:id', async (req, res) => {
  try {
    const pel·lícula = await Pel·lícula.findById(req.params.id);
    if (!pel·lícula) return res.status(404).json('Pel·lícula no trobada');
    res.status(200).json(pel·lícula);
  }
   catch (err) {
    res.status(500).json(err);
  }
});

router.put('modificaPeli/:id', async (req, res) => {
  try {
    const pel·lículaActualitzada = await Pel·lícula.findByIdAndUpdate(
      req.params.id,
      { $set: req.body },
      { new: true }
    );
    res.status(200).json(pel·lículaActualitzada);
  } catch (err) {
    res.status(500).json(err);
  }
});

router.delete('/eliminaPeli/:id', async (req, res) => {
  try {
    await Pel·lícula.findByIdAndDelete(req.params.id);
    res.status(200).json('La pel·lícula ha estat eliminada');
  } catch (err) {
    res.status(500).json(err);
  }
});

module.exports = router;
