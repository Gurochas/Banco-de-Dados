CREATE DATABASE aula8 
GO 
USE aula8


-- Considere o seguinte cenário:

-- Produto
-- Código | Nome | Descrição | Valor Unitário
CREATE TABLE produto (
codigo INT PRIMARY KEY,
nome VARCHAR(100),
descricao VARCHAR(200),
valor_unitario DECIMAL(7,2)
)
INSERT produto VALUES (1, 'Havaiana do Star Wars', 'Ir para o lado negro da força não é desculpa para ter o pé preto!!!!', 39.99)
INSERT produto VALUES (2, 'Havaiana de Praia', 'Antes areia na estampa que no seu pé!', 39.99)
INSERT produto VALUES (3, 'Havaiana do Batman', 'Na dúvida entre o Batman e o superman, leva os dois em um par só!', 39.99)

-- Estoque
-- Codigo_Produto | Qtd_Estoque | Estoque_Minimo
CREATE TABLE estoque (
codigo_produto INT PRIMARY KEY,
qtd_estoque INT,
estoque_minimo INT
FOREIGN KEY (codigo_produto) REFERENCES produto(codigo)
)
INSERT estoque VALUES (1, 30, 5)
INSERT estoque VALUES (2, 10, 2)
INSERT estoque VALUES (3, 70, 80)

-- Venda
-- Nota_Fiscal | Codigo_Produto | Quantidade
CREATE TABLE venda (
nota_fiscal VARCHAR(100) PRIMARY KEY,
codigo_produto INT,
quantidade INT
FOREIGN KEY (codigo_produto) REFERENCES produto(codigo)
)


/* 
	Fazer uma TRIGGER AFTER na tabela Venda que:

	- Uma vez feito um INSERT, verifique se a quantidade está disponível em estoque. 
	  - Caso esteja, a venda se concretiza, 
	  - Caso contrário, a venda deverá ser cancelada e uma mensagem de erro deverá ser enviada.

	- A mesma TRIGGER deverá validar caso a venda se concretize:
	  - Se o estoque está abaixo do estoque mínimo determinado 
	  - Ou se após a venda, ficará abaixo do estoque considerado mínimo 
	  e deverá lançar um print na tela avisando das duas situações.
*/ 
GO
CREATE TRIGGER t_vendinha ON venda
AFTER INSERT
AS
BEGIN
	DECLARE @quantidade	INT, 
			@estoque INT,
			@estoque_min INT,
			@produto INT
	
	SET @quantidade = (SELECT quantidade FROM INSERTED)
	SET @produto = (SELECT codigo_produto FROM INSERTED)
	SET @estoque = (SELECT qtd_estoque FROM estoque WHERE codigo_produto = @produto)

	IF (@quantidade > @estoque)
	BEGIN 
		ROLLBACK TRANSACTION
		RAISERROR('Não tem havaianas suficientes no estoque, lamento', 16, 1)
	END 
	ELSE 
	BEGIN 
		
		UPDATE estoque 
		SET qtd_estoque = qtd_estoque - @quantidade
		WHERE @produto = codigo_produto

		SET @estoque_min = (SELECT estoque_minimo FROM estoque WHERE codigo_produto = @produto)
	
		
		IF ((@estoque - @quantidade) < @estoque_min)
		BEGIN 
			PRINT('O estoque atual está abaixo do estoque minimo')
		END 
		ELSE 
		BEGIN 
			IF (@estoque < @estoque_min)
			BEGIN 
				PRINT('O estoque após a venda está abaixo do estoque minimo')
			END 
		END 

	END 	
END 

-- Testes Trigger 
INSERT INTO venda VALUES ('231', 1, 35)
INSERT INTO venda VALUES ('132', 2, 9)
INSERT INTO venda VALUES ('321', 3, 15)

-- Fazer uma UDF (User Defined Function) Multi Statement Table, que apresente, para uma dada nota fiscal, a seguinte saída:
-- (Nota_Fiscal | Codigo_Produto | Nome_Produto | Descricao_Produto | Valor_Unitario | Quantidade | Valor_Total*)
-- * Considere que Valor_Total = Valor_Unitário * Quantidade
GO 
CREATE FUNCTION fn_gerarNotaFiscal(@nota_fiscal AS VARCHAR(100))
RETURNS @table TABLE (
nota_fiscal VARCHAR(100),
codigo_produto INT,
nome_produto VARCHAR(100),
descricao_produto VARCHAR(200),
valor_unitario DECIMAL(7,2),
quantidade INT,
valor_total DECIMAL(7,2)
)
AS
BEGIN
	INSERT INTO @table 
		SELECT v.nota_fiscal, v.codigo_produto, p.nome, p.descricao, p.valor_unitario, v.quantidade, (p.valor_unitario*v.quantidade)
		FROM produto p, venda v 
		WHERE p.codigo = v.codigo_produto
			AND v.nota_fiscal = @nota_fiscal

	RETURN 
END 
GO

SELECT * FROM fn_gerarNotaFiscal('132')