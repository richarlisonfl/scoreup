INSERT INTO Edicao (nome_edicao, ano, data_inicio, data_fim) VALUES ('Jogos IFPA 2026', 2026, '2026-06-01', '2026-06-06');
INSERT INTO Campus (nome_campus, is_sede) VALUES
('Abaetetuba', FALSE),
('Altamira', FALSE),
('Ananindeua', FALSE),
('Belém',TRUE),
('Bragança', FALSE),
('Breves', FALSE),
('Cametá', FALSE),
('Castanhal', FALSE),
('Conceição do Araguaia', FALSE),
('Itaituba', FALSE),
('Marabá Industrial', FALSE),
('Marabá Rural', FALSE),
('Óbidos', FALSE),
('Paragominas', FALSE),
('Parauapebas', FALSE),
('Santarém', FALSE),
('Tucuruí', FALSE),
('Vigia', FALSE);

CALL sp_atualizar_sede_campus(14); 				-- troca com ID
-- CALL sp_trocar_campus_sede('Paragominas'); 	-- troca com nome

CALL sp_add_local('Ginásio Paragominas - LADO A', 'Mesa oficial disponibilizada no Lado A da quadra do campus.', 14);
CALL sp_add_local('Ginásio Paragominas - LADO B', 'Mesa oficial disponibilizada no Lado B da quadra do campus.', 14);
CALL sp_add_modalidade ('Futsal', 'Futsal masculino e feminino', 40, 3, 1);
CALL sp_add_modalidade ('Voleibol', 'Voleibol de quadra', 60, 3, 1);
CALL sp_add_modalidade ('Basquete', 'Basquete tradicional', 40, 3, 1);
CALL sp_add_modalidade ('Handebol', 'Handebol de quadra', 60, 3, 1);
CALL sp_add_modalidade ('Atletismo', 'Provas de pista e campo', 0, 3, 1);
CALL sp_add_modalidade ('Tênis de Mesa', 'Individual e duplas', 30, 3, 1);
CALL sp_add_modalidade ('Xadrez', 'Competição individual', 60, 3, 1);
CALL sp_add_modalidade ('Judô', 'Lutas individuais', 10, 3, 1);
CALL sp_add_modalidade ('Natação', 'Provas individuais e revezamento', 0, 3, 1);
CALL sp_add_modalidade ('Vôlei de Praia', 'Duplas masculinas e femininas', 30, 3, 1);

CALL sp_add_usuario('Abaetetuba', 'usuario.abaetetuba@ifpa.edu.br', 'senha123', 1, NULL,@n1);
CALL sp_add_usuario('Altamira', 'usuario.altamira@ifpa.edu.br', 'senha123', 2, NULL,@n1);
CALL sp_add_usuario('Ananindeua', 'usuario.ananindeua@ifpa.edu.br', 'senha123', 3, NULL,@n1);
CALL sp_add_usuario('Belem', 'usuario.belem@ifpa.edu.br', 'senha123', 4,NULL,@n1);
CALL sp_add_usuario('Braganca', 'usuario.braganca@ifpa.edu.br', 'senha123', 5,NULL,@n1);
CALL sp_add_usuario('Breves', 'usuario.breves@ifpa.edu.br', 'senha123', 6,NULL,@n1);
CALL sp_add_usuario('Cameta', 'usuario.cameta@ifpa.edu.br', 'senha123', 7, NULL,@n1);
CALL sp_add_usuario('Castanhal', 'usuario.castanhal@ifpa.edu.br', 'senha123', 8, NULL,@n1);
CALL sp_add_usuario('ConceicaoAraguaia', 'usuario.conceicaoaraguaia@ifpa.edu.br', 'senha123', 9,NULL,@n1);
CALL sp_add_usuario('Itaituba', 'usuario.itaituba@ifpa.edu.br', 'senha123', 10, NULL,@n1);
CALL sp_add_usuario('MarabaIndustrial', 'usuario.marabaindustrial@ifpa.edu.br', 'senha123', 11, NULL,@n1);
CALL sp_add_usuario('MarabaRural', 'usuario.marabarural@ifpa.edu.br', 'senha123', 12,NULL,@n1);
CALL sp_add_usuario('Obidos', 'usuario.obidos@ifpa.edu.br', 'senha123', 13, NULL,@n1);
CALL sp_add_usuario('Paragominas', 'usuario.paragominas@ifpa.edu.br', 'senha123', 14,NULL,@n1);
CALL sp_add_usuario('Parauapebas', 'usuario.parauapebas@ifpa.edu.br', 'senha123', 15, NULL,@n1);
CALL sp_add_usuario('Santarem', 'usuario.santarem@ifpa.edu.br', 'senha123', 16, NULL,@n1);
CALL sp_add_usuario('Tucurui', 'usuario.tucurui@ifpa.edu.br', 'senha123', 17,NULL,@n1);
CALL sp_add_usuario('Vigia', 'usuario.vigia@ifpa.edu.br', 'senha123', 18, NULL,@n1);



