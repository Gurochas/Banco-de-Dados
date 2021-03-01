CREATE DATABASE exercicio_10
GO	
USE exercicio_10

CREATE TABLE medicamento (
codigo				INT, 
nome				VARCHAR(200),
apresentacao		VARCHAR(100),
unidade_cadastro	VARCHAR(100),
preco_proposto		DECIMAL(7,3)
PRIMARY KEY (codigo)
)
GO
CREATE TABLE cliente (
cpf			CHAR(12),
nome		VARCHAR(100),
rua			VARCHAR(100),
numero		INT,
bairro		VARCHAR(100),
telefone	CHAR(8)
PRIMARY KEY (cpf)
)
GO
CREATE TABLE venda (
nota_fiscal			CHAR(12),
cpf_cliente			CHAR(12),
codigo_medicamento	INT,
quantidade			INT, 
valor_total			DECIMAL(7,2),
data				DATETIME
PRIMARY KEY (nota_fiscal, cpf_cliente, codigo_medicamento)
FOREIGN KEY (cpf_cliente) REFERENCES cliente (cpf),
FOREIGN KEY (codigo_medicamento) REFERENCES medicamento (codigo)
)

INSERT INTO medicamento (codigo, nome, apresentacao, unidade_cadastro, preco_proposto) VALUES 
(1, 'Acetato de medroxiprogesterona', '150 mg/ml', 'Ampola', 6.700),
(2, 'Aciclovir', '200mg/comp.', 'Comprimido', 0.280),
(3, 'Ácido Acetilsalicílico', '500mg/comp.', 'Comprimido', 0.035),
(4, 'Ácido Acetilsalicílico', '100mg/comp.', 'Comprimido', 0.030),
(5, 'Ácido Fólico', '5mg/comp.', 'Comprimido', 0.054),
(6, 'Albendazol', '400mg/comp. mastigável', 'Comprimido', 0.560),
(7, 'Alopurinol', '100mg/comp.', 'Comprimido', 0.080),
(8, 'Amiodarona', '200mg/comp.', 'Comprimido', 0.200),
(9, 'Amitriptilina(Cloridrato)', '25mg/comp.', 'Comprimido', 0.220),
(10, 'Amoxicilina', '500mg/cáps.', 'Cápsula', 0.190)

INSERT INTO cliente (cpf, nome, rua, numero, bairro, telefone) VALUES
('343908987-00', 'Maria Zélia', 'Anhaia', 65, 'Barra Funda', '92103762'),
('213459862-90', 'Roseli Silva', 'Xv. De Novembro', 987, 'Centro', '82198763'),
('869279818-25', 'Carlos Campos', 'Voluntários da Pátria', 1276, 'Santana', '98172361'),
('310981209-00', 'João Perdizes', 'Carlos de Campos', 90, 'Pari', '61982371')

INSERT INTO venda (nota_fiscal, cpf_cliente, codigo_medicamento, quantidade, valor_total, data) VALUES
('31501', '869279818-25', 10, 3, 0.57, '2010-11-01'),
('31501', '869279818-25', 2, 10, 2.8, '2010-11-01'),
('31501', '869279818-25', 5, 30, 1.05, '2010-11-01'),
('31501', '869279818-25', 8, 30, 6.6, '2010-11-01'),
('31502', '343908987-00', 8, 15, 3, '2010-11-01'),
('31502', '343908987-00', 5, 10, 2.8, '2010-11-01'),
('31502', '343908987-00', 9, 10, 2.2, '2010-11-01'),
('31503', '310981209-00', 1, 20, 134, '2010-11-02')

--Consultar																						
--Nome, apresentação, unidade e valor unitário dos remédios que ainda não foram vendidos. 
--Caso a unidade de cadastro seja comprimido, mostrar Comp.		
SELECT m.nome, m.apresentacao, 
	CASE WHEN (m.unidade_cadastro = 'Comprimido') 
		THEN 
			'Comp.'
		END AS unidade_cadastro, m.preco_proposto
FROM medicamento m LEFT OUTER JOIN venda v 
ON m.codigo = v.codigo_medicamento
WHERE v.codigo_medicamento IS NULL							


--Nome dos clientes que compraram Amiodarona		
SELECT c.nome
FROM medicamento m, venda v, cliente c
WHERE m.codigo = v.codigo_medicamento
	AND v.cpf_cliente = c.cpf
	AND m.nome = 'Amiodarona'


--CPF do cliente, endereço concatenado, nome do medicamento (como nome de remédio),  
--apresentação do remédio, unidade, preço proposto, 
--quantidade vendida e valor total dos remédios vendidos a Maria Zélia		
SELECT cpf_cliente, 
		c.rua + ', ' + CAST(c.numero AS VARCHAR(5)) + ' - ' + c.bairro AS endereco, 
		m.nome AS nome_remedio, m.apresentacao, m.unidade_cadastro, m.preco_proposto,
		v.quantidade, v.valor_total 
FROM medicamento m, venda v, cliente c
WHERE m.codigo = v.codigo_medicamento
	AND v.cpf_cliente = c.cpf
	AND c.nome = 'Maria Zélia'								


--Data de compra, convertida, de Carlos Campos	
SELECT CONVERT(VARCHAR(10), v.data, 103) AS data_compra
FROM venda v, cliente c
WHERE v.cpf_cliente = c.cpf
	AND c.nome = 'Carlos Campos'
											
												
--Alterar o nome da  Amitriptilina(Cloridrato) para Cloridrato de Amitriptilina											
UPDATE medicamento
SET nome = 'Cloridrato de Amitriptilina'
WHERE nome = 'Amitriptilina(Cloridrato)'