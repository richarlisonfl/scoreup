# **Ordem Lógica de Preenchimento das Tabelas no Sistema ScoreUp**

Para implementar o sistema corretamente, é essencial seguir uma **sequência lógica de cadastros**, garantindo que os dados sejam inseridos na ordem certa, sem violar restrições de chave estrangeira. Abaixo está o passo a passo **real** que os usuários seguirão ao utilizar o sistema após sua implementação:

---

## 📌 **1. Cadastro Inicial (Administrador do Campus Sede)**

**Ação humana:** O **administrador principal** (geralmente um professor ou coordenador do campus sede) faz a configuração inicial.

### **Tabelas a serem preenchidas:**

1. **`Edicao`**  
   - Cadastrar a edição dos jogos (ano, nome, datas).
   - Exemplo:
     ```sql
     INSERT INTO Edicao (nome_edicao, ano, data_inicio, data_fim)
     VALUES ('Jogos IFPA 2025', 2025, '2025-06-01', '2025-06-06');
     ```

2. **`Campus`**  
   - Cadastrar todos os campi participantes, indicando qual é sede.
   - Exemplo:
     ```sql
     INSERT INTO Campus (nome_campus, is_sede) VALUES
     ('Abaetetuba', FALSE),
     ('Belém', TRUE),
     ('Santarém', FALSE),
     ...;
     ```
   - Para alterar o campus sede:
     ```sql
     CALL trocar_sede('Santarém');
     ```

3. **`Modalidade`**  
   - Definir todas as modalidades esportivas disponíveis nos JIFs.
   - Exemplo:
     ```sql
     INSERT INTO Modalidade (nome_modalidade, descricao, duracao_minutos, pontos_vitoria, pontos_empate) VALUES
     ('Futsal', 'Futsal masculino e feminino', 40, 3, 1),
     ('Voleibol', 'Voleibol de quadra', 60, 3, 1),
     ...;
     ```

4. **`Local`**  
   - Cadastrar ginásios, campos e espaços de competição, vinculando ao campus.
   - Exemplo:
     ```sql
     INSERT INTO Local (nome_local, descricao, capacidade, id_campus) VALUES
     ('Ginásio Poliesportivo', 'Quadra principal', 1000, 4),
     ('Campo de Futebol', 'Gramado oficial', 500, 4);
     ```

---

## 📌 **2. Cadastro de Usuários (Campus Sede)**

**Ação humana:** O administrador do campus sede cadastra os **responsáveis de cada campus**.

### **Tabela a ser preenchida:**

5. **`Usuario`**  
   - Criar logins para os responsáveis de cada campus (`is_responsavel = TRUE`).  
   - Apenas um usuário pode ser administrador (`is_admin = TRUE`), garantido por trigger.
   - Exemplo:
     ```sql
     INSERT INTO Usuario (nome_completo, email, senha, id_campus, is_admin, is_responsavel) VALUES
     ('Abaetetuba', 'usuario.abaetetuba@ifpa.edu.br', 'senha123', 1, FALSE, TRUE),
     ('Belém', 'usuario.belem@ifpa.edu.br', 'senha123', 4, FALSE, TRUE),
     ...;
     ```

---

## 📌 **3. Cadastro de Times (Campus Visitante)**

**Ação humana:** Os **responsáveis de cada campus** (usuários com `is_responsavel = TRUE`) cadastram seus times.

### **Tabelas a serem preenchidas:**

6. **`Time`**  
   - Cada campus cadastra seus times por modalidade e sexo.
   - Exemplo:
     ```sql
     INSERT INTO Time (nome_time, id_edicao, id_campus, id_modalidade, sexo) VALUES
     ('Tigres do IFPA Belém', 1, 4, 1, 'M');
     ```
   - Regra: Só pode haver 1 time por campus/modalidade/sexo por edição.

7. **`Atleta`**  
   - Adicionar os alunos-atletas de cada time.
   - Exemplo:
     ```sql
     INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES
     ('Carlos Oliveira', '20230001', 'ADS', 1),
     ('Ana Santos', '20230002', 'Engenharia', 1);
     ```

