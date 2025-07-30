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

INSERT INTO Time (nome_time, id_edicao, id_campus, id_modalidade, sexo) VALUES
-- Campus 1 (Abaetetuba)
('Abaetetuba Futebol Masculino', 1, 1, 3, 'M'),
('Abaetetuba Futebol Feminino', 1, 1, 4, 'F'),

-- Campus 2 (Altamira)
('Altamira Futebol Masculino', 1, 2, 3, 'M'),
('Altamira Futebol Feminino', 1, 2, 4, 'F'),

-- Campus 3 (Ananindeua)
('Ananindeua Futebol Masculino', 1, 3, 3, 'M'),
('Ananindeua Futebol Feminino', 1, 3, 4, 'F'),

-- Campus 4 (Belém)
('Belém Futebol Masculino', 1, 4, 3, 'M'),
('Belém Futebol Feminino', 1, 4, 4, 'F'),

-- Campus 5 (Bragança)
('Bragança Futebol Masculino', 1, 5, 3, 'M'),
('Bragança Futebol Feminino', 1, 5, 4, 'F'),

-- Campus 6 (Breves)
('Breves Futebol Masculino', 1, 6, 3, 'M'),
('Breves Futebol Feminino', 1, 6, 4, 'F'),

-- Campus 7 (Cametá)
('Cametá Futebol Masculino', 1, 7, 3, 'M'),
('Cametá Futebol Feminino', 1, 7, 4, 'F'),

-- Campus 8 (Castanhal)
('Castanhal Futebol Masculino', 1, 8, 3, 'M'),
('Castanhal Futebol Feminino', 1, 8, 4, 'F'),

-- Campus 9 (Conceição do Araguaia)
('Conceição do Araguaia Futebol Masculino', 1, 9, 3, 'M'),
('Conceição do Araguaia Futebol Feminino', 1, 9, 4, 'F'),

-- Campus 10 (Itaituba)
('Itaituba Futebol Masculino', 1, 10, 3, 'M'),
('Itaituba Futebol Feminino', 1, 10, 4, 'F'),

-- Campus 11 (Marabá Industrial)
('Marabá Industrial Futebol Masculino', 1, 11, 3, 'M'),
('Marabá Industrial Futebol Feminino', 1, 11, 4, 'F'),

-- Campus 12 (Marabá Rural)
('Marabá Rural Futebol Masculino', 1, 12, 3, 'M'),
('Marabá Rural Futebol Feminino', 1, 12, 4, 'F'),

-- Campus 13 (Óbidos)
('Óbidos Futebol Masculino', 1, 13, 3, 'M'),
('Óbidos Futebol Feminino', 1, 13, 4, 'F'),

-- Campus 14 (Paragominas)
('Paragominas Futebol Masculino', 1, 14, 3, 'M'),
('Paragominas Futebol Feminino', 1, 14, 4, 'F'),

-- Campus 15 (Parauapebas)
('Parauapebas Futebol Masculino', 1, 15, 3, 'M'),
('Parauapebas Futebol Feminino', 1, 15, 4, 'F'),

-- Campus 16 (Santarém)
('Santarém Futebol Masculino', 1, 16, 3, 'M'),
('Santarém Futebol Feminino', 1, 16, 4, 'F'),

-- Campus 17 (Tucuruí)
('Tucuruí Futebol Masculino', 1, 17, 3, 'M'),
('Tucuruí Futebol Feminino', 1, 17, 4, 'F'),

-- Campus 18 (Vigia)
('Vigia Futebol Masculino', 1, 18, 3, 'M'),
('Vigia Futebol Feminino', 1, 18, 4, 'F');

-- Inserção de atletas

-- Campus Abaetetuba - Vôlei Masculino (id_time = 1)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Abaetetuba Masculino
('Lucas Silva', 'VM0102301', 'Educação Física', 1),
('Matheus Oliveira', 'VM0102302', 'Educação Física', 1),
('Gustavo Santos', 'VM0102303', 'Educação Física', 1),
('Pedro Almeida', 'VM0102304', 'Educação Física', 1),
('Rafael Costa', 'VM0102305', 'Educação Física', 1),
('Thiago Ferreira', 'VM0102306', 'Educação Física', 1);

