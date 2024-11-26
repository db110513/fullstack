const multer = require('multer');
const path = require('path');
const fs = require('fs'); 

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

  const filePath = path.join(__dirname, 'imatges', req.file.originalname);
  
  fs.access(filePath, fs.constants.F_OK, (err) => {
    if (!err) {
      return res.status(409).send(`Error: La imatge '${req.file.originalname}' ja existeix.`);
    }

    res.send(`Imatge pujada a l'API.\nNom del fitxer: ${req.file.originalname}`);
  });
});

module.exports = router;