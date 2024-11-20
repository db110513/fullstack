const express = require('express');
const connectDB = require('./config/db');
const productRoutes = require('./rutes/rutesProducte');

const app = express();

connectDB();

app.use(express.json());

app.use('/api', productRoutes);

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => console.log(`Servidor executant-se al port ${PORT}`));
