# **Ordem Lógica de Preenchimento das Tabelas no Sistema ScoreUp**

Para implementar o sistema corretamente, é essencial seguir uma **sequência lógica de cadastros**, garantindo que os dados sejam inseridos na ordem certa, sem violar restrições de chave estrangeira. Abaixo está o passo a passo **real** que os usuários seguirão ao utilizar o sistema após sua implementação:

---

## 📌 **1. Cadastro Inicial (Administrador do Campus Sede)**

**Ação humana:** O **administrador principal** (geralmente um professor ou coordenador do campus sede) faz a configuração inicial.

### **Tabelas a serem preenchidas:**

1. **`Campus`**  
   - Cadastrar todos os campi participantes (incluindo o campus sede).  
   - Exemplo:  

     ```sql
     INSERT INTO Campus (nome_campus, is_sede) VALUES 
     ('Paragominas', TRUE),
     ('Belém', FALSE),
     ('Castanhal', FALSE);
     ```

2. **`Modalidade`**  
   - Definir todas as modalidades esportivas disponíveis nos JIFs.  
   - Exemplo:

     ```sql
     INSERT INTO Modalidade (nome_modalidade, pontos_vitoria, max_sets, sets_para_vencer) VALUES 
     ('Futebol Masculino', 3, NULL, NULL),
     ('Vôlei Feminino', 3, 3, 2),
     ('Basquete Misto', 2, NULL, NULL);
     ```

3. **`Local`** (opcional, se houver locais específicos)  
   - Cadastrar ginásios, campos e espaços de competição.  
   - Exemplo:  

     ```sql
     INSERT INTO Local (nome_local, id_campus) VALUES 
     ('Ginásio Poliesportivo', 1),
     ('Campo de Futebol', 1);
     ```

---

## 📌 **2. Cadastro de Usuários (Campus Sede)**

**Ação humana:** O administrador do campus sede cadastra os **responsáveis de cada campus visitante**.

### **Tabela a ser preenchida:**

4. **`Usuario`**  
   - Criar logins para os responsáveis de cada campus (com `is_responsavel = TRUE`).  
   - Exemplo:  

     ```sql
     INSERT INTO Usuario (nome_completo, email, senha, id_campus, is_responsavel) VALUES 
     ('João Silva', 'joao.silva@ifpa.edu.br', 'senha123', 2, TRUE),
     ('Maria Souza', 'maria.souza@ifpa.edu.br', 'senha456', 3, TRUE);
     ```

---

## 📌 **3. Cadastro de Times (Campus Visitante)**

**Ação humana:** Os **responsáveis de cada campus** (usuários com `is_responsavel = TRUE`) cadastram seus times.

### **Tabelas a serem preenchidas:**

5. **`Time`**  
   - Cada campus cadastra seus times por modalidade.  
   - Exemplo (time de futebol masculino do Campus Belém):  

     ```sql
     INSERT INTO Time (nome_time, id_campus, id_modalidade, sexo) VALUES 
     ('Tigres do IFPA Belém', 2, 1, 'M');
     ```

6. **`Atleta`** (opcional, se for necessário registrar jogadores)  
   - Adicionar os alunos-atletas de cada time.  
   - Exemplo:  

     ```sql
     INSERT INTO Atleta (nome_atleta, matricula, curso, id_time) VALUES 
     ('Carlos Oliveira', '20230001', 'ADS', 1),
     ('Ana Santos', '20230002', 'Engenharia', 1);
     ```

---

## 📌 **4. Agendamento de Partidas (Campus Sede)**

**Ação humana:** O administrador do campus sede **define os jogos** no sistema.

### **Tabela a ser preenchida:**

7. **`Partida`**  
   - Registrar data, hora, local e times participantes.  
   - Exemplo (jogo de futebol entre Belém e Castanhal):  

     ```sql
     INSERT INTO Partida (id_modalidade, id_time_casa, id_time_visitante, data_hora, id_local, fase) VALUES 
     (1, 1, 2, '2025-10-15 14:00:00', 2, 'Fase de Grupos');
     ```

---

## 📌 **5. Lançamento de Resultados (Campus Sede)**

**Ação humana:** O administrador ou um responsável autorizado **insere os resultados** das partidas.

### **Tabela a ser preenchida:**

8. **`Resultado`**  
   - Registrar placar, sets (se aplicável) e o vencedor.  
   - Exemplo (vitória do time da casa 2x1):  

     ```sql
     INSERT INTO Resultado (id_partida, placar_casa, placar_visitante, vencedor, id_usuario_registro) VALUES 
     (1, 2, 1, 1, 1);  -- Time da casa (id_time=1) venceu
     ```

   - ⚠️ **O trigger `after_resultado_insert` atualiza automaticamente:**  
     - `ClassificacaoModalidade` (tabela por modalidade).  
     - `ClassificacaoGeral` (ranking geral dos campi).  

---

## 📌 **6. Publicação de Notícias (Opcional)**

**Ação humana:** O campus sede ou administradores **publicam notícias** sobre o evento.

### **Tabela a ser preenchida:**

9. **`Noticia`**  
   - Exemplo:  

     ```sql
     INSERT INTO Noticia (titulo, conteudo, id_usuario_publicacao) VALUES 
     ('Final de Futebol emocionante!', 'O time de Belém venceu por 2x1...', 1);
     ```

---

## 🔄 **Fluxo Contínuo de Uso**

1. **Campus visitante:**  
   - Apenas **cadastram times** e **visualizam o cronograma**.  

2. **Campus sede:**  
   - **Cadastra modalidades, locais e usuários.**  
   - **Agenda partidas.**  
   - **Insere resultados.**  
   - **Publica notícias.**  

3. **Público geral:**  
   - **Apenas visualiza** resultados, classificações e notícias.  

---

## 📊 **Resumo da Ordem de Operações**

| #  | Ação                           | Responsável          | Tabelas Envolvidas                  |
|----|--------------------------------|----------------------|-------------------------------------|
| 1  | Cadastrar campi                | Campus Sede          | `Campus`                            |
| 2  | Cadastrar modalidades          | Campus Sede          | `Modalidade`                        |
| 3  | Cadastrar locais (opcional)    | Campus Sede          | `Local`                             |
| 4  | Cadastrar responsáveis         | Campus Sede          | `Usuario`                           |
| 5  | Cadastrar times                | Campus Visitante     | `Time`, `Atleta` (opcional)         |
| 6  | Agendar partidas               | Campus Sede          | `Partida`                           |
| 7  | Inserir resultados             | Campus Sede          | `Resultado` (dispara atualizações)  |
| 8  | Publicar notícias (opcional)   | Campus Sede          | `Noticia`                           |

---

### **Observações Importantes:**

✅ **Restrições do sistema:**  

- Um campus **só pode ter 1 time por modalidade/sexo** (regra `UNIQUE(id_campus, id_modalidade, sexo)`).  
- **Apenas o campus sede** pode agendar partidas e lançar resultados.  

✅ **Automatizações:**  

- A **classificação** é calculada automaticamente ao inserir resultados.  
- O **público geral** não precisa de login para ver dados.
