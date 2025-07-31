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

CALL sp_atualizar_sede_campus(14);
-- CALL sp_trocar_campus_sede(14); 

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
