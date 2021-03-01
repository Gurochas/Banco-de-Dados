CREATE DATABASE exercicio_12
GO 
USE exercicio_12

CREATE TABLE planos (
codplano	INT				NOT NULL,
nomeplano	VARCHAR(100)	NOT NULL,
valorplano	decimal(7,2)	NOT NULL
PRIMARY KEY (codplano)
)
GO
CREATE TABLE servicos (
codservicos		INT				NOT NULL,
nomeservico		VARCHAR(100)	NOT NULL,
valorservico	DECIMAL(7,2)	NOT NULL
PRIMARY KEY (codservicos)
)
GO
CREATE TABLE cliente (
codcliente	INT				NOT NULL,
nomecliente	VARCHAR(100)	NOT NULL,
datainicio	DATETIME		NOT NULL
PRIMARY KEY (codcliente)
)
GO
CREATE TABLE contratos (
codcliente	INT			NOT NULL,
codplano	INT			NOT NULL,
codservico	INT			NOT NULL,
status		CHAR(1)		NOT NULL,
data		DATETIME	NOT NULL
PRIMARY KEY (codcliente, codplano, codservico, data)
)

INSERT INTO planos VALUES
(1, '100 Minutos', 80),
(2, '150 Minutos', 130),
(3, '200 Minutos', 160),
(4, '250 Minutos', 220),
(5, '300 Minutos', 260),
(6, '600 Minutos', 350)

INSERT INTO servicos VALUES
(1, '100 SMS', 10),
(2, 'SMS Ilimitado', 30),
(3, 'Internet 500 MB', 40),
(4, 'Internet 1 GB', 60),
(5, 'Internet 2 GB', 70)

INSERT INTO cliente VALUES
(1234, 'Cliente A', '2012-10-15'),
(2468, 'Cliente B', '2012-11-20'),
(3702, 'Cliente C', '2012-11-25'),
(4936, 'Cliente D', '2012-12-01'),
(6170, 'Cliente E', '2012-12-18'),
(7404, 'Cliente F', '2013-01-20'),
(8638, 'Cliente G', '2013-01-25')

INSERT INTO contratos VALUES
(1234, 3, 1, 'E', '2012-10-15'),
(1234, 3, 3, 'E', '2012-10-15'),
(1234, 3, 3, 'A', '2012-10-16'),
(1234, 3, 1, 'A', '2012-10-16'),
(2468, 4, 4, 'E', '2012-11-20'),
(2468, 4, 4, 'A', '2012-11-21'),
(6170, 6, 2, 'E', '2012-12-18'),
(6170, 6, 5, 'E', '2012-12-19'),
(6170, 6, 2, 'A', '2012-12-20'),
(6170, 6, 5, 'A', '2012-12-21'),
(1234, 3, 1, 'D', '2013-01-10'),
(1234, 3, 3, 'D', '2013-01-10'),
(1234, 2, 1, 'E', '2013-01-10'),
(1234, 2, 1, 'A', '2013-01-11'),
(2468, 4, 4, 'D', '2013-01-25'),
(7404, 2, 1, 'E', '2013-01-20'),
(7404, 2, 5, 'E', '2013-01-20'),
(7404, 2, 5, 'A', '2013-01-21'),
(7404, 2, 1, 'A', '2013-01-22'),
(8638, 6, 5, 'E', '2013-01-25'),
(8638, 6, 5, 'A', '2013-01-26'),
(7404, 2, 5, 'D', '2013-02-03')

--Status de contrato A(Ativo), D(Desativado), E(Espera)										
--Um plano só é válido se existe pelo menos um serviço associado a ele									
										
-- Consultar o nome do cliente, o nome do plano, a quantidade de estados de contrato (sem repetições) por contrato, 
-- dos planos cancelados, ordenados pelo nome do cliente		
SELECT c.nomecliente, p.nomeplano, COUNT(DISTINCT co.status) AS qtd_estados
FROM  cliente c,  contratos co, planos p
WHERE c.codcliente = co.codcliente
   AND p.codplano = co.codplano
   AND c.codcliente IN (
		SELECT DISTINCT c.codcliente
		FROM  cliente c,  contratos co
		WHERE c.codcliente = co.codcliente
			AND co.status = 'D'
	)
