const mongoose = require('mongoose');


const MenjarSchema = new mongoose.Schema({
  nom: { type: String, required: true },
  preu: { type: Number, required: true },
  disponible: { type: Boolean, default: true }
});


module.exports = mongoose.model('Menjar', MenjarSchema);
