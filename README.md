# 🎥 Sistema de Locadora de DVDs - Banco de Dados

## 🗂️ Descrição do Projeto
Este repositório contém a implementação de um esquema de banco de dados para uma locadora de DVDs, abrangendo todas as operações essenciais para administrar:
- 👥 Clientes
- 🎞️ Filmes e Categorias
- 💿 DVDs e Status
- 📋 Locações e Reservas

Também inclui funções e procedimentos PL/pgSQL para realizar operações específicas.

---

## ⚡️ Estrutura do Banco
### 📋 Tabelas
- `cliente`
- `categoria`
- `filme`
- `status`
- `dvd`
- `locacao`
- `reserva`

### 🔑 Constraints
- PK (chave primária) para todas as tabelas.
- FK (chave estrangeira) para representar relações e garantir integridade.
- Constraints de unicidade para atributos críticos (ex.: CPF).

---

## ⚙️ Funções e Procedimentos
### 1️⃣ `list_num_par(a INT)`  
Exibe todos os números de `0` até `a-1`, informando se são pares ou ímpares.

### 2️⃣ `list_tabuada(num INT)`  
Exibe a tabuada de `0` a `10` para o número especificado.

### 3️⃣ `list_fatorial(num INT)`  
Exibe o fatorial de `num`.

### 4️⃣ `del_cliente(cod INT)`  
Exclui o cliente especificado e retorna `TRUE` ou `FALSE` para indicar sucesso.

### 5️⃣ `inserir_cliente(...)`  
Insere um novo cliente e retorna seu `codcliente`.

### 6️⃣ `insere_cliente(...)`  
Insere um cliente e retorna `TRUE` ou `FALSE`. Dispara exceção se o CPF estiver registrado.

### 7️⃣ `list_categoria(f_nome_categoria VARCHAR)`  
Exibe quantos filmes e DVDs existem para a categoria especificada.

### 8️⃣ `filme_mais_locado()`  
Retorna o nome do filme mais locado.

### 9️⃣ `qtd_dvds_cliente(f_nome_cliente VARCHAR)`  
Exibe quantos DVDs foram locados por um cliente específico.

### 🔟 `inserir_locacao(f_nome_filme VARCHAR, f_nome_cliente VARCHAR)`  
Insere uma locação e retorna `TRUE` (sucesso) ou `FALSE` (nenhum DVD disponível).

### 1️⃣1️⃣ `inserir_locacao_ex(f_nome_filme VARCHAR, f_nome_cliente VARCHAR)`  
Versão de `inserir_locacao` com exceções específicas para indicar erros.

### 1️⃣2️⃣ `atualiza_status_dvds()`  
Procedimento para atualizar status de DVDs com reserva vencida para `disponível`.

---

## 🥇 Exemplo de Dados
Contém comandos de `INSERT` para:
- Preencher `status`, `categoria`, `filme`, `dvd` e `cliente`.
- Criar registros para `locacao` e `reserva`.

---

## 🛠️ Como Executar
1. Copie e cole o arquivo `.sql` no seu editor de SQL (ex.: **pgAdmin**, **DBeaver**).
2. Execute todas as instruções para:
   - Criar as tabelas.
   - Inserir dados iniciais.
   - Criar funções e procedimentos.

---

## 👥 Autor
Feito por **Eric Fritzen Valle** para prática e desenvolvimento em PL/pgSQL.

---
