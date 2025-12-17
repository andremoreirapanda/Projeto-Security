-- Arquivo: cursos/schema.sql
-- Estrutura de Banco de Dados para SecurityTraining Platform
--
-- NOTA: Este arquivo contém apenas a estrutura (CREATE TABLE) e não os dados (INSERT INTO).
-- Os dados das perguntas serão inseridos via backend/setup.php.


create database security_training;
--
-- Estrutura para tabela `avaliacoes`
--
CREATE TABLE `avaliacoes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `nota` int(11) NOT NULL,
  `acertos` int(11) DEFAULT 0,
  `data_avaliacao` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Estrutura para tabela `certificados`
--
CREATE TABLE `certificados` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `codigo` varchar(32) NOT NULL,
  `data_emissao` datetime DEFAULT current_timestamp(),
  `nota` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Estrutura para tabela `perguntas`
--
CREATE TABLE `perguntas` (
  `id` int(11) NOT NULL,
  `modulo` varchar(50) NOT NULL,
  `tipo` enum('quiz','prova') NOT NULL DEFAULT 'quiz',
  `pergunta` text NOT NULL,
  `alternativa_a` text NOT NULL,
  `alternativa_b` text NOT NULL,
  `alternativa_c` text NOT NULL,
  `alternativa_d` text NOT NULL,
  `correta` char(1) NOT NULL,
  `dificuldade` varchar(20) DEFAULT 'media'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Estrutura para tabela `progresso`
--
CREATE TABLE `progresso` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL, 
  `modulo` varchar(50) NOT NULL,
  `concluido` tinyint(1) DEFAULT 0,
  `pontos` int(11) DEFAULT 0,
  `data_conclusao` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Estrutura para tabela `users`
--
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `nome` varchar(120) NOT NULL,
  `email` varchar(120) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `xp` int(11) DEFAULT 0,
  `pontuacao` int(11) DEFAULT 0,
  `nivel` int(11) DEFAULT 1,
  `moedas` int(11) DEFAULT 0,
  `data_criacao` datetime DEFAULT current_timestamp(),
  `ultimo_acesso` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Definição de Chaves Primárias
ALTER TABLE `avaliacoes` ADD PRIMARY KEY (`id`), ADD KEY `idx_user_avaliacao` (`user_id`);
ALTER TABLE `certificados` ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `codigo` (`codigo`), ADD KEY `idx_user_certificado` (`user_id`);
ALTER TABLE `perguntas` ADD PRIMARY KEY (`id`);
ALTER TABLE `progresso` ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `unique_user_modulo` (`user_id`,`modulo`), ADD KEY `idx_user_id` (`user_id`);
ALTER TABLE `users` ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `email` (`email`);

-- Definição de Auto Increment (para MySQL/MariaDB)
ALTER TABLE `avaliacoes` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `certificados` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `perguntas` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;
ALTER TABLE `progresso` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `users` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;


-- Definição de Chaves Estrangeiras (Restrições)
ALTER TABLE `avaliacoes` ADD CONSTRAINT `avaliacoes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
ALTER TABLE `certificados` ADD CONSTRAINT `certificados_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
ALTER TABLE `progresso` ADD CONSTRAINT `progresso_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

COMMIT;