-- Campus Abaetetuba - Vôlei Feminino (id_time = 2)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Abaetetuba Feminino
('Mariana Souza', 'VF0102301', 'Educação Física', 2),
('Fernanda Lima', 'VF0102302', 'Educação Física', 2),
('Camila Pereira', 'VF0102303', 'Educação Física', 2),
('Julia Rodrigues', 'VF0102304', 'Educação Física', 2),
('Isabela Martins', 'VF0102305', 'Educação Física', 2),
('Patrícia Dias', 'VF0102306', 'Educação Física', 2);

-- Campus Altamira - Vôlei Masculino (id_time = 3)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Altamira Masculino
('Bruno Gomes', 'VM0202301', 'Educação Física', 3),
('Leonardo Rocha', 'VM0202302', 'Educação Física', 3),
('Eduardo Cardoso', 'VM0202303', 'Educação Física', 3),
('Felipe Nascimento', 'VM0202304', 'Educação Física', 3),
('André Moreira', 'VM0202305', 'Educação Física', 3),
('Diego Cunha', 'VM0202306', 'Educação Física', 3);

-- Campus Altamira - Vôlei Feminino (id_time = 4)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Altamira Feminino
('Larissa Melo', 'VF0202301', 'Educação Física', 4),
('Aline Barros', 'VF0202302', 'Educação Física', 4),
('Bianca Castro', 'VF0202303', 'Educação Física', 4),
('Raquel Fernandes', 'VF0202304', 'Educação Física', 4),
('Sabrina Teixeira', 'VF0202305', 'Educação Física', 4),
('Carla Pinto', 'VF0202306', 'Educação Física', 4);

-- Campus Ananindeua - Vôlei Masculino (id_time = 5)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Ananindeua Masculino
('Victor Santos', 'VM0302301', 'Educação Física', 5),
('Daniel Lima', 'VM0302302', 'Educação Física', 5),
('Caio Alves', 'VM0302303', 'Educação Física', 5),
('Rômulo Pereira', 'VM0302304', 'Educação Física', 5),
('Henrique Moreira', 'VM0302305', 'Educação Física', 5),
('Júlio Ferreira', 'VM0302306', 'Educação Física', 5);

-- Campus Ananindeua - Vôlei Feminino (id_time = 6)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Ananindeua Feminino
('Natália Ribeiro', 'VF0302301', 'Educação Física', 6),
('Bruna Gomes', 'VF0302302', 'Educação Física', 6),
('Tatiane Souza', 'VF0302303', 'Educação Física', 6),
('Fernanda Lima', 'VF0302304', 'Educação Física', 6),
('Monica Alves', 'VF0302305', 'Educação Física', 6),
('Juliana Castro', 'VF0302306', 'Educação Física', 6);

-- Campus Belém - Vôlei Masculino (id_time = 7)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Belém Masculino
('Leandro Silva', 'VM0402301', 'Educação Física', 7),
('Marcos Oliveira', 'VM0402302', 'Educação Física', 7),
('Felipe Santos', 'VM0402303', 'Educação Física', 7),
('Ricardo Almeida', 'VM0402304', 'Educação Física', 7),
('Bruno Costa', 'VM0402305', 'Educação Física', 7),
('Rafael Ferreira', 'VM0402306', 'Educação Física', 7);

-- Campus Belém - Vôlei Feminino (id_time = 8)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Belém Feminino
('Daniela Souza', 'VF0402301', 'Educação Física', 8),
('Patrícia Lima', 'VF0402302', 'Educação Física', 8),
('Vanessa Pereira', 'VF0402303', 'Educação Física', 8),
('Simone Rodrigues', 'VF0402304', 'Educação Física', 8),
('Aline Martins', 'VF0402305', 'Educação Física', 8),
('Cristina Dias', 'VF0402306', 'Educação Física', 8);

-- Campus Bragança - Vôlei Masculino (id_time = 9)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Bragança Masculino
('Igor Gomes', 'VM0502301', 'Educação Física', 9),
('Guilherme Rocha', 'VM0502302', 'Educação Física', 9),
('Roberto Cardoso', 'VM0502303', 'Educação Física', 9),
('Adriano Nascimento', 'VM0502304', 'Educação Física', 9),
('Marcelo Moreira', 'VM0502305', 'Educação Física', 9),
('Paulo Cunha', 'VM0502306', 'Educação Física', 9);

