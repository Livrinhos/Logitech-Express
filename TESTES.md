# TESTES.md

# Plano de Testes - LogiTech Express

## Objetivo

Documentar os cenários de teste que serão implementados na próxima Unidade Curricular de Testes de Back-End.

---

# Teste 1 - Cadastro de Motorista

## Endpoint

POST /motoristas

## JSON de Entrada

```json
{
  "nome": "Carlos Silva",
  "cpf": "12345678900",
  "telefone": "49999999999"
}
```

## Resultado Esperado

```json
{
  "id": 1,
  "nome": "Carlos Silva",
  "mensagem": "Motorista cadastrado com sucesso"
}
```

### Validações

* Nome obrigatório
* CPF obrigatório
* Telefone obrigatório
* CPF deve ser único

---

# Teste 2 - Bloqueio de CPF Duplicado

## Endpoint

POST /motoristas

## Resultado Esperado

* Retornar erro de validação
* Informar que o CPF já está cadastrado

---

# Teste 3 - Cadastro de Veículo

## Endpoint

POST /veiculos

## JSON de Entrada

```json
{
  "placa": "ABC1D23",
  "modelo": "Volvo FH",
  "capacidadeCarga": 25000
}
```

## Resultado Esperado

```json
{
  "id": 1,
  "placa": "ABC1D23",
  "mensagem": "Veículo cadastrado com sucesso"
}
```

### Validações

* Placa obrigatória
* Modelo obrigatório
* Capacidade de carga obrigatória

---

# Teste 4 - Cadastro de Entrega

## Endpoint

POST /entregas

## JSON de Entrada

```json
{
  "descricao": "Carga Eletrônicos",
  "origem": "Joinville",
  "destino": "Curitiba",
  "motoristaId": 1,
  "veiculoId": 1
}
```

## Resultado Esperado

```json
{
  "id": 1,
  "status": "Pendente",
  "mensagem": "Entrega criada com sucesso"
}
```

### Validações

* Origem obrigatória
* Destino obrigatória
* Motorista deve existir
* Veículo deve existir

---

# Teste 5 - Atualização de Status da Entrega

## Endpoint

PUT /entregas/:id

## JSON de Entrada

```json
{
  "status": "Em Transporte"
}
```

## Resultado Esperado

* Status atualizado com sucesso
* Registro salvo no banco de dados

---

# Teste 6 - Validação de Campos Obrigatórios

## Cenários

### Motorista

```json
{
  "nome": ""
}
```

Resultado esperado:

* Erro de validação
* Mensagem indicando campos obrigatórios

### Veículo

```json
{
  "placa": ""
}
```

Resultado esperado:

* Erro de validação

### Entrega

```json
{
  "origem": ""
}
```

Resultado esperado:

* Erro de validação

---

# Teste 7 - Busca por ID

## Endpoints

* GET /motoristas/:id
* GET /veiculos/:id
* GET /entregas/:id

## Resultado Esperado

* Retornar os dados corretos do registro solicitado
* Retornar erro caso o ID não exista

---

# Teste 8 - Exclusão de Registros

## Endpoints

* DELETE /motoristas/:id
* DELETE /veiculos/:id
* DELETE /entregas/:id

## Resultado Esperado

* Registro removido com sucesso
* Retornar mensagem de confirmação

---

# Casos de Teste (CT)

## CT01 - Cadastro de Motorista

### 1. Nível do Teste

Sistema

### 2. Pré-condição

* API em execução.
* Banco de dados disponível.
* O CPF informado não deve existir no banco.

### 3. Dados de Entrada / Payload

```json
{
  "nome": "Carlos Silva",
  "cpf": "12345678900",
  "telefone": "49999999999"
}
```

### 4. Passos de Execução

1. Iniciar a aplicação.
2. Enviar uma requisição **POST** para `/motoristas`.
3. Informar o JSON de entrada.
4. Enviar a requisição.
5. Verificar a resposta da API.
6. Consultar o banco de dados para confirmar o cadastro.

### 5. Resultado Esperado

* Status Code **201 (Created)**.
* Retornar:

```json
{
  "id": 1,
  "nome": "Carlos Silva",
  "mensagem": "Motorista cadastrado com sucesso"
}
```

* O motorista deve ser salvo corretamente no banco de dados.

---

## CT02 - Bloqueio de CPF Duplicado

### 1. Nível do Teste

Sistema

### 2. Pré-condição

* Já existe um motorista cadastrado com CPF **12345678900**.

### 3. Dados de Entrada / Payload

```json
{
  "nome": "Carlos Silva",
  "cpf": "12345678900",
  "telefone": "49999999999"
}
```

### 4. Passos de Execução

1. Confirmar que existe um motorista cadastrado com esse CPF.
2. Enviar uma requisição **POST** para `/motoristas`.
3. Informar o mesmo CPF já cadastrado.
4. Enviar a requisição.
5. Verificar a resposta da API.
6. Confirmar que nenhum novo registro foi criado.

### 5. Resultado Esperado

* Status Code **400 (Bad Request)** ou **409 (Conflict)**.
* Mensagem informando que o CPF já está cadastrado.
* Nenhum novo motorista deve ser inserido no banco de dados.

---

## CT03 - Cadastro de Entrega

### 1. Nível do Teste

Integração

### 2. Pré-condição

* Motorista cadastrado com ID **1**.
* Veículo cadastrado com ID **1**.
* API em execução.
* Banco de dados disponível.

### 3. Dados de Entrada / Payload

```json
{
  "descricao": "Carga Eletrônicos",
  "origem": "Joinville",
  "destino": "Curitiba",
  "motoristaId": 1,
  "veiculoId": 1
}
```

### 4. Passos de Execução

1. Confirmar que o motorista existe.
2. Confirmar que o veículo existe.
3. Enviar uma requisição **POST** para `/entregas`.
4. Informar o JSON de entrada.
5. Enviar a requisição.
6. Verificar a resposta da API.
7. Consultar o banco de dados para confirmar o cadastro da entrega.

### 5. Resultado Esperado

* Status Code **201 (Created)**.
* Retornar:

```json
{
  "id": 1,
  "status": "Pendente",
  "mensagem": "Entrega criada com sucesso"
}
```

* A entrega deve ser salva no banco de dados.
* A entrega deve estar vinculada ao motorista e ao veículo informados.
