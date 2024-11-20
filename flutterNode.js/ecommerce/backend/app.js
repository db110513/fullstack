const express = require('express');
const connectDB = require('./config/db');
const productRoutes = require('./rutes/rutesProducte');
const userRoutes = require('./rutes/rutesUsuari');

const app = express();

connectDB();

app.use(express.json());

app.use('/api', productRoutes);
app.use('/api/usuari', userRoutes);

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => console.log(`Servidor actiu al port ${PORT}`));