-- Campus Bragança - Vôlei Feminino (id_time = 10)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Bragança Feminino
('Juliana Melo', 'VF0502301', 'Educação Física', 10),
('Marcia Barros', 'VF0502302', 'Educação Física', 10),
('Claudia Castro', 'VF0502303', 'Educação Física', 10),
('Eliane Fernandes', 'VF0502304', 'Educação Física', 10),
('Sonia Teixeira', 'VF0502305', 'Educação Física', 10),
('Livia Pinto', 'VF0502306', 'Educação Física', 10);

-- Campus Breves - Vôlei Masculino (id_time = 11)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Breves Masculino
('Marcos Santos', 'VM0602301', 'Educação Física', 11),
('Anderson Lima', 'VM0602302', 'Educação Física', 11),
('Renato Alves', 'VM0602303', 'Educação Física', 11),
('Fabio Pereira', 'VM0602304', 'Educação Física', 11),
('Carlos Moreira', 'VM0602305', 'Educação Física', 11),
('Vitor Ferreira', 'VM0602306', 'Educação Física', 11);

-- Campus Breves - Vôlei Feminino (id_time = 12)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Breves Feminino
('Renata Ribeiro', 'VF0602301', 'Educação Física', 12),
('Tatiane Gomes', 'VF0602302', 'Educação Física', 12),
('Adriana Souza', 'VF0602303', 'Educação Física', 12),
('Elaine Lima', 'VF0602304', 'Educação Física', 12),
('Luciana Alves', 'VF0602305', 'Educação Física', 12),
('Bianca Castro', 'VF0602306', 'Educação Física', 12);

-- Campus Cametá - Vôlei Masculino (id_time = 13)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Cametá Masculino
('José Silva', 'VM0702301', 'Educação Física', 13),
('João Oliveira', 'VM0702302', 'Educação Física', 13),
('Carlos Santos', 'VM0702303', 'Educação Física', 13),
('Paulo Almeida', 'VM0702304', 'Educação Física', 13),
('Felipe Costa', 'VM0702305', 'Educação Física', 13),
('Lucas Ferreira', 'VM0702306', 'Educação Física', 13);

-- Campus Cametá - Vôlei Feminino (id_time = 14)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Cametá Feminino
('Ana Souza', 'VF0702301', 'Educação Física', 14),
('Maria Lima', 'VF0702302', 'Educação Física', 14),
('Julia Pereira', 'VF0702303', 'Educação Física', 14),
('Fernanda Rodrigues', 'VF0702304', 'Educação Física', 14),
('Carla Martins', 'VF0702305', 'Educação Física', 14),
('Isabela Dias', 'VF0702306', 'Educação Física', 14);

-- Campus Castanhal - Vôlei Masculino (id_time = 15)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Castanhal Masculino
('Rafael Gomes', 'VM0802301', 'Educação Física', 15),
('Bruno Rocha', 'VM0802302', 'Educação Física', 15),
('Leonardo Cardoso', 'VM0802303', 'Educação Física', 15),
('Thiago Nascimento', 'VM0802304', 'Educação Física', 15),
('Daniel Moreira', 'VM0802305', 'Educação Física', 15),
('Victor Cunha', 'VM0802306', 'Educação Física', 15);

-- Campus Castanhal - Vôlei Feminino (id_time = 16)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Castanhal Feminino
('Juliana Ribeiro', 'VF0802301', 'Educação Física', 16),
('Patrícia Gomes', 'VF0802302', 'Educação Física', 16),
('Larissa Souza', 'VF0802303', 'Educação Física', 16),
('Bianca Lima', 'VF0802304', 'Educação Física', 16),
('Mariana Alves', 'VF0802305', 'Educação Física', 16),
('Fernanda Castro', 'VF0802306', 'Educação Física', 16);

-- Campus Conceição do Araguaia - Vôlei Masculino (id_time = 17)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Conceição do Araguaia Masculino
('Eduardo Silva', 'VM0902301', 'Educação Física', 17),
('Felipe Oliveira', 'VM0902302', 'Educação Física', 17),
('André Santos', 'VM0902303', 'Educação Física', 17),
('Carlos Almeida', 'VM0902304', 'Educação Física', 17),
('Renato Costa', 'VM0902305', 'Educação Física', 17),
('Marcelo Ferreira', 'VM0902306', 'Educação Física', 17);

