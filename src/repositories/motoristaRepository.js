const db = require('../config/database');

const fields = 'id_motorista AS id, nome, cpf, telefone, cnh, status, email';

async function findAll() { return db.query(`SELECT ${fields} FROM Motorista ORDER BY id_motorista DESC`); }
async function findById(id) { const rows = await db.query(`SELECT ${fields} FROM Motorista WHERE id_motorista = ?`, [id]); return rows[0] || null; }
async function findByCpf(cpf) { const rows = await db.query(`SELECT ${fields} FROM Motorista WHERE cpf = ?`, [cpf]); return rows[0] || null; }
async function findByTelefone(telefone) { const rows = await db.query(`SELECT ${fields} FROM Motorista WHERE telefone = ?`, [telefone]); return rows[0] || null; }
async function create(data) {
  const result = await db.query('INSERT INTO Motorista (nome, cpf, telefone, cnh, status, email) VALUES (?, ?, ?, ?, ?, ?)', [data.nome, data.cpf, data.telefone, data.cnh || null, data.status || 'Ativo', data.email || null]);
  return findById(result.insertId);
}
async function update(id, data) {
  await db.query('UPDATE Motorista SET nome = ?, cpf = ?, telefone = ?, cnh = ?, status = ?, email = ? WHERE id_motorista = ?', [data.nome, data.cpf, data.telefone, data.cnh || null, data.status || 'Ativo', data.email || null, id]);
  return findById(id);
}
async function remove(id) { const result = await db.query('DELETE FROM Motorista WHERE id_motorista = ?', [id]); return result.affectedRows > 0; }
module.exports = { findAll, findById, findByCpf, findByTelefone, create, update, remove };
