const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const cors = require('cors');

const menjarRoutes = require('./rutes/menjar');
const comandaRoutes = require('./rutes/comandes');
const rutesUsuaris = require('./rutes/usuaris');

app.use('/api/usuaris', usuarisRoutes);

const app = express();
app.use(bodyParser.json());
app.use(cors());

mongoose.connect('mongodb://localhost:27017/compra-menjar')
  .then(() => console.log('Connexió a la base de dades correcta'))
  .catch(error => console.error('Error en connectar', error));

app.use('/api/menjar', menjarRoutes);
app.use('/api/comandes', comandaRoutes);

app.listen(3000, () => console.log('Servidor en funcionament al port 3000'));
