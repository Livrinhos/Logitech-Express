CREATE DATABASE IF NOT EXISTS LogiTechExpress CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE LogiTechExpress;

CREATE TABLE IF NOT EXISTS Endereco (
    id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    rua VARCHAR(100) NOT NULL,
    numero VARCHAR(10),
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    estado VARCHAR(30),
    cep VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    tipo_cliente VARCHAR(2) NOT NULL,
    documento VARCHAR(20) UNIQUE,
    telefone VARCHAR(15),
    email VARCHAR(100),
    id_endereco INT,
    CONSTRAINT fk_cliente_endereco FOREIGN KEY (id_endereco) REFERENCES Endereco(id_endereco)
);

CREATE TABLE IF NOT EXISTS Motorista (
    id_motorista INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(15) NOT NULL,
    cnh VARCHAR(20) UNIQUE,
    status VARCHAR(20) NOT NULL DEFAULT 'Ativo',
    email VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Veiculo (
    id_veiculo INT PRIMARY KEY AUTO_INCREMENT,
    placa VARCHAR(10) NOT NULL UNIQUE,
    modelo VARCHAR(50) NOT NULL,
    tipo VARCHAR(30),
    capacidade DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Disponível',
    CONSTRAINT chk_veiculo_capacidade CHECK (capacidade > 0)
);

CREATE TABLE IF NOT EXISTS Rota (
    id_rota INT PRIMARY KEY AUTO_INCREMENT,
    origem VARCHAR(100) NOT NULL,
    destino VARCHAR(100) NOT NULL,
    distancia_km DECIMAL(10,2),
    tempo_estimado VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS Entrega (
    id_entrega INT PRIMARY KEY AUTO_INCREMENT,
    data_criacao DATE NOT NULL,
    data_prevista DATE,
    data_conclusao DATE,
    status VARCHAR(30) NOT NULL DEFAULT 'Pendente',
    descricao VARCHAR(255),
    id_motorista INT NOT NULL,
    id_veiculo INT NOT NULL,
    id_rota INT NOT NULL,
    id_cliente INT,
    CONSTRAINT fk_entrega_motorista FOREIGN KEY (id_motorista) REFERENCES Motorista(id_motorista),
    CONSTRAINT fk_entrega_veiculo FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    CONSTRAINT fk_entrega_rota FOREIGN KEY (id_rota) REFERENCES Rota(id_rota),
    CONSTRAINT fk_entrega_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    INDEX idx_entrega_status (status),
    INDEX idx_entrega_motorista (id_motorista),
    INDEX idx_entrega_veiculo (id_veiculo)
);

CREATE TABLE IF NOT EXISTS Atualizacao_Entrega (
    id_atualizacao INT PRIMARY KEY AUTO_INCREMENT,
    id_entrega INT NOT NULL,
    status VARCHAR(30) NOT NULL,
    data_hora DATETIME NOT NULL,
    observacao VARCHAR(255),
    CONSTRAINT fk_atualizacao_entrega FOREIGN KEY (id_entrega) REFERENCES Entrega(id_entrega) ON DELETE CASCADE
);

-- ==========================================
-- CARGA INICIAL DE DADOS PARA TESTES
-- 20 registros por categoria/tabela principal
-- ==========================================

INSERT IGNORE INTO Endereco (id_endereco, rua, numero, bairro, cidade, estado, cep) VALUES
(1, 'Rua das Araucárias', '101', 'Centro', 'Joinville', 'SC', '89201-000'),
(2, 'Avenida Brasil', '202', 'América', 'Joinville', 'SC', '89204-000'),
(3, 'Rua XV de Novembro', '303', 'Centro', 'Curitiba', 'PR', '80020-310'),
(4, 'Avenida Paulista', '404', 'Bela Vista', 'São Paulo', 'SP', '01310-000'),
(5, 'Rua Sete de Setembro', '505', 'Centro', 'Blumenau', 'SC', '89010-200'),
(6, 'Rua Hercílio Luz', '606', 'Centro', 'Itajaí', 'SC', '88301-001'),
(7, 'Avenida Beira Mar', '707', 'Centro', 'Florianópolis', 'SC', '88015-600'),
(8, 'Rua Marechal Deodoro', '808', 'Centro', 'Ponta Grossa', 'PR', '84010-310'),
(9, 'Avenida Ipiranga', '909', 'Centro Histórico', 'Porto Alegre', 'RS', '90010-001'),
(10, 'Rua Bahia', '1001', 'Salto', 'Blumenau', 'SC', '89031-001'),
(11, 'Rua Amazonas', '1102', 'Saguaçu', 'Joinville', 'SC', '89221-000'),
(12, 'Avenida Atlântica', '1203', 'Centro', 'Balneário Camboriú', 'SC', '88330-003'),
(13, 'Rua das Palmeiras', '1304', 'Jardim Botânico', 'Curitiba', 'PR', '80210-170'),
(14, 'Rua dos Pinheiros', '1405', 'Pinheiros', 'São Paulo', 'SP', '05422-001'),
(15, 'Avenida das Torres', '1506', 'Uberaba', 'Curitiba', 'PR', '81560-001'),
(16, 'Rua Frei Caneca', '1607', 'Consolação', 'São Paulo', 'SP', '01307-001'),
(17, 'Rua Padre Roma', '1708', 'Centro', 'Florianópolis', 'SC', '88010-090'),
(18, 'Avenida Getúlio Vargas', '1809', 'Anita Garibaldi', 'Joinville', 'SC', '89202-000'),
(19, 'Rua Bento Gonçalves', '1910', 'Centro', 'Caxias do Sul', 'RS', '95020-412'),
(20, 'Rua Tiradentes', '2011', 'Centro', 'Londrina', 'PR', '86010-190');

INSERT IGNORE INTO Cliente (id_cliente, nome, tipo_cliente, documento, telefone, email, id_endereco) VALUES
(1, 'Mercado Norte Ltda', 'PJ', '11222333000101', '4733330001', 'contato@mercadonorte.com.br', 1),
(2, 'Farmácia Vida Mais', 'PJ', '11222333000102', '4733330002', 'logistica@vidamais.com.br', 2),
(3, 'Carlos Eduardo Lima', 'PF', '12345678901', '41999990003', 'carlos.lima@email.com', 3),
(4, 'TechParts Brasil', 'PJ', '11222333000104', '1133330004', 'operacoes@techparts.com.br', 4),
(5, 'Têxtil Vale Europeu', 'PJ', '11222333000105', '4733330005', 'expedicao@textilvale.com.br', 5),
(6, 'Porto Sul Distribuidora', 'PJ', '11222333000106', '4733330006', 'entregas@portosul.com.br', 6),
(7, 'Marina Souza', 'PF', '12345678907', '48999990007', 'marina.souza@email.com', 7),
(8, 'Agro Campos Gerais', 'PJ', '11222333000108', '4233330008', 'compras@agrocampos.com.br', 8),
(9, 'RS Express Peças', 'PJ', '11222333000109', '5133330009', 'recebimento@rsexpress.com.br', 9),
(10, 'Indústria Blumenau', 'PJ', '11222333000110', '4733330010', 'sac@industriablumenau.com.br', 10),
(11, 'Ana Paula Ribeiro', 'PF', '12345678911', '47999990011', 'ana.ribeiro@email.com', 11),
(12, 'Litoral Eventos', 'PJ', '11222333000112', '4733330012', 'eventos@litoraleventos.com.br', 12),
(13, 'Clínica Jardim', 'PJ', '11222333000113', '4133330013', 'admin@clinicajardim.com.br', 13),
(14, 'Pinheiros Office', 'PJ', '11222333000114', '1133330014', 'facilities@pinheirosoffice.com.br', 14),
(15, 'Curitiba Auto Center', 'PJ', '11222333000115', '4133330015', 'pecas@curitibaauto.com.br', 15),
(16, 'Loja Caneca Criativa', 'PJ', '11222333000116', '1133330016', 'vendas@canecacriativa.com.br', 16),
(17, 'Hotel Ilha Azul', 'PJ', '11222333000117', '4833330017', 'compras@ilhaazul.com.br', 17),
(18, 'Joinville Hospitalar', 'PJ', '11222333000118', '4733330018', 'suprimentos@joinvillehospitalar.com.br', 18),
(19, 'Serra Gaúcha Vinhos', 'PJ', '11222333000119', '5433330019', 'logistica@serravinhos.com.br', 19),
(20, 'Londrina Fresh Foods', 'PJ', '11222333000120', '4333330020', 'pedidos@freshfoods.com.br', 20);

INSERT IGNORE INTO Motorista (id_motorista, nome, cpf, telefone, cnh, status, email) VALUES
(1, 'Carlos Silva', '11111111101', '47999990001', 'SC000001', 'Ativo', 'carlos.silva@logitech.com'),
(2, 'Mariana Costa', '11111111102', '47999990002', 'SC000002', 'Ativo', 'mariana.costa@logitech.com'),
(3, 'João Pereira', '11111111103', '41999990003', 'PR000003', 'Ativo', 'joao.pereira@logitech.com'),
(4, 'Fernanda Rocha', '11111111104', '11999990004', 'SP000004', 'Ativo', 'fernanda.rocha@logitech.com'),
(5, 'Rafael Martins', '11111111105', '47999990005', 'SC000005', 'Ativo', 'rafael.martins@logitech.com'),
(6, 'Patrícia Nunes', '11111111106', '47999990006', 'SC000006', 'Ativo', 'patricia.nunes@logitech.com'),
(7, 'Lucas Almeida', '11111111107', '48999990007', 'SC000007', 'Ativo', 'lucas.almeida@logitech.com'),
(8, 'Bianca Ferreira', '11111111108', '42999990008', 'PR000008', 'Ativo', 'bianca.ferreira@logitech.com'),
(9, 'Eduardo Gomes', '11111111109', '51999990009', 'RS000009', 'Ativo', 'eduardo.gomes@logitech.com'),
(10, 'Aline Carvalho', '11111111110', '47999990010', 'SC000010', 'Ativo', 'aline.carvalho@logitech.com'),
(11, 'Gustavo Lima', '11111111111', '47999990011', 'SC000011', 'Ativo', 'gustavo.lima@logitech.com'),
(12, 'Camila Dias', '11111111112', '47999990012', 'SC000012', 'Ativo', 'camila.dias@logitech.com'),
(13, 'Roberto Alves', '11111111113', '41999990013', 'PR000013', 'Ativo', 'roberto.alves@logitech.com'),
(14, 'Juliana Mendes', '11111111114', '11999990014', 'SP000014', 'Ativo', 'juliana.mendes@logitech.com'),
(15, 'Henrique Barbosa', '11111111115', '41999990015', 'PR000015', 'Ativo', 'henrique.barbosa@logitech.com'),
(16, 'Natália Freitas', '11111111116', '11999990016', 'SP000016', 'Ativo', 'natalia.freitas@logitech.com'),
(17, 'Diego Ramos', '11111111117', '48999990017', 'SC000017', 'Ativo', 'diego.ramos@logitech.com'),
(18, 'Priscila Teixeira', '11111111118', '47999990018', 'SC000018', 'Ativo', 'priscila.teixeira@logitech.com'),
(19, 'Marcelo Vieira', '11111111119', '54999990019', 'RS000019', 'Ativo', 'marcelo.vieira@logitech.com'),
(20, 'Sofia Moreira', '11111111120', '43999990020', 'PR000020', 'Ativo', 'sofia.moreira@logitech.com');

INSERT IGNORE INTO Veiculo (id_veiculo, placa, modelo, tipo, capacidade, status) VALUES
(1, 'ABC1D01', 'Volvo FH', 'Caminhão', 25000.00, 'Disponível'),
(2, 'ABC1D02', 'Scania R450', 'Caminhão', 27000.00, 'Disponível'),
(3, 'ABC1D03', 'Mercedes Accelo', 'Caminhão leve', 8500.00, 'Disponível'),
(4, 'ABC1D04', 'Volkswagen Delivery', 'Caminhão leve', 6000.00, 'Disponível'),
(5, 'ABC1D05', 'Iveco Daily', 'Van', 3500.00, 'Disponível'),
(6, 'ABC1D06', 'Renault Master', 'Van', 1600.00, 'Disponível'),
(7, 'ABC1D07', 'Ford Cargo', 'Caminhão', 17000.00, 'Disponível'),
(8, 'ABC1D08', 'DAF XF', 'Carreta', 30000.00, 'Disponível'),
(9, 'ABC1D09', 'MAN TGX', 'Carreta', 32000.00, 'Disponível'),
(10, 'ABC1D10', 'Hyundai HR', 'Utilitário', 1800.00, 'Disponível'),
(11, 'ABC1D11', 'Fiat Fiorino', 'Utilitário', 650.00, 'Disponível'),
(12, 'ABC1D12', 'Peugeot Partner', 'Utilitário', 800.00, 'Disponível'),
(13, 'ABC1D13', 'Mercedes Atego', 'Caminhão', 14000.00, 'Disponível'),
(14, 'ABC1D14', 'Volvo VM', 'Caminhão', 18000.00, 'Disponível'),
(15, 'ABC1D15', 'Scania P320', 'Caminhão', 16000.00, 'Disponível'),
(16, 'ABC1D16', 'Volkswagen Constellation', 'Caminhão', 23000.00, 'Disponível'),
(17, 'ABC1D17', 'Iveco Tector', 'Caminhão', 13000.00, 'Disponível'),
(18, 'ABC1D18', 'Mercedes Sprinter', 'Van', 1500.00, 'Disponível'),
(19, 'ABC1D19', 'Ford Transit', 'Van', 1400.00, 'Disponível'),
(20, 'ABC1D20', 'Renault Kangoo', 'Utilitário', 750.00, 'Disponível');

INSERT IGNORE INTO Rota (id_rota, origem, destino, distancia_km, tempo_estimado) VALUES
(1, 'Joinville/SC', 'Curitiba/PR', 130.50, '2h10'),
(2, 'Joinville/SC', 'Florianópolis/SC', 175.00, '2h40'),
(3, 'Curitiba/PR', 'São Paulo/SP', 408.00, '6h00'),
(4, 'São Paulo/SP', 'Campinas/SP', 100.00, '1h30'),
(5, 'Blumenau/SC', 'Itajaí/SC', 55.00, '1h00'),
(6, 'Itajaí/SC', 'Joinville/SC', 88.00, '1h25'),
(7, 'Florianópolis/SC', 'Blumenau/SC', 140.00, '2h20'),
(8, 'Ponta Grossa/PR', 'Curitiba/PR', 115.00, '1h50'),
(9, 'Porto Alegre/RS', 'Caxias do Sul/RS', 128.00, '2h15'),
(10, 'Blumenau/SC', 'Joinville/SC', 105.00, '1h45'),
(11, 'Joinville/SC', 'Balneário Camboriú/SC', 95.00, '1h20'),
(12, 'Balneário Camboriú/SC', 'Florianópolis/SC', 82.00, '1h15'),
(13, 'Curitiba/PR', 'Londrina/PR', 380.00, '5h30'),
(14, 'São Paulo/SP', 'Curitiba/PR', 408.00, '6h10'),
(15, 'Curitiba/PR', 'Ponta Grossa/PR', 115.00, '1h50'),
(16, 'São Paulo/SP', 'Santos/SP', 75.00, '1h20'),
(17, 'Florianópolis/SC', 'Itajaí/SC', 100.00, '1h35'),
(18, 'Joinville/SC', 'Blumenau/SC', 105.00, '1h45'),
(19, 'Caxias do Sul/RS', 'Porto Alegre/RS', 128.00, '2h15'),
(20, 'Londrina/PR', 'Curitiba/PR', 380.00, '5h30');

INSERT IGNORE INTO Entrega (id_entrega, data_criacao, data_prevista, data_conclusao, status, descricao, id_motorista, id_veiculo, id_rota, id_cliente) VALUES
(1, '2026-08-01', '2026-08-02', NULL, 'Pendente', 'Alimentos não perecíveis', 1, 1, 1, 1),
(2, '2026-08-01', '2026-08-02', NULL, 'Em Transporte', 'Medicamentos controlados', 2, 2, 2, 2),
(3, '2026-08-02', '2026-08-03', '2026-08-03', 'Entregue', 'Pedido residencial', 3, 3, 3, 3),
(4, '2026-08-02', '2026-08-04', NULL, 'Pendente', 'Componentes eletrônicos', 4, 4, 4, 4),
(5, '2026-08-03', '2026-08-04', NULL, 'Em Transporte', 'Carga têxtil', 5, 5, 5, 5),
(6, '2026-08-03', '2026-08-04', '2026-08-04', 'Entregue', 'Produtos portuários', 6, 6, 6, 6),
(7, '2026-08-04', '2026-08-05', NULL, 'Pendente', 'Itens pessoais', 7, 7, 7, 7),
(8, '2026-08-04', '2026-08-05', NULL, 'Em Transporte', 'Insumos agrícolas', 8, 8, 8, 8),
(9, '2026-08-05', '2026-08-06', '2026-08-06', 'Entregue', 'Peças automotivas', 9, 9, 9, 9),
(10, '2026-08-05', '2026-08-06', NULL, 'Cancelada', 'Material industrial', 10, 10, 10, 10),
(11, '2026-08-06', '2026-08-07', NULL, 'Pendente', 'Entrega expressa', 11, 11, 11, 11),
(12, '2026-08-06', '2026-08-07', NULL, 'Em Transporte', 'Materiais para evento', 12, 12, 12, 12),
(13, '2026-08-07', '2026-08-08', '2026-08-08', 'Entregue', 'Equipamentos clínicos', 13, 13, 13, 13),
(14, '2026-08-07', '2026-08-09', NULL, 'Pendente', 'Móveis corporativos', 14, 14, 14, 14),
(15, '2026-08-08', '2026-08-09', NULL, 'Em Transporte', 'Autopeças', 15, 15, 15, 15),
(16, '2026-08-08', '2026-08-09', NULL, 'Pendente', 'Produtos personalizados', 16, 16, 16, 16),
(17, '2026-08-09', '2026-08-10', '2026-08-10', 'Entregue', 'Suprimentos hoteleiros', 17, 17, 17, 17),
(18, '2026-08-09', '2026-08-10', NULL, 'Em Transporte', 'Materiais hospitalares', 18, 18, 18, 18),
(19, '2026-08-10', '2026-08-11', NULL, 'Pendente', 'Bebidas especiais', 19, 19, 19, 19),
(20, '2026-08-10', '2026-08-11', NULL, 'Em Transporte', 'Alimentos refrigerados', 20, 20, 20, 20);

INSERT IGNORE INTO Atualizacao_Entrega (id_atualizacao, id_entrega, status, data_hora, observacao) VALUES
(1, 1, 'Pendente', '2026-08-01 08:00:00', 'Entrega criada e aguardando despacho'),
(2, 2, 'Em Transporte', '2026-08-01 09:00:00', 'Entrega saiu para transporte'),
(3, 3, 'Entregue', '2026-08-03 15:30:00', 'Entrega concluída no destino'),
(4, 4, 'Pendente', '2026-08-02 10:00:00', 'Entrega criada e aguardando coleta'),
(5, 5, 'Em Transporte', '2026-08-03 11:20:00', 'Veículo em rota'),
(6, 6, 'Entregue', '2026-08-04 14:10:00', 'Entrega finalizada'),
(7, 7, 'Pendente', '2026-08-04 08:40:00', 'Pedido recebido'),
(8, 8, 'Em Transporte', '2026-08-04 13:15:00', 'Carga em deslocamento'),
(9, 9, 'Entregue', '2026-08-06 16:45:00', 'Entrega confirmada pelo cliente'),
(10, 10, 'Cancelada', '2026-08-05 12:00:00', 'Entrega cancelada pelo cliente'),
(11, 11, 'Pendente', '2026-08-06 09:05:00', 'Aguardando roteirização'),
(12, 12, 'Em Transporte', '2026-08-06 10:35:00', 'Saiu do centro de distribuição'),
(13, 13, 'Entregue', '2026-08-08 17:00:00', 'Recebimento confirmado'),
(14, 14, 'Pendente', '2026-08-07 08:25:00', 'Entrega programada'),
(15, 15, 'Em Transporte', '2026-08-08 12:15:00', 'Motorista em rota'),
(16, 16, 'Pendente', '2026-08-08 14:00:00', 'Separação concluída'),
(17, 17, 'Entregue', '2026-08-10 11:45:00', 'Entrega sem ocorrência'),
(18, 18, 'Em Transporte', '2026-08-09 15:20:00', 'Carga em trânsito'),
(19, 19, 'Pendente', '2026-08-10 08:10:00', 'Aguardando carregamento'),
(20, 20, 'Em Transporte', '2026-08-10 09:30:00', 'Transporte refrigerado ativo');
