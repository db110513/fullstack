const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const path = require('path');
const axios = require('axios'); // Afegim axios per fer peticions HTTP

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

app.post('/api/temps', async (req, res) => {
  const { nom } = req.body;

  if (!nom) {
    return res.status(400).json({ error: 'El nom de la localitat és obligatori' });
  }

  try {
    const apiURL = `https://wttr.in/${encodeURIComponent(nom)}?format=%C+%t`;
    const response = await axios.get(apiURL);
    const [temps, temperatura] = response.data.split(' ');

    res.status(200).json({ temps, temperatura });
  } catch (error) {
    console.error('Error obtenint dades de temps:', error.message);
    res.status(500).json({ error: 'No s\'han pogut obtenir dades de temps per aquesta localitat.' });
  }
});

app.listen(PORT, () => console.log(`Servidor actiu al port ${PORT}`));