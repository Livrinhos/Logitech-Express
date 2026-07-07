| ID do Requisito / Rota | Gargalo / Problema Potencial | Cenário de Teste Sugerido | Tipo de Teste |
|---|---|---|---|
| POST /motoristas | Cadastro pode falhar mesmo com dados válidos | Enviar nome, CPF e telefone válidos e verificar se o motorista é cadastrado | Funcional / Caixa Preta |
| POST /motoristas | Nome obrigatório não informado | Enviar dados sem o campo nome e verificar o retorno de erro | Funcional / Caixa Preta |
| POST /motoristas | Nome enviado vazio | Enviar nome como texto vazio e verificar se a validação bloqueia o cadastro | Funcional / Caixa Preta |
| POST /motoristas | CPF obrigatório não informado | Enviar dados sem o campo CPF e verificar o retorno da API | Funcional / Caixa Preta |
| POST /motoristas | CPF duplicado | Tentar cadastrar um motorista com CPF já existente | Funcional / Caixa Preta |
| POST /motoristas | Validação interna de CPF duplicado pode não executar corretamente | Verificar se a condição interna de busca do CPF percorre os caminhos de CPF existente e CPF inexistente | Estrutural / Caixa Branca |
| POST /motoristas | Fluxo interno de validação dos campos obrigatórios pode estar incompleto | Executar os ramos internos de validação para nome, CPF e telefone ausentes | Estrutural / Caixa Branca |
| POST /motoristas | Erro do banco pode não ser tratado | Simular falha interna ao salvar o motorista e verificar o tratamento da exceção | Estrutural / Caixa Branca |
| POST /motoristas | Dados vazios podem passar pelas condições internas | Verificar os caminhos do código responsáveis por rejeitar valores vazios | Estrutural / Caixa Branca |
| POST /motoristas | Cadastro pode ser executado mesmo após uma validação falhar | Verificar se o fluxo interno é interrompido quando uma regra de validação retorna erro | Estrutural / Caixa Branca |
| GET /motoristas/:id | Motorista existente pode não ser localizado | Buscar um motorista utilizando um ID válido | Funcional / Caixa Preta |
| GET /motoristas/:id | ID do motorista inexistente | Buscar motorista utilizando um ID que não existe | Funcional / Caixa Preta |
| GET /motoristas/:id | Fluxos de ID existente e inexistente podem não estar cobertos | Executar internamente os dois ramos da condição de busca do motorista | Estrutural / Caixa Branca |
| DELETE /motoristas/:id | Exclusão pode falhar para registro existente | Excluir um motorista utilizando um ID válido | Funcional / Caixa Preta |
| DELETE /motoristas/:id | Tentativa de excluir motorista inexistente | Excluir motorista utilizando um ID que não existe | Funcional / Caixa Preta |
| POST /veiculos | Cadastro pode falhar mesmo com dados válidos | Enviar placa, modelo e capacidade de carga válidos | Funcional / Caixa Preta |
| POST /veiculos | Placa obrigatória não informada | Enviar dados sem o campo placa | Funcional / Caixa Preta |
| POST /veiculos | Placa enviada vazia | Enviar placa como texto vazio e verificar se o cadastro é bloqueado | Funcional / Caixa Preta |
| POST /veiculos | Modelo obrigatório não informado | Enviar dados sem o campo modelo | Funcional / Caixa Preta |
| POST /veiculos | Capacidade de carga não informada | Enviar dados sem o campo capacidadeCarga | Funcional / Caixa Preta |
| POST /veiculos | Capacidade de carga negativa | Enviar capacidadeCarga com valor negativo | Funcional / Caixa Preta |
| POST /veiculos | Capacidade de carga igual a zero | Enviar capacidadeCarga com valor 0 | Funcional / Caixa Preta |
| POST /veiculos | Validação interna dos campos pode não cobrir todos os caminhos | Executar os ramos de placa, modelo e capacidade ausentes e presentes | Estrutural / Caixa Branca |
| POST /veiculos | Validação interna da capacidade pode aceitar valor inválido | Verificar os caminhos condicionais para capacidade positiva, zero e negativa | Estrutural / Caixa Branca |
| POST /veiculos | Falha na persistência pode não ser tratada | Simular erro interno do banco durante o cadastro do veículo | Estrutural / Caixa Branca |
| GET /veiculos/:id | Veículo existente pode não ser localizado | Buscar veículo utilizando um ID válido | Funcional / Caixa Preta |
| GET /veiculos/:id | Veículo inexistente | Buscar veículo utilizando ID que não existe | Funcional / Caixa Preta |
| GET /veiculos/:id | Condição interna de busca pode tratar incorretamente resultado nulo | Executar os caminhos internos de veículo encontrado e não encontrado | Estrutural / Caixa Branca |
| DELETE /veiculos/:id | Exclusão pode falhar para veículo existente | Excluir veículo utilizando um ID válido | Funcional / Caixa Preta |
| DELETE /veiculos/:id | Tentativa de excluir veículo inexistente | Excluir veículo utilizando ID que não existe | Funcional / Caixa Preta |
| POST /entregas | Cadastro de entrega pode falhar com dados válidos | Criar entrega com descrição, origem, destino, motorista e veículo válidos | Funcional / Caixa Preta |
| POST /entregas | Origem obrigatória não informada | Enviar dados sem o campo origem | Funcional / Caixa Preta |
| POST /entregas | Destino obrigatório não informado | Enviar dados sem o campo destino | Funcional / Caixa Preta |
| POST /entregas | Motorista informado não existe | Criar entrega utilizando motoristaId inexistente | Funcional / Caixa Preta |
| POST /entregas | Veículo informado não existe | Criar entrega utilizando veiculoId inexistente | Funcional / Caixa Preta |
| POST /entregas | Verificação interna do motorista pode falhar | Executar os caminhos internos em que o motorista existe e não existe | Estrutural / Caixa Branca |
| POST /entregas | Verificação interna do veículo pode falhar | Executar os caminhos internos em que o veículo existe e não existe | Estrutural / Caixa Branca |
| POST /entregas | Entrega pode ser salva mesmo com relacionamento inválido | Verificar se o fluxo interno é interrompido quando motorista ou veículo não existem | Estrutural / Caixa Branca |
| PUT /entregas/:id | Atualização de status pode falhar | Atualizar uma entrega existente para o status Em Transporte | Funcional / Caixa Preta |
| PUT /entregas/:id | Status inválido pode ser aceito | Enviar um status não permitido pelo sistema | Funcional / Caixa Preta |
| PUT /entregas/:id | Entrega inexistente | Atualizar status utilizando um ID de entrega inexistente | Funcional / Caixa Preta |
| PUT /entregas/:id | Alteração pode ocorrer apenas em memória e não no banco | Verificar internamente se a operação de persistência é executada após alterar o status | Estrutural / Caixa Branca |
| PUT /entregas/:id | Fluxos internos de atualização podem não estar cobertos | Executar os ramos de entrega encontrada, não encontrada e status inválido | Estrutural / Caixa Branca |
| GET /entregas/:id | Entrega existente pode não ser localizada | Buscar uma entrega utilizando ID válido | Funcional / Caixa Preta |
| DELETE /entregas/:id | Exclusão pode remover registro incorreto ou falhar | Excluir uma entrega existente e verificar internamente se apenas o registro correspondente ao ID foi removido | Estrutural / Caixa Branca |
