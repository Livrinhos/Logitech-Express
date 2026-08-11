const db = require('../config/database');
const fields = 'id_veiculo AS id, placa, modelo, tipo, capacidade AS capacidadeCarga, status';
async function findAll() { return db.query(`SELECT ${fields} FROM Veiculo ORDER BY id_veiculo DESC`); }
async function findById(id) { const rows = await db.query(`SELECT ${fields} FROM Veiculo WHERE id_veiculo = ?`, [id]); return rows[0] || null; }
async function findByPlaca(placa) { const rows = await db.query(`SELECT ${fields} FROM Veiculo WHERE placa = ?`, [placa]); return rows[0] || null; }
async function create(data) { const result = await db.query('INSERT INTO Veiculo (placa, modelo, tipo, capacidade, status) VALUES (?, ?, ?, ?, ?)', [data.placa, data.modelo, data.tipo || null, data.capacidadeCarga, data.status || 'Disponível']); return findById(result.insertId); }
async function update(id, data) { await db.query('UPDATE Veiculo SET placa = ?, modelo = ?, tipo = ?, capacidade = ?, status = ? WHERE id_veiculo = ?', [data.placa, data.modelo, data.tipo || null, data.capacidadeCarga, data.status || 'Disponível', id]); return findById(id); }
async function remove(id) { const result = await db.query('DELETE FROM Veiculo WHERE id_veiculo = ?', [id]); return result.affectedRows > 0; }
module.exports = { findAll, findById, findByPlaca, create, update, remove };
