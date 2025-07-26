# Testes SQL
obs.: lembre-se de deletar os registros criados apos os testes.

## Popular o Banco com Dados de Teste
```sql
-- Inserir campus
INSERT INTO Campus (nome_campus, is_sede) VALUES 
('Campus Central', TRUE),
('Campus Norte', FALSE),
('Campus Leste', FALSE);

-- Inserir modalidades
INSERT INTO Modalidade (nome_modalidade, pontos_vitoria, pontos_empate, max_sets, sets_para_vencer, descricao) VALUES 
('Futsal Masculino', 3, 1, NULL, NULL, 'Futsal para times masculinos'),
('Vôlei Feminino', 3, 0, 3, 2, 'Melhor de 3 sets');

-- Inserir usuários
INSERT INTO Usuario (nome_completo, email, senha, id_campus, is_admin, is_responsavel) VALUES 
('Admin Principal', 'admin@email.com', SHA2('senha123', 256), 1, TRUE, TRUE),
('Responsável Campus Norte', 'responsavel.norte@email.com', SHA2('senha456', 256), 2, FALSE, TRUE);

-- Inserir times
INSERT INTO Time (nome_time, id_campus, id_modalidade, sexo) VALUES 
('Leões do Central', 1, 1, 'M'),
('Tigres do Norte', 2, 1, 'M'),
('Águias do Leste', 3, 2, 'F');

-- Inserir atletas
INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES 
('João Silva', '2023001', 'Engenharia', 1),
('Carlos Oliveira', '2023002', 'Administração', 1),
('Maria Souza', '2023003', 'Direito', 3);

-- Inserir locais
INSERT INTO Local (nome_local, descricao, capacidade, id_campus) VALUES 
('Ginásio Principal', 'Ginásio coberto com arquibancada', 500, 1),
('Quadra Externa', 'Quadra de areia para vôlei', 200, 3);

-- Inicializar classificações
CALL InicializarClassificacaoModalidade(1);
CALL InicializarClassificacaoModalidade(2);

```
## Testar as Funcionalidades

### Testar a trigger de resultados:

```sql
-- Agendar partida
INSERT INTO Partida (id_modalidade, id_time_casa, id_time_visitante, data_hora, id_local, fase, status)
VALUES (1, 1, 2, NOW() + INTERVAL 1 DAY, 1, 'Grupo A', 'agendada');

-- Registrar resultado (disparará a trigger)
INSERT INTO Resultado (id_partida, placar_casa, placar_visitante, sets_casa, sets_visitante, vencedor, id_usuario_registro)
VALUES (1, 2, 1, NULL, NULL, 1, 1);

-- Verificar classificações
SELECT * FROM ClassificacaoModalidade;
SELECT * FROM ClassificacaoGeral;
```

### Criar Views Úteis (Opcional)
```sql
-- View para partidas agendadas
CREATE VIEW PartidasAgendadas AS
SELECT p.id_partida, m.nome_modalidade, 
       tc.nome_time AS time_casa, tv.nome_time AS time_visitante,
       p.data_hora, l.nome_local AS local
FROM Partida p
JOIN Modalidade m ON p.id_modalidade = m.id_modalidade
JOIN Time tc ON p.id_time_casa = tc.id_time
JOIN Time tv ON p.id_time_visitante = tv.id_time
LEFT JOIN Local l ON p.id_local = l.id_local
WHERE p.status = 'agendada';

-- View para classificação por modalidade
CREATE VIEW ClassificacaoPorModalidade AS
SELECT m.nome_modalidade, t.nome_time, c.nome_campus,
       cm.pontos, cm.jogos, cm.vitorias, cm.empates, cm.derrotas,
       cm.sets_pro, cm.sets_contra, cm.saldo_sets,
       cm.pontos_pro, cm.pontos_contra, cm.saldo_pontos
FROM ClassificacaoModalidade cm
JOIN Modalidade m ON cm.id_modalidade = m.id_modalidade
JOIN Time t ON cm.id_time = t.id_time
JOIN Campus c ON t.id_campus = c.id_campus
ORDER BY m.nome_modalidade, cm.pontos DESC, cm.saldo_sets DESC, cm.saldo_pontos DESC;
```
### Criar Usuário com Permissões Limitadas (Para Aplicação)

```sql
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'senha_aplicacao';
GRANT SELECT, INSERT, UPDATE ON seu_banco.* TO 'app_user'@'localhost';
FLUSH PRIVILEGES;
```


# SQL para Remover Todas as Alterações

Para deletar completamente todas as estruturas e dados criados pelos scripts anteriores, você pode executar o seguinte conjunto de comandos SQL:

## TRUNCATE das Tabelas (mantém a estrutura, remove apenas os dados)
```sql
-- Desativar verificações de FK temporariamente
SET FOREIGN_KEY_CHECKS = 0;

-- Limpar dados das tabelas
TRUNCATE TABLE Noticia;
TRUNCATE TABLE ClassificacaoGeral;
TRUNCATE TABLE ClassificacaoModalidade;
TRUNCATE TABLE Resultado;
TRUNCATE TABLE Partida;
TRUNCATE TABLE Local;
TRUNCATE TABLE Atleta;
TRUNCATE TABLE Time;
TRUNCATE TABLE Usuario;
TRUNCATE TABLE Modalidade;
TRUNCATE TABLE Campus;

-- Reativar verificações de FK
SET FOREIGN_KEY_CHECKS = 1;
```
## DROP de Todas as Tabelas e Objetos Individualmente (mais controlado)

```sql
-- Desativar verificações de FK temporariamente
SET FOREIGN_KEY_CHECKS = 0;

-- Remover triggers
DROP TRIGGER IF EXISTS after_resultado_insert;

-- Remover procedures
DROP PROCEDURE IF EXISTS AtualizarClassificacaoGeral;
DROP PROCEDURE IF EXISTS InicializarClassificacaoModalidade;

-- Remover views (se existirem)
DROP VIEW IF EXISTS PartidasAgendadas;
DROP VIEW IF EXISTS ClassificacaoPorModalidade;

-- Remover tabelas na ordem inversa de dependência
DROP TABLE IF EXISTS Noticia;
DROP TABLE IF EXISTS ClassificacaoGeral;
DROP TABLE IF EXISTS ClassificacaoModalidade;
DROP TABLE IF EXISTS Resultado;
DROP TABLE IF EXISTS Partida;
DROP TABLE IF EXISTS Local;
DROP TABLE IF EXISTS Atleta;
DROP TABLE IF EXISTS Time;
DROP TABLE IF EXISTS Usuario;
DROP TABLE IF EXISTS Modalidade;
DROP TABLE IF EXISTS Campus;

-- Reativar verificações de FK
SET FOREIGN_KEY_CHECKS = 1;
```
## DROP DATABASE (mais radical - remove todo o banco)
```sql
DROP DATABASE IF EXISTS nome_do_seu_banco;
CREATE DATABASE nome_do_seu_banco;
```
