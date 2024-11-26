const multer = require('multer');
const path = require('path');
const express = require('express');
const router = express.Router();

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'imatges/'); 
  },
  filename: function (req, file, cb) {
    cb(null, file.originalname); 
  }
});

const upload = multer({ storage: storage });

router.post('/pujar', upload.single('imatge'), (req, res) => {
  if (!req.file) {
    return res.status(400).send('No s\'ha pujat cap fitxer.');
  }
  res.send(`Imatge pujada amb èxit! Nom del fitxer: ${req.file.originalname}`);
});

module.exports = router;