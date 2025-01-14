const mongoose = require('mongoose');

const EsquemaPel·lícula = new mongoose.Schema({
  títol: { type: String, required: true, unique: true },
  descripció: { type: String },
  imatge: { type: String },
  imatgeTítol: { type: String },
  tràiler: { type: String },
  vídeo: { type: String },
  any: { type: String },
  límitEdat: { type: Number },
  gènere: { type: String },
  esSèrie: { type: Boolean, default: false },
}, { timestamps: true });

module.exports = mongoose.model('Pel·lícula', EsquemaPel·lícula);
