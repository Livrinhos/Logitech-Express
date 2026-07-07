| ID do Requisito / Rota | Gargalo / Problema Potencial             | Cenário de Teste Sugerido                               | Tipo de Teste           |
| ---------------------- | ---------------------------------------- | ------------------------------------------------------- | ----------------------- |
| POST /motoristas       | Cadastro com dados obrigatórios ausentes | Enviar payload sem nome, CPF ou telefone                | Funcional / Caixa Preta |
| POST /motoristas       | CPF duplicado no sistema                 | Enviar payload com CPF já cadastrado                    | Funcional / Caixa Preta |
| POST /veiculos         | Cadastro com campos obrigatórios vazios  | Enviar payload sem placa, modelo ou capacidade de carga | Funcional / Caixa Preta |
| POST /veiculos         | Capacidade de carga inválida             | Enviar capacidade de carga negativa ou zero             | Funcional / Caixa Preta |
| POST /entregas         | Origem ou destino ausente                | Enviar payload com origem ou destino vazio              | Funcional / Caixa Preta |
| POST /entregas         | Motorista inexistente                    | Criar entrega usando motoristaId que não existe         | Funcional / Caixa Preta |
| POST /entregas         | Veículo inexistente                      | Criar entrega usando veiculoId que não existe           | Funcional / Caixa Preta |
| PUT /entregas/:id      | Status inválido                          | Enviar um status não permitido                          | Funcional / Caixa Preta |
| PUT /entregas/:id      | Entrega inexistente                      | Atualizar status usando ID que não existe               | Funcional / Caixa Preta |
| GET /motoristas/:id    | Motorista não encontrado                 | Buscar motorista com ID inexistente                     | Funcional / Caixa Preta |
| GET /veiculos/:id      | Veículo não encontrado                   | Buscar veículo com ID inexistente                       | Funcional / Caixa Preta |
| GET /entregas/:id      | Entrega não encontrada                   | Buscar entrega com ID inexistente                       | Funcional / Caixa Preta |
| DELETE /motoristas/:id | Motorista inexistente                    | Excluir motorista usando ID que não existe              | Funcional / Caixa Preta |
| DELETE /veiculos/:id   | Veículo inexistente                      | Excluir veículo usando ID que não existe                | Funcional / Caixa Preta |
| DELETE /entregas/:id   | Entrega inexistente                      | Excluir entrega usando ID que não existe                | Funcional / Caixa Preta |