-- TIMES ALTERADOS PARA TÊNIS DE MESA (id_modalidade = 6) - REMOVIDOS ABAETETUBA E ÓBIDOS



-- Campus 2 (Altamira)
CALL sp_add_time('Altamira Tênis de Mesa Masculino', 1, 2, 6, 'M', @id_time_m);  -- id_time = 1
CALL sp_add_time('Altamira Tênis de Mesa Feminino', 1, 2, 6, 'F',@id_time_f);   -- id_time = 2

-- Campus 3 (Ananindeua)
CALL sp_add_time('Ananindeua Tênis de Mesa Masculino', 1, 3, 6, 'M',@id_time_m); -- id_time = 3
CALL sp_add_time('Ananindeua Tênis de Mesa Feminino', 1, 3, 6, 'F',@id_time_f);  -- id_time = 4

-- Campus 4 (Belém)
CALL sp_add_time('Belém Tênis de Mesa Masculino', 1, 4, 6, 'M',@id_time_m);      -- id_time = 5
CALL sp_add_time('Belém Tênis de Mesa Feminino', 1, 4, 6, 'F',@id_time_f);       -- id_time = 6

-- Campus 5 (Bragança)
CALL sp_add_time('Bragança Tênis de Mesa Masculino', 1, 5, 6, 'M',@id_time_m);   -- id_time = 7
CALL sp_add_time('Bragança Tênis de Mesa Feminino', 1, 5, 6, 'F',@id_time_f);    -- id_time = 8

-- Campus 6 (Breves)
CALL sp_add_time('Breves Tênis de Mesa Masculino', 1, 6, 6, 'M',@id_time_m);     -- id_time = 9
CALL sp_add_time('Breves Tênis de Mesa Feminino', 1, 6, 6, 'F',@id_time_f);      -- id_time = 10

-- Campus 7 (Cametá)
CALL sp_add_time('Cametá Tênis de Mesa Masculino', 1, 7, 6, 'M',@id_time_m);     -- id_time = 11
CALL sp_add_time('Cametá Tênis de Mesa Feminino', 1, 7, 6, 'F',@id_time_f);      -- id_time = 12

-- Campus 8 (Castanhal)
CALL sp_add_time('Castanhal Tênis de Mesa Masculino', 1, 8, 6, 'M',@id_time_m);  -- id_time = 13
CALL sp_add_time('Castanhal Tênis de Mesa Feminino', 1, 8, 6, 'F',@id_time_f);   -- id_time = 14

-- Campus 9 (Conceição do Araguaia)
CALL sp_add_time('Conceição do Araguaia Tênis de Mesa Masculino', 1, 9, 6, 'M',@id_time_m); -- id_time = 15
CALL sp_add_time('Conceição do Araguaia Tênis de Mesa Feminino', 1, 9, 6, 'F',@id_time_f);  -- id_time = 16

-- Campus 10 (Itaituba)
CALL sp_add_time('Itaituba Tênis de Mesa Masculino', 1, 10, 6, 'M',@id_time_m);  -- id_time = 17
CALL sp_add_time('Itaituba Tênis de Mesa Feminino', 1, 10, 6, 'F',@id_time_f);   -- id_time = 18

