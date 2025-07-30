# 🏆 ScoreUp

**ScoreUp** é um sistema de pontuação desenvolvido para os Jogos Internos dos Institutos Federais (JIFs) do IFPA. Criado pela turma de Análise e Desenvolvimento de Sistemas (ADS) de 2024, o projeto visa centralizar, organizar e automatizar a contagem e exibição de pontos por modalidades, equipes e instituições participantes.

## 📌 Objetivo

Facilitar o controle da pontuação durante os eventos dos JIFs, garantindo mais transparência, agilidade e confiabilidade nas informações divulgadas.

---

## 🧩 Etapas de Desenvolvimento

O desenvolvimento do **ScoreUp** segue uma estrutura modular e colaborativa, com foco em entregas iterativas e melhoria contínua. Abaixo, uma visão geral das etapas:

1. **Levantamento de Requisitos**
   - Entendimento das regras de pontuação dos JIFs.
   - Identificação dos usuários do sistema (organizadores, árbitros, público).
   - Coleta de dados essenciais para o funcionamento (modalidades, equipes, resultados etc.).

2. **Modelagem do Banco de Dados**
   - Definição das entidades e relacionamentos.
   - Normalização das tabelas para evitar redundâncias.
   - Preparação do script SQL de criação e inserção de dados fictícios para testes.

3. **Desenvolvimento Backend**
   - Definição das rotas e lógica de negócios.
   - Implementação da API para comunicação com o frontend.
   - Criação das regras de pontuação automática.

4. **Desenvolvimento Frontend**
   - Criação de telas para usuários e administradores.
   - Visualização de resultados e rankings.
   - Interface responsiva e acessível.

5. **Testes e Validação**
   - Testes unitários das funcionalidades.
   - Validação com usuários reais do evento.
   - Ajustes baseados no feedback.

6. **Deploy e Documentação**
   - Disponibilização do sistema online.
   - Elaboração de documentação técnica e manual do usuário.

---

## 🗃️ Modelagem Atual do Banco de Dados

 A modelagem do banco foi projetada para refletir fielmente a lógica competitiva dos jogos. As principais tabelas e seus propósitos são:

   - **Campus**: representa os campi participantes, indicando inclusive se são sede.
   - **Modalidade**: define os esportes e suas regras de pontuação.
   - **Usuário**: participantes com funções administrativas ou de registro de dados.
   - **Time**: equipes formadas pelos campi em determinada modalidade.
   - **Atleta**: integrantes dos times.
   - **Local**: locais dos jogos.
   - **Partida**: confrontos entre times, incluindo data, local e fase.
   - **Resultado**: placares e dados estatísticos registrados.
   - **Classificação das Modalidades**: ranking por modalidade com estatísticas completas.
   - **Classificação Geral**: somatório dos desempenhos dos campi em todas as modalidades.
   - **Notícia**: publicação de comunicados dentro do sistema.

   Também foram criadas **procedures** e **triggers** para garantir:
   - Atualização automática das classificações após cada resultado inserido.
   - Inicialização de rankings quando uma nova modalidade é cadastrada.

   > ⚠️ *A estrutura completa pode ser consultada no diretório `/sql` com os scripts de criação, procedures e triggers.*

---

## ⚙️ Lógicas de Pontuação (em construção)

O ScoreUp conta com uma trigger chamada `after_resultado_insert` que é acionada automaticamente após o registro de um resultado. Ela é responsável por:

- Identificar a modalidade e times envolvidos.
- Atualizar estatísticas na tabela `ClassificacaoModalidade`.
- Discriminar vitórias, empates e derrotas.
- Calcular saldo de pontos e sets.
- Chamar a procedure `AtualizarClassificacaoGeral` para atualizar o somatório do campus.

Adicionalmente, a procedure `InicializarClassificacaoModalidade` é utilizada para preparar os times de uma nova modalidade na tabela de classificação.

---

## 🚧 Status do Projeto

🟨 **Em desenvolvimento** – Modelagem concluída, backend e lógicas em andamento.

---

## 👥 Equipe

Projeto desenvolvido pelos alunos de **TADS - IFPA 2024 (G0791NC)**, sob orientação de professores Sebastião.

- Richarlison Lisboa
- Antonio Lucas
- David Matheus
- Gustavo Santos
- Amanda Anjos
- Keilane Soares

> ⚠️ **Observação importante:**  
> O sistema permite apenas um usuário administrador por vez, garantido por uma trigger no banco de dados. Todos os usuários cadastrados inicialmente possuem perfil de responsável, podendo gerenciar dados do seu campus.
