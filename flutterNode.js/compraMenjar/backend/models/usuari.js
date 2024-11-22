const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const UsuariSchema = new mongoose.Schema({
  nom: { type: String, required: true },
  correu: { type: String, required: true, unique: true },
  contrasenya: { type: String, required: true }
});


UsuariSchema.pre('save', async function (next) {
  if (this.isModified('contrasenya')) {
    this.contrasenya = await bcrypt.hash(this.contrasenya, 10);
  }
  next();
});


UsuariSchema.methods.verificarContrasenya = async function (contrasenya) {
  return await bcrypt.compare(contrasenya, this.contrasenya);
};

module.exports = mongoose.model('Usuari', UsuariSchema);
