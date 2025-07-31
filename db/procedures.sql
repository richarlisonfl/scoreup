-- 1. Procedures para Gestão de Partidas
DELIMITER //
CREATE PROCEDURE sp_agendar_partida(
    IN p_id_edicao INT,
    IN p_id_modalidade INT,
    IN p_data_hora DATETIME,
    IN p_id_local INT,
    IN p_duracao_minutos INT,
    IN p_observacao VARCHAR(50)
)
BEGIN
    -- Verificar se os parâmetros obrigatórios foram fornecidos
    IF p_id_edicao IS NULL OR p_id_modalidade IS NULL OR p_data_hora IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Parâmetros obrigatórios não fornecidos (id_edicao, id_modalidade, data_hora)';
    END IF;
    
    -- Verificar se a edição e modalidade existem
    IF NOT EXISTS (SELECT 1 FROM Edicao WHERE id_edicao = p_id_edicao) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Edição não encontrada';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM Modalidade WHERE id_modalidade = p_id_modalidade) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Modalidade não encontrada';
    END IF;
    
    -- Inserir a partida com status correto
    INSERT INTO Partida (
        id_edicao, 
        id_modalidade, 
        data_hora, 
        id_local, 
        duracao_minutos, 
        observacao, 
        status
    ) VALUES (
        p_id_edicao, 
        p_id_modalidade, 
        p_data_hora, 
        p_id_local, 
        p_duracao_minutos, 
        p_observacao, 
        'sem_time_atribuida' -- Valor explícito do ENUM
    );
END //

-- 2. Procedures para Registro de Resultados
CREATE PROCEDURE sp_registrar_resultado(
    IN p_id_partida INT,
    IN p_placar_a INT,
    IN p_placar_b INT,
    IN p_sets_a INT,
    IN p_sets_b INT,
    IN p_id_usuario_registro INT,
    IN p_observacoes TEXT
)
BEGIN
    DECLARE v_vencedor INT;
    DECLARE v_id_edicao INT;
    DECLARE v_id_modalidade INT;
    DECLARE v_id_time_a INT;
    DECLARE v_id_time_b INT;
    
    -- Determinar vencedor
    IF p_placar_a > p_placar_b THEN
        SELECT id_time_a INTO v_vencedor FROM Partida WHERE id_partida = p_id_partida;
    ELSEIF p_placar_b > p_placar_a THEN
        SELECT id_time_b INTO v_vencedor FROM Partida WHERE id_partida = p_id_partida;
    ELSE
        SET v_vencedor = NULL; -- Empate
    END IF;
    
    -- Obter informações da partida
    SELECT id_edicao, id_modalidade, id_time_a, id_time_b 
    INTO v_id_edicao, v_id_modalidade, v_id_time_a, v_id_time_b
    FROM Partida 
    WHERE id_partida = p_id_partida;
    
    -- Inserir resultado
    INSERT INTO Resultado (id_partida, placar_a, placar_b, sets_a, sets_b, vencedor, observacoes, id_usuario_registro)
    VALUES (p_id_partida, p_placar_a, p_placar_b, p_sets_a, p_sets_b, v_vencedor, p_observacoes, p_id_usuario_registro);
    
    -- Atualizar status da partida
    UPDATE Partida SET status = 'concluida' WHERE id_partida = p_id_partida;
    
    -- Atualizar classificações
    CALL sp_atualizar_classificacao_modalidade(v_id_edicao, v_id_modalidade, v_id_time_a, v_id_time_b, p_placar_a, p_placar_b, p_sets_a, p_sets_b, v_vencedor);
    CALL sp_atualizar_classificacao_geral(v_id_edicao, v_id_time_a, v_id_time_b, v_vencedor);
END //

