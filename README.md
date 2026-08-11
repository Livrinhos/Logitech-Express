````markdown
# LogiTech Express - Backend

Backend da plataforma LogiTech Express, responsável pelo gerenciamento de motoristas, veículos, rotas e entregas.

## Objetivo

Estruturar uma arquitetura escalável e organizada para suportar as operações logísticas da empresa, garantindo integridade dos dados, facilidade de manutenção e segurança das informações.

## Arquitetura

O projeto segue os padrões:

- MVC (Model-View-Controller)
- Repository Pattern

### Estrutura

```text
Logitech-Express/
├── public/
│   ├── index.html
│   └── app.js
├── src/
│   ├── config/
│   ├── controllers/
│   ├── models/
│   ├── repositories/
│   ├── routes/
│   ├── services/
│   └── app.js
├── banco_logiexpress.sql
├── .env.example
├── .gitignore
├── package.json
├── package-lock.json
├── README.md
└── TESTES.md
````

## Requisitos

Para executar o projeto localmente, é necessário ter instalado:

* Node.js
* npm
* MySQL
* Git

## Instalação local

### 1. Clonar o repositório

```bash
git clone https://github.com/LivrInhos/Logitech-Express.git
```

Entre na pasta do projeto:

```bash
cd Logitech-Express
```

### 2. Instalar as dependências

Execute:

```bash
npm install
```

Esse comando instala todas as dependências necessárias para executar o projeto.

### 3. Configurar o banco de dados

O projeto possui o arquivo:

```text
banco_logiexpress.sql
```

Importe esse arquivo no MySQL para criar a estrutura necessária para o funcionamento do sistema.

Certifique-se de que o servidor MySQL esteja em execução.

### 4. Configurar o arquivo `.env`

Crie um arquivo `.env` na raiz do projeto utilizando o `.env.example` como modelo.

Exemplo:

```env
PORT=3000
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=logiexpress
CORS_ORIGIN=*
```

Configure os valores de acordo com o seu ambiente.

> O arquivo `.env` não deve ser enviado para o GitHub.

### 5. Iniciar o projeto

Execute:

```bash
npm start
```

O arquivo `src/app.js` será responsável por iniciar a aplicação.

Quando a API estiver funcionando, será disponibilizada em:

```text
http://localhost:3000
```

## Acessar o sistema

Com o servidor em execução, abra no navegador:

```text
http://localhost:3000/
```

O frontend localizado na pasta `public/` será carregado pelo servidor.

## Verificar a API

Para verificar se a API está funcionando, acesse:

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

### Motoristas

* `GET /motoristas`
* `GET /motoristas/:id`
* `POST /motoristas`
* `PUT /motoristas/:id`
* `DELETE /motoristas/:id`

### Veículos

* `GET /veiculos`
* `GET /veiculos/:id`
* `POST /veiculos`
* `PUT /veiculos/:id`
* `DELETE /veiculos/:id`

### Entregas

* `GET /entregas`
* `GET /entregas/:id`
* `POST /entregas`
* `PUT /entregas/:id`
* `DELETE /entregas/:id`

### Health Check

* `GET /health`

## Testes

Os endpoints podem ser testados utilizando ferramentas como:

* Postman
* Thunder Client
* Insomnia
* Navegador para requisições GET

Os testes da API estão documentados no arquivo:

```text
TESTES.md
```

## Segurança

As credenciais do sistema devem ser armazenadas em variáveis de ambiente através do arquivo `.env`.

O arquivo `.env` não deve ser versionado, sendo ignorado pelo Git através do `.gitignore`.

Nunca compartilhe credenciais do banco de dados.

## Execução rápida

Depois de configurar o banco de dados e o `.env`:

```bash
npm install
npm start
```

Acesse:

```text
http://localhost:3000/
```

Para verificar a API:

```text
http://localhost:3000/health
```