-- Campus Conceição do Araguaia - Vôlei Feminino (id_time = 18)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Conceição do Araguaia Feminino
('Vanessa Souza', 'VF0902301', 'Educação Física', 18),
('Simone Lima', 'VF0902302', 'Educação Física', 18),
('Aline Pereira', 'VF0902303', 'Educação Física', 18),
('Sabrina Rodrigues', 'VF0902304', 'Educação Física', 18),
('Patrícia Martins', 'VF0902305', 'Educação Física', 18),
('Cristina Dias', 'VF0902306', 'Educação Física', 18);

-- Campus Itaituba - Vôlei Masculino (id_time = 19)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Itaituba Masculino
('Rodrigo Santos', 'VM1002301', 'Educação Física', 19),
('Marcelo Lima', 'VM1002302', 'Educação Física', 19),
('Paulo Alves', 'VM1002303', 'Educação Física', 19),
('Igor Pereira', 'VM1002304', 'Educação Física', 19),
('Vitor Moreira', 'VM1002305', 'Educação Física', 19),
('Leonardo Ferreira', 'VM1002306', 'Educação Física', 19);

-- Campus Itaituba - Vôlei Feminino (id_time = 20)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Itaituba Feminino
('Juliana Ribeiro', 'VF1002301', 'Educação Física', 20),
('Patrícia Gomes', 'VF1002302', 'Educação Física', 20),
('Larissa Souza', 'VF1002303', 'Educação Física', 20),
('Bianca Lima', 'VF1002304', 'Educação Física', 20),
('Mariana Alves', 'VF1002305', 'Educação Física', 20),
('Fernanda Castro', 'VF1002306', 'Educação Física', 20);

-- Campus Marabá Industrial - Vôlei Masculino (id_time = 21)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Marabá Industrial Masculino
('Thiago Silva', 'VM1102301', 'Educação Física', 21),
('Lucas Oliveira', 'VM1102302', 'Educação Física', 21),
('Daniel Santos', 'VM1102303', 'Educação Física', 21),
('Felipe Almeida', 'VM1102304', 'Educação Física', 21),
('Rafael Costa', 'VM1102305', 'Educação Física', 21),
('Pedro Ferreira', 'VM1102306', 'Educação Física', 21);

-- Campus Marabá Industrial - Vôlei Feminino (id_time = 22)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Marabá Industrial Feminino
('Mariana Souza', 'VF1102301', 'Educação Física', 22),
('Fernanda Lima', 'VF1102302', 'Educação Física', 22),
('Camila Pereira', 'VF1102303', 'Educação Física', 22),
('Julia Rodrigues', 'VF1102304', 'Educação Física', 22),
('Isabela Martins', 'VF1102305', 'Educação Física', 22),
('Patrícia Dias', 'VF1102306', 'Educação Física', 22);

-- Campus Marabá Rural - Vôlei Masculino (id_time = 23)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Marabá Rural Masculino
('Matheus Gomes', 'VM1202301', 'Educação Física', 23),
('Bruno Rocha', 'VM1202302', 'Educação Física', 23),
('Eduardo Cardoso', 'VM1202303', 'Educação Física', 23),
('Felipe Nascimento', 'VM1202304', 'Educação Física', 23),
('André Moreira', 'VM1202305', 'Educação Física', 23),
('Diego Cunha', 'VM1202306', 'Educação Física', 23);

-- Campus Marabá Rural - Vôlei Feminino (id_time = 24)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Marabá Rural Feminino
('Larissa Melo', 'VF1202301', 'Educação Física', 24),
('Aline Barros', 'VF1202302', 'Educação Física', 24),
('Bianca Castro', 'VF1202303', 'Educação Física', 24),
('Raquel Fernandes', 'VF1202304', 'Educação Física', 24),
('Sabrina Teixeira', 'VF1202305', 'Educação Física', 24),
('Carla Pinto', 'VF1202306', 'Educação Física', 24);