-- 3. Procedures para Classificação
CREATE PROCEDURE sp_atualizar_classificacao_modalidade(
    IN p_id_edicao INT,
    IN p_id_modalidade INT,
    IN p_id_time_a INT,
    IN p_id_time_b INT,
    IN p_placar_a INT,
    IN p_placar_b INT,
    IN p_sets_a INT,
    IN p_sets_b INT,
    IN p_vencedor INT
)
BEGIN
    DECLARE v_pontos_time_a INT;
    DECLARE v_pontos_time_b INT;
    
    -- Determinar pontos para cada time
    IF p_vencedor = p_id_time_a THEN
        SET v_pontos_time_a = (SELECT pontos_vitoria FROM Modalidade WHERE id_modalidade = p_id_modalidade);
        SET v_pontos_time_b = 0;
    ELSEIF p_vencedor = p_id_time_b THEN
        SET v_pontos_time_a = 0;
        SET v_pontos_time_b = (SELECT pontos_vitoria FROM Modalidade WHERE id_modalidade = p_id_modalidade);
    ELSE -- Empate
        SET v_pontos_time_a = (SELECT pontos_empate FROM Modalidade WHERE id_modalidade = p_id_modalidade);
        SET v_pontos_time_b = (SELECT pontos_empate FROM Modalidade WHERE id_modalidade = p_id_modalidade);
    END IF;
    
    -- Atualizar classificação do time A
    IF EXISTS (SELECT 1 FROM ClassificacaoModalidade WHERE id_edicao = p_id_edicao AND id_modalidade = p_id_modalidade AND id_time = p_id_time_a) THEN
        UPDATE ClassificacaoModalidade 
        SET pontos = pontos + v_pontos_time_a,
            jogos = jogos + 1,
            vitorias = vitorias + IF(p_vencedor = p_id_time_a, 1, 0),
            empates = empates + IF(p_vencedor IS NULL, 1, 0),
            derrotas = derrotas + IF(p_vencedor = p_id_time_b, 1, 0),
            sets_pro = sets_pro + IFNULL(p_sets_a, 0),
            sets_contra = sets_contra + IFNULL(p_sets_b, 0),
            pontos_pro = pontos_pro + p_placar_a,
            pontos_contra = pontos_contra + p_placar_b,
            saldo_sets = saldo_sets + IFNULL(p_sets_a, 0) - IFNULL(p_sets_b, 0),
            saldo_pontos = saldo_pontos + p_placar_a - p_placar_b
        WHERE id_edicao = p_id_edicao AND id_modalidade = p_id_modalidade AND id_time = p_id_time_a;
    ELSE
        INSERT INTO ClassificacaoModalidade (id_edicao, id_modalidade, id_time, pontos, jogos, vitorias, empates, derrotas, 
                                           sets_pro, sets_contra, pontos_pro, pontos_contra, saldo_sets, saldo_pontos)
        VALUES (p_id_edicao, p_id_modalidade, p_id_time_a, v_pontos_time_a, 1, 
                IF(p_vencedor = p_id_time_a, 1, 0), 
                IF(p_vencedor IS NULL, 1, 0),
                IF(p_vencedor = p_id_time_b, 1, 0),
                IFNULL(p_sets_a, 0), IFNULL(p_sets_b, 0),
                p_placar_a, p_placar_b,
                IFNULL(p_sets_a, 0) - IFNULL(p_sets_b, 0),
                p_placar_a - p_placar_b);
    END IF;
    
    -- Atualizar classificação do time B
    IF EXISTS (SELECT 1 FROM ClassificacaoModalidade WHERE id_edicao = p_id_edicao AND id_modalidade = p_id_modalidade AND id_time = p_id_time_b) THEN
        UPDATE ClassificacaoModalidade 
        SET pontos = pontos + v_pontos_time_b,
            jogos = jogos + 1,
            vitorias = vitorias + IF(p_vencedor = p_id_time_b, 1, 0),
            empates = empates + IF(p_vencedor IS NULL, 1, 0),
            derrotas = derrotas + IF(p_vencedor = p_id_time_a, 1, 0),
            sets_pro = sets_pro + IFNULL(p_sets_b, 0),
            sets_contra = sets_contra + IFNULL(p_sets_a, 0),
            pontos_pro = pontos_pro + p_placar_b,
            pontos_contra = pontos_contra + p_placar_a,
            saldo_sets = saldo_sets + IFNULL(p_sets_b, 0) - IFNULL(p_sets_a, 0),
            saldo_pontos = saldo_pontos + p_placar_b - p_placar_a
        WHERE id_edicao = p_id_edicao AND id_modalidade = p_id_modalidade AND id_time = p_id_time_b;
    ELSE
        INSERT INTO ClassificacaoModalidade (id_edicao, id_modalidade, id_time, pontos, jogos, vitorias, empates, derrotas, 
                                           sets_pro, sets_contra, pontos_pro, pontos_contra, saldo_sets, saldo_pontos)
        VALUES (p_id_edicao, p_id_modalidade, p_id_time_b, v_pontos_time_b, 1, 
                IF(p_vencedor = p_id_time_b, 1, 0), 
                IF(p_vencedor IS NULL, 1, 0),
                IF(p_vencedor = p_id_time_a, 1, 0),
                IFNULL(p_sets_b, 0), IFNULL(p_sets_a, 0),
                p_placar_b, p_placar_a,
                IFNULL(p_sets_b, 0) - IFNULL(p_sets_a, 0),
                p_placar_b - p_placar_a);
    END IF;
