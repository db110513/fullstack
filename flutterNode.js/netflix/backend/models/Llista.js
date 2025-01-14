const mongoose = require('mongoose');

const EsquemaLlista = new mongoose.Schema({
  títol: { type: String, required: true, unique: true },
  tipus: { type: String },
  gènere: { type: String },
  contingut: { type: Array },
}, { timestamps: true });

module.exports = mongoose.model('Llista', EsquemaLlista);