-- Campus 11 (Marabá Industrial)
CALL sp_add_time('Marabá Industrial Tênis de Mesa Masculino', 1, 11, 6, 'M',@id_time_m); -- id_time = 19
CALL sp_add_time('Marabá Industrial Tênis de Mesa Feminino', 1, 11, 6, 'F',@id_time_f);  -- id_time = 20

-- Campus 12 (Marabá Rural)
CALL sp_add_time('Marabá Rural Tênis de Mesa Masculino', 1, 12, 6, 'M',@id_time_m); -- id_time = 21
CALL sp_add_time('Marabá Rural Tênis de Mesa Feminino', 1, 12, 6, 'F',@id_time_f);  -- id_time = 22

-- Campus 14 (Paragominas)
CALL sp_add_time('Paragominas Tênis de Mesa Masculino', 1, 14, 6, 'M',@id_time_m); -- id_time = 23
CALL sp_add_time('Paragominas Tênis de Mesa Feminino', 1, 14, 6, 'F',@id_time_f);  -- id_time = 24

-- Campus 15 (Parauapebas)
CALL sp_add_time('Parauapebas Tênis de Mesa Masculino', 1, 15, 6, 'M',@id_time_m); -- id_time = 25
CALL sp_add_time('Parauapebas Tênis de Mesa Feminino', 1, 15, 6, 'F',@id_time_f);  -- id_time = 26

-- Campus 16 (Santarém)
CALL sp_add_time('Santarém Tênis de Mesa Masculino', 1, 16, 6, 'M',@id_time_m);    -- id_time = 27
CALL sp_add_time('Santarém Tênis de Mesa Feminino', 1, 16, 6, 'F',@id_time_f);     -- id_time = 28

-- Campus 17 (Tucuruí)
CALL sp_add_time('Tucuruí Tênis de Mesa Masculino', 1, 17, 6, 'M',@id_time_m);     -- id_time = 29
CALL sp_add_time('Tucuruí Tênis de Mesa Feminino', 1, 17, 6, 'F',@id_time_f);      -- id_time = 30

-- Campus 18 (Vigia)
CALL sp_add_time('Vigia Tênis de Mesa Masculino', 1, 18, 6, 'M',@id_time_m);       -- id_time = 31
CALL sp_add_time('Vigia Tênis de Mesa Feminino', 1, 18, 6, 'F',@id_time_f);        -- id_time = 32

-- Inserção de atletas (REMOVIDOS ABAETETUBA E ÓBIDOS)

-- Campus Altamira - Tênis de Mesa Masculino (id_time = 1)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Bruno Gomes', 'TM0202301', 'Educação Física', 1);

-- Campus Altamira - Tênis de Mesa Feminino (id_time = 2)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Larissa Melo', 'TF0202301', 'Educação Física', 2);

-- Campus Ananindeua - Tênis de Mesa Masculino (id_time = 3)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Victor Santos', 'TM0302301', 'Educação Física', 3);

-- Campus Ananindeua - Tênis de Mesa Feminino (id_time = 4)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Natália Ribeiro', 'TF0302301', 'Educação Física', 4);

-- Campus Belém - Tênis de Mesa Masculino (id_time = 5)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Leandro Silva', 'TM0402301', 'Educação Física', 5);

-- Campus Belém - Tênis de Mesa Feminino (id_time = 6)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Daniela Souza', 'TF0402301', 'Educação Física', 6);

-- Campus Bragança - Tênis de Mesa Masculino (id_time = 7)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Igor Gomes', 'TM0502301', 'Educação Física', 7);

-- Campus Bragança - Tênis de Mesa Feminino (id_time = 8)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Juliana Melo', 'TF0502301', 'Educação Física', 8);

-- Campus Breves - Tênis de Mesa Masculino (id_time = 9)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Marcos Santos', 'TM0602301', 'Educação Física', 9);

-- Campus Breves - Tênis de Mesa Feminino (id_time = 10)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Renata Ribeiro', 'TF0602301', 'Educação Física', 10);