END //

CREATE PROCEDURE sp_atualizar_classificacao_geral(
    IN p_id_edicao INT,
    IN p_id_time_a INT,
    IN p_id_time_b INT,
    IN p_vencedor INT
)
BEGIN
    DECLARE v_id_campus_a INT;
    DECLARE v_id_campus_b INT;
    
    -- Obter campus dos times
    SELECT id_campus INTO v_id_campus_a FROM Time WHERE id_time = p_id_time_a;
    SELECT id_campus INTO v_id_campus_b FROM Time WHERE id_time = p_id_time_b;
    
    -- Atualizar classificação do campus A
    IF EXISTS (SELECT 1 FROM ClassificacaoGeral WHERE id_edicao = p_id_edicao AND id_campus = v_id_campus_a) THEN
        UPDATE ClassificacaoGeral 
        SET total_vitorias = total_vitorias + IF(p_vencedor = p_id_time_a, 1, 0),
            total_empates = total_empates + IF(p_vencedor IS NULL, 1, 0),
            total_derrotas = total_derrotas + IF(p_vencedor = p_id_time_b, 1, 0)
        WHERE id_edicao = p_id_edicao AND id_campus = v_id_campus_a;
    ELSE
        INSERT INTO ClassificacaoGeral (id_edicao, id_campus, total_vitorias, total_empates, total_derrotas)
        VALUES (p_id_edicao, v_id_campus_a, 
                IF(p_vencedor = p_id_time_a, 1, 0),
                IF(p_vencedor IS NULL, 1, 0),
                IF(p_vencedor = p_id_time_b, 1, 0));
    END IF;
    
    -- Atualizar classificação do campus B
    IF EXISTS (SELECT 1 FROM ClassificacaoGeral WHERE id_edicao = p_id_edicao AND id_campus = v_id_campus_b) THEN
        UPDATE ClassificacaoGeral 
        SET total_vitorias = total_vitorias + IF(p_vencedor = p_id_time_b, 1, 0),
            total_empates = total_empates + IF(p_vencedor IS NULL, 1, 0),
            total_derrotas = total_derrotas + IF(p_vencedor = p_id_time_a, 1, 0)
        WHERE id_edicao = p_id_edicao AND id_campus = v_id_campus_b;
    ELSE
        INSERT INTO ClassificacaoGeral (id_edicao, id_campus, total_vitorias, total_empates, total_derrotas)
        VALUES (p_id_edicao, v_id_campus_b, 
                IF(p_vencedor = p_id_time_b, 1, 0),
                IF(p_vencedor IS NULL, 1, 0),
                IF(p_vencedor = p_id_time_a, 1, 0));
    END IF;
END //

