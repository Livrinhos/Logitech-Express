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
