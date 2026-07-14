# TESTES.md

# Plano de Testes - LogiTech Express

## Objetivo

Documentar os cenários de teste que serão implementados na Unidade Curricular de Testes de Back-End, garantindo a rastreabilidade entre regras de negócio, endpoints e casos de teste.

---

# Regras de Negócio

| Código | Regra de Negócio                                                            |
| ------ | --------------------------------------------------------------------------- |
| RN01   | Todo motorista deve possuir nome, CPF e telefone.                           |
| RN02   | O CPF do motorista deve ser único.                                          |
| RN03   | Todo veículo deve possuir placa, modelo e capacidade de carga.              |
| RN04   | Uma entrega somente poderá ser criada caso o motorista e o veículo existam. |
| RN05   | Origem e destino são campos obrigatórios para uma entrega.                  |
| RN06   | O status da entrega deve ser atualizado corretamente.                       |

---

# Resumo dos Casos de Teste

| CT   | Tipo         | Nível      | Endpoint / Regra Validada                     |
| ---- | ------------ | ---------- | --------------------------------------------- |
| CT01 | Caixa Preta  | Integração | POST /motoristas - RN01                       |
| CT02 | Caixa Preta  | Integração | POST /motoristas - RN02                       |
| CT03 | Caixa Preta  | Integração | POST /veiculos - RN03                         |
| CT04 | Caixa Preta  | Integração | POST /entregas - RN04 e RN05                  |
| CT05 | Caixa Preta  | Integração | PUT /entregas/:id - RN06                      |
| CT06 | Caixa Preta  | Integração | GET /motoristas/:id                           |
| CT07 | Caixa Branca | Unitário   | MotoristaService.validarCpfDuplicado() - RN02 |
| CT08 | Caixa Branca | Unitário   | EntregaService.validarEntrega() - RN05        |

---

# CT01 - Cadastro de Motorista

## 1. Tipo de Teste

Caixa Preta

## 2. Nível do Teste

Integração

## 3. Objetivo

Verificar se um motorista é cadastrado corretamente quando todos os dados obrigatórios são informados.

## 4. Rastreabilidade

* Endpoint: POST /motoristas
* Regra de Negócio: RN01

## 5. Pré-condição

* API em execução.
* Banco de dados disponível.
* O CPF informado não existe no banco.

## 6. Dados de Entrada

```json
{
  "nome": "Carlos Silva",
  "cpf": "12345678900",
  "telefone": "49999999999"
}
```

## 7. Passos de Execução

1. Executar a API.
2. Enviar uma requisição POST para `/motoristas`.
3. Informar o JSON de entrada.
4. Executar a requisição.
5. Validar a resposta.
6. Consultar o banco de dados.

## 8. Resultado Esperado

* HTTP 201 (Created).
* Motorista cadastrado.
* Mensagem de sucesso.
* Registro salvo corretamente no banco.

## 9. Critério de Aprovação

O teste será aprovado caso o motorista seja cadastrado e persistido no banco de dados sem erros.

---

# CT02 - Bloqueio de CPF Duplicado

## 1. Tipo de Teste

Caixa Preta

## 2. Nível do Teste

Integração

## 3. Objetivo

Verificar se o sistema impede o cadastro de um motorista com CPF já existente.

## 4. Rastreabilidade

* Endpoint: POST /motoristas
* Regra de Negócio: RN02

## 5. Pré-condição

Existe um motorista cadastrado com CPF **12345678900**.

## 6. Dados de Entrada

```json
{
  "nome": "Carlos Silva",
  "cpf": "12345678900",
  "telefone": "49999999999"
}
```

## 7. Passos de Execução

1. Confirmar que o CPF já existe.
2. Enviar uma nova requisição POST.
3. Informar o mesmo CPF.
4. Validar a resposta.
5. Consultar o banco.

## 8. Resultado Esperado

* HTTP 400 ou HTTP 409.
* Mensagem informando CPF duplicado.
* Nenhum novo registro criado.

## 9. Critério de Aprovação

O teste será aprovado caso o sistema impeça o cadastro e mantenha apenas um registro do CPF informado.

---

# CT03 - Cadastro de Veículo

## 1. Tipo de Teste

Caixa Preta

## 2. Nível do Teste

Integração

## 3. Objetivo

Verificar se um veículo é cadastrado corretamente quando todos os dados obrigatórios são preenchidos.

## 4. Rastreabilidade

* Endpoint: POST /veiculos
* Regra de Negócio: RN03

## 5. Pré-condição

* API em execução.
* Banco de dados disponível.

## 6. Dados de Entrada

```json
{
  "placa": "ABC1D23",
  "modelo": "Volvo FH",
  "capacidadeCarga": 25000
}
```

## 7. Passos de Execução

1. Enviar POST para `/veiculos`.
2. Informar o payload.
3. Validar a resposta.
4. Consultar o banco.

## 8. Resultado Esperado

* HTTP 201.
* Veículo cadastrado.
* Dados persistidos.

## 9. Critério de Aprovação

O teste será aprovado caso o veículo seja salvo corretamente no banco de dados.

---

# CT04 - Cadastro de Entrega

## 1. Tipo de Teste

