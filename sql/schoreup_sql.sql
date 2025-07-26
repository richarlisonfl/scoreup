-- Tabela de Campus
CREATE TABLE Campus (
    id_campus INT PRIMARY KEY AUTO_INCREMENT,
    nome_campus VARCHAR(100) NOT NULL,
    is_sede BOOLEAN NOT NULL DEFAULT FALSE
);

-- Tabela de Modalidades
CREATE TABLE Modalidade (
    id_modalidade INT PRIMARY KEY AUTO_INCREMENT,
    nome_modalidade VARCHAR(50) NOT NULL,
    pontos_vitoria INT NOT NULL DEFAULT 1,
    pontos_empate INT NOT NULL DEFAULT 0,
    max_sets INT,
    sets_para_vencer INT,
    descricao TEXT,
    UNIQUE(nome_modalidade)
);

-- Tabela de Usuários
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

-- Tabela de Times
CREATE TABLE Time (
    id_time INT PRIMARY KEY AUTO_INCREMENT,
    nome_time VARCHAR(100) NOT NULL,
    id_campus INT NOT NULL,
    id_modalidade INT NOT NULL,
    sexo ENUM('M', 'F') NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_campus) REFERENCES Campus(id_campus),
    FOREIGN KEY (id_modalidade) REFERENCES Modalidade(id_modalidade),
    UNIQUE(id_campus, id_modalidade, sexo)
);

-- Tabela de Atletas
CREATE TABLE Atleta (
    id_atleta INT PRIMARY KEY AUTO_INCREMENT,
    nome_atleta VARCHAR(100) NOT NULL,
    matricula VARCHAR(20),
    curso VARCHAR(50),
    id_time INT NOT NULL,
    FOREIGN KEY (id_time) REFERENCES Time(id_time)
);

-- Tabela de Locais
CREATE TABLE Local (
    id_local INT PRIMARY KEY AUTO_INCREMENT,
    nome_local VARCHAR(100) NOT NULL,
    descricao TEXT,
    capacidade INT,
    id_campus INT NOT NULL,
    FOREIGN KEY (id_campus) REFERENCES Campus(id_campus)
);

-- Tabela de Partidas
CREATE TABLE Partida (
    id_partida INT PRIMARY KEY AUTO_INCREMENT,
    id_modalidade INT NOT NULL,
    id_time_casa INT NOT NULL,
    id_time_visitante INT NOT NULL,
    data_hora DATETIME NOT NULL,
    id_local INT,
    fase VARCHAR(50) NOT NULL, -- Fase de grupos, quartas, semi, final etc.
    status ENUM('agendada', 'em_andamento', 'concluida', 'cancelada') DEFAULT 'agendada',
    FOREIGN KEY (id_modalidade) REFERENCES Modalidade(id_modalidade),
    FOREIGN KEY (id_time_casa) REFERENCES Time(id_time),
    FOREIGN KEY (id_time_visitante) REFERENCES Time(id_time),
    FOREIGN KEY (id_local) REFERENCES Local(id_local)
);

-- Tabela de Resultados
CREATE TABLE Resultado (
    id_resultado INT PRIMARY KEY AUTO_INCREMENT,
    id_partida INT NOT NULL,
    placar_casa INT NOT NULL,
    placar_visitante INT NOT NULL,
    sets_casa INT,
    sets_visitante INT,
    vencedor INT, -- Pode ser NULL em caso de empate, se a modalidade permitir
    observacoes TEXT,
    data_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_usuario_registro INT NOT NULL,
    FOREIGN KEY (id_partida) REFERENCES Partida(id_partida),
    FOREIGN KEY (vencedor) REFERENCES Time(id_time),
    FOREIGN KEY (id_usuario_registro) REFERENCES Usuario(id_usuario),
    UNIQUE(id_partida)
);

-- Tabela de Classificação por Modalidade
CREATE TABLE ClassificacaoModalidade (
    id_classificacao INT PRIMARY KEY AUTO_INCREMENT,
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
    FOREIGN KEY (id_modalidade) REFERENCES Modalidade(id_modalidade),
    FOREIGN KEY (id_time) REFERENCES Time(id_time),
    UNIQUE(id_modalidade, id_time)
);

-- Tabela de Classificação Geral
CREATE TABLE ClassificacaoGeral (
    id_classificacao INT PRIMARY KEY AUTO_INCREMENT,
    id_campus INT NOT NULL,
    total_pontos INT NOT NULL DEFAULT 0,
    total_vitorias INT NOT NULL DEFAULT 0,
    total_empates INT NOT NULL DEFAULT 0,
    total_derrotas INT NOT NULL DEFAULT 0,
    FOREIGN KEY (id_campus) REFERENCES Campus(id_campus),
    UNIQUE(id_campus)
);

