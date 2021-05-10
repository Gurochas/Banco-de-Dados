CREATE DATABASE empresa 
GO
USE empresa 

CREATE TABLE Filial (
idFilial INT PRIMARY KEY,
logradouro VARCHAR(100),
numero INT
)

INSERT INTO Filial VALUES 
(1, 'R. A', 250),
(2, 'R. B', 500),
(3, 'R. C', 125)

CREATE TABLE Cliente (
idCliente INT PRIMARY KEY,
nome VARCHAR(100),
filial INT,
gasto_filial DECIMAL(7,2)
FOREIGN KEY (filial) REFERENCES filial(idFilial)
)

INSERT INTO Cliente VALUES 
(1001, 'Cliente1', 1, 6404.00),
(1002, 'Cliente2', 1, 5652.00),
(1003, 'Cliente3', 3, 1800.00),
(1004, 'Cliente4', 2, 3536.00),
(1005, 'Cliente5', 2, 8110.00),
(1006, 'Cliente6', 2, 5256.00),
(1007, 'Cliente7', 2, 6879.00),
(1008, 'Cliente8', 2, 7092.00),
(1009, 'Cliente9', 3, 7976.00),
(1010, 'Cliente10', 3, 4192.00),
(1011, 'Cliente11', 3, 8278.00),
(1012, 'Cliente12', 1, 8913.00)

/*
A filial 3 resolveu se desmembrar da empresa. 
Cada gasto de cliente da filial 3 gerará uma multa para as outras filiais.
- Se o gasto for até 3000.00 (85% ficará com filial 3, 15% ficará com as outras filiais a título de multa). 
- Se o gasto for entre 3000.00 e 6000.00 (75% - 100.00 ficará com filial 3, o restante ficará com as outras filiais a título de multa). 
- Se o gasto for superior a 6000.00 (65% ficará com a filial 3 e 35% ficara com as outras filiais a título de multa).

Considerando o cenário acima, criar uma UDF com cursor que percorra a tabela cliente e exiba a seguinte saída:
	fn_cli_fil_3()  (idCliente, nomeCliente, Gasto_Filial_3, Multa_Filiais)
*/

CREATE FUNCTION fn_cli_fil_3()
RETURNS @tabela TABLE (
idCliente INT,
nomeCliente	VARCHAR(50),
gasto_filial DECIMAL(7,2),
multa_filial DECIMAL(7,2)
)
AS
BEGIN
	DECLARE @idCliente INT,
			@nomeCliente VARCHAR(50),
			@gasto_filial DECIMAL(7,2),
			@multa_filial DECIMAL(7,2) 

	DECLARE c CURSOR FOR SELECT idCliente, nome, gasto_filial FROM Cliente

	OPEN c
	FETCH NEXT FROM c INTO @idCliente, @nomeCliente, @gasto_filial

	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		-- Se o gasto for até 3000.00 (85% ficará com filial 3, 15% ficará com as outras filiais a título de multa). 
		IF (@gasto_filial < 3000)
		BEGIN
			SET @multa_filial = @gasto_filial * 0.15
			SET @gasto_filial = @gasto_filial * 0.85
		END
		ELSE 
		BEGIN 
			-- Se o gasto for entre 3000.00 e 6000.00 (75% - 100.00 ficará com filial 3, o restante ficará com as outras filiais a título de multa). 
			IF (@gasto_filial < 6000)
			BEGIN
				SET @multa_filial = @gasto_filial - ((@gasto_filial * 0.75) - 100)
				SET @gasto_filial = (@gasto_filial * 0.75) - 100
			END
			-- Se o gasto for superior a 6000.00 (65% ficará com a filial 3 e 35% ficara com as outras filiais a título de multa).
			ELSE 
			BEGIN 
				SET @multa_filial = @gasto_filial * 0.35
				SET @gasto_filial = @gasto_filial * 0.65
			END 
		END 

		INSERT @tabela VALUES 
		(@idCliente, @nomeCliente, @gasto_filial, @multa_filial)

		FETCH NEXT FROM c INTO @idCliente, @nomeCliente, @gasto_filial
	END

	CLOSE c
	DEALLOCATE c

	RETURN
END

SELECT * FROM fn_cli_fil_3()