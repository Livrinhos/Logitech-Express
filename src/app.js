const path = require('path');
const express = require('express');
const cors = require('cors');
require('dotenv').config();

const { initializeDatabase } = require('./config/database');
const motoristaRoutes = require('./routes/motoristaRoutes');
const veiculoRoutes = require('./routes/veiculoRoutes');
const entregaRoutes = require('./routes/entregaRoutes');

const app = express();
app.use(cors({ origin: process.env.CORS_ORIGIN || '*' }));
app.use(express.json());
app.use(express.static(path.join(__dirname, '..', 'public')));

app.get('/health', (req, res) => res.json({ success: true, message: 'API LogiTech Express online' }));
app.use('/api', motoristaRoutes, veiculoRoutes, entregaRoutes);

app.use((req, res) => res.status(404).json({ success: false, message: 'Rota não encontrada' }));
app.use((err, req, res, next) => {
  const status = err.statusCode || 500;
  const message = status === 500 ? 'Erro interno do servidor' : err.message;
  if (status === 500) console.error(err);
  res.status(status).json({ success: false, message });
});

if (require.main === module) {
  const port = process.env.PORT || 3000;
  initializeDatabase()
    .then(() => app.listen(port, () => console.log(`LogiTech Express rodando na porta ${port}`)))
    .catch((error) => {
      console.error('Não foi possível inicializar o banco de dados:', error.message);
      process.exit(1);
    });
}
module.exports = app;
