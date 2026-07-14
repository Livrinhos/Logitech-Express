# TESTES.md

# Plano de Testes - LogiTech Express

## Objetivo

Documentar os cenários de teste que serão implementados na Unidade Curricular de Testes de Back-End, garantindo rastreabilidade entre regras de negócio, endpoints e casos de teste.

---

# Regras de Negócio

| Código | Regra |
|--------|-------|
| RN01 | Todo motorista deve possuir nome, CPF e telefone. |
| RN02 | O CPF do motorista deve ser único. |
| RN03 | Todo veículo deve possuir placa, modelo e capacidade de carga. |
| RN04 | Uma entrega somente pode ser criada se motorista e veículo existirem. |
| RN05 | Origem e destino da entrega são obrigatórios. |
| RN06 | O status da entrega deve ser atualizado corretamente. |

---

# Resumo dos Casos de Teste

| CT | Tipo | Nível | Rastreabilidade |
|----|------|--------|-----------------|
| CT01 | Caixa Preta | Integração | POST /motoristas - RN01 |
| CT02 | Caixa Preta | Integração | POST /motoristas - RN02 |
| CT03 | Caixa Preta | Integração | POST /veiculos - RN03 |
| CT04 | Caixa Preta | Integração | POST /entregas - RN04/RN05 |
| CT05 | Caixa Preta | Integração | PUT /entregas/:id - RN06 |
| CT06 | Caixa Preta | Integração | GET /motoristas/:id |
| CT07 | Caixa Branca | Unitário | MotoristaService.validarCpfDuplicado() - RN02 |
| CT08 | Caixa Branca | Unitário | EntregaService.validarEntrega() - RN05 |

---

# CT01 - Cadastro de Motorista

## Tipo de Teste
Caixa Preta

## Nível do Teste
Integração

## Rastreabilidade
- Endpoint: POST /motoristas
- Regra: RN01

## Pré-condição
- API em execução.
- Banco disponível.
- CPF inexistente.

## Payload

```json
{
  "nome":"Carlos Silva",
  "cpf":"12345678900",
  "telefone":"49999999999"
}
```

## Passos
1. Enviar POST /motoristas.
2. Informar o payload.
3. Validar resposta.
4. Consultar banco.

## Resultado Esperado
- HTTP 201.
- Motorista salvo.
- Mensagem de sucesso.

---

# CT02 - Bloqueio de CPF Duplicado

## Tipo de Teste
Caixa Preta

## Nível do Teste
Integração

## Rastreabilidade
- Endpoint: POST /motoristas
- Regra: RN02

## Pré-condição
Já existe motorista com CPF informado.

## Payload

```json
{
  "nome":"Carlos Silva",
  "cpf":"12345678900",
  "telefone":"49999999999"
}
```

## Passos
1. Enviar POST com CPF duplicado.
2. Validar resposta.

## Resultado Esperado
- HTTP 400 ou 409.
- Mensagem informando CPF já cadastrado.
- Nenhum novo registro criado.

---

# CT03 - Cadastro de Veículo

## Tipo de Teste
Caixa Preta

## Nível do Teste
Integração

## Rastreabilidade
- Endpoint: POST /veiculos
- Regra: RN03

## Pré-condição
API disponível.

## Payload

```json
{
  "placa":"ABC1D23",
  "modelo":"Volvo FH",
  "capacidadeCarga":25000
}
```

## Passos
1. Enviar POST /veiculos.
2. Validar resposta.
3. Consultar banco.

## Resultado Esperado
- HTTP 201.
- Veículo salvo.

---

# CT04 - Cadastro de Entrega

## Tipo de Teste
Caixa Preta

## Nível do Teste
Integração

## Rastreabilidade
- Endpoint: POST /entregas
- Regras: RN04 e RN05

## Pré-condição
Motorista e veículo cadastrados.

## Payload

```json
{
  "descricao":"Carga Eletrônicos",
  "origem":"Joinville",
  "destino":"Curitiba",
  "motoristaId":1,
  "veiculoId":1
}
```

## Passos
1. Enviar POST /entregas.
2. Validar resposta.
3. Consultar banco.

## Resultado Esperado
- HTTP 201.
- Status inicial Pendente.
- Entrega vinculada ao motorista e veículo.

---

# CT05 - Atualização de Status

## Tipo de Teste
Caixa Preta

## Nível do Teste
Integração

## Rastreabilidade
- Endpoint: PUT /entregas/:id
- Regra: RN06

## Payload

```json
{
  "status":"Em Transporte"
}
```

## Passos
1. Enviar PUT.
2. Validar banco.

## Resultado Esperado
- HTTP 200.
- Status atualizado.

---

# CT06 - Busca por ID

## Tipo de Teste
Caixa Preta

## Nível do Teste
Integração

## Rastreabilidade
- Endpoint: GET /motoristas/:id

## Pré-condição
Motorista existente.

## Passos
1. Executar GET.
2. Validar retorno.

## Resultado Esperado
- HTTP 200 para ID existente.
- HTTP 404 para ID inexistente.

---

# CT07 - Validação de CPF Duplicado

## Tipo de Teste
Caixa Branca

## Nível do Teste
Unitário

## Rastreabilidade
- Classe: MotoristaService
- Método: validarCpfDuplicado()
- Regra: RN02

## Pré-condição
Mock do repositório retornando CPF existente.

## Passos
1. Executar método.
2. Simular CPF existente.

## Resultado Esperado
- Exceção lançada.
- Cadastro bloqueado.

---

# CT08 - Validação de Campos da Entrega

## Tipo de Teste
Caixa Branca

## Nível do Teste
Unitário

## Rastreabilidade
- Classe: EntregaService
- Método: validarEntrega()
- Regra: RN05

## Payload

```json
{
  "origem":"",
  "destino":"Curitiba"
}
```

## Passos
1. Executar método.
2. Informar origem vazia.

## Resultado Esperado
- Erro de validação.
- Entrega não criada.

---

# Conclusão

Este documento contempla:
- Testes de Caixa Preta.
- Testes de Caixa Branca.
- Testes Unitários.
- Testes de Integração.
- Rastreabilidade entre casos de teste, regras de negócio e endpoints.
- Oito Casos de Teste completos.
