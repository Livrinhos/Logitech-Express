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
app.use(express.urlencoded({ extended: true }));

app.get('/health', (req, res) => {
  res.status(200).json({
    success: true,
    message: 'API LogiTech Express online',
  });
});

app.use(motoristaRoutes);
app.use(veiculoRoutes);
app.use(entregaRoutes);

app.use((req, res) => {
  res.status(404).json({
    success: false,
    message: 'Rota não encontrada',
  });
});

app.use((err, req, res, next) => {
  const statusCode = err.statusCode || 500;
  const message = statusCode === 500 ? 'Erro interno do servidor' : err.message;

  if (statusCode === 500) {
    console.error(err);
  }

  res.status(statusCode).json({
    success: false,
    message,
  });
});

async function startServer() {
  const port = process.env.PORT || 3000;
  await initializeDatabase();
  app.listen(port, () => {
    console.log(`API LogiTech Express rodando em http://localhost:${port}`);
  });
}

if (require.main === module) {
  startServer().catch((error) => {
    console.error('Não foi possível iniciar a API:', error.message);
    process.exit(1);
  });
}

module.exports = app;
