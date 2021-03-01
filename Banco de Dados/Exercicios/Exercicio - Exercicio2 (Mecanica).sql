CREATE DATABASE exercicio_2
GO 
USE exercicio_2

CREATE TABLE carro (
placa	CHAR(7)			NOT NULL,
marca	VARCHAR(50)		NOT NULL,
modelo	VARCHAR(50)		NOT NULL,
cor		VARCHAR(50)		NOT NULL,
ano		INT				NOT NULL
PRIMARY KEY(placa)
)
GO
CREATE TABLE peca (
codigo	INT				NOT NULL,
nome	VARCHAR(100)	NOT NULL,
valor	DECIMAL(7,2)	NOT NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE cliente (
nome		VARCHAR(200)	NOT NULL,
logradouro	VARCHAR(200)	NOT NULL,
numero		INT				NOT NULL,
bairro		VARCHAR(100)	NOT NULL,
telefone	CHAR(8)			NOT NULL,
carro		CHAR(7)			NOT NULL,
PRIMARY KEY(carro),
FOREIGN KEY (carro) REFERENCES carro(placa)
)
GO
CREATE TABLE servico (
carro			CHAR(7)			NOT NULL,
peca			INT				NOT NULL,
quantidade		INT				NOT NULL,
valor			DECIMAL(7,2)	NOT NULL,
data			DATETIME		NOT NULL
PRIMARY KEY (carro, peca, data),
FOREIGN KEY (carro) REFERENCES carro(placa),
FOREIGN KEY (peca) REFERENCES peca(codigo)
)

INSERT INTO carro (placa, marca, modelo, cor, ano) VALUES
('AFT9087', 'VW', 'Gol', 'Preto', 2007),
('DXO9876', 'Ford', 'Ka', 'Azul', 2000),
('EGT4631', 'Renault', 'Clio', 'Verde', 2004),
('LKM7380', 'Fiat', 'Palio', 'Prata', 1997),
('BCD7521', 'Ford', 'Fiesta', 'Preto', 1999)

INSERT INTO peca (codigo, nome, valor) VALUES
(1, 'Vela', 70),
(2, 'Correia Dentada', 125),
(3, 'Trambulador', 90),
(4, 'Filtro de Ar', 30)

INSERT INTO cliente (nome, logradouro, numero, bairro, telefone, carro) VALUES
('João Alves' ,'R. Pereira Barreto', 1258, 'Jd. Oliveiras', '21549658', 'DXO9876'),
('Ana Maria' ,'R. 7 de Setembro', 259, 'Centro', '96588541', 'LKM7380'),
('Clara Oliveira' ,'Av. Nações Unidas', 10254, 'Pinheiros', '24589658', 'EGT4631'),
('José Simões' ,'R. XV de Novembro', 36, 'Água Branca', '78952459', 'BCD7521'),
('Paula Rocha' ,'R. Anhaia', 548, 'Barra Funda', '69582548', 'AFT9087')

INSERT INTO servico (carro, peca, quantidade, valor, data) VALUES
('DXO9876', 1, 4, 280, '2020-08-01'),
('DXO9876', 4, 1, 30, '2020-08-01'),
('EGT4631', 3, 1, 90, '2020-08-02'),
('DXO9876', 2, 1, 125, '2020-08-07')

--Consultar em Subqueries					
--Telefone do dono do carro Ka, Azul
SELECT SUBSTRING (telefone, 1, 4) + '-' + SUBSTRING (telefone, 5, 4) AS Telefone
FROM cliente
WHERE carro IN (
	SELECT placa
	FROM carro 
	WHERE modelo = 'Ka' AND cor = 'Azul'
)
					
--Endereço concatenado do cliente que fez o serviço do dia 02/08/2020
SELECT logradouro + ', ' + CAST(numero AS VARCHAR(5)) + ' - ' + bairro 
FROM cliente
WHERE carro IN (
	SELECT carro 
	FROM servico
	WHERE data = '2020-08-02'
)		

--Consultar:				
--Placas dos carros de anos anteriores a 2001				
SELECT placa 
FROM carro
WHERE ano < 2001

--Marca, modelo e cor, concatenado dos carros posteriores a 2005	
SELECT marca + ' ' + modelo + ' ' + cor AS descricao_carro
FROM carro
WHERE ano > 2005

--Código e nome das peças que custam menos de R$80,00	
SELECT codigo, nome
FROM peca
WHERE valor < 80.00			