Caixa Preta

## 2. Nível do Teste

Integração

## 3. Objetivo

Verificar se uma entrega é cadastrada corretamente utilizando um motorista e um veículo existentes.

## 4. Rastreabilidade

* Endpoint: POST /entregas
* Regras de Negócio: RN04 e RN05

## 5. Pré-condição

* Motorista cadastrado.
* Veículo cadastrado.
* API em execução.
* Banco de dados disponível.

## 6. Dados de Entrada

```json
{
  "descricao": "Carga Eletrônicos",
  "origem": "Joinville",
  "destino": "Curitiba",
  "motoristaId": 1,
  "veiculoId": 1
}
```

## 7. Passos de Execução

1. Confirmar que motorista e veículo existem.
2. Enviar POST para `/entregas`.
3. Validar a resposta.
4. Consultar o banco.

## 8. Resultado Esperado

* HTTP 201.
* Entrega cadastrada.
* Status inicial "Pendente".
* Associação correta entre motorista e veículo.

## 9. Critério de Aprovação

O teste será aprovado caso a entrega seja criada corretamente e armazenada no banco.

---

# CT05 - Atualização de Status da Entrega

## 1. Tipo de Teste

Caixa Preta

## 2. Nível do Teste

Integração

## 3. Objetivo

Verificar se o status de uma entrega pode ser atualizado corretamente.

## 4. Rastreabilidade

* Endpoint: PUT /entregas/:id
* Regra de Negócio: RN06

## 5. Pré-condição

* Existe uma entrega cadastrada.
* API em execução.
* Banco de dados disponível.

## 6. Dados de Entrada

```json
{
  "status": "Em Transporte"
}
```

## 7. Passos de Execução

1. Enviar PUT para `/entregas/1`.
2. Informar o novo status.
3. Validar a resposta.
4. Consultar o banco.

## 8. Resultado Esperado

* HTTP 200.
* Status alterado para "Em Transporte".

## 9. Critério de Aprovação

O teste será aprovado caso a alteração seja persistida corretamente no banco de dados.

---

# CT06 - Busca de Motorista por ID

## 1. Tipo de Teste

Caixa Preta

## 2. Nível do Teste

Integração

## 3. Objetivo

Verificar se o sistema retorna corretamente um motorista através do seu ID.

## 4. Rastreabilidade

* Endpoint: GET /motoristas/:id

## 5. Pré-condição

Existe um motorista cadastrado com ID 1.

## 6. Dados de Entrada

```
GET /motoristas/1
```

## 7. Passos de Execução

1. Executar a requisição GET.
2. Informar o ID.
3. Validar a resposta.

## 8. Resultado Esperado

* HTTP 200 para ID existente.
* HTTP 404 para ID inexistente.

## 9. Critério de Aprovação

O teste será aprovado caso o sistema retorne corretamente os dados do motorista ou informe que ele não foi encontrado.

---

# CT07 - Validação de CPF Duplicado

## 1. Tipo de Teste

Caixa Branca

## 2. Nível do Teste

Unitário

## 3. Objetivo

Verificar se a regra de negócio responsável por impedir CPFs duplicados funciona corretamente na camada de serviço.

## 4. Rastreabilidade

* Classe: MotoristaService
* Método: validarCpfDuplicado()
* Regra de Negócio: RN02

## 5. Pré-condição

Mock do repositório retornando CPF existente.

## 6. Dados de Entrada

CPF:

```
12345678900
```

## 7. Passos de Execução

1. Executar o método.
2. Simular CPF existente.
3. Validar a exceção.

## 8. Resultado Esperado

* Exceção lançada.
* Cadastro bloqueado.

## 9. Critério de Aprovação

O teste será aprovado caso o método impeça a criação do motorista quando o CPF já existir.

---

# CT08 - Validação dos Campos Obrigatórios da Entrega

## 1. Tipo de Teste

Caixa Branca

## 2. Nível do Teste

Unitário

## 3. Objetivo

Verificar se a regra de validação impede a criação de uma entrega quando os campos obrigatórios não forem preenchidos.

## 4. Rastreabilidade

* Classe: EntregaService
* Método: validarEntrega()
* Regra de Negócio: RN05

## 5. Pré-condição

* Ambiente de testes configurado.
* Serviço disponível.

## 6. Dados de Entrada

```json
{
  "origem": "",
  "destino": "Curitiba"
}
```

## 7. Passos de Execução

1. Executar o método de validação.
2. Informar origem vazia.
3. Validar o retorno.

## 8. Resultado Esperado

* Erro de validação.
* Entrega não criada.

## 9. Critério de Aprovação

O teste será aprovado caso o método retorne erro de validação e impeça a criação da entrega.

---

# Conclusão

O documento atende aos requisitos da atividade, contemplando:

* 8 Casos de Teste completos.
* Testes de Caixa Preta.
* Testes de Caixa Branca.
* Testes Unitários.
* Testes de Integração.
* Rastreabilidade entre Casos de Teste, Endpoints e Regras de Negócio.
* Objetivo, Pré-condição, Dados de Entrada, Passos de Execução, Resultado Esperado e Critério de Aprovação para todos os casos de teste.
