const request = require('supertest');
const app = require('../src/app');
const db = require('../src/config/database');

const criarMotorista = (telefone = `(49) 99999-${Date.now().toString().slice(-4)}`) => ({
  nome: 'Motorista Teste',
  cpf: String(Date.now()).slice(-11),
  telefone,
});

describe('Testes de Integração - API LogiTech Express', () => {
  beforeAll(async () => {
    await db.initializeDatabase();
  });

  afterAll(async () => {
    await db.getPool().end();
  });

  test('Caminho feliz: GET /api/motoristas deve retornar 200', async () => {
    const response = await request(app).get('/api/motoristas');

    expect(response.statusCode).toBe(200);
    expect(response.body.success).toBe(true);
    expect(response.body).toHaveProperty('data');
    expect(Array.isArray(response.body.data)).toBe(true);
  });

  test('Caminho feliz: GET /api/motoristas/:id deve retornar o motorista', async () => {
    const motorista = criarMotorista();
    const criado = await request(app).post('/api/motoristas').send(motorista);
    const id = criado.body.data.id;

    const response = await request(app).get(`/api/motoristas/${id}`);

    expect(response.statusCode).toBe(200);
    expect(response.body.success).toBe(true);
    expect(response.body.data).toHaveProperty('id', id);
    expect(response.body.data).toHaveProperty('nome', motorista.nome);

    await request(app).delete(`/api/motoristas/${id}`);
  });

  test('Erro 404: motorista inexistente deve retornar 404', async () => {
    const response = await request(app).get('/api/motoristas/999999');

    expect(response.statusCode).toBe(404);
    expect(response.body.success).toBe(false);
    expect(response.body).toHaveProperty('message', 'Motorista não encontrado');
  });

  test('Erro 404: rota inexistente deve retornar 404', async () => {
    const response = await request(app).get('/api/rota-inexistente');

    expect(response.statusCode).toBe(404);
    expect(response.body.success).toBe(false);
  });

  test('Erro 400: POST sem nome deve retornar 400', async () => {
    const response = await request(app)
      .post('/api/motoristas')
      .send({ cpf: String(Date.now()).slice(-11), telefone: criarMotorista().telefone });

    expect(response.statusCode).toBe(400);
    expect(response.body.success).toBe(false);
    expect(response.body).toHaveProperty('message', 'Nome do motorista é obrigatório');
  });

  test('Erro 409: POST com telefone já cadastrado deve retornar 409', async () => {
    const telefone = criarMotorista().telefone;
    const primeiro = criarMotorista(telefone);
    const segundo = criarMotorista(telefone);

    const criado = await request(app).post('/api/motoristas').send(primeiro);
    const response = await request(app).post('/api/motoristas').send(segundo);

    expect(criado.statusCode).toBe(201);
    expect(response.statusCode).toBe(409);
    expect(response.body.success).toBe(false);
    expect(response.body).toHaveProperty('message', 'Telefone já cadastrado');

    await request(app).delete(`/api/motoristas/${criado.body.data.id}`);
  });

  test('Mutação: POST deve criar um motorista com status 201', async () => {
    const motorista = criarMotorista();
    const response = await request(app).post('/api/motoristas').send(motorista);

    expect(response.statusCode).toBe(201);
    expect(response.body.success).toBe(true);
    expect(response.body.data).toHaveProperty('id');
    expect(response.body.data).toHaveProperty('nome', motorista.nome);

    await request(app).delete(`/api/motoristas/${response.body.data.id}`);
  });

  test('Mutação: PUT deve atualizar um motorista', async () => {
    const motorista = criarMotorista();
    const criado = await request(app).post('/api/motoristas').send(motorista);
    const id = criado.body.data.id;

    const response = await request(app)
      .put(`/api/motoristas/${id}`)
      .send({ nome: 'Motorista Atualizado', cpf: motorista.cpf, telefone: criarMotorista().telefone });

    expect(response.statusCode).toBe(200);
    expect(response.body.success).toBe(true);
    expect(response.body.data).toHaveProperty('id', id);
    expect(response.body.data).toHaveProperty('nome', 'Motorista Atualizado');

    await request(app).delete(`/api/motoristas/${id}`);
  });

  test('Mutação: DELETE deve remover o motorista e o GET seguinte deve retornar 404', async () => {
    const motorista = criarMotorista();
    const criado = await request(app).post('/api/motoristas').send(motorista);
    const id = criado.body.data.id;

    const response = await request(app).delete(`/api/motoristas/${id}`);

    expect(response.statusCode).toBe(200);
    expect(response.body.success).toBe(true);

    const buscaAposDelete = await request(app).get(`/api/motoristas/${id}`);
    expect(buscaAposDelete.statusCode).toBe(404);
    expect(buscaAposDelete.body).toHaveProperty('message', 'Motorista não encontrado');
  });
});
