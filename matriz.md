| ID do Requisito / Rota | Gargalo / Problema Potencial | Cenário de Teste Sugerido | Tipo de Teste |
|---|---|---|---|
| POST /motoristas | Cadastro pode falhar mesmo com dados válidos | Enviar nome, CPF e telefone válidos e verificar se o motorista é cadastrado | Funcional / Caixa Preta |
| POST /motoristas | Nome obrigatório não informado | Enviar dados sem o campo nome | Funcional / Caixa Preta |
| POST /motoristas | Nome enviado vazio | Enviar nome como texto vazio | Funcional / Caixa Preta |
| POST /motoristas | CPF obrigatório não informado | Enviar dados sem o campo CPF | Funcional / Caixa Preta |
| POST /motoristas | CPF duplicado | Tentar cadastrar um motorista com CPF já existente | Funcional / Caixa Preta |
| POST /motoristas | CPF com quantidade incorreta de caracteres | Enviar CPF com menos ou mais de 11 dígitos | Funcional / Caixa Preta |
| POST /motoristas | CPF contendo letras | Enviar CPF contendo caracteres alfabéticos | Funcional / Caixa Preta |
| POST /motoristas | Telefone obrigatório não informado | Enviar dados sem o campo telefone | Funcional / Caixa Preta |
| POST /motoristas | Telefone em formato inválido | Enviar telefone contendo letras ou caracteres inválidos | Funcional / Caixa Preta |
| POST /motoristas | Dados completamente vazios | Enviar um objeto JSON vazio no cadastro | Funcional / Caixa Preta |
| GET /motoristas/:id | Motorista existente pode não ser localizado | Buscar um motorista utilizando um ID válido | Funcional / Caixa Preta |
| GET /motoristas/:id | ID do motorista inexistente | Buscar motorista utilizando um ID que não existe | Funcional / Caixa Preta |
| GET /motoristas/:id | ID em formato inválido | Buscar motorista utilizando letras no lugar do ID numérico | Funcional / Caixa Preta |
| DELETE /motoristas/:id | Exclusão pode falhar para registro existente | Excluir um motorista utilizando um ID válido | Funcional / Caixa Preta |
| DELETE /motoristas/:id | Tentativa de excluir motorista inexistente | Excluir motorista utilizando um ID que não existe | Funcional / Caixa Preta |
| POST /veiculos | Cadastro pode falhar mesmo com dados válidos | Enviar placa, modelo e capacidade de carga válidos | Funcional / Caixa Preta |
| POST /veiculos | Placa obrigatória não informada | Enviar dados sem o campo placa | Funcional / Caixa Preta |
| POST /veiculos | Placa enviada vazia | Enviar placa como texto vazio | Funcional / Caixa Preta |
| POST /veiculos | Placa em formato inválido | Enviar uma placa fora do padrão esperado | Funcional / Caixa Preta |
| POST /veiculos | Modelo obrigatório não informado | Enviar dados sem o campo modelo | Funcional / Caixa Preta |
| POST /veiculos | Modelo enviado vazio | Enviar modelo como texto vazio | Funcional / Caixa Preta |
| POST /veiculos | Capacidade de carga não informada | Enviar dados sem capacidadeCarga | Funcional / Caixa Preta |
| POST /veiculos | Capacidade de carga negativa | Enviar capacidadeCarga com valor negativo | Funcional / Caixa Preta |
| POST /veiculos | Capacidade de carga igual a zero | Enviar capacidadeCarga com valor 0 | Funcional / Caixa Preta |
| POST /veiculos | Capacidade de carga com tipo incorreto | Enviar texto no campo capacidadeCarga | Funcional / Caixa Preta |
| GET /veiculos/:id | Veículo existente pode não ser localizado | Buscar veículo utilizando um ID válido | Funcional / Caixa Preta |
| GET /veiculos/:id | Veículo inexistente | Buscar veículo utilizando ID que não existe | Funcional / Caixa Preta |
| GET /veiculos/:id | ID do veículo em formato inválido | Buscar veículo utilizando letras como ID | Funcional / Caixa Preta |
| DELETE /veiculos/:id | Exclusão pode falhar para veículo existente | Excluir veículo utilizando um ID válido | Funcional / Caixa Preta |
| DELETE /veiculos/:id | Tentativa de excluir veículo inexistente | Excluir veículo utilizando ID que não existe | Funcional / Caixa Preta |
| POST /entregas | Cadastro de entrega pode falhar com dados válidos | Criar entrega com descrição, origem, destino, motorista e veículo válidos | Funcional / Caixa Preta |
| POST /entregas | Origem obrigatória não informada | Enviar dados sem o campo origem | Funcional / Caixa Preta |
| POST /entregas | Origem enviada vazia | Enviar origem como texto vazio | Funcional / Caixa Preta |
| POST /entregas | Destino obrigatório não informado | Enviar dados sem o campo destino | Funcional / Caixa Preta |
| POST /entregas | Destino enviado vazio | Enviar destino como texto vazio | Funcional / Caixa Preta |
| POST /entregas | Motorista informado não existe | Criar entrega utilizando motoristaId inexistente | Funcional / Caixa Preta |
| POST /entregas | Veículo informado não existe | Criar entrega utilizando veiculoId inexistente | Funcional / Caixa Preta |
| POST /entregas | ID do motorista em formato incorreto | Enviar texto no campo motoristaId | Funcional / Caixa Preta |
| POST /entregas | ID do veículo em formato incorreto | Enviar texto no campo veiculoId | Funcional / Caixa Preta |
| PUT /entregas/:id | Atualização de status pode falhar | Atualizar uma entrega existente para o status Em Transporte | Funcional / Caixa Preta |
| PUT /entregas/:id | Status inválido pode ser aceito | Enviar um status não permitido pelo sistema | Funcional / Caixa Preta |
| PUT /entregas/:id | Entrega inexistente | Atualizar status utilizando um ID de entrega inexistente | Funcional / Caixa Preta |
| GET /entregas/:id | Entrega existente pode não ser localizada | Buscar uma entrega utilizando ID válido | Funcional / Caixa Preta |
| GET /entregas/:id | Entrega inexistente | Buscar uma entrega utilizando ID que não existe | Funcional / Caixa Preta |
| DELETE /entregas/:id | Exclusão de entrega pode apresentar falha | Excluir uma entrega existente e verificar a confirmação da remoção | Funcional / Caixa Preta |