-- Campus Óbidos - Vôlei Masculino (id_time = 25)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Óbidos Masculino
('Victor Santos', 'VM1302301', 'Educação Física', 25),
('Daniel Lima', 'VM1302302', 'Educação Física', 25),
('Caio Alves', 'VM1302303', 'Educação Física', 25),
('Rômulo Pereira', 'VM1302304', 'Educação Física', 25),
('Henrique Moreira', 'VM1302305', 'Educação Física', 25),
('Júlio Ferreira', 'VM1302306', 'Educação Física', 25);

-- Campus Óbidos - Vôlei Feminino (id_time = 26)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Óbidos Feminino
('Natália Ribeiro', 'VF1302301', 'Educação Física', 26),
('Bruna Gomes', 'VF1302302', 'Educação Física', 26),
('Tatiane Souza', 'VF1302303', 'Educação Física', 26),
('Fernanda Lima', 'VF1302304', 'Educação Física', 26),
('Monica Alves', 'VF1302305', 'Educação Física', 26),
('Juliana Castro', 'VF1302306', 'Educação Física', 26);

-- Campus Paragominas - Vôlei Masculino (id_time = 27)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Paragominas Masculino
('Leandro Silva', 'VM1402301', 'Educação Física', 27),
('Marcos Oliveira', 'VM1402302', 'Educação Física', 27),
('Felipe Santos', 'VM1402303', 'Educação Física', 27),
('Ricardo Almeida', 'VM1402304', 'Educação Física', 27),
('Bruno Costa', 'VM1402305', 'Educação Física', 27),
('Rafael Ferreira', 'VM1402306', 'Educação Física', 27);

-- Campus Paragominas - Vôlei Feminino (id_time = 28)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Paragominas Feminino
('Daniela Souza', 'VF1402301', 'Educação Física', 28),
('Patrícia Lima', 'VF1402302', 'Educação Física', 28),
('Vanessa Pereira', 'VF1402303', 'Educação Física', 28),
('Simone Rodrigues', 'VF1402304', 'Educação Física', 28),
('Aline Martins', 'VF1402305', 'Educação Física', 28),
('Cristina Dias', 'VF1402306', 'Educação Física', 28);

-- Campus Parauapebas - Vôlei Masculino (id_time = 29)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Parauapebas Masculino
('Igor Gomes', 'VM1502301', 'Educação Física', 29),
('Guilherme Rocha', 'VM1502302', 'Educação Física', 29),
('Roberto Cardoso', 'VM1502303', 'Educação Física', 29),
('Adriano Nascimento', 'VM1502304', 'Educação Física', 29),
('Marcelo Moreira', 'VM1502305', 'Educação Física', 29),
('Paulo Cunha', 'VM1502306', 'Educação Física', 29);

-- Campus Parauapebas - Vôlei Feminino (id_time = 30)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Parauapebas Feminino
('Juliana Melo', 'VF1502301', 'Educação Física', 30),
('Marcia Barros', 'VF1502302', 'Educação Física', 30),
('Claudia Castro', 'VF1502303', 'Educação Física', 30),
('Eliane Fernandes', 'VF1502304', 'Educação Física', 30),
('Sonia Teixeira', 'VF1502305', 'Educação Física', 30),
('Livia Pinto', 'VF1502306', 'Educação Física', 30);

-- Campus Santarém - Vôlei Masculino (id_time = 31)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Santarém Masculino
('Marcos Santos', 'VM1602301', 'Educação Física', 31),
('Anderson Lima', 'VM1602302', 'Educação Física', 31),
('Renato Alves', 'VM1602303', 'Educação Física', 31),
('Fabio Pereira', 'VM1602304', 'Educação Física', 31),
('Carlos Moreira', 'VM1602305', 'Educação Física', 31),
('Vitor Ferreira', 'VM1602306', 'Educação Física', 31);

-- Campus Santarém - Vôlei Feminino (id_time = 32)
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
-- Santarém Feminino
('Renata Ribeiro', 'VF1602301', 'Educação Física', 32),
('Tatiane Gomes', 'VF1602302', 'Educação Física', 32),
('Adriana Souza', 'VF1602303', 'Educação Física', 32),
('Elaine Lima', 'VF1602304', 'Educação Física', 32),
('Luciana Alves', 'VF1602305', 'Educação Física', 32),
('Bianca Castro', 'VF1602306', 'Educação Física', 32);

