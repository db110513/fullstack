const express = require('express');
const app = express();

const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const cors = require('cors');

const menjarRoutes = require('./rutes/menjar');
const comandaRoutes = require('./rutes/comandes');
const usuarisRoutes = require('./rutes/usuaris');

const PORT = process.env.PORT || 3000;

app.use(bodyParser.json());
app.use(cors()); 

mongoose.connect('mongodb://localhost:27017/compra-menjar')
  .then(() => console.log('Connexió a la base de dades correcta'))
  .catch(error => console.error('Error en connectar', error));

app.use('/api/usuaris', usuarisRoutes);
app.use('/api/menjar', menjarRoutes);
app.use('/api/comandes', comandaRoutes);

app.listen(PORT, () => console.log(`Servidor actiu al port ${PORT}`));
