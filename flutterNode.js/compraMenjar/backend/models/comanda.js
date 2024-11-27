const mongoose = require('mongoose');

const ComandaSchema = new mongoose.Schema({
  nomClient: { type: String, required: true },
  direccio: { type: String, required: true },
});

module.exports = mongoose.model('Comanda', ComandaSchema);