-- Campus Cametá - Tênis de Mesa Masculino (id_time = 11)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('José Silva', 'TM0702301', 'Educação Física', 11);

-- Campus Cametá - Tênis de Mesa Feminino (id_time = 12)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Ana Souza', 'TF0702301', 'Educação Física', 12);

-- Campus Castanhal - Tênis de Mesa Masculino (id_time = 13)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Rafael Gomes', 'TM0802301', 'Educação Física', 13);

-- Campus Castanhal - Tênis de Mesa Feminino (id_time = 14)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Juliana Ribeiro', 'TF0802301', 'Educação Física', 14);

-- Campus Conceição do Araguaia - Tênis de Mesa Masculino (id_time = 15)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Eduardo Silva', 'TM0902301', 'Educação Física', 15);

-- Campus Conceição do Araguaia - Tênis de Mesa Feminino (id_time = 16)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Vanessa Souza', 'TF0902301', 'Educação Física', 16);

-- Campus Itaituba - Tênis de Mesa Masculino (id_time = 17)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Rodrigo Santos', 'TM1002301', 'Educação Física', 17);

-- Campus Itaituba - Tênis de Mesa Feminino (id_time = 18)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Juliana Ribeiro', 'TF1002301', 'Educação Física', 18);

-- Campus Marabá Industrial - Tênis de Mesa Masculino (id_time = 19)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Thiago Silva', 'TM1102301', 'Educação Física', 19);

-- Campus Marabá Industrial - Tênis de Mesa Feminino (id_time = 20)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Mariana Souza', 'TF1102301', 'Educação Física', 20);

-- Campus Marabá Rural - Tênis de Mesa Masculino (id_time = 21)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Matheus Gomes', 'TM1202301', 'Educação Física', 21);

-- Campus Marabá Rural - Tênis de Mesa Feminino (id_time = 22)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Larissa Melo', 'TF1202301', 'Educação Física', 22);

-- Campus Paragominas - Tênis de Mesa Masculino (id_time = 23)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Leandro Silva', 'TM1402301', 'Educação Física', 23);

-- Campus Paragominas - Tênis de Mesa Feminino (id_time = 24)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Daniela Souza', 'TF1402301', 'Educação Física', 24);

-- Campus Parauapebas - Tênis de Mesa Masculino (id_time = 25)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Igor Gomes', 'TM1502301', 'Educação Física', 25);

-- Campus Parauapebas - Tênis de Mesa Feminino (id_time = 26)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Juliana Melo', 'TF1502301', 'Educação Física', 26);

-- Campus Santarém - Tênis de Mesa Masculino (id_time = 27)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Marcos Santos', 'TM1602301', 'Educação Física', 27);

-- Campus Santarém - Tênis de Mesa Feminino (id_time = 28)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Renata Ribeiro', 'TF1602301', 'Educação Física', 28);

-- Campus Tucuruí - Tênis de Mesa Masculino (id_time = 29)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('José Silva', 'TM1702301', 'Educação Física', 29);

-- Campus Tucuruí - Tênis de Mesa Feminino (id_time = 30)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Ana Souza', 'TF1702301', 'Educação Física', 30);

-- Campus Vigia - Tênis de Mesa Masculino (id_time = 31)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Rafael Gomes', 'TM1802301', 'Educação Física', 31);

-- Campus Vigia - Tênis de Mesa Feminino (id_time = 32)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
('Juliana Ribeiro', 'TF1802301', 'Educação Física', 32);

-- Cadastro de Partidas para Tênis de Mesa nos Jogos IFPA 2026
-- Considerando:
-- - Duração de 1h por partida
-- - Primeira partida em 02/06/2026 às 8h
-- - 4 partidas pela manhã e 4 pela tarde
-- - Período de 02/06 a 05/06 (4 dias de jogos)
-- - Status inicial "sem_time_atribuido"

