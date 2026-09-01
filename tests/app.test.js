const request = require('supertest');

jest.mock('../src/services/motoristaService', () => ({
  list: jest.fn().mockResolvedValue([]),
  get: jest.fn().mockImplementation(async (id) => {
    if (id === '9999') {
      const error = new Error('Motorista não encontrado');
      error.statusCode = 404;
      throw error;
    }
    return { id, nome: 'João da Silva', cpf: '123.456.789-00', telefone: '(49) 99999-9999' };
  }),
  create: jest.fn().mockResolvedValue({
    id: 1,
    nome: 'João da Silva',
    cpf: '123.456.789-00',
    telefone: '(49) 99999-9999',
  }),
  update: jest.fn().mockResolvedValue({
    id: '1',
    nome: 'João da Silva Atualizado',
    cpf: '123.456.789-00',
    telefone: '(49) 98888-8888',
  }),
  remove: jest.fn().mockResolvedValue(undefined),
}));

const app = require('../src/app');

describe('Testes da API LogiTech Express', () => {
  test('Caminho feliz: GET /health deve retornar 200', async () => {
    const response = await request(app).get('/health');

    expect(response.statusCode).toBe(200);
    expect(response.body.success).toBe(true);
  });

  test('Caminho feliz: GET /api/motoristas deve retornar 200', async () => {
    const response = await request(app).get('/api/motoristas');

    expect(response.statusCode).toBe(200);
    expect(response.body.success).toBe(true);
  });

  test('Erro 404: rota inexistente deve retornar 404', async () => {
    const response = await request(app).get('/api/rota-inexistente');

    expect(response.statusCode).toBe(404);
    expect(response.body.success).toBe(false);
  });

  test('Erro 404: motorista inexistente deve retornar 404', async () => {
    const response = await request(app).get('/api/motoristas/9999');

    expect(response.statusCode).toBe(404);
    expect(response.body.success).toBe(false);
    expect(response.body.message).toBe('Motorista não encontrado');
  });

  test('Erro 400: cadastro sem nome deve retornar 400', async () => {
    const response = await request(app)
      .post('/api/motoristas')
      .send({ cpf: '123.456.789-00', telefone: '(49) 99999-9999' });

    expect(response.statusCode).toBe(400);
    expect(response.body.success).toBe(false);
    expect(response.body.message).toBe('Nome do motorista é obrigatório');
  });

  test('Mutação: POST /api/motoristas deve criar um motorista', async () => {
    const response = await request(app)
      .post('/api/motoristas')
      .send({
        nome: 'João da Silva',
        cpf: '123.456.789-00',
        telefone: '(49) 99999-9999',
      });

    expect(response.statusCode).toBe(201);
    expect(response.body.success).toBe(true);
    expect(response.body.data.id).toBe(1);
  });

  test('Mutação: PUT /api/motoristas/:id deve atualizar um motorista', async () => {
    const response = await request(app)
      .put('/api/motoristas/1')
      .send({
        nome: 'João da Silva Atualizado',
        cpf: '123.456.789-00',
        telefone: '(49) 98888-8888',
      });

    expect(response.statusCode).toBe(200);
    expect(response.body.success).toBe(true);
  });

  test('Mutação: DELETE /api/motoristas/:id deve excluir um motorista', async () => {
    const response = await request(app).delete('/api/motoristas/1');

    expect(response.statusCode).toBe(200);
    expect(response.body.success).toBe(true);
  });
});
