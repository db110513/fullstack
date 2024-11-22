const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const UsuariSchema = new mongoose.Schema({
  nomUsuari: { type: String, required: true, unique: true },
  contrassenya: { type: String, required: true }
});


UsuariSchema.pre('save', async function (next) {
  if (this.isModified('contrassenya')) {
    this.contrasenya = await bcrypt.hash(this.contrassenya, 10);
  }
  next();
});


UsuariSchema.methods.verificarContrasenya = async function (contrassenya) {
  return await bcrypt.compare(contrassenya, this.contrassenya);
};

module.exports = mongoose.model('Usuari', UsuariSchema);
