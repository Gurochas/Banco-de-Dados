CREATE DATABASE exercicio_CRUD
GO 
USE exercicio_CRUD

CREATE TABLE livro(
codigo_livro	INT				NOT NULL,
nome			VARCHAR(100)	NOT NULL,
lingua			VARCHAR(50)		NOT NULL,
ano				INT				NOT NULL,
PRIMARY KEY (codigo_livro)	 
)

CREATE TABLE autor(
codigo_autor	INT				NOT NULL,
nome			VARCHAR(100)	NOT NULL,
nascimento		DATE			NOT NULL,
pais			VARCHAR(50)		NOT NULL,
biografia		VARCHAR(max)	NOT NULL
PRIMARY KEY (codigo_autor)	
)

CREATE TABLE livro_autor (
livroCodigo_Livro	INT				NOT NULL,
autorCodigo_Autor	INT				NOT NULL
PRIMARY KEY (livroCodigo_Livro, autorCodigo_Autor)
FOREIGN KEY (livroCodigo_Livro) REFERENCES livro(codigo_livro),
FOREIGN KEY (autorCodigo_Autor) REFERENCES autor(codigo_autor)
)

CREATE TABLE edicoes (
isbn				CHAR(13)		NOT NULL,
preco				DECIMAL(7,2)	NOT NULL,	
ano					INT				NOT NULL,	
num_paginas			INT				NOT NULL,
qtd_estoque			INT				NOT NULL,
PRIMARY KEY (isbn)
)

CREATE TABLE editora(
codigo_editora		INT				NOT NULL,
nome				VARCHAR(50)		NOT NULL,
logradouro			VARCHAR(255)	NOT NULL,
numero				INT				NOT NULL,
cep					CHAR(8)			NOT NULL,
telefone			VARCHAR(11)		NOT NULL
PRIMARY KEY (codigo_editora)
)

CREATE TABLE livro_edicoes_editora (
edicoesIsbn					CHAR(13)		NOT NULL,
livroCodigo_Livro			INT				NOT NULL,
editoraCodigo_Editora		INT				NOT NULL
PRIMARY KEY (edicoesIsbn, livroCodigo_Livro, editoraCodigo_Editora)
FOREIGN KEY (livroCodigo_Livro) REFERENCES livro(codigo_livro),
FOREIGN KEY (edicoesIsbn) REFERENCES edicoes(isbn),
FOREIGN KEY (editoraCodigo_Editora) REFERENCES editora(codigo_editora)
)

-- Modificar o nome da coluna ano da tabela edicoes, para AnoEdicao
EXEC sp_rename 'dbo.edicoes.ano', 'anoEdicao', 'COLUMN'

-- Modificar o tamanho do varchar do Nome da editora de 50 para 30ALTER TABLE editoraALTER COLUMN nome VARCHAR(30) NOT NULL-- Modificar o tipo da coluna ano da tabela autor para intALTER TABLE autorDROP COLUMN nascimento ALTER TABLE autor ADD nascimento INT NOT NULL-- Inserir os dados-- LivroINSERT INTO livro (codigo_livro, nome, lingua, ano) 
VALUES 
(1001, 'CCNA 4.1', 'PT-BR', 2015),
(1002, 'HTML 5', 'PT-BR', 2017),
(1003, 'Redes de Computadores', 'EN', 2010),(1004, 'Android em Ação', 'PT-BR', 2018)--AutorINSERT INTO autor(codigo_autor, nome, nascimento, pais, biografia)
VALUES (10001, 'Inácio da Silva', 1975, 'Brasil' , 'Programador WEB desde 1995'),(10002, 'Andrew Tannenbaum', 1944, 'EUA' , 'Chefe do Departamento de Sistemas de Computação da Universidade de Vrij'),(10003, 'Luis Rocha', 1967, 'Brasil' , 'Programador Mobile desde 2000'),(10004, 'David Halliday', 1916, 'EUA' , 'Físico PH.D desde 1941')--Livro AutorINSERT INTO livro_autor(livroCodigo_Livro, autorCodigo_Autor)
VALUES (1001, 10001),(1002, 10003),(1003, 10002),(1004, 10003)--Edicoes INSERT INTO edicoes (isbn, preco, anoEdicao, num_paginas, qtd_estoque)VALUES ('0130661023', 189.99, 2018, 653, 10)--A universidade do Prof. Tannenbaum chama-se Vrije e não Vrij, modificar
UPDATE autor
SET biografia = 'Chefe do Departamento de Sistemas de Computação da Universidade de Vrije'
WHERE codigo_autor = 10002

--A livraria vendeu 2 unidades do livro 0130661023, atualizar
UPDATE edicoes
SET qtd_estoque = qtd_estoque - 1
WHERE isbn = '0130661023'

--Por não ter mais livros do David Halliday, apagar o autor.
DELETE autor 
WHERE nome = 'David Halliday'