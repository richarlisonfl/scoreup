# Checklist: Análise do Schema SQL - ScoreUp

## 📌 Tabelas para Revisão

### **1. Edicao**

- [ ] Verificar se `ano` como `YEAR` é suficiente ou substituir por `INT`
- [ ] Definir se `data_inicio` e `data_fim` devem ser `NOT NULL`

### **2. Campus**

- [ ] Adicionar comentário explicando o critério de `is_sede`

### **3. Modalidade**

- [ ] Avaliar se valores padrão (`pontos_vitoria`, `pontos_empate`) são universais
- [ ] Sugerir campo `is_modalidade_equipe` (BOOLEAN)

### **4. Usuario**

- [ ] Revisar `is_responsavel DEFAULT TRUE` (regra de negócio)
- [ ] Alterar `senha` para `CHAR(60)` se usar bcrypt

### **5. Time** ⚠ **(Crítico)**

- [ ] Problema: UNIQUE KEY atual impede times do mesmo sexo/modalidade/edição
- [ ] Opção 1: Trocar para `UNIQUE(nome_time, id_edicao)`
- [ ] Opção 2: Adicionar sufixo (ex: "Time A", "Time B")
- [ ] Sugerir campo `is_inscricao_ativa` (BOOLEAN)

### **6. Atleta**

- [ ] Definir se `matricula` deve ser `UNIQUE`
- [ ] Sugerir campo `data_nascimento`

### **7. Local**

- [ ] Adicionar `capacidade_maxima` (INT)

### **8. Partida** ⚠

- [ ] Corrigir inconsistência: `sem_time_atribuido` (ENUM) vs `sem_time_atribuida` (comentário)
- [ ] Adicionar campo `fase` (como em `CronogramaPartidas`)?
- [ ] Criar regra para `id_time_a` e `id_time_b` quando status != 'sem_time_atribuido'

### **9. Resultado**

- [ ] Definir se `vencedor` pode ser NULL em empates
- [ ] Sugerir campo `motivo_cancelamento`

### **10. ClassificacaoModalidade / ClassificacaoGeral**

- [ ] Sugerir stored procedure para atualização automática

### **11. Noticia**

- [ ] Adicionar campo `imagem_capa` (VARCHAR)

### **12. CronogramaPartidas** ⚠ **(Redundância?)**

- [ ] Opção 1: Fundir com `Partida` (adicionar campos faltantes)
- [ ] Opção 2: Manter apenas para agendamento prévio (sem times)

## 🔧 Ações Gerais

- [ ] Padronizar termos (ex: `sem_time_atribuido` no singular)
- [ ] Adicionar índices em chaves estrangeiras
- [ ] Documentar regras de negócio (ex: empates sem vencedor)
- [ ] Incluir comentários nas tabelas (ex: `COMMENT 'Armazena...'`)

## 📝 Notas

- **Prioridade**: Tabelas `Time`, `Partida` e `CronogramaPartidas` exigem decisão imediata.
- **Sugestão**: Usar labels no GitHub para categorizar (ex: `bug`, `melhoria`, `dúvida`).
