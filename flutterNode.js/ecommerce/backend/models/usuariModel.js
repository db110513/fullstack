const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const UsuariSchema = new mongoose.Schema({
  nom: {
    type: String,
    required: true,
  },
  contrassenya: {
    type: String,
    required: true,
  },
});

// Hash la contrassenya abans de guardar
UsuariSchema.pre('save', async function(next) {
  if (!this.isModified('contrassenya')) {
    return next();
  }
  this.contrassenya = await bcrypt.hash(this.contrassenya, 10);
  next();
});

module.exports = mongoose.model('Usuari', UsuariSchema);
