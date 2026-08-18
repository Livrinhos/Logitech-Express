const request = require('supertest');
const app = require('../src/app');

describe('Smoke Test - Verificação de Ambiente', () => {
  test('Deve responder com status 200 na rota /health', async () => {
    const response = await request(app).get('/health');

    expect(response.statusCode).toBe(200);
  });
});
