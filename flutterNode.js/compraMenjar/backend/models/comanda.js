const mongoose = require('mongoose');


const ComandaSchema = new mongoose.Schema({
  client: { type: String, required: true },
  menjarId: { type: mongoose.Schema.Types.ObjectId, ref: 'Menjar', required: true },
  adreça: { type: String, required: true },
  estat: { type: String, default: 'pendent' }
});


module.exports = mongoose.model('Comanda', ComandaSchema);
