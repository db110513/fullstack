const express = require('express');
const Menjar = require('../models/menjar');

const router = express.Router();

router.get('/', async (req, res) => {
  const menjar = await Menjar.find();
  res.send(menjar);
});

router.post('/', async (req, res) => {
  try {
    const nouMenjar = new Menjar(req.body);
    await nouMenjar.save();
    res.status(201).send(nouMenjar);
  } catch (error) {
    res.status(400).send(error);
  }
});

module.exports = router;
