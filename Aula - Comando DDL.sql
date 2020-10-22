--DATABASE
--DDL - Linguagem de Definição de Dados (Estrutura do Banco de Dados)


--DML - Linguagem de Manipulação de Dados (Instância - Registros)

--Criar Database
--CREATE DATABASE nome


/*
Habilitar Número de Linhas
Ferramentas -> Opções -> Editor de Texto
Texto sem formatação  Habilitar Número de linhas
Todos os idiomas - Habilitar Número de linhas
Transact SQL -Habilitar Número de linhas
XML - Habilitar Número de linhas
*/
--Ctrl + R - Abre e fecha a aba de mensagens


CREATE DATABASE inst_financeira -- Clicar em Executar, F5, Ctrl + E
GO
USE inst_financeira -- Ativa a database inst_financeira

USE master -- Ativa a database master

DROP DATABASE inst_financeira -- Descarta a database

--Comandos DDL (CREATE - Criar, ALTER - Alterar, DROP - Descartar)

--Criar uma tabela
/*
CREATE TABLE nome (
atributo1 tipo nulidade(NOT NUL - Obrigatório / NULL - Opicional),
atributo2 tipo nulidade,
...
atributoN tipo nulidade
PRIMARY KEY(atr1, atr2)
FOREIGN KEY(atrx) REFERENCES tabela1(PK),
FOREIGN KEY(atry) REFERENCES tabela2(PK)
) 
*/
CREATE TABLE cliente(
cpf				INT				NOT NULL,
nome			VARCHAR(100)	NOT NULL,
logradouro		VARCHAR(200)	NOT NULL,
numero			INT				NOT NULL,
cep				CHAR(8)			NOT NULL,
complemento		VARCHAR(255)	NULL,
dt_nasc			DATE			NOT NULL
PRIMARY KEY (cpf)
)

--Informações da Tabela
--EXEC sp_help nome_tabela
EXEC sp_help cliente

CREATE TABLE Cliente_Tel(
cliente_cpf INT		NOT NULL,
telefone	CHAR(9) NOT NULL
PRIMARY KEY (cliente_cpf, telefone)
FOREIGN KEY (cliente_cpf) REFERENCES cliente(cpf)
)

CREATE TABLE conta(
numero_conta	INT				NOT NULL,
saldo			DECIMAL(9,2)	NULL,
PRIMARY KEY(numero_conta)
)

--ALTER TABLE nome
--ADD, ALTER COLUMN, DROP COLUMN, ADD PRIMARY KEY, ADD FOREIGN KEY
ALTER TABLE conta 
ADD numero_conta INT NOT NULL

ALTER TABLE conta
ALTER COLUMN saldo DECIMAL(7,2) NOT NULL

ALTER TABLE conta
ADD data_conta DATE NOT NULL

ALTER TABLE conta 
DROP COLUMN data_conta

ALTER TABLE conta
ADD PRIMARY KEY (numero_conta)

--Modificar nome de table e coluna 
--EXEC sp_rename 'tabela', 'novo_nome', 'COLUMN' (3a cláusula só se for coluna)
EXEC sp_rename 'dbo.conta.saldo', 'saldo_conta', 'COLUMN'
EXEC sp_rename 'dbo.Cliente_Tel', 'cliente_telefone'
 
 --Excluir tabela
 --DROP TABLE nome
 DROP TABLE conta