# LogiTech Express - Backend

Backend da plataforma **LogiTech Express**, responsável pelo gerenciamento de motoristas, veículos, rotas e entregas.

## Objetivo

Estruturar uma arquitetura escalável e organizada para suportar as operações logísticas da empresa, garantindo integridade dos dados, facilidade de manutenção e segurança das informações.

## Tecnologias utilizadas

### Backend

- **Node.js** — ambiente de execução JavaScript no servidor
- **Express.js** — framework para criação da API REST
- **MySQL** — banco de dados relacional
- **mysql2** — conexão e integração com o MySQL
- **CORS** — controle de acesso entre diferentes origens
- **dotenv** — gerenciamento de variáveis de ambiente

### Testes

- **Jest** — framework para testes automatizados
- **Supertest** — testes de requisições HTTP e endpoints da API

### Ferramentas

- **npm** — gerenciamento de dependências e scripts
- **Git / GitHub** — versionamento e hospedagem do projeto

## Arquitetura

O projeto segue os padrões:

- MVC (Model-View-Controller)
- Repository Pattern

## Estrutura

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

## Instalação local

### Requisitos

* Node.js
* npm
* MySQL
* Git

### 1. Clonar o repositório

```bash
git clone https://github.com/LivrInhos/Logitech-Express.git
```

Entre na pasta do projeto:

```bash
cd Logitech-Express
```

### 2. Instalar as dependências

```bash
npm install
```

### 3. Configurar o banco de dados

O projeto possui o arquivo:

```text
banco_logiexpress.sql
```

Importe esse arquivo no MySQL para criar a estrutura do banco de dados.

Certifique-se de que o MySQL esteja em execução.

### 4. Configurar o arquivo `.env`

Utilize o arquivo `.env.example` como modelo e crie um arquivo `.env` na raiz do projeto.

Exemplo:

```text
PORT=3000
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=logiexpress
CORS_ORIGIN=*
```

Configure os valores de acordo com o seu ambiente.

O arquivo `.env` não deve ser versionado.

### 5. Iniciar a aplicação

Execute:

```bash
npm start
```

O arquivo `src/app.js` será responsável por iniciar a API.

A aplicação estará disponível em:

```text
http://localhost:3000
```

### 6. Acessar o sistema

Abra no navegador:

```text
http://localhost:3000/
```

O frontend está localizado na pasta `public/`.

### 7. Verificar a API

Acesse:

```text
http://localhost:3000/health
```

Resposta esperada:

```json
{
  "success": true,
  "message": "API LogiTech Express online"
}
```

## Endpoints

As rotas da API utilizam o prefixo `/api`.

### Motoristas

* GET /api/motoristas
* GET /api/motoristas/:id
* POST /api/motoristas
* PUT /api/motoristas/:id
* DELETE /api/motoristas/:id

### Veículos

* GET /api/veiculos
* GET /api/veiculos/:id
* POST /api/veiculos
* PUT /api/veiculos/:id
* DELETE /api/veiculos/:id

### Entregas

* GET /api/entregas
* GET /api/entregas/:id
* POST /api/entregas
* PUT /api/entregas/:id
* DELETE /api/entregas/:id

## Testes

Os testes automatizados estão localizados em `tests/app.test.js` e utilizam **Jest** e **Supertest**.

Para executar:

```bash
npm test
```

### Cenários validados

- **Caminho feliz (200):** verifica o funcionamento da rota `/health` e a listagem de motoristas.
- **Erro 404:** verifica o comportamento para rotas inexistentes e para um motorista que não foi encontrado.
- **Erro 400:** verifica a validação de dados obrigatórios no cadastro de motorista.
- **Mutações:** verifica as operações de criação (`POST`), atualização (`PUT`) e exclusão (`DELETE`) de motoristas.

## Segurança

As credenciais do sistema devem ser armazenadas em variáveis de ambiente através do arquivo `.env`.

O arquivo `.env` não deve ser versionado, sendo ignorado pelo Git através do `.gitignore`.

Nunca compartilhe credenciais do banco de dados.
