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

A modelagem foi feita pensando na escalabilidade e na clareza da lógica de pontuação. As principais entidades são:

- **Instituição**: representa os campi participantes.
- **Equipe**: grupo de alunos inscritos em uma modalidade.
- **Modalidade**: nome e tipo (individual ou coletiva) do esporte ou competição.
- **Partida**: confronto entre equipes ou participantes.
- **Pontuação**: resultado da partida convertido em pontos.

**Relacionamentos:**

- Cada **instituição** pode ter várias **equipes**.
- Cada **modalidade** pode ter várias **partidas**.
- Cada **partida** gera uma **pontuação** associada à equipe e à instituição.

> ⚠️ *[Inserir aqui um diagrama ER ou link para ele, se disponível.]*

---

## ⚙️ Lógicas de Pontuação (em construção)

Esta seção será atualizada conforme as regras específicas forem sendo implementadas, por exemplo:

- Critérios de desempate.
- Pontos extras por comportamento.
- Classificação por grupos ou chaves eliminatórias.

---

## 🚧 Status do Projeto

🟨 **Em desenvolvimento** – Modelagem concluída, lógicas sendo implementadas.

---

## 👥 Equipe

Projeto desenvolvido pelos alunos de **Análise e Desenvolvimento de Sistemas - IFPA 2024**, sob orientação de professores do curso.
