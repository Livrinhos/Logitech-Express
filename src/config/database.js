const mysql = require('mysql2/promise');
require('dotenv').config();

let pool;

function getPool() {
  if (!pool) {
    pool = mysql.createPool({
      host: process.env.DB_HOST || 'localhost',
      user: process.env.DB_USER || 'root',
      password: process.env.DB_PASSWORD || '',
      database: process.env.DB_NAME || 'LogiTechExpress',
      port: Number(process.env.DB_PORT || 3306),
      waitForConnections: true,
      connectionLimit: Number(process.env.DB_CONNECTION_LIMIT || 10),
      namedPlaceholders: true,
    });
  }
  return pool;
}

async function query(sql, params = []) {
  const [rows] = await getPool().execute(sql, params);
  return rows;
}

module.exports = { getPool, query };
