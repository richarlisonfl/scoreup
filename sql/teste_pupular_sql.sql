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
('Abaetetuba', 'usuario.abaetetuba@ifpa.edu.br', 'senha123', 1, FALSE, TRUE),
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
('Obidos', 'usuario.obidos@ifpa.edu.br', 'senha123', 13, FALSE, TRUE),
('Paragominas', 'usuario.paragominas@ifpa.edu.br', 'senha123', 14, FALSE, TRUE),
('Parauapebas', 'usuario.parauapebas@ifpa.edu.br', 'senha123', 15, FALSE, TRUE),
('Santarem', 'usuario.santarem@ifpa.edu.br', 'senha123', 16, FALSE, TRUE),
('Tucurui', 'usuario.tucurui@ifpa.edu.br', 'senha123', 17, FALSE, TRUE),
('Vigia', 'usuario.vigia@ifpa.edu.br', 'senha123', 18, FALSE, TRUE);