-- 4. Procedures para Relatórios
CREATE PROCEDURE sp_obter_classificacao_modalidade(
    IN p_id_edicao INT,
    IN p_id_modalidade INT
)
BEGIN
    WITH classificacao AS (
        SELECT 
            id_time,
            pontos,
            jogos,
            vitorias,
            empates,
            derrotas,
            sets_pro,
            sets_contra,
            pontos_pro,
            pontos_contra,
            saldo_sets,
            saldo_pontos,
            ROW_NUMBER() OVER (
                ORDER BY pontos DESC, saldo_sets DESC, saldo_pontos DESC
            ) AS posicao
        FROM 
            ClassificacaoModalidade
        WHERE 
            id_edicao = p_id_edicao AND 
            id_modalidade = p_id_modalidade
    )
    SELECT 
        c.posicao,
        t.nome_time,
        cp.nome_campus,
        c.pontos,
        c.jogos,
        c.vitorias,
        c.empates,
        c.derrotas,
        c.sets_pro,
        c.sets_contra,
        c.saldo_sets,
        c.pontos_pro,
        c.pontos_contra,
        c.saldo_pontos
    FROM 
        classificacao c
    JOIN Time t ON c.id_time = t.id_time
    JOIN Campus cp ON t.id_campus = cp.id_campus
    ORDER BY c.posicao;
END //

CREATE PROCEDURE sp_obter_classificacao_geral(
    IN p_id_edicao INT
)
BEGIN
    WITH classificacao AS (
        SELECT 
            id_campus,
            total_pontos,
            total_vitorias,
            total_empates,
            total_derrotas,
            ROW_NUMBER() OVER (
                ORDER BY total_pontos DESC, total_vitorias DESC
            ) AS posicao
        FROM 
            ClassificacaoGeral
        WHERE 
            id_edicao = p_id_edicao
    )
    SELECT 
        c.posicao,
        cp.nome_campus,
        c.total_pontos,
        c.total_vitorias,
        c.total_empates,
        c.total_derrotas
    FROM 
        classificacao c
    JOIN Campus cp ON c.id_campus = cp.id_campus
    ORDER BY c.posicao;
END //

-- 5. Procedures para Gestão de Times
CREATE PROCEDURE sp_add_time(
    IN p_nome_time VARCHAR(100),
    IN p_id_edicao INT,
    IN p_id_campus INT,
    IN p_id_modalidade INT,
    IN p_sexo ENUM('M', 'F'),
    OUT p_id_time INT
)
/*
Nome: sp_add_time
Descrição: Cadastra um novo time no sistema com todas as validações necessárias
Parâmetros:
  - p_nome_time: Nome do time
  - p_id_edicao: ID da edição do evento
  - p_id_campus: ID do campus
  - p_id_modalidade: ID da modalidade esportiva
  - p_sexo: Sexo dos participantes ('M' ou 'F')
  - p_id_time: Retorna o ID do time criado
Exemplo:
  CALL sp_add_time('Time A', 1, 1, 1, 'M', @id_time);
  SELECT @id_time;
*/
BEGIN
    DECLARE v_time_existe INT;
    DECLARE v_modalidade_valida BOOLEAN;
    
    -- Validações básicas
    IF p_nome_time IS NULL OR p_id_edicao IS NULL OR p_id_campus IS NULL OR 
       p_id_modalidade IS NULL OR p_sexo IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Todos os parâmetros são obrigatórios';
    END IF;
    
    -- Verificar se edição existe
    IF NOT EXISTS (SELECT 1 FROM Edicao WHERE id_edicao = p_id_edicao) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Edição não encontrada';
    END IF;
    
    -- Verificar se campus existe
    IF NOT EXISTS (SELECT 1 FROM Campus WHERE id_campus = p_id_campus) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Campus não encontrado';
    END IF;
    
    -- Verificar se modalidade existe
    IF NOT EXISTS (SELECT 1 FROM Modalidade WHERE id_modalidade = p_id_modalidade) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Modalidade não encontrada';
    END IF;
    
    -- Verificar se já existe time para mesma combinação
    SELECT COUNT(*) INTO v_time_existe 
    FROM Time 
    WHERE id_edicao = p_id_edicao 
      AND id_campus = p_id_campus 
      AND id_modalidade = p_id_modalidade 
      AND sexo = p_sexo;
    
    IF v_time_existe > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Já existe um time para esta modalidade, edição, campus e sexo';
    END IF;
    
    -- Inserir o novo time
    INSERT INTO Time (
        nome_time, 
        id_edicao, 
        id_campus, 
        id_modalidade, 
        sexo,
        data_cadastro
    ) VALUES (
        p_nome_time, 
        p_id_edicao, 
        p_id_campus, 
        p_id_modalidade, 
        p_sexo,
        NOW()
    );
    
    -- Retornar o ID do time criado
    SET p_id_time = LAST_INSERT_ID();
    
    -- Inserir classificação inicial para o time
    INSERT INTO ClassificacaoModalidade (
        id_edicao, 
        id_modalidade, 
        id_time,
        pontos,
        jogos,
        vitorias,
        empates,
        derrotas,
        sets_pro,
        sets_contra,
        pontos_pro,
        pontos_contra,
        saldo_sets,
        saldo_pontos
    ) VALUES (
        p_id_edicao,
        p_id_modalidade,
        p_id_time,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    );