GROUP BY c.codcliente, c.nomecliente, p.nomeplano
ORDER BY c.nomecliente

-- Consultar o nome do cliente, o nome do plano, a quantidade de estados de contrato (sem repetições) por contrato, 
-- dos planos não cancelados, ordenados pelo nome do cliente							
SELECT c.codcliente, c.nomecliente, p.nomeplano, COUNT(DISTINCT co.status) AS qtd_estados
FROM  cliente c,  contratos co, planos p
WHERE c.codcliente = co.codcliente
   AND p.codplano = co.codplano
   AND c.codcliente NOT IN (
		SELECT DISTINCT c.codcliente
		FROM  cliente c,  contratos co
		WHERE c.codcliente = co.codcliente
			AND co.status = 'D'
	)
GROUP BY c.codcliente, c.nomecliente, p.nomeplano
ORDER BY c.nomecliente

-- Consultar o nome do cliente, o nome do plano, e o valor da conta de cada contrato que está ou esteve ativo, 
-- sob as seguintes condições:										
	-- A conta é o valor do plano, somado à soma dos valores de todos os serviços									
	-- Caso a conta tenha valor superior a R$400.00, deverá ser incluído um desconto de 8%									
	-- Caso a conta tenha valor entre R$300,00 a R$400.00, deverá ser incluído um desconto de 5%									
	-- Caso a conta tenha valor entre R$200,00 a R$300.00, deverá ser incluído um desconto de 3%									
	-- Contas com valor inferiores a R$200,00 não tem desconto	
SELECT c.nomecliente, p.nomeplano, p.valorplano, SUM(s.valorservico) AS soma_servico, CAST((p.valorplano + SUM(s.valorservico)) AS DECIMAL(7,2)) as total ,
	CASE WHEN ((p.valorplano + SUM(s.valorservico)) > 400) 
	THEN
		CAST(((p.valorplano + SUM(s.valorservico)) * 0.92) AS DECIMAL(7,2)) 
	ELSE 
		CASE WHEN ((p.valorplano + SUM(s.valorservico)) > 300)
		THEN 
			CAST(((p.valorplano + SUM(s.valorservico)) * 0.95) AS DECIMAL(7,2)) 
		ELSE 
			CASE WHEN ((p.valorplano + SUM(s.valorservico)) > 200)
			THEN 
				CAST(((p.valorplano + SUM(s.valorservico)) * 0.97) AS DECIMAL(7,2)) 
			ELSE 
				CAST(p.valorplano + SUM(s.valorservico) AS DECIMAL(7,2)) 
			END 
		END 
	END AS valor_conta
FROM cliente c,  contratos co, planos p, servicos s
WHERE c.codcliente = co.codcliente
   AND p.codplano = co.codplano
   AND s.codservicos = co.codservico
   AND c.codcliente IN (
		SELECT DISTINCT c.codcliente
		FROM  cliente c,  contratos co
		WHERE c.codcliente = co.codcliente
			AND co.status = 'A'
	)
GROUP BY c.codcliente, c.nomecliente, p.codplano, p.nomeplano, p.valorplano
ORDER BY c.nomecliente
									
-- Consultar o nome do cliente, o nome do serviço, e a duração, em meses (até a data de hoje) do serviço, 
-- dos cliente que nunca cancelaram nenhum plano	
SELECT DISTINCT c.nomecliente, s.nomeservico, DATEDIFF(MONTH, co.data, GETDATE()) AS meses_de_servico
FROM  cliente c,  contratos co, planos p, servicos s
WHERE c.codcliente = co.codcliente
   AND p.codplano = co.codplano
   AND s.codservicos = co.codservico
   AND c.codcliente NOT IN (
		SELECT DISTINCT c.codcliente
		FROM  cliente c,  contratos co
		WHERE c.codcliente = co.codcliente
			AND co.status = 'D'
	)
GROUP BY c.codcliente, c.nomecliente, s.codservicos, s.nomeservico, co.data
ORDER BY c.nomecliente