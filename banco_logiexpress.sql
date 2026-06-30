-- ==========================================
-- CRIAÇÃO DO BANCO DE DADOS
-- ==========================================

CREATE DATABASE LogiTechExpress;
USE LogiTechExpress;


-- ==========================================
-- TABELA ENDERECO
-- Armazena os endereços dos clientes
-- ==========================================

CREATE TABLE Endereco (
    id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    rua VARCHAR(100) NOT NULL,
    numero VARCHAR(10),
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    estado VARCHAR(30),
    cep VARCHAR(10)
);


-- ==========================================
-- TABELA CLIENTE
-- Armazena informações dos clientes
-- ==========================================

CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,

    -- PF = Pessoa Física
    -- PJ = Pessoa Jurídica
    tipo_cliente VARCHAR(2) NOT NULL,

    -- CPF ou CNPJ
    documento VARCHAR(20) UNIQUE,

    telefone VARCHAR(15),
    email VARCHAR(100),

    -- Chave estrangeira para endereço
    id_endereco INT,

    FOREIGN KEY (id_endereco)
    REFERENCES Endereco(id_endereco)
);


-- ==========================================
-- TABELA MOTORISTA
-- Armazena dados dos motoristas
-- ==========================================

CREATE TABLE Motorista (
    id_motorista INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE,
    telefone VARCHAR(15),
    cnh VARCHAR(20) UNIQUE,
    status VARCHAR(20),
    email VARCHAR(100)
);


-- ==========================================
-- TABELA VEICULO
-- Armazena dados dos veículos
-- ==========================================

CREATE TABLE Veiculo (
    id_veiculo INT PRIMARY KEY AUTO_INCREMENT,

    placa VARCHAR(10) UNIQUE NOT NULL,
    modelo VARCHAR(50),
    tipo VARCHAR(30),

    capacidade DECIMAL(10,2),

    status VARCHAR(20)
);


-- ==========================================
-- TABELA ROTA
-- Armazena informações das rotas
-- ==========================================

CREATE TABLE Rota (
    id_rota INT PRIMARY KEY AUTO_INCREMENT,

    origem VARCHAR(100),
    destino VARCHAR(100),

    distancia_km DECIMAL(10,2),

    tempo_estimado VARCHAR(30)
);


-- ==========================================
-- TABELA ENTREGA
-- Tabela principal do sistema
-- Liga motorista, veículo, cliente e rota
-- ==========================================

CREATE TABLE Entrega (
    id_entrega INT PRIMARY KEY AUTO_INCREMENT,

    data_criacao DATE,
    data_prevista DATE,
    data_conclusao DATE,

    status VARCHAR(30),

    descricao VARCHAR(255),

    id_motorista INT,
    id_veiculo INT,
    id_rota INT,
    id_cliente INT,

    -- Chave estrangeira do motorista
    FOREIGN KEY (id_motorista)
    REFERENCES Motorista(id_motorista),

    -- Chave estrangeira do veículo
    FOREIGN KEY (id_veiculo)
    REFERENCES Veiculo(id_veiculo),

    -- Chave estrangeira da rota
    FOREIGN KEY (id_rota)
    REFERENCES Rota(id_rota),

    -- Chave estrangeira do cliente
    FOREIGN KEY (id_cliente)
    REFERENCES Cliente(id_cliente)
);


-- ==========================================
-- TABELA ATUALIZACAO_ENTREGA
-- Guarda histórico de status das entregas
-- ==========================================

CREATE TABLE Atualizacao_Entrega (
    id_atualizacao INT PRIMARY KEY AUTO_INCREMENT,

    id_entrega INT,

    status VARCHAR(30),

    data_hora DATETIME,

    observacao VARCHAR(255),

    FOREIGN KEY (id_entrega)
    REFERENCES Entrega(id_entrega)
);