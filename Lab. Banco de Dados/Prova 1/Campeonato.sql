USE MASTER 
go
DROP DATABASE campeonato
go
create database campeonato
GO
use campeonato
GO
CREATE TABLE Times(
	CodigoTime		INT	PRIMARY KEY		IDENTITY,
	NomeTime		VARCHAR(30)			NOT NULL,
	Cidade			VARCHAR(30)			NOT NULL,
	Estadio			VARCHAR(30)			NOT NULL
)
GO
INSERT INTO Times VALUES('Botafogo-SP','Ribeirão Preto','Santa Cruz')
,('Bragantino','Bragança Paulista','Nabi Abi Chedid')
,('Corinthians','São Paulo','Arena Corinthians')
,('Ferroviária','Araraquara','Fonte Luminosa')
,('Guarani','Campinas','Brinco de Ouro da Princesa')
,('Ituano','Itu','Novelli Júnior')
,('Mirassol','Mirassol','Jóse Maria de Campos Maia')
,('Novorizontino','Novo Horizonte','Jorge Ismael de Biasi')
,('Oeste','Barueri','Arena Barueri')
,('Palmeiras','São Paulo','Allianz Parque')
,('Ponte Preta','Campinas','Moisés Lucarelli')
,('Red Bull Brasil','Campinas','Moisés Lucarelli')
,('Santos','Santos','Vila Belmiro')
,('São Bento','Sorocaba','Walter Ribeiro')
,('São Caetano','São Caetano do Sul','Anacletto Campenella')
,('São Paulo','São Paulo','Morumbi')
GO
CREATE TABLE Grupos(
	Grupo			VARCHAR(1) CHECK (Grupo IN ('A','B','C','D')),
	Codigo_Time		INT
PRIMARY KEY (Grupo, Codigo_Time)
)	
GO
CREATE TABLE Jogos(
	CodigoTimeA		INT,
	CodigoTimeB		INT,
	GolsTimeA		INT,
	GolsTimeB		INT,
	DataJogo		DATE	CHECK(DataJogo BETWEEN '2019-01-19' and '2019-04-21')	
PRIMARY KEY (CodigoTimeA, CodigoTimeB)
)
GO
ALTER TABLE Grupos ADD CONSTRAINT FK_Grupos_Times
FOREIGN KEY(Codigo_Time) REFERENCES Times(CodigoTime)
GO
ALTER TABLE Jogos ADD CONSTRAINT FK_Jogos_TimesA
FOREIGN KEY(CodigoTimeA) REFERENCES Times(CodigoTime)
GO
ALTER TABLE Jogos ADD CONSTRAINT FK_Jogos_TimesB
FOREIGN KEY(CodigoTimeB) REFERENCES Times(CodigoTime)
GO
CREATE PROC sp_gerarGrupos
AS
    DECLARE @random INT, 
            @secundarios AS VARCHAR(16),
            @principais AS VARCHAR (4),
            @grupo AS CHAR(1),
            @time AS VARCHAR(16),
            @count AS INT,
            @aux AS CHAR(1)

    SET @secundarios = 'AAABBBCCCDDD'
    SET @principais = 'ABCD'

    SET @count = 1

    WHILE (@count <= 16) 
    BEGIN 
        IF ((@count = 3) OR (@count = 16) OR (@count = 10) OR (@count = 13)) 
        BEGIN 
            SET @time = @principais
            SET @aux = 'p'
        END 
        ELSE
        BEGIN 
            SET @time = @secundarios
            SET @aux = 's'
        END 

        SET @random = FLOOR(RAND()*(LEN(@time))+1)

        SET @grupo = SUBSTRING(@time, @random, 1)
        SET @time = STUFF(@time, PATINDEX('%' + @grupo + '%', @time), LEN(@grupo), '')

        IF (@aux = 's')
        BEGIN 

            SET @secundarios = @time 

        END 
        ELSE 
        BEGIN

            SET @principais = @time

        END  

        INSERT INTO Grupos VALUES (@grupo, @count)
        SET @count = @count + 1 

        END 
