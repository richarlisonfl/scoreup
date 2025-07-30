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

CREATE TABLE Partida (
    id_partida INT PRIMARY KEY AUTO_INCREMENT,
    id_edicao INT NOT NULL,
    id_modalidade INT NOT NULL,
    id_time_a INT NOT NULL,
    id_time_b INT NOT NULL,
    data_hora DATETIME NOT NULL,
    id_local INT NULL,
    fase VARCHAR(50) NOT NULL,
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
    placar_casa INT NOT NULL,
    placar_visitante INT NOT NULL,
    sets_casa INT,
    sets_visitante INT,
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

DELIMITER //
CREATE TRIGGER valida_genero_partida
BEFORE INSERT ON Partida
FOR EACH ROW
BEGIN
    DECLARE genero_casa CHAR(1);
    DECLARE genero_visitante CHAR(1);

    SELECT sexo INTO genero_casa FROM Time WHERE id_time = NEW.id_time_a;
    SELECT sexo INTO genero_visitante FROM Time WHERE id_time = NEW.id_time_b;

    IF genero_casa != genero_visitante THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Times devem ser do mesmo gênero para uma partida';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER after_resultado_insert
AFTER INSERT ON Resultado
FOR EACH ROW
BEGIN
    DECLARE modalidade_id INT;
    DECLARE time_vencedor_id INT;
    DECLARE time_perdedor_id INT;
    DECLARE empate BOOLEAN DEFAULT FALSE;
    DECLARE edicao_id INT;

    SELECT id_modalidade, id_edicao, id_time_a, id_time_b 
    INTO modalidade_id, edicao_id, time_vencedor_id, time_perdedor_id
    FROM Partida WHERE id_partida = NEW.id_partida;

    IF NEW.vencedor IS NULL THEN
        SET empate = TRUE;
    ELSE
        SET time_vencedor_id = NEW.vencedor;
        IF NEW.vencedor = time_vencedor_id THEN
            SET time_perdedor_id = time_perdedor_id;
        ELSE
            SET time_perdedor_id = time_vencedor_id;
            SET time_vencedor_id = NEW.vencedor;
        END IF;
    END IF;

    IF empate THEN
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
        WHERE id_edicao = edicao_id AND id_modalidade = modalidade_id AND id_time = time_vencedor_id;

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
        WHERE id_edicao = edicao_id AND id_modalidade = modalidade_id AND id_time = time_perdedor_id;

    ELSE
        UPDATE ClassificacaoModalidade
        SET pontos = pontos + (SELECT pontos_vitoria FROM Modalidade WHERE id_modalidade = modalidade_id),
            jogos = jogos + 1,
            vitorias = vitorias + 1,
            sets_pro = sets_pro + IF(time_vencedor_id = (SELECT id_time_a FROM Partida WHERE id_partida = NEW.id_partida), NEW.sets_casa, NEW.sets_visitante),
            sets_contra = sets_contra + IF(time_vencedor_id = (SELECT id_time_a FROM Partida WHERE id_partida = NEW.id_partida), NEW.sets_visitante, NEW.sets_casa),
            pontos_pro = pontos_pro + IF(time_vencedor_id = (SELECT id_time_a FROM Partida WHERE id_partida = NEW.id_partida), NEW.placar_casa, NEW.placar_visitante),
            pontos_contra = pontos_contra + IF(time_vencedor_id = (SELECT id_time_a FROM Partida WHERE id_partida = NEW.id_partida), NEW.placar_visitante, NEW.placar_casa),
            saldo_sets = (sets_pro + IF(time_vencedor_id = (SELECT id_time_a FROM Partida WHERE id_partida = NEW.id_partida), NEW.sets_casa, NEW.sets_visitante)) - 
                          (sets_contra + IF(time_vencedor_id = (SELECT id_time_a FROM Partida WHERE id_partida = NEW.id_partida), NEW.sets_visitante, NEW.sets_casa)),
            saldo_pontos = (pontos_pro + IF(time_vencedor_id = (SELECT id_time_a FROM Partida WHERE id_partida = NEW.id_partida), NEW.placar_casa, NEW.placar_visitante)) - 
                           (pontos_contra + IF(time_vencedor_id = (SELECT id_time_a FROM Partida WHERE id_partida = NEW.id_partida), NEW.placar_visitante, NEW.placar_casa))
        WHERE id_edicao = edicao_id AND id_modalidade = modalidade_id AND id_time = time_vencedor_id;

        UPDATE ClassificacaoModalidade
        SET jogos = jogos + 1,
            derrotas = derrotas + 1,
            sets_pro = sets_pro + IF(time_perdedor_id = (SELECT id_time_a FROM Partida WHERE id_partida = NEW.id_partida), NEW.sets_casa, NEW.sets_visitante),
            sets_contra = sets_contra + IF(time_perdedor_id = (SELECT id_time_a FROM Partida WHERE id_partida = NEW.id_partida), NEW.sets_visitante, NEW.sets_casa),
            pontos_pro = pontos_pro + IF(time_perdedor_id = (SELECT id_time_a FROM Partida WHERE id_partida = NEW.id_partida), NEW.placar_casa, NEW.placar_visitante),
            pontos_contra = pontos_contra + IF(time_perdedor_id = (SELECT id_time_a FROM Partida WHERE id_partida = NEW.id_partida), NEW.placar_visitante, NEW.placar_casa),
            saldo_sets = (sets_pro + IF(time_perdedor_id = (SELECT id_time_a FROM Partida WHERE id_partida = NEW.id_partida), NEW.sets_casa, NEW.sets_visitante)) - 
                          (sets_contra + IF(time_perdedor_id = (SELECT id_time_a FROM Partida WHERE id_partida = NEW.id_partida), NEW.sets_visitante, NEW.sets_casa)),
            saldo_pontos = (pontos_pro + IF(time_perdedor_id = (SELECT id_time_a FROM Partida WHERE id_partida = NEW.id_partida), NEW.placar_casa, NEW.placar_visitante)) - 
                           (pontos_contra + IF(time_perdedor_id = (SELECT id_time_a FROM Partida WHERE id_partida = NEW.id_partida), NEW.placar_visitante, NEW.placar_casa))
        WHERE id_edicao = edicao_id AND id_modalidade = modalidade_id AND id_time = time_perdedor_id;
    END IF;

    CALL AtualizarClassificacaoGeral(edicao_id);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AtualizarClassificacaoGeral(IN edicao_id INT)
BEGIN
    INSERT INTO ClassificacaoGeral (id_edicao, id_campus, total_pontos, total_vitorias, total_empates, total_derrotas)
    SELECT c.id_campus,
           COALESCE(SUM(cm.pontos), 0),
           COALESCE(SUM(cm.vitorias), 0),
           COALESCE(SUM(cm.empates), 0),
           COALESCE(SUM(cm.derrotas), 0)
    FROM Campus c
    LEFT JOIN Time t ON t.id_campus = c.id_campus AND t.id_edicao = edicao_id
    LEFT JOIN ClassificacaoModalidade cm ON cm.id_time = t.id_time AND cm.id_edicao = edicao_id
    GROUP BY c.id_campus
    ON DUPLICATE KEY UPDATE
        total_pontos = VALUES(total_pontos),
        total_vitorias = VALUES(total_vitorias),
        total_empates = VALUES(total_empates),
        total_derrotas = VALUES(total_derrotas);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE InicializarClassificacaoModalidade(
    IN modalidade_id INT,
    IN edicao_id INT
)
BEGIN
    INSERT INTO ClassificacaoModalidade (
        id_edicao, id_modalidade, id_time, pontos, jogos, vitorias, empates, derrotas,
        sets_pro, sets_contra, pontos_pro, pontos_contra, saldo_sets, saldo_pontos
    )
    SELECT edicao_id, modalidade_id, t.id_time, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    FROM Time t
    WHERE t.id_modalidade = modalidade_id AND t.id_edicao = edicao_id
    ON DUPLICATE KEY UPDATE id_edicao = id_edicao;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE trocar_sede(novo_nome VARCHAR(100))
BEGIN
  SET SQL_SAFE_UPDATES = 0;

  UPDATE Campus
  SET is_sede = FALSE
  WHERE is_sede = TRUE;

  UPDATE Campus
  SET is_sede = TRUE
  WHERE nome_campus = novo_nome;

  SET SQL_SAFE_UPDATES = 1;
END//

DELIMITER ;
DELIMITER //
CREATE PROCEDURE GerarCronogramaPartidas(IN edicao INT, IN data_inicio DATE, IN data_fim DATE)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE modalidade INT;
    DECLARE local INT;
    DECLARE duracao INT;
    DECLARE hora_inicio TIME DEFAULT '08:00:00';
    DECLARE hora_fim TIME;
    DECLARE cur_modalidades CURSOR FOR SELECT id_modalidade, duracao_minutos FROM Modalidade;
    DECLARE cur_locais CURSOR FOR SELECT id_local FROM Local;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_modalidades;
    modalidade_loop: LOOP
        FETCH cur_modalidades INTO modalidade, duracao;
        IF done THEN
            LEAVE modalidade_loop;
        END IF;

        SET done = FALSE;
        OPEN cur_locais;
        local_loop: LOOP
            FETCH cur_locais INTO local;
            IF done THEN
                LEAVE local_loop;
            END IF;

            -- Exemplo: agenda uma partida por modalidade/local por dia
            SET hora_inicio = '08:00:00';
            SET hora_fim = ADDTIME(hora_inicio, SEC_TO_TIME(duracao * 60));
            INSERT INTO CronogramaPartidas (id_edicao, id_modalidade, id_local, data_partida, hora_inicio, hora_fim, fase)
            VALUES (edicao, modalidade, local, data_inicio, hora_inicio, hora_fim, 'grupo');
        END LOOP;
        CLOSE cur_locais;
        SET done = FALSE;
    END LOOP;
    CLOSE cur_modalidades;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER unico_admin
BEFORE INSERT ON Usuario
FOR EACH ROW
BEGIN
    IF NEW.is_admin = TRUE THEN
        IF (SELECT COUNT(*) FROM Usuario WHERE is_admin = TRUE) > 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Já existe um administrador cadastrado.';
        END IF;
    END IF;
END //
DELIMITER ;