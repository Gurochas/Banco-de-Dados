CREATE DATABASE exercicio_constraints
GO 
USE exercicio_constraints

CREATE TABLE livro(
codigo_livro	INT				NOT NULL,
nome			VARCHAR(50)		NOT NULL	UNIQUE,
lingua			VARCHAR(20)		NOT NULL	DEFAULT('PT-BR'),
ano				INT				NOT NULL	CHECK(ano < '1990'),
PRIMARY KEY (codigo_livro)	 
)

CREATE TABLE autor(
codigo_autor	INT				NOT NULL,
nome			VARCHAR(50)		NOT NULL	UNIQUE,
dt_nasc			DATE			NOT NULL,
pais			VARCHAR(20)		NOT NULL	CHECK(pais = 'Brasil' OR pais = 'Alemanha'),
biografia		VARCHAR(300)	NOT NULL
PRIMARY KEY (codigo_autor)	
)

CREATE TABLE livro_autor (
livroCodigo_Livro	INT				NOT NULL,
autorCodigo_Autor	INT				NOT NULL
PRIMARY KEY (livroCodigo_Livro, autorCodigo_Autor)
FOREIGN KEY (livroCodigo_Livro) REFERENCES livro(codigo_livro),
FOREIGN KEY (autorCodigo_Autor) REFERENCES autor(codigo_autor)
)

CREATE TABLE edicao (
isbn				CHAR(13)		NOT NULL,
preco				DECIMAL(9,2)	NOT NULL	CHECK (preco < 0),	
ano					INT				NOT NULL	CHECK (ano < '1993'),	
num_paginas			INT				NOT NULL	CHECK (num_paginas < 0),
qtd_estoque			INT				NOT NULL,
livroCodigo_Livro	INT				NOT NULL
PRIMARY KEY (isbn)
FOREIGN KEY (livroCodigo_Livro) REFERENCES livro(codigo_livro)
)

CREATE TABLE editora(
codigo_editora		INT				NOT NULL,
nome				VARCHAR(50)		NOT NULL	UNIQUE,
logradouro			VARCHAR(100)	NOT NULL,
numero				INT				NOT NULL	CHECK (numero < 0),
cep					CHAR(8)			NOT NULL,
telefone			VARCHAR(11)		NOT NULL
PRIMARY KEY (codigo_editora)
)

CREATE TABLE edicao_editora (
edicoesIsbn					CHAR(13)		NOT NULL,
editoraCodigo_Editora		INT				NOT NULL
PRIMARY KEY (edicoesIsbn, editoraCodigo_Editora)
FOREIGN KEY (edicoesIsbn) REFERENCES edicao(isbn),
FOREIGN KEY (editoraCodigo_Editora) REFERENCES editora(codigo_editora)
)