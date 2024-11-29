# API

```
npm init -y
npm i express mongoose body-parser jsonwebtoken bcrypt nodemon cors multer
```

## Estructura
```
mkdir models

mkdir rutes

mkdir imatges
```

## Arxius
```
new-item index.js

new-item models/usuari.js

new-item rutes/usuaris.js

new-item rutesimatges.js

new-item penjarImatges.html

```
## 

## package.json
```
"scripts": {
  "dev": "nodemon index"
}
```

## models/usuari.js
```
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const UsuariSchema = new mongoose.Schema({
  nomUsuari: { type: String, required: true, unique: true },
  contrassenya: { type: String, required: true }
});


UsuariSchema.pre('save', async function (next) {
  if (this.isModified('contrassenya')) {
    this.contrasenya = await bcrypt.hash(this.contrassenya, 10);
  }
  next();
});


UsuariSchema.methods.verificarContrasenya = async function (contrassenya) {
  return await bcrypt.compare(contrassenya, this.contrassenya);
};

module.exports = mongoose.model('Usuari', UsuariSchema);
```

## rutes/usuaris.js
```
const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const Usuari = require('../models/usuari');

const router = express.Router();
const SECRET_KEY = process.env.SECRET_KEY || 'compra-menjar'; 

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
```
