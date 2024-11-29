# API

```
npm init -y
npm i express mongoose body-parser jsonwebtoken bcrypt nodemon cors multer
```

### Estructura
```
mkdir models

mkdir rutes

mkdir imatges
```

### Arxius
```
new-item index.js

new-item models/usuari.js

new-item rutes/usuaris.js

new-item rutes/imatges.js

new-item penjarImatges.html

```

### index.js
```
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const path = require('path');

const usuarisRoutes = require('./rutes/usuaris');
const imatgesRoutes = require('./rutes/imatges');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use(cors());

mongoose.connect('mongodb://localhost:27017/BBDD')
.then(() => console.log('Connexió a la base de dades correcta'))
.catch(error => console.error('Error en connectar', error));

app.use('/usuaris', usuarisRoutes);
app.use('/imatges', imatgesRoutes);

app.use('/imatges', express.static(path.join(__dirname, 'imatges')));

app.get('/pujar-imatge', (req, res) => {
  res.sendFile(path.join(__dirname, 'penjarImatges.html'));
});

app.get('/', (req, res) => {
  res.send('Servidor actiu!');
});

app.listen(PORT, () => console.log(`Servidor actiu al port ${PORT}`));
```
### penjarImatges.html
```
<!DOCTYPE html>
<html lang="ca">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DBG</title>
    <style>
        #previsualitzacio {
            margin-top: 30px; /* Augmenta l'espai entre el formulari i la imatge */
        }
        #previsualitzacio img {
            max-width: 300px;
            border: 2px solid #ddd;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <h3>Pujar Imatge</h3>
    <form id="uploadForm">
        <input type="file" name="imatge" accept="image/*" required>
        <button type="submit">Pujar</button> <!-- Només "Pujar" sense nom de fitxer -->
    </form>
    <div id="previsualitzacio"></div>
    <div id="missatge"></div>

    <script>
        document.querySelector('input[type="file"]').addEventListener('change', function(e) {
            const file = e.target.files[0];
            const reader = new FileReader();
            reader.onload = function(event) {
                const img = document.createElement('img');
                img.src = event.target.result;
                document.getElementById('previsualitzacio').innerHTML = '';
                document.getElementById('previsualitzacio').appendChild(img);
            }
            reader.readAsDataURL(file);
        });

        document.getElementById('uploadForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(this);

            fetch('http://localhost:3000/imatges/pujar', {
                method: 'POST',
                body: formData
            })
            .then(response => response.text())
            .then(data => {
                document.getElementById('missatge').textContent = data;
                document.getElementById('uploadForm').reset();
                document.getElementById('previsualitzacio').innerHTML = '';
            })
            .catch(error => {
                console.error('Error:', error);
                document.getElementById('missatge').textContent = 'Error en pujar la imatge';
            });
        });
    </script>
</body>
</html>
```
### rutes/imatges.js
```
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
```

### models/usuari.js
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

### rutes/usuaris.js
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

## package.json
```
"scripts": {
  "dev": "nodemon index"
}
```

##### npm run dev
