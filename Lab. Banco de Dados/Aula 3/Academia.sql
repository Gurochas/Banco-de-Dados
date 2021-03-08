CREATE DATABASE academia
GO
USE academia 

--drop table Aluno
CREATE TABLE Aluno(
CodigoAluno SMALLINT PRIMARY KEY IDENTITY,
Nome VARCHAR(50) 
);

--drop table Atividade
CREATE TABLE Atividade(
CodigoAtividade SMALLINT PRIMARY KEY,
Descricao VARCHAR(50),
IMC DECIMAL(4,2) 
);

--drop table AtividadesAluno
CREATE TABLE AtividadesAluno(
codigoAlunoAtividade SMALLINT PRIMARY KEY IDENTITY,
Altura DECIMAL(3,2) NOT NULL,
Peso DECIMAL(6,3) NOT NULL,
IMC DECIMAL(4,2),
CodigoAtividade SMALLINT,
CodigoAluno SMALLINT CHECK (CodigoAluno>0),
CONSTRAINT FK_CodigoAtividade FOREIGN KEY(CodigoAtividade) REFERENCES Atividade(CodigoAtividade),
CONSTRAINT FK_CodigoAluno FOREIGN KEY (CodigoAluno) REFERENCES Aluno(CodigoAluno)
);

INSERT INTO atividade (CodigoAtividade, Descricao, IMC) 
VALUES
(1,'Corrida + Step', 18.90),
(2,'Biceps + Costas + Pernas', 24.90),
(3,'Esteira + Biceps + Costas + Pernas', 29.90),
(4,'Bicicleta + Biceps + Costas + Pernas', 34.90),
(5,'Esteira + Bicicleta', 39.90)

INSERT INTO Aluno(Nome)
VALUES
('lucas'),
('joao'),
('maria')

SELECT * FROM Aluno

SELECT * FROM Atividade

/*
Atividade: Buscar a PRIMEIRA atividade referente ao IMC imediatamente acima do calculado.
Caso o IMC seja maior que 40, utilizar o código 5.
Criar uma Stored Procedure (sp_alunoatividades), com as seguintes regras:
 - Se, dos dados inseridos, o código for nulo, mas, existirem nome, altura, peso, deve-se inserir um 
 novo registro nas tabelas aluno e aluno atividade com o imc calculado e as atividades pelas 
 regras estabelecidas acima.
 - Se, dos dados inseridos, o nome for (ou não nulo), mas, existirem código, altura, peso, deve-se 
 verificar se aquele código existe na base de dados e atualizar a altura, o peso, o imc calculado e 
 as atividades pelas regras estabelecidas acima.
*/

CREATE PROCEDURE sp_alunoatividades (@nome VARCHAR(50), @altura DECIMAL(3,2), @peso DECIMAL(6,3), @codigo SMALLINT, @saida VARCHAR(MAX) OUTPUT)
AS

	IF(@peso IS NULL OR @altura IS NULL)
	BEGIN
		SET @saida = 'Insira valores validos para a altura e peso'
	END
	ELSE
	BEGIN 
		
		DECLARE @valor SMALLINT --retorna o numero do id da atividade
		DECLARE @IMC DECIMAL(4,2)
		SET @IMC = @Peso / (@Altura * @Altura)

		-------------------- Calcula qual deve ser a atividade para este aluno
		IF (@IMC > 40)
		BEGIN
			SET @valor = 5
		END
		ELSE
		BEGIN
			SET @valor = (SELECT TOP 1 CodigoAtividade from Atividade WHERE IMC > @IMC)
		END
		---------------------

		IF(@codigo IS NULL)
		BEGIN

			INSERT INTO Aluno(nome) VALUES (@nome)
			DECLARE @NovoCodigo SMALLINT
			SET @NovoCodigo = (SELECT TOP 1 CodigoAluno FROM Aluno ORDER BY CodigoAluno DESC)
			INSERT INTO AtividadesAluno (Altura, Peso, IMC, CodigoAtividade, CodigoAluno) VALUES (@Altura, @Peso, @IMC, @valor, @NovoCodigo)

			SET @saida = 'Aluno inserido com sucesso, e atividade designada'

		END
		ELSE
		BEGIN

			DECLARE @Procura SMALLINT
			SET @Procura = (SELECT CodigoAluno FROM aluno WHERE CodigoAluno = @codigo)

			IF (@Procura IS NULL)
			BEGIN
				RAISERROR('O id não existe na base de dados', 16, 1)
			END
			ELSE 
			BEGIN

				DECLARE @Verifica SMALLINT
				SET @Verifica = (SELECT CodigoAluno FROM AtividadesAluno WHERE CodigoAluno = @codigo)
					IF (@Verifica IS NULL)
					BEGIN
						INSERT INTO AtividadesAluno (Altura, Peso, IMC, CodigoAtividade, CodigoAluno) VALUES (@Altura, @Peso, @IMC, @valor, @codigo)
						SET @saida = 'Dado da atividade do aluno criada com sucesso'
					END
					ELSE
					BEGIN
						UPDATE AtividadesAluno SET Peso = @peso, Altura = @altura, IMC = @IMC, CodigoAtividade = @valor WHERE CodigoAluno = @codigo
						SET @saida = 'Dado da atividade do aluno atualizada com sucesso'
					END
			END
		END
	END


	--DECLARE @out VARCHAR(MAX)
	EXEC sp_alunoatividades 'Francisco', 1.70, 90, NULL, @out OUTPUT -- INSERIR OS DADOS COM O CODIGO SENDO NULO
	PRINT @out

	--DECLARE @out VARCHAR(MAX)
	EXEC sp_alunoatividades 'lucas', 1.80, 65, 1, @out OUTPUT -- INSERIR DADOS COM NOME E CODIGO
	PRINT @out

	--DECLARE @out VARCHAR(MAX)
	EXEC sp_alunoatividades NULL,2.00, 90, 2, @out OUTPUT-- INSERIR DADOS COM NOME NULO E CODIGO
	PRINT @out

	SELECT * FROM Aluno
	SELECT * FROM AtividadesAluno