-- Tabela de Notícias/Comunicados
CREATE TABLE Noticia (
    id_noticia INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200) NOT NULL,
    conteudo TEXT NOT NULL,
    data_publicacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_usuario_publicacao INT NOT NULL,
    FOREIGN KEY (id_usuario_publicacao) REFERENCES Usuario(id_usuario)
);








-- Trigger para atualizar a classificação quando um resultado é inserido
DELIMITER //
CREATE TRIGGER after_resultado_insert
AFTER INSERT ON Resultado
FOR EACH ROW
BEGIN
    DECLARE modalidade_id INT;
    DECLARE time_vencedor_id INT;
    DECLARE time_perdedor_id INT;
    DECLARE empate BOOLEAN DEFAULT FALSE;
    
    -- Obter a modalidade da partida
    SELECT id_modalidade INTO modalidade_id FROM Partida WHERE id_partida = NEW.id_partida;
    
    -- Determinar vencedor e perdedor (ou se foi empate)
    IF NEW.vencedor IS NULL THEN
        SET empate = TRUE;
        SELECT id_time_casa, id_time_visitante INTO time_vencedor_id, time_perdedor_id 
        FROM Partida WHERE id_partida = NEW.id_partida;
    ELSE
        SET time_vencedor_id = NEW.vencedor;
        -- Determinar o perdedor
        IF NEW.vencedor = (SELECT id_time_casa FROM Partida WHERE id_partida = NEW.id_partida) THEN
            SELECT id_time_visitante INTO time_perdedor_id FROM Partida WHERE id_partida = NEW.id_partida;
        ELSE
            SELECT id_time_casa INTO time_perdedor_id FROM Partida WHERE id_partida = NEW.id_partida;
        END IF;
    END IF;
    
    -- Atualizar classificação da modalidade para ambos os times
    IF empate THEN
        -- Time da casa (empate)
        UPDATE ClassificacaoModalidade
        SET pontos = pontos + (SELECT pontos_empate FROM Modalidade WHERE id_modalidade = modalidade_id),
            jogos = jogos + 1,
            empates = empates + 1,
            sets_pro = sets_pro + NEW.sets_casa,
            sets_contra = sets_contra + NEW.sets_visitante,
            pontos_pro = pontos_pro + NEW.placar_casa,
            pontos_contra = pontos_contra + NEW.placar_visitante,
            saldo_sets = (sets_pro + NEW.sets_casa) - (sets_contra + NEW.sets_visitante),
            saldo_pontos = (pontos_pro + NEW.placar_casa) - (pontos_contra + NEW.placar_visitante)
        WHERE id_modalidade = modalidade_id AND id_time = time_vencedor_id;
        
        -- Time visitante (empate)
        UPDATE ClassificacaoModalidade
        SET pontos = pontos + (SELECT pontos_empate FROM Modalidade WHERE id_modalidade = modalidade_id),
            jogos = jogos + 1,
            empates = empates + 1,
            sets_pro = sets_pro + NEW.sets_visitante,
            sets_contra = sets_contra + NEW.sets_casa,
            pontos_pro = pontos_pro + NEW.placar_visitante,
            pontos_contra = pontos_contra + NEW.placar_casa,
            saldo_sets = (sets_pro + NEW.sets_visitante) - (sets_contra + NEW.sets_casa),
            saldo_pontos = (pontos_pro + NEW.placar_visitante) - (pontos_contra + NEW.placar_casa)
        WHERE id_modalidade = modalidade_id AND id_time = time_perdedor_id;
    ELSE
        -- Time vencedor
        UPDATE ClassificacaoModalidade
        SET pontos = pontos + (SELECT pontos_vitoria FROM Modalidade WHERE id_modalidade = modalidade_id),
            jogos = jogos + 1,
            vitorias = vitorias + 1,
            sets_pro = sets_pro + IF(time_vencedor_id = (SELECT id_time_casa FROM Partida WHERE id_partida = NEW.id_partida), NEW.sets_casa, NEW.sets_visitante),
            sets_contra = sets_contra + IF(time_vencedor_id = (SELECT id_time_casa FROM Partida WHERE id_partida = NEW.id_partida), NEW.sets_visitante, NEW.sets_casa),
            pontos_pro = pontos_pro + IF(time_vencedor_id = (SELECT id_time_casa FROM Partida WHERE id_partida = NEW.id_partida), NEW.placar_casa, NEW.placar_visitante),
            pontos_contra = pontos_contra + IF(time_vencedor_id = (SELECT id_time_casa FROM Partida WHERE id_partida = NEW.id_partida), NEW.placar_visitante, NEW.placar_casa),
            saldo_sets = (sets_pro + IF(time_vencedor_id = (SELECT id_time_casa FROM Partida WHERE id_partida = NEW.id_partida), NEW.sets_casa, NEW.sets_visitante)) - 
                          (sets_contra + IF(time_vencedor_id = (SELECT id_time_casa FROM Partida WHERE id_partida = NEW.id_partida), NEW.sets_visitante, NEW.sets_casa)),
            saldo_pontos = (pontos_pro + IF(time_vencedor_id = (SELECT id_time_casa FROM Partida WHERE id_partida = NEW.id_partida), NEW.placar_casa, NEW.placar_visitante)) - 
                           (pontos_contra + IF(time_vencedor_id = (SELECT id_time_casa FROM Partida WHERE id_partida = NEW.id_partida), NEW.placar_visitante, NEW.placar_casa))
        WHERE id_modalidade = modalidade_id AND id_time = time_vencedor_id;
        
        -- Time perdedor
        UPDATE ClassificacaoModalidade
        SET jogos = jogos + 1,
            derrotas = derrotas + 1,
            sets_pro = sets_pro + IF(time_perdedor_id = (SELECT id_time_casa FROM Partida WHERE id_partida = NEW.id_partida), NEW.sets_casa, NEW.sets_visitante),
            sets_contra = sets_contra + IF(time_perdedor_id = (SELECT id_time_casa FROM Partida WHERE id_partida = NEW.id_partida), NEW.sets_visitante, NEW.sets_casa),
            pontos_pro = pontos_pro + IF(time_perdedor_id = (SELECT id_time_casa FROM Partida WHERE id_partida = NEW.id_partida), NEW.placar_casa, NEW.placar_visitante),
            pontos_contra = pontos_contra + IF(time_perdedor_id = (SELECT id_time_casa FROM Partida WHERE id_partida = NEW.id_partida), NEW.placar_visitante, NEW.placar_casa),
            saldo_sets = (sets_pro + IF(time_perdedor_id = (SELECT id_time_casa FROM Partida WHERE id_partida = NEW.id_partida), NEW.sets_casa, NEW.sets_visitante)) - 
                          (sets_contra + IF(time_perdedor_id = (SELECT id_time_casa FROM Partida WHERE id_partida = NEW.id_partida), NEW.sets_visitante, NEW.sets_casa)),
            saldo_pontos = (pontos_pro + IF(time_perdedor_id = (SELECT id_time_casa FROM Partida WHERE id_partida = NEW.id_partida), NEW.placar_casa, NEW.placar_visitante)) - 
                           (pontos_contra + IF(time_perdedor_id = (SELECT id_time_casa FROM Partida WHERE id_partida = NEW.id_partida), NEW.placar_visitante, NEW.placar_casa))
        WHERE id_modalidade = modalidade_id AND id_time = time_perdedor_id;
    END IF;
    
    -- Atualizar classificação geral dos campi
    CALL AtualizarClassificacaoGeral();
