const mongoose = require('mongoose');

const EsquemaUsuari = new mongoose.Schema({
  nomUsuari: { type: String, required: true, unique: true },
  correu: { type: String, required: true, unique: true },
  contrasenya: { type: String, required: true },
  esAdmin: { type: Boolean, default: false },
}, { timestamps: true });

module.exports = mongoose.model('Usuari', EsquemaUsuari);
