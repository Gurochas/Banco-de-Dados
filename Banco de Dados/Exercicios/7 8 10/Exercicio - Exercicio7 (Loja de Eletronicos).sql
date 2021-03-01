CREATE DATABASE exercicio_7
GO
USE exercicio_7
 
CREATE TABLE cliente (
rg			VARCHAR(15),	
cpf			VARCHAR(15),
nome		VARCHAR(100),
endereco	VARCHAR(300)
PRIMARY KEY(rg)
)
GO
CREATE TABLE pedido(
nota_fiscal	INT,
valor		DECIMAL(7,2),
data		DATETIME,
rg_cliente	VARCHAR(15)
PRIMARY KEY (nota_fiscal)
FOREIGN KEY (rg_cliente) REFERENCES cliente(rg)
)
GO
CREATE TABLE fornecedor (
codigo		INT,
nome		VARCHAR(100),
endereco	VARCHAR(200),
telefone	VARCHAR(15),
cgc			VARCHAR(20),
cidade		VARCHAR(50),
transporte	VARCHAR(50),
pais		VARCHAR(10),
moeda		VARCHAR(10)
PRIMARY KEY (codigo)
)
GO
CREATE TABLE mercadoria (
codigo			INT, 
descricao		VARCHAR(100),
preco			DECIMAL(7,2),
qtd				INT, 
cod_fornecedor	INT 
PRIMARY KEY (codigo)
FOREIGN KEY (cod_fornecedor) REFERENCES fornecedor (codigo) 
)

INSERT INTO cliente (rg, cpf, nome, endereco) VALUES
('2.953.184-4', '345.198.780-40', 'Luiz André', 'R. Astorga, 500'),
('13.514.996-x', '849.842.856-30', 'Maria Luiza', 'R. Piauí, 174'),
('12.198.554-1', '233.549.973-10', 'Ana Barbara', 'Av. Jaceguai, 1141'),
('23.987.746-x', '435.876.699-20', 'Marcos Alberto', 'R. Quinze, 22')

INSERT INTO pedido (nota_fiscal, valor, data, rg_cliente) VALUES 
(1001, 754, '2018-04-01', '12.198.554-1'),
(1002, 350, '2018-04-02', '12.198.554-1'),
(1003, 30, '2018-04-02', '2.953.184-4'),
(1004, 1500, '2018-04-03', '13.514.996-x')

INSERT INTO fornecedor (codigo, nome, endereco, telefone, cgc, cidade, transporte, pais, moeda) VALUES
(1, 'Clone', 'Av. Nações Unidas, 12000', '(11)4148-7000', NULL, 'São Paulo', NULL, NULL, NULL), 
(2, 'Logitech', '28th Street, 100', '1-800-145990', NULL, NULL, 'Avião', 'EUA', 'US$'), 
(3, 'LG', 'Rod. Castello Branco', '0800-664400', '415997810/0001', 'Sorocaba', NULL, NULL, NULL), 
(4, 'PcChips', 'Ponte da Amizade', NULL, NULL, NULL, 'Navio', 'Py', 'US$')

INSERT INTO mercadoria (codigo, descricao, preco, qtd, cod_fornecedor) VALUES 
(10, 'Mouse', 24, 30, 1), 
(11, 'Teclado', 50, 20, 1), 
(12, 'Cx. De Som', 30, 8, 2), 
(13, 'Monitor 17', 350, 4, 3), 
(14, 'Notebook', 1500, 7, 4)


--Consultar 10% de desconto no pedido 1003	
SELECT CAST(valor*0.1 AS DECIMAL (7,2)) 
FROM pedido 
WHERE nota_fiscal = 1003
					
--Consultar 5% de desconto em pedidos com valor maior de R$700,00		
SELECT CAST(valor*0.05 AS DECIMAL (7,2))
FROM pedido 
WHERE valor > 700

--Consultar e atualizar aumento de 20% no valor de marcadorias com estoque menor de 10			
SELECT CAST(preco*0.20 AS DECIMAL (7,2))
FROM mercadoria
WHERE qtd < 10 

UPDATE mercadoria
SET preco = preco * 1.20
WHERE qtd < 10
						
--Data e valor dos pedidos do Luiz
SELECT data, valor 
FROM pedido 
WHERE rg_cliente IN (
	SELECT rg 
	FROM cliente
	WHERE nome LIKE 'Luiz%'
)
									
--CPF, Nome e endereço do cliente de nota 1004		
SELECT cpf, nome, endereco 
FROM cliente 
WHERE rg IN (
	SELECT rg_cliente 
	FROM pedido 
	WHERE nota_fiscal = 1004
)
				
--País e meio de transporte da Cx. De som	
SELECT pais, transporte
FROM fornecedor
WHERE codigo IN(
	SELECT cod_fornecedor 
	FROM mercadoria
	WHERE descricao = 'Cx. De som'				
)				

--Nome e Quantidade em estoque dos produtos fornecidos pela Clone	
SELECT descricao, qtd
FROM mercadoria
WHERE cod_fornecedor IN (
	SELECT codigo 
	FROM fornecedor
	WHERE nome = 'Clone'
)
								
--Endereço e telefone dos fornecedores do monitor	
SELECT endereco, telefone 
FROM fornecedor
WHERE codigo IN (
	SELECT cod_fornecedor	
	FROM mercadoria
	WHERE descricao LIKE 'Monitor%'
)
								
--Tipo de moeda que se compra o notebook	
SELECT moeda
FROM fornecedor
WHERE codigo IN (
	SELECT cod_fornecedor	
	FROM mercadoria
	WHERE descricao LIKE 'Notebook'
)
						
--Há quantos dias foram feitos os pedidos e,
--criar uma coluna que escreva: 'Pedido antigo' para pedidos feitos há mais de 6 meses				
SELECT DATEDIFF(DAY, data, GETDATE()) AS dias_pedido,
	CASE WHEN (DATEDIFF(MONTH, data, GETDATE()) > 6) 
		THEN 
			'Pedido antigo'
		END AS status_pedido
FROM pedido

--Nome e Quantos pedidos foram feitos por cada cliente	
SELECT DISTINCT c.nome
FROM cliente c, pedido p
WHERE c.rg = p.rg_cliente
ORDER BY c.nome
								
--RG,CPF,Nome e Endereço dos cliente cadastrados que Não Fizeram pedidos
SELECT c.rg, c.cpf, c.nome, c.endereco
FROM cliente c LEFT OUTER JOIN pedido p
ON c.rg = p.rg_cliente
WHERE p.rg_cliente IS NULL 