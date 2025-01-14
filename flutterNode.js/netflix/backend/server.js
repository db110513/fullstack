const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');

dotenv.config();

const app = express();
app.use(express.json());

mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
.then(() => console.log('Connectat a MongoDB'))
.catch((err) => console.error('Error de connexió a MongoDB:', err));

app.use('/api/users', require('./routes/users'));
app.use('/api/movies', require('./routes/movies'));
app.use('/api/lists', require('./routes/lists'));

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Servidor funcionant al port ${PORT}`));
