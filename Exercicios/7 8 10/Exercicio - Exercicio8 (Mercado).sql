CREATE DATABASE exercicio_8
GO
USE exercicio_8
 
CREATE TABLE cliente (
codigo 				INT,	
nome				VARCHAR(100),
endereco			VARCHAR(300),
telefone			CHAR(8),
telefone_comercial	CHAR(8)
PRIMARY KEY(codigo)
)
GO
CREATE TABLE tipo_mercadoria (
codigo			INT, 
nome			VARCHAR(100),
PRIMARY KEY (codigo)	
)
GO
CREATE TABLE corredor (
codigo			INT, 
tipo			INT,
nome			VARCHAR(100)
PRIMARY KEY (codigo)	
FOREIGN KEY (tipo) REFERENCES tipo_mercadoria(codigo),
)
GO
CREATE TABLE mercadoria (
codigo			INT, 
nome			VARCHAR(100),
corredor 		INT, 
tipo			INT,
valor			DECIMAL(7,2)
PRIMARY KEY (codigo)	
FOREIGN KEY (corredor) REFERENCES corredor (codigo),
FOREIGN KEY (tipo) REFERENCES tipo_mercadoria(codigo)
)
GO
CREATE TABLE compra (
nota_fiscal		INT, 
codigo_cliente  INT,
valor			DECIMAL(7,2)
PRIMARY KEY (nota_fiscal)	
FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo)
)

INSERT INTO cliente (codigo, nome, endereco, telefone, telefone_comercial) VALUES
(1, 'Luis Paulo', 'R. Xv de Novembro, 100', '45657878', NULL),
(2, 'Maria Fernanda', 'R. Anhaia, 1098', '27289098', '40040090'),
(3, 'Ana Claudia', 'Av. Voluntários da Pátria, 876', '21346548', NULL),
(4, 'Marcos Henrique', 'R. Pantojo, 76', '51425890', '30394540'),
(5, 'Emerson Souza', 'R. Pedro Álvares Cabral, 97', '44236545', '39389900'),
(6, 'Ricardo Santos', 'Trav. Hum, 10', '98789878', NULL)

INSERT INTO tipo_mercadoria (codigo, nome) VALUES
(10001, 'Pães'),
(10002, 'Frios'),
(10003, 'Bolacha'),
(10004, 'Clorados'),
(10005, 'Frutas'),
(10006, 'Esponjas'),
(10007, 'Massas'),
(10008, 'Molhos')

INSERT INTO corredor (codigo, tipo, nome) VALUES
(101, 10001, 'Padaria'),
(102, 10002, 'Calçados'),
(103, 10003, 'Biscoitos'),
(104, 10004, 'Limpeza'),
(105, NULL, NULL),
(106, NULL, NULL),
(107, 10007, 'Congelados')

INSERT INTO mercadoria (codigo, nome, corredor, tipo, valor) VALUES
(1001, 'Pão de Forma', 101, 10001, 3.5),
(1002, 'Presunto', 101, 10002, 2.0),
(1003, 'Cream Cracker', 103, 10003, 4.5),
(1004, 'Água Sanitária', 104, 10004, 6.5),
(1005, 'Maçã', 105, 10005, 0.9),
(1006, 'Palha de Aço', 106, 10006, 1.3),
(1007, 'Lasanha', 107, 10007, 9.7)

INSERT INTO compra (nota_fiscal, codigo_cliente, valor) VALUES
(1234, 2, 200),
(2345, 4, 156),
(3456, 6, 354),
(4567, 3, 19)

--Pede-se:		
--Valor da Compra de Luis Paulo		
SELECT valor
FROM compra 
WHERE codigo_cliente IN (
	SELECT codigo 
	FROM cliente
	WHERE nome = 'Luis Paulo'
)

--Valor da Compra de Marcos Henrique
SELECT valor
FROM compra 
WHERE codigo_cliente IN (
	SELECT codigo 
	FROM cliente
	WHERE nome = 'Marcos Henrique'
)		

--Endereço e telefone do comprador de Nota Fiscal = 4567		
SELECT endereco, telefone 
FROM cliente 
WHERE codigo IN (
	SELECT codigo_cliente 
	FROM compra
	WHERE nota_fiscal = 4567
)	

--Valor da mercadoria cadastrada do tipo " Pães"	
SELECT valor 
FROM mercadoria
WHERE tipo IN (
	SELECT codigo
	FROM tipo_mercadoria
	WHERE nome = 'Pães'
)

--Nome do corredor onde está a Lasanha
SELECT nome  
FROM corredor 
WHERE codigo IN (
	SELECT corredor 
	FROM mercadoria
	WHERE nome = 'Lasanha'
)		

--Nome do corredor onde estão os clorados		
SELECT nome  
FROM corredor 
WHERE tipo IN (
	SELECT codigo 
	FROM tipo_mercadoria
	WHERE nome = 'Clorados'
)