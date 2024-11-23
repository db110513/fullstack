const express = require('express');
const multer = require('multer');
const path = require('path');
const Menjar = require('./models/menjar');  
const app = express();

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/');
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname));
  }
});

const upload = multer({ storage: storage });

app.post('/plats', upload.single('imatge'), async (req, res) => {
  try {
    const plat = new Menjar({
      nom: req.body.nom,
      preu: req.body.preu,
      descripcio: req.body.descripcio,
      imatge: req.file ? req.file.path : null
    });

    await plat.save();
    res.status(201).send('Plat afegit amb èxit!');
  } catch (error) {
    res.status(400).send('Error en afegir el plat: ' + error.message);
  }
});