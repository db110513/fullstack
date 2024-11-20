const mongoose = require('mongoose');

const ProductSchema = new mongoose.Schema({
  nom: {
    type: String,
    required: true
  },
  preu: {
    type: Number,
    required: true
  }
});

module.exports = mongoose.model('Producte', ProductSchema);
