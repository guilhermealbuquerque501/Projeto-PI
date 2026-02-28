-- Criando o banco de dados do projeto
CREATE DATABASE luminare;
USE luminare;

-- Essa tabela foi criada com o intuito de guardar, gerenciar e modelar os dados que se relacionam com o cadastro da empresa
-- no site operacional, no caso, site com função do projeto

CREATE TABLE cadastro_empresa (
    id_empresa INT PRIMARY KEY AUTO_INCREMENT, -- id da empresa ( unico e geral, sendo o mesmo que aparece em várias tabelas )
    razao_social VARCHAR(200) NOT NULL, -- nome completo registrado da empresa | exemp: Nike, Inc.
    nome_fantasia VARCHAR(200) NOT NULL, -- nome social da empresa | exemp: NIKE
    cnpj_empresa CHAR(18) UNIQUE NOT NULL, -- cpnj empresa
    email_empresa VARCHAR(150) NOT NULL, -- email de contato da empresa
    cep_empresa CHAR(8), -- CEP, rua, bairro etc
    status_empresa VARCHAR(20) DEFAULT 'Ativa', -- Ativa ou inativa
    responsavel_legal VARCHAR(150) NOT NULL, -- CEO da empresa, que tem o cpnj linkado ao seu nome
    email_responsavel VARCHAR(150) NOT NULL, -- email do CEO
    cpf_responsavel VARCHAR(14) UNIQUE NOT NULL, -- cpf do CEO
    cnae_empresa CHAR(7), -- tipo economico da empresa ( constituição brasileira )
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP, -- data criação do cadastro da empresa
    data_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP, -- data da ultima atualização nos dados da empresa
    CONSTRAINT cStatus_empresa CHECK (status_empresa IN('Ativa', 'Inativa')) -- restrição ativa ou inativa
);

-- Essa tabela foi criada com o intuito de guardar, gerenciar e modelar os dados que se relacionam com o cadastro dos funcionarios
-- nas empresas já cadastradas no nosso site

CREATE TABLE cadastro_funcionario (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT, -- id funcionario chave primaria
    nome_completo_funcionario VARCHAR(150) NOT NULL, -- nome completo funcionario
    email_funcionario VARCHAR(150) NOT NULL, --  email de contato funcionario
    senha_funcionario VARCHAR(100) NOT NULL, -- senha de login funcionario
    cpf_funcionario CHAR(14) UNIQUE NOT NULL, -- cpf funcionario ( identificação )
    status_funcionario VARCHAR(20) DEFAULT 'Ativo', -- satus do funcionario, se ele está ativo ou inativo
    dt_registro_funcionario DATETIME DEFAULT CURRENT_TIMESTAMP, -- data qque o funcionario foi resgistrado no sistema
    dt_atualizacao_funcionario DATETIME DEFAULT CURRENT_TIMESTAMP, -- data que ocorreu a ultima atulizacao nessa tabela do funcionario
    nome_empresa VARCHAR(200) NOT NULL, -- nome da empresa 
    id_empresa VARCHAR(200) NOT NULL, -- id da empresa que ele atua ( relacional futuro )
    CONSTRAINT cStatus_funcionario CHECK (status_funcionario IN('Ativo', 'Inativo')) -- restrição do status para ativo e inativo
);

-- -- Essa tabela foi criada com o intuito de guardar, gerenciar e modelar os dados que se relacionam com o cadastro de todos os sensores
-- que a empresa tem acesso, sejam eles ativos ou inativos

CREATE TABLE sensores (
    id_sensor INT AUTO_INCREMENT PRIMARY KEY, -- id de cada sensor 
    nome_sensor VARCHAR(100), -- nome do sensor, que pode ser estilo: 1AB etc
	estufa_sensor VARCHAR(100) NOT NULL, -- estufa que o sensor está localizado
    grupo_estufa_sensor INT NOT NULL, -- grupo de plantas dentro de x estufa no qual o sensor capta os dados
    status_sensor VARCHAR(20) DEFAULT 'Ativo', -- satus do sensor
    dt_instalacao DATETIME DEFAULT CURRENT_TIMESTAMP, -- data de instalação do sensor
    dt_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP, -- data da ultima atualização nos dados dos sensor
    CONSTRAINT cSensor_status CHECK (status_sensor IN('Ativo', 'Inativo')) -- restrição do status para ativo e inativo
);

-- Essa tabela foi criada com o intuito de guardar, gerenciar e modelar os dados que se relacionam com a captação
-- de dados da iluminação de um grupo x de plantas em uma x estufa

CREATE TABLE leituras_luminosidade (
    id_data INT AUTO_INCREMENT PRIMARY KEY, -- id dos dados
    id_sensor INT NOT NULL, -- id do sensor que relaciona com a tabela sensores
	status_arduino VARCHAR(100) NOT NULL, -- status do
    luminosidade DECIMAL(10,2) NOT NULL,  -- valor medido
    unidade VARCHAR(20) DEFAULT 'lux',    -- lux, PPFD, etc
    status_luminosidade VARCHAR(100) NOT NULL, -- se está no nível baixo, médio ou alto
	estufa_sensor VARCHAR(100) NOT NULL, -- estufa que os dados estão sendo captados
    grupo_estufa_sensor INT NOT NULL, -- grupo da planta em x estufa que o sensor capta
	dt_captacao_dados DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- data que os dados foram captados
    dt_instalacao DATETIME DEFAULT CURRENT_TIMESTAMP, -- data de instalação do sensor, que relaciona com a tabela dos sensores
    dt_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP, -- data da ultima atualização dos dados 
	CONSTRAINT cStatus_arduino CHECK (status_arduino In('Ativo', 'Inativo'))
);

-- Essa tabela foi criada com o intuito de guardar, gerenciar e modelar os dados que se relacionam com a organização de grupos
-- em uma x estufa, separadas por colunas e linhas que criam "quadrados" nos quais os sensores poderam analisar 
-- captando dados diferentes para cada grupo seleto.

CREATE TABLE grupo_plantas (
    id_grupo_plantas INT PRIMARY KEY AUTO_INCREMENT, -- id grupo das plantas
    nome_grupo_plantas VARCHAR(100), -- nome "social" utilizado para referenciar um x grupo de plantas 
    qtd_plantas_grupo INT, -- número de espécimes nesse x grupo.
    coluna_plantas VARCHAR(30) NOT NULL, -- coluna da estufa em que essas tais plantas estão localizadas
    linha_plantas VARCHAR(30) NOT NULL, -- linha da estufa em que essas tais plantas estão localizadas
    sensor_modelo VARCHAR(30) NOT NULL, -- nome do sensor senso utlizado nesse grupo de plantas relacionado com a table sensores
    id_sensor INT, -- id do sensor utilizado nesse grupo relacionado com a table sensores
    status_grupo_plantas VARCHAR(15) DEFAULT 'Ativo' NOT NULL,
    CONSTRAINT cStatus_grupo_plantas CHECK (status_grupo_plantas IN('Ativo', 'Inativo'))
);

/*
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100),
luminosidade_min DECIMAL(20,2),
luminosidade_max DECIMAL(20,2)
*/