END //
DELIMITER ;

-- Procedure para atualizar a classificação geral
DELIMITER //
CREATE PROCEDURE AtualizarClassificacaoGeral()
BEGIN
    -- Para cada campus, somar todas as vitórias de seus times em todas as modalidades
    INSERT INTO ClassificacaoGeral (id_campus, total_pontos, total_vitorias, total_empates, total_derrotas)
    SELECT c.id_campus, 
           SUM(cm.pontos) AS total_pontos,
           SUM(cm.vitorias) AS total_vitorias,
           SUM(cm.empates) AS total_empates,
           SUM(cm.derrotas) AS total_derrotas
    FROM Campus c
    LEFT JOIN Time t ON t.id_campus = c.id_campus
    LEFT JOIN ClassificacaoModalidade cm ON cm.id_time = t.id_time
    GROUP BY c.id_campus
    ON DUPLICATE KEY UPDATE
        total_pontos = VALUES(total_pontos),
        total_vitorias = VALUES(total_vitorias),
        total_empates = VALUES(total_empates),
        total_derrotas = VALUES(total_derrotas);
END //
DELIMITER ;

-- Procedure para inicializar a classificação de uma modalidade
DELIMITER //
CREATE PROCEDURE InicializarClassificacaoModalidade(IN modalidade_id INT)
BEGIN
    -- Inserir todos os times da modalidade na tabela de classificação
    INSERT INTO ClassificacaoModalidade (id_modalidade, id_time, pontos, jogos, vitorias, empates, derrotas, sets_pro, sets_contra, pontos_pro, pontos_contra, saldo_sets, saldo_pontos)
    SELECT modalidade_id, t.id_time, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    FROM Time t
    WHERE t.id_modalidade = modalidade_id
    ON DUPLICATE KEY UPDATE id_modalidade = id_modalidade;
END //
DELIMITER ;