GO
EXEC sp_gerarGrupos
go
select g.Grupo, t.NomeTime
from Grupos g
inner join Times t
on t.CodigoTime = g.Codigo_Time
select * from Times
select * from Jogos
GO
CREATE PROC sp_gerarJogos
AS
	DECLARE @dia_de_hoje AS DATE, 
			@dia_final AS DATE,
			@contador AS INT,
			@codigo AS INT,
			@codigoAdv AS INT,
			@times_jogados AS INT,
			@adversario AS INT,
			@jogou AS INT,
			@id_time AS INT
	
	-- Escolhe o dia de inicio e do fim de campeonato
	SET @dia_de_hoje = '2019-01-19'
	SET @dia_final = '2019-04-21'

	-- Enquanto o campeonato estiver rolando 
	WHILE (@dia_de_hoje < @dia_final)
	BEGIN 
		-- Verifica se é dia de Jogo (Quarta ou Domingo)
		IF ((DATEPART(WEEKDAY, @dia_de_hoje) = 1) OR (DATEPART(WEEKDAY, @dia_de_hoje) = 4))
		BEGIN 

			SET @times_jogados = 1

			WHILE (@times_jogados <= 16 )
			BEGIN 

				-- Escolhe o time A que ira jogar 
	            SET @id_time = @times_jogados

				-- Verifica se o time A jogou no dia de hoje
				SET @codigo = NULL
				SET @codigo = (SELECT j.CodigoTimeA 
				               FROM Jogos AS j 
							   WHERE ((@id_time = j.CodigoTimeA OR 
									 @id_time = j.CodigoTimeB) AND
									 @dia_de_hoje = j.DataJogo))

				-- Caso ainda não tenha jogado 
				IF (@codigo IS NULL)
				BEGIN
					SET @jogou = 0
					SET @contador = 1
					SET @adversario = 0

					-- Em quanto ainda não jogou e ainda tem adversários para serem enfrentados
					WHILE ((@jogou = 0) AND (@contador < 16))
					BEGIN 
						
						-- Escolhe o adversário
						SET @adversario = @id_time + @contador 
						IF (@adversario > 16)
						BEGIN
							SET @adversario = @adversario - 16 
						END 

						-- Verifica se adversario já jogou no dia de hoje
						SET @codigoAdv = NULL
						SET @codigoAdv = (SELECT j.CodigoTimeA 
										  FROM Jogos AS j 
										  WHERE ((@adversario = j.CodigoTimeA OR 
												 @adversario = j.CodigoTimeB) AND
												 @dia_de_hoje = j.DataJogo))

						-- Verfica se ambos os times já jogaram um contra o outro				
						SET @codigo = NULL
						SET @codigo = (SELECT j.CodigoTimeA
									   FROM Jogos AS J 
									   WHERE (j.CodigoTimeA = @id_time AND j.CodigoTimeB = @adversario) OR 
											 (j.CodigoTimeA = @adversario AND j.CodigoTimeB = @id_time))
						
						-- Se alguma das condições forem Verdadeiras, ira se decidir um novo adversario.
						IF ((@codigo IS NOT NULL) OR (@codigoAdv IS NOT NULL) or (@id_time = @adversario))
						BEGIN 
							SET @contador = @contador + 1
						END 

						-- Senão eles irão se enfrentar 
						ELSE 
						BEGIN 
							SET @jogou = 1; 
							INSERT INTO Jogos VALUES (@id_time, @adversario, NULL, NULL, @dia_de_hoje)
						END 
					END 
				END
				SET @times_jogados = @times_jogados + 1 	
			END 
		END 

		SET @dia_de_hoje = DATEADD(DAY, 1, @dia_de_hoje)

	END 
GO
EXEC sp_gerarJogos


select * from Jogos
order by CodigoTimeB