-- Partidas do dia 02/06/2026 (Manhã)
CALL sp_agendar_partida(1, 6, '2026-06-02 08:00:00', 1, 60, 'Ginásio Lado A - 1ª Partida Matutina');
CALL sp_agendar_partida(1, 6, '2026-06-02 08:00:00', 2, 60, 'Ginásio Lado B - 1ª Partida Matutina');
CALL sp_agendar_partida(1, 6, '2026-06-02 09:15:00', 1, 60, 'Ginásio Lado A - 2ª Partida Matutina');
CALL sp_agendar_partida(1, 6, '2026-06-02 09:15:00', 2, 60, 'Ginásio Lado B - 2ª Partida Matutina');

-- Partidas do dia 02/06/2026 (Tarde)
CALL sp_agendar_partida(1, 6, '2026-06-02 14:00:00', 1, 60, 'Ginásio Lado A - 1ª Partida Vespertina');
CALL sp_agendar_partida(1, 6, '2026-06-02 14:00:00', 2, 60, 'Ginásio Lado B - 1ª Partida Vespertina');
CALL sp_agendar_partida(1, 6, '2026-06-02 15:15:00', 1, 60, 'Ginásio Lado A - 2ª Partida Vespertina');
CALL sp_agendar_partida(1, 6, '2026-06-02 15:15:00', 2, 60, 'Ginásio Lado B - 2ª Partida Vespertina');

-- Partidas do dia 03/06/2026 (Manhã)
CALL sp_agendar_partida(1, 6, '2026-06-03 08:00:00', 1, 60, 'Ginásio Lado A - 1ª Partida Matutina');
CALL sp_agendar_partida(1, 6, '2026-06-03 08:00:00', 2, 60, 'Ginásio Lado B - 1ª Partida Matutina');
CALL sp_agendar_partida(1, 6, '2026-06-03 09:15:00', 1, 60, 'Ginásio Lado A - 2ª Partida Matutina');
CALL sp_agendar_partida(1, 6, '2026-06-03 09:15:00', 2, 60, 'Ginásio Lado B - 2ª Partida Matutina');

-- Partidas do dia 03/06/2026 (Tarde)
CALL sp_agendar_partida(1, 6, '2026-06-03 14:00:00', 1, 60, 'Ginásio Lado A - 1ª Partida Vespertina');
CALL sp_agendar_partida(1, 6, '2026-06-03 14:00:00', 2, 60, 'Ginásio Lado B - 1ª Partida Vespertina');
CALL sp_agendar_partida(1, 6, '2026-06-03 15:15:00', 1, 60, 'Ginásio Lado A - 2ª Partida Vespertina');
CALL sp_agendar_partida(1, 6, '2026-06-03 15:15:00', 2, 60, 'Ginásio Lado B - 2ª Partida Vespertina');

-- Partidas do dia 04/06/2026 (Manhã)
CALL sp_agendar_partida(1, 6, '2026-06-04 08:00:00', 1, 60, 'Ginásio Lado A - 1ª Partida Matutina');
CALL sp_agendar_partida(1, 6, '2026-06-04 08:00:00', 2, 60, 'Ginásio Lado B - 1ª Partida Matutina');
CALL sp_agendar_partida(1, 6, '2026-06-04 09:15:00', 1, 60, 'Ginásio Lado A - 2ª Partida Matutina');
CALL sp_agendar_partida(1, 6, '2026-06-04 09:15:00', 2, 60, 'Ginásio Lado B - 2ª Partida Matutina');

-- Partidas do dia 04/06/2026 (Tarde)
CALL sp_agendar_partida(1, 6, '2026-06-04 14:00:00', 1, 60, 'Ginásio Lado A - 1ª Partida Vespertina');
CALL sp_agendar_partida(1, 6, '2026-06-04 14:00:00', 2, 60, 'Ginásio Lado B - 1ª Partida Vespertina');
CALL sp_agendar_partida(1, 6, '2026-06-04 15:15:00', 1, 60, 'Ginásio Lado A - 2ª Partida Vespertina');
CALL sp_agendar_partida(1, 6, '2026-06-04 15:15:00', 2, 60, 'Ginásio Lado B - 2ª Partida Vespertina');

