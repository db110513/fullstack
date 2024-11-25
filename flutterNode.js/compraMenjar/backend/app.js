const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const menjarRoutes = require('./rutes/menjar');
const comandaRoutes = require('./rutes/comandes');
const usuarisRoutes = require('./rutes/usuaris');
const afegirPlatRoutes = require('./rutes/afegirPlat'); 

const app = express();
const PORT = process.env.PORT || 3000;

// Utilitza express.json() per analitzar les sol·licituds amb càrregues útils JSON
app.use(express.json());
app.use(cors()); 

mongoose.connect('mongodb://localhost:27017/compra-menjar', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
.then(() => console.log('Connexió a la base de dades correcta'))
.catch(error => console.error('Error en connectar', error));

app.use('/usuaris', usuarisRoutes);
app.use('/menjar', menjarRoutes);
app.use('/comandes', comandaRoutes);
app.use('/afegir-plat', afegirPlatRoutes);  

app.listen(PORT, () => console.log(`Servidor actiu al port ${PORT}`));

app.get('/', (req, res) => {
  res.send('Servidor actiu!');
});