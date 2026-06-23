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
* Destino obrigatório
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