---

## 📌 **4. Agendamento de Partidas (Campus Sede)**

**Ação humana:** O administrador do campus sede agenda os jogos no sistema.

### **Tabela a ser preenchida:**

8. **`Partida`**  
   - Registrar data, hora, local e times participantes.
   - Exemplo:
     ```sql
     INSERT INTO Partida (id_edicao, id_modalidade, id_time_a, id_time_b, data_hora, id_local, fase) VALUES
     (1, 1, 1, 2, '2025-06-02 14:00:00', 1, 'grupo');
     ```

---

## 📌 **5. Lançamento de Resultados (Campus Sede)**

**Ação humana:** O administrador ou responsável autorizado insere os resultados das partidas.

### **Tabela a ser preenchida:**

9. **`Resultado`**  
   - Registrar placar, sets (se aplicável) e o vencedor.
   - Exemplo:
     ```sql
     INSERT INTO Resultado (id_partida, placar_casa, placar_visitante, sets_casa, sets_visitante, vencedor, observacoes, id_usuario_registro) VALUES
     (1, 2, 1, NULL, NULL, 1, 'Jogo equilibrado', 1);
     ```
   - ⚠️ O trigger `after_resultado_insert` atualiza automaticamente:
     - `ClassificacaoModalidade` (ranking por modalidade).
     - `ClassificacaoGeral` (ranking geral dos campi).

---

## 📌 **6. Publicação de Notícias (Opcional)**

**Ação humana:** O campus sede ou administradores publicam notícias sobre o evento.

### **Tabela a ser preenchida:**

10. **`Noticia`**  
    - Exemplo:
      ```sql
      INSERT INTO Noticia (titulo, conteudo, id_usuario_publicacao) VALUES
      ('Final de Futebol emocionante!', 'O time de Belém venceu por 2x1...', 1);
      ```

---

## 🔄 **Fluxo Contínuo de Uso**

1. **Campus visitante:**  
   - Cadastram times e atletas, visualizam cronograma e resultados.

2. **Campus sede:**  
   - Cadastra modalidades, locais, usuários, agenda partidas, insere resultados e publica notícias.

3. **Público geral:**  
   - Apenas visualiza resultados, classificações e notícias.

---

## 📊 **Resumo da Ordem de Operações**

| #  | Ação                           | Responsável          | Tabelas Envolvidas                  |
|----|--------------------------------|----------------------|-------------------------------------|
| 1  | Cadastrar edição               | Campus Sede          | `Edicao`                            |
| 2  | Cadastrar campi                | Campus Sede          | `Campus`                            |
| 3  | Cadastrar modalidades          | Campus Sede          | `Modalidade`                        |
| 4  | Cadastrar locais               | Campus Sede          | `Local`                             |
| 5  | Cadastrar usuários             | Campus Sede          | `Usuario`                           |
| 6  | Cadastrar times                | Campus Visitante     | `Time`, `Atleta`                    |
| 7  | Agendar partidas               | Campus Sede          | `Partida`                           |
| 8  | Inserir resultados             | Campus Sede          | `Resultado` (dispara atualizações)  |
| 9  | Publicar notícias (opcional)   | Campus Sede          | `Noticia`                           |

---

### **Observações Importantes:**

✅ **Restrições do sistema:**  
- Um campus só pode ter 1 time por modalidade/sexo/edição (`UNIQUE(id_edicao, id_campus, id_modalidade, sexo)`).
- Apenas o campus sede pode agendar partidas e lançar resultados.
- Apenas um usuário pode ser administrador por vez, garantido por trigger no banco de dados.
- Todos os usuários cadastrados inicialmente possuem perfil de responsável (`is_responsavel = TRUE`).

✅ **Automatizações:**  
- A classificação é calculada automaticamente ao inserir resultados.
- O público geral não precisa de login para ver dados.

---
