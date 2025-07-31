DROP DATABASE IF EXISTS scoreup;
CREATE DATABASE scoreup;
USE scoreup;

CREATE TABLE Edicao (
    id_edicao INT PRIMARY KEY AUTO_INCREMENT,
    nome_edicao VARCHAR(100) NOT NULL,
    ano YEAR NOT NULL,
    data_inicio DATE,
    data_fim DATE,
    UNIQUE (nome_edicao, ano)
);

CREATE TABLE Campus (
    id_campus INT PRIMARY KEY AUTO_INCREMENT,
    nome_campus VARCHAR(100) NOT NULL,
    is_sede BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE Modalidade (
    id_modalidade INT PRIMARY KEY AUTO_INCREMENT,
    nome_modalidade VARCHAR(50) NOT NULL,
    descricao TEXT,
    duracao_minutos INT DEFAULT 60,
    pontos_vitoria INT DEFAULT 3,
    pontos_empate INT DEFAULT 1,
    UNIQUE(nome_modalidade)
);

CREATE TABLE Usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome_completo VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    id_campus INT NOT NULL,
    is_admin BOOLEAN NOT NULL DEFAULT FALSE,
    is_responsavel BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (id_campus) REFERENCES Campus(id_campus),
    UNIQUE(email)
);

CREATE TABLE Time (
    id_time INT PRIMARY KEY AUTO_INCREMENT,
    nome_time VARCHAR(100) NOT NULL,
    id_edicao INT NOT NULL,
    id_campus INT NOT NULL,
    id_modalidade INT NOT NULL,
    sexo ENUM('M', 'F') NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_edicao) REFERENCES Edicao(id_edicao),
    FOREIGN KEY (id_campus) REFERENCES Campus(id_campus),
    FOREIGN KEY (id_modalidade) REFERENCES Modalidade(id_modalidade),
    UNIQUE(id_edicao, id_campus, id_modalidade, sexo)
);

CREATE TABLE Atleta (
    id_atleta INT PRIMARY KEY AUTO_INCREMENT,
    nome_atleta VARCHAR(100) NOT NULL,
    matricula VARCHAR(20),
    curso VARCHAR(50),
    id_time INT NOT NULL,
    FOREIGN KEY (id_time) REFERENCES Time(id_time)
);

CREATE TABLE Local (
    id_local INT PRIMARY KEY AUTO_INCREMENT,
    nome_local VARCHAR(100) NOT NULL,
    descricao TEXT,
    -- capacidade INT,
    id_campus INT NOT NULL,
    FOREIGN KEY (id_campus) REFERENCES Campus(id_campus)
);
-- INSERT INTO Partida (data_hora, duracao_minutos, status, id_local, id_modalidade, id_edicao) VALUES
CREATE TABLE Partida (
    id_partida INT PRIMARY KEY AUTO_INCREMENT, -- 1
    id_edicao INT NOT NULL, -- 1
    id_modalidade INT NOT NULL, -- 6
    id_time_a INT NULL,  -- Alterado para permitir NULL
    id_time_b INT NULL,  -- Alterado para permitir NULL
    data_hora DATETIME NOT NULL,
    duracao_minutos INT NULL,  -- Adicionado
    id_local INT NULL,
    observacao VARCHAR(50) NULL,
    status ENUM('sem_time_atribuida','agendada', 'em_andamento', 'concluida', 'cancelada') DEFAULT 'sem_time_atribuida',
    FOREIGN KEY (id_edicao) REFERENCES Edicao(id_edicao),
    FOREIGN KEY (id_modalidade) REFERENCES Modalidade(id_modalidade),
    FOREIGN KEY (id_time_a) REFERENCES Time(id_time),
    FOREIGN KEY (id_time_b) REFERENCES Time(id_time),
    FOREIGN KEY (id_local) REFERENCES Local(id_local)
);

CREATE TABLE Resultado (
    id_resultado INT PRIMARY KEY AUTO_INCREMENT,
    id_partida INT NOT NULL,
    placar_a INT NOT NULL,
    placar_b INT NOT NULL,
    sets_a INT,
    sets_b INT,
    vencedor INT,
    observacoes TEXT,
    data_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_usuario_registro INT NOT NULL,
    FOREIGN KEY (id_partida) REFERENCES Partida(id_partida),
    FOREIGN KEY (vencedor) REFERENCES Time(id_time),
    FOREIGN KEY (id_usuario_registro) REFERENCES Usuario(id_usuario),
    UNIQUE(id_partida)
);

CREATE TABLE ClassificacaoModalidade (
    id_classificacao INT PRIMARY KEY AUTO_INCREMENT,
    id_edicao INT NOT NULL,
    id_modalidade INT NOT NULL,
    id_time INT NOT NULL,
    pontos INT NOT NULL DEFAULT 0,
    jogos INT NOT NULL DEFAULT 0,
    vitorias INT NOT NULL DEFAULT 0,
    empates INT NOT NULL DEFAULT 0,
    derrotas INT NOT NULL DEFAULT 0,
    sets_pro INT NOT NULL DEFAULT 0,
    sets_contra INT NOT NULL DEFAULT 0,
    pontos_pro INT NOT NULL DEFAULT 0,
    pontos_contra INT NOT NULL DEFAULT 0,
    saldo_sets INT NOT NULL DEFAULT 0,
    saldo_pontos INT NOT NULL DEFAULT 0,
    FOREIGN KEY (id_edicao) REFERENCES Edicao(id_edicao),
    FOREIGN KEY (id_modalidade) REFERENCES Modalidade(id_modalidade),
    FOREIGN KEY (id_time) REFERENCES Time(id_time),
    UNIQUE(id_edicao, id_modalidade, id_time)
);

CREATE TABLE ClassificacaoGeral (
    id_classificacao INT PRIMARY KEY AUTO_INCREMENT,
    id_edicao INT NOT NULL,
    id_campus INT NOT NULL,
    total_pontos INT NOT NULL DEFAULT 0,
    total_vitorias INT NOT NULL DEFAULT 0,
    total_empates INT NOT NULL DEFAULT 0,
    total_derrotas INT NOT NULL DEFAULT 0,
    FOREIGN KEY (id_edicao) REFERENCES Edicao(id_edicao),
    FOREIGN KEY (id_campus) REFERENCES Campus(id_campus),
    UNIQUE(id_edicao, id_campus)
);

CREATE TABLE Noticia (
    id_noticia INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200) NOT NULL,
    conteudo TEXT NOT NULL,
    data_publicacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_usuario_publicacao INT NOT NULL,
    FOREIGN KEY (id_usuario_publicacao) REFERENCES Usuario(id_usuario)
);

-- Tabela para armazenar o cronograma das partidas
CREATE TABLE CronogramaPartidas (
    id_cronograma INT PRIMARY KEY AUTO_INCREMENT,
    id_edicao INT NOT NULL,
    id_modalidade INT NOT NULL,
    id_local INT NOT NULL,
    data_partida DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL,
    id_time_a INT, -- Preenchido após sorteio
    id_time_b INT, -- Preenchido após sorteio
    fase VARCHAR(50),
    status ENUM('agendada', 'realizada', 'cancelada') DEFAULT 'agendada',
    FOREIGN KEY (id_edicao) REFERENCES Edicao(id_edicao),
    FOREIGN KEY (id_modalidade) REFERENCES Modalidade(id_modalidade),
    FOREIGN KEY (id_local) REFERENCES Local(id_local),
    FOREIGN KEY (id_time_a) REFERENCES Time(id_time),
    FOREIGN KEY (id_time_b) REFERENCES Time(id_time)
);