-- EDICÇÃO DOS JOGOS 2025 (6 dias de jogos - abertura mais 5 dias de jogos)
INSERT INTO Edicao (nome_edicao, ano, data_inicio, data_fim)
VALUES ('Jogos IFPA 2025', 2025, '2025-06-01', '2025-06-06');

-- INSERIR TODOS OS 18 CAMPUS
INSERT INTO Campus (nome_campus, is_sede) VALUES
('Abaetetuba', FALSE),
('Altamira', FALSE),
('Ananindeua', FALSE),
('Belém', TRUE),		-- por padrão belem é sede ao iniciar
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

-- ALTERANDO A SEDE PARA SANTARÉM
CALL trocar_sede('Santarém');

-- INSERIR MODALIDADES
INSERT INTO Modalidade (nome_modalidade, descricao, duracao_minutos, pontos_vitoria, pontos_empate) VALUES
('Futsal', 'Futsal masculino e feminino', 40, 3, 1),
('Voleibol', 'Voleibol de quadra', 60, 3, 1),
('Basquete', 'Basquete tradicional', 40, 3, 1),
('Handebol', 'Handebol de quadra', 60, 3, 1),
('Atletismo', 'Provas de pista e campo', 0, 3, 1),
('Tênis de Mesa', 'Individual e duplas', 30, 3, 1),
('Xadrez', 'Competição individual', 60, 3, 1),
('Judô', 'Lutas individuais', 10, 3, 1),
('Natação', 'Provas individuais e revezamento', 0, 3, 1),
('Vôlei de Praia', 'Duplas masculinas e femininas', 30, 3, 1);

INSERT INTO Usuario (nome_completo, email, senha, id_campus, is_admin, is_responsavel) VALUES
-- ('Abaetetuba', 'usuario.abaetetuba@ifpa.edu.br', 'senha123', 1, FALSE, TRUE),
('Altamira', 'usuario.altamira@ifpa.edu.br', 'senha123', 2, FALSE, TRUE),
('Ananindeua', 'usuario.ananindeua@ifpa.edu.br', 'senha123', 3, FALSE, TRUE),
('Belem', 'usuario.belem@ifpa.edu.br', 'senha123', 4, FALSE, TRUE),
('Braganca', 'usuario.braganca@ifpa.edu.br', 'senha123', 5, FALSE, TRUE),
('Breves', 'usuario.breves@ifpa.edu.br', 'senha123', 6, FALSE, TRUE),
('Cameta', 'usuario.cameta@ifpa.edu.br', 'senha123', 7, FALSE, TRUE),
('Castanhal', 'usuario.castanhal@ifpa.edu.br', 'senha123', 8, FALSE, TRUE),
('ConceicaoAraguaia', 'usuario.conceicaoaraguaia@ifpa.edu.br', 'senha123', 9, FALSE, TRUE),
('Itaituba', 'usuario.itaituba@ifpa.edu.br', 'senha123', 10, FALSE, TRUE),
('MarabaIndustrial', 'usuario.marabaindustrial@ifpa.edu.br', 'senha123', 11, FALSE, TRUE),
('MarabaRural', 'usuario.marabarural@ifpa.edu.br', 'senha123', 12, FALSE, TRUE),
-- ('Obidos', 'usuario.obidos@ifpa.edu.br', 'senha123', 13, FALSE, TRUE),
('Paragominas', 'usuario.paragominas@ifpa.edu.br', 'senha123', 14, FALSE, TRUE),
('Parauapebas', 'usuario.parauapebas@ifpa.edu.br', 'senha123', 15, FALSE, TRUE),
('Santarem', 'usuario.santarem@ifpa.edu.br', 'senha123', 16, FALSE, TRUE),
('Tucurui', 'usuario.tucurui@ifpa.edu.br', 'senha123', 17, FALSE, TRUE),
('Vigia', 'usuario.vigia@ifpa.edu.br', 'senha123', 18, FALSE, TRUE);

-- TIMES ALTERADOS PARA TÊNIS DE MESA (id_modalidade = 6) - REMOVIDOS ABAETETUBA E ÓBIDOS
INSERT INTO Time (nome_time, id_edicao, id_campus, id_modalidade, sexo) VALUES
-- Campus 2 (Altamira)
('Altamira Tênis de Mesa Masculino', 1, 2, 6, 'M'),  -- id_time = 1
('Altamira Tênis de Mesa Feminino', 1, 2, 6, 'F'),   -- id_time = 2

