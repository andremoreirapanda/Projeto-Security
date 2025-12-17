# 🔌 Documentação da API Backend

## Visão Geral

O backend da SecurityTraining Platform fornece endpoints REST em PHP/MySQL para:
- Autenticação de usuários
- Gerenciamento de progresso
- Armazenamento de avaliações
- Geração de certificados
- Carregamento de perguntas
- Ranking de usuários

---

## Endpoints Disponíveis

### 1. Login / Registro

**URL:** `POST /backend/login.php`

**Request:**
\`\`\`json
{
  "email": "usuario@example.com",
  "password": "senha123",
  "nome": "João Silva",
  "isNewUser": false
}
\`\`\`

**Response (Sucesso):**
\`\`\`json
{
  "userId": 1,
  "email": "usuario@example.com",
  "nome": "João Silva",
  "xp": 0,
  "pontuacao": 0,
  "nivel": 1,
  "moedas": 0,
  "progresso": {}
}
\`\`\`

**Response (Erro):**
\`\`\`json
{
  "error": "Email já registrado"
}
\`\`\`

---

### 2. Salvar Progresso de Módulo

**URL:** `POST /backend/salvar-progresso.php`

**Headers:**
\`\`\`
Content-Type: application/json
\`\`\`

**Request:**
\`\`\`json
{
  "user_id": 1,
  "modulo": "modulo1",
  "pontos": 50
}
\`\`\`

**Response (Sucesso):**
\`\`\`json
{
  "status": "ok",
  "mensagem": "Progresso salvo com sucesso",
  "user_xp": 100,
  "user_nivel": 1,
  "user_moedas": 10
}
\`\`\`

---

### 3. Salvar Avaliação Final

**URL:** `POST /backend/salvar-avaliacao.php`

**Request:**
\`\`\`json
{
  "user_id": 1,
  "nota": 85,
  "acertos": 8
}
\`\`\`

**Response (Sucesso):**
\`\`\`json
{
  "status": "ok",
  "avaliacaoId": 1,
  "nota": 85,
  "aprovado": true
}
\`\`\`

---

### 4. Gerar Certificado

**URL:** `POST /backend/salvar-certificado.php`

**Request:**
\`\`\`json
{
  "user_id": 1,
  "nota": 85
}
\`\`\`

**Response (Sucesso):**
\`\`\`json
{
  "status": "ok",
  "certificadoId": 1,
  "codigo": "a1b2c3d4e5f6g7h8",
  "data_emissao": "2024-01-15 10:30:00"
}
\`\`\`

---

### 5. Carregar Perguntas

**URL:** `GET /backend/perguntas.php?modulo=modulo1`

**Response (Sucesso):**
\`\`\`json
{
  "perguntas": [
    {
      "id": 1,
      "pergunta": "O que é segurança da informação?",
      "alternativa_a": "Proteção de dados...",
      "alternativa_b": "Apenas sobre senhas",
      "alternativa_c": "Somente para bancos",
      "alternativa_d": "Proteção de hardware",
      "correta": "a"
    }
  ]
}
\`\`\`

---

### 6. Verificar Resposta

**URL:** `POST /backend/verificar-resposta.php`

**Request:**
\`\`\`json
{
  "pergunta_id": 1,
  "resposta": "a"
}
\`\`\`

**Response (Sucesso):**
\`\`\`json
{
  "correto": true,
  "resposta_correta": "a",
  "pontos_ganhos": 10
}
\`\`\`

---

### 7. Listar Ranking

**URL:** `GET /backend/listar-ranking.php?limite=10&ordenar=pontuacao`

**Query Parameters:**
- `limite` (opcional): Número de usuários (padrão: 10)
- `ordenar` (opcional): Campo para ordenar (pontuacao, xp, nivel)

**Response (Sucesso):**
\`\`\`json
{
  "ranking": [
    {
      "posicao": 1,
      "user_id": 5,
      "nome": "João Silva",
      "pontuacao": 500,
      "xp": 2000,
      "nivel": 5,
      "modulos_completos": 5
    },
    {
      "posicao": 2,
      "user_id": 3,
      "nome": "Maria Santos",
      "pontuacao": 450,
      "xp": 1800,
      "nivel": 4,
      "modulos_completos": 4
    }
  ]
}
\`\`\`

---

## Códigos de Status HTTP

| Código | Significado |
|--------|-------------|
| 200 | OK - Requisição bem-sucedida |
| 400 | Bad Request - Dados inválidos |
| 401 | Unauthorized - Não autenticado |
| 500 | Server Error - Erro no servidor |

---

## Tratamento de Erros

Todas as respostas de erro seguem este formato:

\`\`\`json
{
  "error": "Descrição do erro",
  "code": "ERROR_CODE",
  "timestamp": "2024-01-15 10:30:00"
}
\`\`\`

---

## CORS

Todos os endpoints permitem requisições CORS. Headers configurados:
\`\`\`
Access-Control-Allow-Origin: *
Access-Control-Allow-Methods: GET, POST, OPTIONS
Access-Control-Allow-Headers: Content-Type
\`\`\`

---

## Autenticação

Atualmente, a autenticação é baseada em **session** PHP:

1. Login realizado → `user_id` armazenado em `$_SESSION`
2. Requisições subsequentes usam `user_id` da sessão
3. Logout remove a sessão

**Melhorias futuras:**
- JWT Tokens
- API Keys
- OAuth2

---

## Limites e Rate Limiting

Por padrão, não há rate limiting implementado. Para produção, recomenda-se:

\`\`\`php
// Adicionar em config.php:
define('MAX_LOGIN_ATTEMPTS', 5);
define('MAX_QUIZ_PER_DAY', 3);
define('MAX_SUBMISSIONS_PER_HOUR', 10);
\`\`\`

---

## Exemplo de Integração (JavaScript)

\`\`\`javascript
// 1. Login
const loginResponse = await fetch('backend/login.php', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    email: 'user@example.com',
    password: 'pass123',
    nome: 'João',
    isNewUser: false
  })
});

const loginData = await loginResponse.json();
sessionStorage.setItem('userId', loginData.userId);

// 2. Salvar Progresso
await fetch('backend/salvar-progresso.php', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    user_id: loginData.userId,
    modulo: 'modulo1',
    pontos: 50
  })
});

// 3. Carregar Ranking
const rankingResponse = await fetch('backend/listar-ranking.php?limite=10');
const rankingData = await rankingResponse.json();
console.log(rankingData.ranking);
\`\`\`

---

## Segurança

Recomendações de segurança:

- ✅ Todas as entradas são sanitizadas com `htmlspecialchars()`
- ✅ Senhas salvas com hash bcrypt (implementado em login.php)
- ✅ Proteção CSRF via sessão PHP
- ⚠️ Para produção: Implementar JWT ou OAuth2
- ⚠️ Para produção: Usar HTTPS obrigatoriamente
- ⚠️ Para produção: Implementar rate limiting

---

## Logs e Debugging

Ativar modo debug em `backend/config.php`:

\`\`\`php
define('DEBUG_MODE', true);
\`\`\`

Logs serão salvos em: `/var/log/php-errors.log`

---

## Troubleshooting

### Erro: "Cross-Origin Request Blocked"
**Solução:** Verifique se CORS headers estão configurados em `config.php`

### Erro: "Database connection failed"
**Solução:** Valide credenciais em `backend/config.php`

### Erro: "Session not found"
**Solução:** Confirme que `session_start()` é chamado no início de cada arquivo

### Erro: "Invalid JSON"
**Solução:** Valide formato JSON com `http://jsonlint.com`

---

## Versão
- **Versão API:** 1.0
- **Última atualização:** Janeiro 2024
- **Status:** Produção
