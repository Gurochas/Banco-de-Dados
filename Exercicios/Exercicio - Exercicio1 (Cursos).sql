CREATE DATABASE exercicio_1
GO 
USE exercicio_1

CREATE TABLE aluno (
ra			CHAR(5)			NOT NULL,
nome		VARCHAR(100)	NOT NULL,
sobrenome	VARCHAR(200)	NOT NULL,
rua			VARCHAR(200)	NOT NULL,
numero		INT				NOT NULL,
bairro		VARCHAR(100)	NOT NULL,
cep			CHAR(8)			NOT NULL,
telefone	CHAR(8)			NULL,
PRIMARY KEY (ra)
)

CREATE TABLE curso (
codigo			INT				NOT NULL,
nome			VARCHAR(200)	NOT NULL,
carga_horaria	INT				NOT NULL,
turno			VARCHAR(50)		NOT NULL,
PRIMARY KEY (codigo)
)

CREATE TABLE disciplina (
codigo			INT				NOT NULL,
nome			VARCHAR(200)	NOT NULL,
carga_horaria	INT				NOT NULL,
turno			VARCHAR(50)		NOT NULL,	
semestre		INT				NOT NULL,
PRIMARY KEY (codigo)
)

INSERT INTO aluno (ra, nome, sobrenome, rua, numero, bairro, cep, telefone) VALUES
('12345','José', 'Silva', 'Almirante Noronha', 236, 'Jardim São Paulo', '15890000', '69875287'),
('12346','Ana', 'Maria Bastos', 'Anhaia', 1568, 'Barra Funda', '35690000', '25698526'),
('12347','Mario', 'Santos', 'XV de Novembro', 1841, 'Centro', '10200030', NULL),
('12348','Marcia', 'Neves', 'Voluntários da Patria', 225, 'Santana', '27850900', '78964152')

INSERT INTO curso (codigo, nome, carga_horaria, turno) VALUES
(1, 'Informática', 2800, 'Tarde'),
(2, 'Informática', 2800, 'Noite'),
(3, 'Logística', 2650, 'Tarde'),
(4, 'Logística', 2650, 'Noite'),
(5, 'Plásticos', 2500, 'Tarde'),
(6, 'Plásticos', 2500, 'Noite')

INSERT INTO disciplina (codigo, nome, carga_horaria, turno, semestre) VALUES
(1, 'Informática', 4, 'Tarde', 1),
(2, 'Informática', 4, 'Noite', 1),
(3, 'Quimica', 4, 'Tarde', 1),
(4, 'Quimica', 4, 'Noite', 1),
(5, 'Banco de Dados I', 2, 'Tarde', 3),
(6, 'Banco de Dados I', 2, 'Noite', 3),
(7, 'Estrutura de Dados', 4, 'Tarde', 4),
(8, 'Estrutura de Dados', 4, 'Noite', 4)

--Consultar:									
--Nome e sobrenome, como nome completo dos Alunos Matriculados	
SELECT nome + ' ' + sobrenome AS nome_completo
FROM aluno

--Rua, nº , Bairro e CEP como Endereço do aluno que não tem telefone
SELECT rua + ', ' + CAST(numero AS VARCHAR(5)) + ' ' + bairro + ' - ' + cep AS endereco_aluno   
FROM aluno
WHERE telefone IS NULL 

--Telefone do aluno com RA 12348
SELECT telefone 
FROM aluno
WHERE ra = '12348'

--Nome e Turno dos cursos com 2800 horas
SELECT nome, turno
FROM curso
WHERE carga_horaria = 2800

--O semestre do curso de Banco de Dados I noite	
SELECT semestre
FROM disciplina
WHERE nome = 'Banco de Dados I' AND turno = 'Noite'