END //

CREATE PROCEDURE sp_add_atleta(
    IN p_nome_atleta VARCHAR(100),
    IN p_matricula VARCHAR(20),
    IN p_curso VARCHAR(50),
    IN p_id_time INT
)
BEGIN
    INSERT INTO Atleta (nome_atleta, matricula, curso, id_time)
    VALUES (p_nome_atleta, p_matricula, p_curso, p_id_time);
END //



CREATE PROCEDURE sp_trocar_campus_sede(
    IN p_nome_novo_campus VARCHAR(100)
)
BEGIN
    DECLARE v_id_novo_campus INT;
    
    -- Obter ID do campus pelo nome
    SELECT id_campus INTO v_id_novo_campus 
    FROM Campus 
    WHERE nome_campus = p_nome_novo_campus;
    
    IF v_id_novo_campus IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Campus não encontrado';
    ELSE
        -- Chamar a procedure base que usa ID
        CALL sp_atualizar_sede_campus(v_id_novo_campus);
    END IF;
END //
CREATE PROCEDURE sp_add_local(
    IN p_nome_local VARCHAR(100),
    IN p_descricao TEXT,
    IN p_id_campus INT
)
BEGIN
    -- Verificar se o campus existe
    IF NOT EXISTS (SELECT 1 FROM Campus WHERE id_campus = p_id_campus) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Campus não encontrado';
    END IF;
    
    -- Inserir o local
    INSERT INTO Local (nome_local, descricao, id_campus)
    VALUES (p_nome_local, p_descricao, p_id_campus);
    
    -- Retornar o ID do local inserido
    -- SELECT LAST_INSERT_ID() AS id_local;
END //
CREATE PROCEDURE sp_add_modalidade(
    IN p_nome_modalidade VARCHAR(50),
    IN p_descricao TEXT,
    IN p_duracao_minutos INT,
    IN p_pontos_vitoria INT,
    IN p_pontos_empate INT
)
BEGIN
    -- Verificar se a modalidade já existe
    IF EXISTS (SELECT 1 FROM Modalidade WHERE nome_modalidade = p_nome_modalidade) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Modalidade já cadastrada';
    END IF;
    
    -- Validação dos parâmetros
    IF p_duracao_minutos <= 0 THEN
        SET p_duracao_minutos = 60; -- Valor padrão
    END IF;
    
    IF p_pontos_vitoria <= 0 THEN
        SET p_pontos_vitoria = 3; -- Valor padrão
    END IF;
    
    IF p_pontos_empate < 0 THEN
        SET p_pontos_empate = 1; -- Valor padrão
    END IF;
    
    -- Inserir a modalidade
    INSERT INTO Modalidade (
        nome_modalidade, 
        descricao, 
        duracao_minutos, 
        pontos_vitoria, 
        pontos_empate
    ) VALUES (
        p_nome_modalidade, 
        p_descricao, 
        p_duracao_minutos, 
        p_pontos_vitoria, 
        p_pontos_empate
    );
    
    -- Retornar o ID da modalidade inserida
    -- SELECT LAST_INSERT_ID() AS id_modalidade;
