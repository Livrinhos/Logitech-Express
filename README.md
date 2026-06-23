# LogiTech Express - Backend

Backend da plataforma LogiTech Express, responsável pelo gerenciamento de motoristas, veículos, rotas e entregas.

## Objetivo

Estruturar uma arquitetura escalável e organizada para suportar as operações logísticas da empresa, garantindo integridade dos dados, facilidade de manutenção e segurança das informações.

## Arquitetura

O projeto segue os padrões:

* MVC (Model-View-Controller)
* Repository Pattern

### Estrutura

```text
src/
├── config/
├── controllers/
├── models/
├── repositories/
├── routes/
├── services/
└── app.js
```

## Endpoints Planejados

### Motoristas

* GET /motoristas
* GET /motoristas/:id
* POST /motoristas
* PUT /motoristas/:id
* DELETE /motoristas/:id

### Veículos

* GET /veiculos
* GET /veiculos/:id
* POST /veiculos
* PUT /veiculos/:id
* DELETE /veiculos/:id

### Entregas

* GET /entregas
* GET /entregas/:id
* POST /entregas
* PUT /entregas/:id
* DELETE /entregas/:id

## Segurança

As credenciais do sistema devem ser armazenadas em variáveis de ambiente através do arquivo `.env`.

O arquivo `.env` não deve ser versionado, sendo ignorado pelo Git através do `.gitignore`.

## Próximas Etapas

* Implementação da conexão com banco de dados.
* Desenvolvimento das regras de negócio.
* Implementação dos endpoints.
* Criação dos testes automatizados.