-- Partidas do dia 05/06/2026 (Manhã)
CALL sp_agendar_partida(1, 6, '2026-06-05 08:00:00', 1, 60, 'Ginásio Lado A - 1ª Partida Matutina');
CALL sp_agendar_partida(1, 6, '2026-06-05 08:00:00', 2, 60, 'Ginásio Lado B - 1ª Partida Matutina');
CALL sp_agendar_partida(1, 6, '2026-06-05 09:15:00', 1, 60, 'Ginásio Lado A - 2ª Partida Matutina');
CALL sp_agendar_partida(1, 6, '2026-06-05 09:15:00', 2, 60, 'Ginásio Lado B - 2ª Partida Matutina');

-- Partidas do dia 05/06/2026 (Tarde)
CALL sp_agendar_partida(1, 6, '2026-06-05 14:00:00', 1, 60, 'Ginásio Lado A - 1ª Partida Vespertina');
CALL sp_agendar_partida(1, 6, '2026-06-05 14:00:00', 2, 60, 'Ginásio Lado B - 1ª Partida Vespertina');
CALL sp_agendar_partida(1, 6, '2026-06-05 15:15:00', 1, 60, 'Ginásio Lado A - 2ª Partida Vespertina');
CALL sp_agendar_partida(1, 6, '2026-06-05 15:15:00', 2, 60, 'Ginásio Lado B - 2ª Partida Vespertina');

-- Atualizando as partidas com os times (masculinos e femininos separados)

-- Partidas Masculinas (16 times - 16 partidas)
UPDATE Partida SET id_time_a = 1, id_time_b = 3, status = 'agendada' WHERE id_partida = 1;  -- Altamira x Ananindeua
UPDATE Partida SET id_time_a = 5, id_time_b = 7, status = 'agendada' WHERE id_partida = 2;  -- Belém x Bragança
UPDATE Partida SET id_time_a = 9, id_time_b = 11, status = 'agendada' WHERE id_partida = 3;  -- Breves x Cametá
UPDATE Partida SET id_time_a = 13, id_time_b = 15, status = 'agendada' WHERE id_partida = 4; -- Castanhal x Conceição Araguaia
UPDATE Partida SET id_time_a = 17, id_time_b = 19, status = 'agendada' WHERE id_partida = 5; -- Itaituba x Marabá Industrial
UPDATE Partida SET id_time_a = 21, id_time_b = 23, status = 'agendada' WHERE id_partida = 6; -- Marabá Rural x Paragominas
UPDATE Partida SET id_time_a = 25, id_time_b = 27, status = 'agendada' WHERE id_partida = 7; -- Parauapebas x Santarém
UPDATE Partida SET id_time_a = 29, id_time_b = 31, status = 'agendada' WHERE id_partida = 8; -- Tucuruí x Vigia

-- Partidas Femininas (16 times - 16 partidas)
UPDATE Partida SET id_time_a = 2, id_time_b = 4, status = 'agendada' WHERE id_partida = 9;   -- Altamira x Ananindeua
UPDATE Partida SET id_time_a = 6, id_time_b = 8, status = 'agendada' WHERE id_partida = 10;  -- Belém x Bragança
UPDATE Partida SET id_time_a = 10, id_time_b = 12, status = 'agendada' WHERE id_partida = 11; -- Breves x Cametá
UPDATE Partida SET id_time_a = 14, id_time_b = 16, status = 'agendada' WHERE id_partida = 12; -- Castanhal x Conceição Araguaia
UPDATE Partida SET id_time_a = 18, id_time_b = 20, status = 'agendada' WHERE id_partida = 13; -- Itaituba x Marabá Industrial
UPDATE Partida SET id_time_a = 22, id_time_b = 24, status = 'agendada' WHERE id_partida = 14; -- Marabá Rural x Paragominas
UPDATE Partida SET id_time_a = 26, id_time_b = 28, status = 'agendada' WHERE id_partida = 15; -- Parauapebas x Santarém
UPDATE Partida SET id_time_a = 30, id_time_b = 32, status = 'agendada' WHERE id_partida = 16; -- Tucuruí x Vigia

-- As próximas partidas (17-32) serão para as fases seguintes e podem ficar sem times atribuídos por enquanto