END //

CREATE PROCEDURE sp_add_usuario(
    IN p_nome_completo VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_senha_aberta VARCHAR(255),
    IN p_id_campus INT,
    IN p_is_responsavel BOOLEAN,
    OUT p_id_usuario INT
)
BEGIN
    DECLARE v_is_sede BOOLEAN DEFAULT FALSE;
    DECLARE v_senha_hash VARCHAR(255);
    DECLARE v_email_existe INT;
    
    -- Validações iniciais
    IF p_nome_completo IS NULL OR p_email IS NULL OR p_senha_aberta IS NULL OR p_id_campus IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Nome, email, senha e id_campus são obrigatórios';
    END IF;
    
    -- Verificar se email já existe
    SELECT COUNT(*) INTO v_email_existe FROM Usuario WHERE email = p_email;
    IF v_email_existe > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Email já cadastrado no sistema';
    END IF;
    
    -- Verificar se campus existe e obter status de sede
    SELECT is_sede INTO v_is_sede 
    FROM Campus 
    WHERE id_campus = p_id_campus;
    
    IF v_is_sede IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Campus não encontrado';
    END IF;
    
    -- Criar hash da senha (SHA-256)
    SET v_senha_hash = SHA2(p_senha_aberta, 256);
    
    -- Inserir usuário com transação (SEM data_cadastro)
    START TRANSACTION;
    
    INSERT INTO Usuario (
        nome_completo, 
        email, 
        senha, 
        id_campus, 
        is_admin, 
        is_responsavel  -- Removido data_cadastro
    ) VALUES (
        p_nome_completo, 
        p_email, 
        v_senha_hash, 
        p_id_campus, 
        v_is_sede,
        IFNULL(p_is_responsavel, FALSE)
    );
    
    -- Obter e retornar o ID do usuário inserido
    SET p_id_usuario = LAST_INSERT_ID();
    
    -- Se for do campus sede, garantir que é o único admin
    IF v_is_sede = TRUE THEN
        UPDATE Usuario SET is_admin = FALSE 
        WHERE id_campus = p_id_campus AND id_usuario != p_id_usuario;
        
        UPDATE Usuario SET is_admin = TRUE 
        WHERE id_usuario = p_id_usuario;
    END IF;
    
    COMMIT;
END //

CREATE PROCEDURE sp_atualizar_sede_campus(
    IN p_id_novo_campus_sede INT
)
BEGIN
    DECLARE v_id_atual_sede INT;
    
    START TRANSACTION;
    
    -- Obter campus sede atual (usando WHERE com KEY)
    SELECT id_campus INTO v_id_atual_sede FROM Campus WHERE is_sede = TRUE LIMIT 1;
    
    -- Atualizar apenas o campus sede atual (usando WHERE com KEY)
    IF v_id_atual_sede IS NOT NULL THEN
        UPDATE Campus SET is_sede = FALSE WHERE id_campus = v_id_atual_sede;
    END IF;
    
    -- Definir novo campus sede (usando WHERE com KEY)
    UPDATE Campus SET is_sede = TRUE WHERE id_campus = p_id_novo_campus_sede;
    
    -- Atualizar privilégios admin (agora em duas etapas)
    -- 1. Remover admin de todos os usuários do campus que era sede
    IF v_id_atual_sede IS NOT NULL THEN
        UPDATE Usuario SET is_admin = FALSE WHERE id_campus = v_id_atual_sede;
    END IF;
    
    -- 2. Definir como admin um usuário do novo campus sede (usando WHERE com KEY)
    UPDATE Usuario u
    JOIN (
        SELECT id_usuario 
        FROM Usuario 
        WHERE id_campus = p_id_novo_campus_sede
        ORDER BY is_responsavel DESC, id_usuario
        LIMIT 1
    ) AS novo_admin ON u.id_usuario = novo_admin.id_usuario
    SET u.is_admin = TRUE;
    
    COMMIT;
END //
DELIMITER ;