-- Campus 3 (Ananindeua)
('Ananindeua Tênis de Mesa Masculino', 1, 3, 6, 'M'), -- id_time = 3
('Ananindeua Tênis de Mesa Feminino', 1, 3, 6, 'F'),  -- id_time = 4

-- Campus 4 (Belém)
('Belém Tênis de Mesa Masculino', 1, 4, 6, 'M'),      -- id_time = 5
('Belém Tênis de Mesa Feminino', 1, 4, 6, 'F'),       -- id_time = 6

-- Campus 5 (Bragança)
('Bragança Tênis de Mesa Masculino', 1, 5, 6, 'M'),   -- id_time = 7
('Bragança Tênis de Mesa Feminino', 1, 5, 6, 'F'),    -- id_time = 8

-- Campus 6 (Breves)
('Breves Tênis de Mesa Masculino', 1, 6, 6, 'M'),     -- id_time = 9
('Breves Tênis de Mesa Feminino', 1, 6, 6, 'F'),      -- id_time = 10

-- Campus 7 (Cametá)
('Cametá Tênis de Mesa Masculino', 1, 7, 6, 'M'),     -- id_time = 11
('Cametá Tênis de Mesa Feminino', 1, 7, 6, 'F'),      -- id_time = 12

-- Campus 8 (Castanhal)
('Castanhal Tênis de Mesa Masculino', 1, 8, 6, 'M'),  -- id_time = 13
('Castanhal Tênis de Mesa Feminino', 1, 8, 6, 'F'),   -- id_time = 14

-- Campus 9 (Conceição do Araguaia)
('Conceição do Araguaia Tênis de Mesa Masculino', 1, 9, 6, 'M'), -- id_time = 15
('Conceição do Araguaia Tênis de Mesa Feminino', 1, 9, 6, 'F'),  -- id_time = 16

-- Campus 10 (Itaituba)
('Itaituba Tênis de Mesa Masculino', 1, 10, 6, 'M'),  -- id_time = 17
('Itaituba Tênis de Mesa Feminino', 1, 10, 6, 'F'),   -- id_time = 18

-- Campus 11 (Marabá Industrial)
('Marabá Industrial Tênis de Mesa Masculino', 1, 11, 6, 'M'), -- id_time = 19
('Marabá Industrial Tênis de Mesa Feminino', 1, 11, 6, 'F'),  -- id_time = 20

-- Campus 12 (Marabá Rural)
('Marabá Rural Tênis de Mesa Masculino', 1, 12, 6, 'M'), -- id_time = 21
('Marabá Rural Tênis de Mesa Feminino', 1, 12, 6, 'F'),  -- id_time = 22

-- Campus 14 (Paragominas)
('Paragominas Tênis de Mesa Masculino', 1, 14, 6, 'M'), -- id_time = 23
('Paragominas Tênis de Mesa Feminino', 1, 14, 6, 'F'),  -- id_time = 24

-- Campus 15 (Parauapebas)
('Parauapebas Tênis de Mesa Masculino', 1, 15, 6, 'M'), -- id_time = 25
('Parauapebas Tênis de Mesa Feminino', 1, 15, 6, 'F'),  -- id_time = 26

-- Campus 16 (Santarém)
('Santarém Tênis de Mesa Masculino', 1, 16, 6, 'M'),    -- id_time = 27
('Santarém Tênis de Mesa Feminino', 1, 16, 6, 'F'),     -- id_time = 28

-- Campus 17 (Tucuruí)
('Tucuruí Tênis de Mesa Masculino', 1, 17, 6, 'M'),     -- id_time = 29
('Tucuruí Tênis de Mesa Feminino', 1, 17, 6, 'F'),      -- id_time = 30

-- Campus 18 (Vigia)
('Vigia Tênis de Mesa Masculino', 1, 18, 6, 'M'),       -- id_time = 31
('Vigia Tênis de Mesa Feminino', 1, 18, 6, 'F');        -- id_time = 32

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