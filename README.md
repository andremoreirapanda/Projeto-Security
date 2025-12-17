

## 🚀 Como Instalar e Rodar

Siga estes passos para configurar a plataforma no seu ambiente local (XAMPP/WAMP/MAMP):

### 1. Configuração Inicial

1.  **Hospedagem:** Coloque toda a pasta `cursos` dentro do diretório de servidor web (`htdocs` ou `www`).
2.  **Servidor Web:** Inicie o Apache e o MySQL no seu servidor local (ex: XAMPP).
3.  **Banco de Dados:**
    * Crie um novo banco de dados no phpMyAdmin chamado **`security_training`**.
    * Para isso acesse o workbanch ou o phpMyAdmin, copie todo o conteudo de schema.sql e execute todas as linhas na ordem *
    * Em seguida execute na url do seu navegador  **`cursos/backend/fix_db.php`** (ele irá verificar se todas as tabelas foram inseridas corretamente e conectar ao código)
    * Agora execute na URL do naveador **`cursos/backend/setup.php`** (Irá adicionar as perguntas no banco de dados)

### 2. Configurar Conexão (PHP)

Edite o arquivo `cursos/backend/config.php` e verifique as credenciais de acesso ao banco.

```php
// Arquivo: cursos/backend/config.php
$DB_HOST = "localhost";
$DB_USER = "root";
$DB_PASS = ""; // Altere esta linha se você usa senha no MySQL
$DB_NAME = "security_training";
````

### 3\. Instalar a Estrutura do Banco de Dados

Este passo criará as tabelas e inserirá as 100 perguntas iniciais.

1.  Abra seu navegador.
2.  Acesse: `http://localhost/cursos/backend/fix_db.php` e tambem `http://cursos/backend/setup.php`(Ajuste o caminho se necessário).
3.  *Resultado Esperado:* O script deve exibir uma mensagem de **"Instalação Completa\!"** em verde.

### 4\. Acessar a Plataforma

1.  Acesse: `http://localhost/cursos/index.html`
2.  **Cadastre-se:** Marque a caixa **"Criar novo cadastro"** e preencha o Nome, Email e Senha.
3.  O sistema irá redirecionar para o Dashboard.

-----

## 💡 Como Usar o Site (Fluxo do Aluno)

O treinamento segue uma trilha de aprendizado linear e gamificada:

### 1\. Dashboard (Visão Geral)

  * Ao logar, você acessa a **Visão Geral**.
  * Aqui, você monitora sua **Pontuação**, **XP**, **Nível** e o **Progresso Geral** do curso.
  * A navegação lateral (`📚 Módulos`, `🏆 Ranking`, `🎓 Certificados`) permite acessar as seções principais.

### 2\. Trilha de Módulos

1.  Clique em **"📚 Módulos"** ou em um card de módulo na Visão Geral.
2.  **Estudo:** Dentro de cada módulo, você encontrará o conteúdo dividido por seções (texto, listas, vídeos).
3.  **Quiz:** Na parte inferior do conteúdo, há um **Quiz de Fixação** com 10 perguntas.
      * Você deve acertar **70%** (7 de 10) para ser aprovado e avançar para o próximo módulo.
      * A aprovação registra o módulo como **Completo** no seu perfil e concede **Pontos** e **XP**.

### 3\. Ranking e Gamificação

  * A cada conclusão de módulo, sua pontuação e XP são atualizados, impactando sua **posição no Ranking Global**.
  * Você ganha um novo **Nível** ao acumular XP suficiente.

### 4\. Avaliação Final e Certificado (Objetivo Final)

1.  Após completar todos os 5 módulos, a **Avaliação Final** é liberada (link no Dashboard).
2.  A avaliação é uma prova abrangente de **50 perguntas** sobre todo o conteúdo.
3.  **Aprovação:** É necessário obter nota **igual ou superior a 70%**.
4.  **Emissão do Certificado:** Se aprovado, o sistema registra sua nota e emite um certificado com um código de autenticidade, que fica disponível na seção **"🎓 Certificados"** para download em PDF.

-----

## 📂 Estrutura de Arquivos

| Pasta/Arquivo | Descrição |
| :--- | :--- |
| **`index.html`** | Tela de Login/Cadastro. |
| **`dashboard.html`** | Painel principal do usuário. |
| **`certificado.html`** | Tela de visualização e download do certificado. |
| **`schema.sql`** | Estrutura SQL das tabelas. |
| **`backend/`** | Contém todos os arquivos PHP de lógica do servidor. |
| `backend/perfil.php` | Endpoint crucial para carregar dados do usuário, progresso e certificado. |
| `backend/setup.php` | Insere as 100 perguntas na tabela `perguntas`. |
| **`js/`** | Contém todos os arquivos JavaScript do frontend. |
| `js/main.js` | Lógica de autenticação e navegação do Dashboard. |
| `js/gamification.js` | Controla XP, pontos e a lógica de geração de certificado. |
| `js/certificate.js` | Preenche os dados do certificado e gera o PDF. |

```
```