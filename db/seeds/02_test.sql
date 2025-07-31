INSERT INTO Edicao (nome_edicao, ano, data_inicio, data_fim) VALUES ('Jogos IFPA 2026', 2026, '2026-06-01', '2026-06-06');
INSERT INTO Campus (nome_campus, is_sede) VALUES
('Belém',TRUE),
('Abaetetuba', FALSE),
('Altamira', FALSE),
('Ananindeua', FALSE),
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

CALL sp_add_usuario('Belem', 'usuario.belem@ifpa.edu.br', 'senha123', 1,NULL,@n1);
CALL sp_add_usuario('Altamira', 'usuario.altamira@ifpa.edu.br', 'senha123', 2, NULL,@n1);
-- CALL sp_add_usuario('Abaetetuba', 'usuario.abaetetuba@ifpa.edu.br', 'senha123', 1, NULL,@n1);
CALL sp_add_usuario('Ananindeua', 'usuario.ananindeua@ifpa.edu.br', 'senha123', 3, NULL,@n1);
CALL sp_add_usuario('Braganca', 'usuario.braganca@ifpa.edu.br', 'senha123', 5,NULL,@n1);
CALL sp_add_usuario('Breves', 'usuario.breves@ifpa.edu.br', 'senha123', 6,NULL,@n1);
CALL sp_add_usuario('Cameta', 'usuario.cameta@ifpa.edu.br', 'senha123', 7, NULL,@n1);
CALL sp_add_usuario('Castanhal', 'usuario.castanhal@ifpa.edu.br', 'senha123', 8, NULL,@n1);
CALL sp_add_usuario('ConceicaoAraguaia', 'usuario.conceicaoaraguaia@ifpa.edu.br', 'senha123', 9,NULL,@n1);
CALL sp_add_usuario('Itaituba', 'usuario.itaituba@ifpa.edu.br', 'senha123', 10, NULL,@n1);
CALL sp_add_usuario('MarabaIndustrial', 'usuario.marabaindustrial@ifpa.edu.br', 'senha123', 11, NULL,@n1);
CALL sp_add_usuario('MarabaRural', 'usuario.marabarural@ifpa.edu.br', 'senha123', 12,NULL,@n1);
-- CALL sp_add_usuario('Obidos', 'usuario.obidos@ifpa.edu.br', 'senha123', 13, NULL);
CALL sp_add_usuario('Paragominas', 'usuario.paragominas@ifpa.edu.br', 'senha123', 14,NULL,@n1);
CALL sp_add_usuario('Parauapebas', 'usuario.parauapebas@ifpa.edu.br', 'senha123', 15, NULL,@n1);
CALL sp_add_usuario('Santarem', 'usuario.santarem@ifpa.edu.br', 'senha123', 16, NULL,@n1);
CALL sp_add_usuario('Tucurui', 'usuario.tucurui@ifpa.edu.br', 'senha123', 17,NULL,@n1);
CALL sp_add_usuario('Vigia', 'usuario.vigia@ifpa.edu.br', 'senha123', 18, NULL,@n1);