CREATE DATABASE exercicio_3
GO
USE exercicio_3 

CREATE TABLE paciente (
cpf			CHAR(11)		NOT NULL,
nome		VARCHAR(200)	NOT NULL,	
rua			VARCHAR(200)	NOT NULL,
numero		INT				NOT NULL,
bairro		VARCHAR(100)	NOT NULL,
telefone	CHAR(8)			NULL
PRIMARY KEY (cpf)
)
GO
CREATE TABLE medico (
codigo			INT				NOT NULL,
nome			VARCHAR(200)	NOT NULL,
especialidade	VARCHAR(200)	NOT NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE prontuario (	
data			DATETIME		NOT NULL,
cpf_paciente	CHAR(11)		NOT NULL,
codigo_medico	INT				NOT NULL,
diagnostico		VARCHAR(200)	NOT NULL,
medicamento		VARCHAR(200)	NOT NULL
PRIMARY KEY (data, cpf_paciente, codigo_medico),
FOREIGN KEY (cpf_paciente) REFERENCES paciente (cpf),
FOREIGN KEY (codigo_medico) REFERENCES medico (codigo)
)

INSERT INTO paciente (cpf, nome, rua, numero, bairro, telefone) VALUES
('35454562890', 'Jos� Rubens', 'Campos Salles', 2750, 'Centro', '21450998'), 
('29865439810', 'Ana Claudia', 'Sete de Setembro', 178, 'Centro', '97382764'), 
('82176534800', 'Marcos Aur�lio', 'Tim�teo Penteado', 236, 'Vila Galv�o', '68172651'), 
('12386758770', 'Maria Rita', 'Castello Branco', 7765, 'Vila Ros�lia', NULL), 
('92173458910', 'Joana de Souza', 'XV de Novembro', 298, 'Centro', '21276578')

INSERT INTO medico (codigo, nome, especialidade) VALUES
(1, 'Wilson Cesar', 'Pediatra'),
(2, 'Marcia Matos', 'Geriatra'),
(3, 'Carolina Oliveira', 'Ortopedista'),
(4, 'Vinicius Araujo', 'Cl�nico Geral')

INSERT INTO prontuario (data, cpf_paciente, codigo_medico, diagnostico, medicamento) VALUES 
('2020-09-10', '35454562890', 2, 'Reumatismo', 'Celebra'),
('2020-09-10', '92173458910', 2, 'Renite Al�rgica', 'Allegra'),
('2020-09-12', '29865439810', 1, 'Inflama��o de garganta', 'Nimesulida'),
('2020-09-13', '35454562890', 2, 'H1N1', 'Tamiflu'),
('2020-09-15', '82176534800', 4, 'Gripe', 'Resprin'),
('2020-09-15', '12386758770', 3, 'Bra�o Quebrado', 'Dorflex + Gesso')

--Consultar:				
--Qual a especialidade de Carolina Oliveira		
SELECT especialidade
FROM medico
WHERE nome = 'Carolina Oliveira'	
	
--Qual medicamento receitado para reumatismo				
SELECT medicamento
FROM prontuario 
WHERE diagnostico = 'Reumatismo'

--Consultar em subqueries:													
--Diagn�stico e Medicamento do paciente Jos� Rubens em suas consultas

SELECT diagnostico, medicamento
FROM prontuario
WHERE cpf_paciente IN (
	SELECT cpf 
	FROM paciente 
	WHERE nome = 'Jos� Rubens'
)
						 							
--Nome e especialidade do(s) M�dico(s) que atenderam Jos� Rubens. 
--Caso a especialidade tenha mais de 3 letras, mostrar apenas as 3 primeiras letras concatenada com um ponto final (.)	
SELECT nome, 
	CASE WHEN (LEN(especialidade) > 3)
		THEN 
			SUBSTRING(especialidade, 1, 3) + '.'
		ELSE 
			especialidade
		END 
FROM medico 
WHERE codigo IN (
	SELECT codigo_medico
	FROM prontuario
	WHERE cpf_paciente IN (
		SELECT cpf 
		FROM paciente 
		WHERE nome = 'Jos� Rubens'
	)
)							

--CPF (Com a m�scara XXX.XXX.XXX-XX), Nome, Endere�o completo (Rua, n� - Bairro),
--Telefone (Caso nulo, mostrar um tra�o (-)) dos pacientes do m�dico Vinicius		

SELECT SUBSTRING(cpf, 1, 3) + '.' + SUBSTRING(cpf, 4, 3) + '.' + SUBSTRING(cpf, 7, 3) + '-' + SUBSTRING(cpf, 10, 2),
	   nome, rua + ', ' + CAST(numero AS VARCHAR(5)) + ' - ' + bairro AS endereco_completo,
	   CASE WHEN (telefone IS NULL) 
			THEN 
				'-'
			ELSE
				telefone
			END AS telefone
FROM paciente
WHERE cpf IN(
	SELECT cpf_paciente
	FROM prontuario 
	WHERE codigo_medico IN (
		SELECT codigo 
		FROM medico 
		WHERE nome LIKE 'Vinicius%'
	)
)
											
--Quantos dias fazem da consulta de Maria Rita at� hoje			
SELECT DATEDIFF(DAY, data, GETDATE()) AS dias_consulta
FROM prontuario
WHERE cpf_paciente IN (
	SELECT cpf 
	FROM paciente 
	WHERE nome = 'Maria Rita'
)

--Alterar dados
--Alterar o telefone da paciente Maria Rita, para 98345621	
UPDATE paciente
SET telefone = '98345621'
WHERE nome = 'Maria Rita'
			
--Alterar o Endere�o de Joana de Souza para Volunt�rios da P�tria, 1980, Jd. Aeroporto	
UPDATE paciente 
SET rua = 'Volunt�rios da P�tria', 
	numero = 1980,
	bairro = 'Jd. Aeroporto'
WHERE nome = 'Joana de Souza' 				