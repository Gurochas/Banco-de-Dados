CREATE DATABASE exercicio9
GO
USE exercicio9

CREATE TABLE estoque (
codigo		INT				NOT NULL,
nome		VARCHAR(150)	NOT NULL	UNIQUE,
quantidade	INT				NOT NULL,
valor		DECIMAL(7,2)	NOT NULL	CHECK(valor > 0),
cod_editora	INT				NOT NULL,
cod_autor	INT				NOT NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE editora (
codigo	INT				NOT NULL,
nome	VARCHAR(100)	NOT NULL,
site	VARCHAR(150)	NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE autor (
codigo		INT				NOT NULL,
nome		VARCHAR(200)	NOT NULL,
biografia	VARCHAR(300)	NOT NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE compras (
codigo			INT				NOT NULL,
cod_livro		INT				NOT NULL,
qtd_comprada	INT				NOT NULL	CHECK(qtd_comprada > 0),
valor			DECIMAL(7,2)	NOT NULL	CHECK(valor > 0),
data_compra		DATETIME		NOT NULL
PRIMARY KEY (codigo, cod_livro)
)

INSERT INTO estoque (codigo, nome, quantidade, valor, cod_editora, cod_autor) VALUES
(10001, 'Sistemas Operacionais Modernos', 4, 108.00, 1, 101), 
(10002, 'A Arte da Política', 2, 55.00, 2, 102), 
(10003, 'Calculo A', 12, 79.00, 3, 103), 
(10004, 'Fundamentos de Física I', 26, 68.00, 4, 104), 
(10005, 'Geometria Analítica', 1, 95.00, 3, 105), 
(10006, 'Gramática Reflexiva', 10, 49.00, 5, 106), 
(10007, 'Fundamentos de Física III', 1, 78.00, 4, 104), 
(10008, 'Calculo B', 3, 95.00, 3, 103)

INSERT INTO editora (codigo, nome, site) VALUES
(1, 'Pearson', 'www.pearson.com.br'),
(2, 'Civilização Brasileira', NULL),
(3, 'Makron Books', 'www.mbooks.com.br'),
(4, 'LTC', 'www.ltceditora.com.br'),
(5, 'Atual', 'www.atualeditora.com.br'),
(6, 'Moderna', 'www.moderna.com.br')


INSERT INTO autor (codigo, nome, biografia) VALUES
(101, 'Andrew Tannenbaun', 'Desenvolvedor do Minix'),
(102, 'Fernando Henrique Cardoso', 'Ex-Presidente do Brasil'),
(103, 'Diva Marília Flemming', 'Professora adjunta da UFSC'),
(104, 'David Halliday', 'Ph.D. da University of Pittsburgh'),
(105, 'Alfredo Steinbruch', 'Professor de Matemática da UFRS e da PUCRS'),
(106, 'Willian Roberto Cereja', 'Doutorado em Lingüística Aplicada e Estudos da Linguagem'),
(107, 'William Stallings', 'Doutorado em Ciências da Computacão pelo MIT'),
(108, 'Carlos Morimoto', 'Criador do Kurumin Linux')

INSERT INTO compras (codigo, cod_livro, qtd_comprada, valor, data_compra) VALUES 
(15051, 10003, 2, 158.00, '2020-07-04'),
(15051, 10008, 1, 95.00, '2020-07-04'),
(15051, 10004, 1, 68.00, '2020-07-04'),
(15051, 10007, 1, 78.00, '2020-07-04'),
(15052, 10006, 1, 49.00, '2020-07-05'),
(15052, 10002, 3, 165.00, '2020-07-05'),
(15053, 10001, 1, 108.00, '2020-07-05'),
(15054, 10003, 1, 79.00, '2020-07-06'),
(15054, 10008, 1, 95.00, '2020-07-06')

--Pede-se:												
--Consultar nome, valor unitário, nome da editora e nome do autor dos livros do estoque que foram vendidos.
--Não podem haver repetições.		
SELECT DISTINCT e.nome AS nome_livro, e.valor, ed.nome AS nome_editora, a.nome AS nome_autor
FROM estoque e, editora ed, autor a, compras c
WHERE e.cod_editora = ed.codigo
	AND e.cod_autor = a.codigo 
	AND c.cod_livro = e.codigo 
ORDER BY e.nome 

--Consultar nome do livro, quantidade comprada e valor de compra da compra 15051	
SELECT e.nome AS nome_livro, c.qtd_comprada, c.valor
FROM estoque e, compras c
WHERE c.cod_livro = e.codigo 
	AND c.codigo = 15051
ORDER BY e.nome 
									
--Consultar Nome do livro e site da editora dos livros da Makron books 
--(Caso o site tenha mais de 10 dígitos, remover o www.).				
SELECT e.nome, 
		CASE WHEN (LEN(ed.site) > 10) 
			THEN 
				SUBSTRING(ed.site, 5, LEN(ed.site))
			ELSE
				ed.site
			END AS site_editora
FROM estoque e, editora ed
WHERE e.cod_editora = ed.codigo
	AND ed.nome = 'Makron books' 
ORDER BY e.nome 			

--Consultar nome do livro e Breve Biografia do David Halliday
SELECT e.nome, a.biografia
FROM estoque e, editora ed, autor a
WHERE e.cod_editora = ed.codigo
	AND e.cod_autor = a.codigo
	AND a.nome = 'David Halliday'
							
--Consultar código de compra e quantidade comprada do livro Sistemas Operacionais Modernos	
SELECT c.codigo, c.qtd_comprada
FROM estoque e, compras c
WHERE c.cod_livro = e.codigo
	AND e.nome = 'Sistemas Operacionais Modernos' 
											
--Consultar quais livros não foram vendidos	
SELECT e.codigo, e.nome
FROM estoque e LEFT OUTER JOIN compras c
ON e.codigo = c.cod_livro
WHERE c.cod_livro IS NULL
											
--Consultar quais livros foram vendidos e não estão cadastrados		
SELECT c.codigo
FROM estoque e RIGHT OUTER JOIN compras c
ON e.codigo = c.cod_livro
WHERE e.codigo IS NULL
										
--Consultar Nome e site da editora que não tem Livros no estoque 
--(Caso o site tenha mais de 10 dígitos, remover o www.)		
SELECT ed.nome, 
		CASE WHEN (LEN(ed.site) > 10) 
			THEN 
				SUBSTRING(ed.site, 5, LEN(ed.site))
			ELSE
				ed.site
			END AS site_editora
FROM estoque e RIGHT OUTER JOIN editora ed
ON e.cod_editora = ed.codigo
WHERE e.cod_editora IS NULL
ORDER BY e.nome 										

--Consultar Nome e biografia do autor que não tem Livros no estoque 
--(Caso a biografia inicie com Doutorado, substituir por Ph.D.)		
SELECT a.nome,
		CASE WHEN (a.biografia LIKE 'Doutorado%') 
			THEN 
				'Ph.D.'
			ELSE
				a.biografia
			END AS biografia
FROM estoque e RIGHT OUTER JOIN autor a
ON e.cod_autor = a.codigo
WHERE e.cod_autor IS NULL									

--Consultar o nome do Autor, e o maior valor de Livro no estoque. Ordenar por valor descendente		
SELECT a.nome, MAX(e.quantidade) AS maior_estoque
FROM estoque e, autor a
WHERE e.cod_autor = a.codigo
GROUP BY a.codigo, a.nome
ORDER BY maior_estoque DESC
										
--Consultar o código da compra, o total de livros comprados e a soma dos valores gastos.
--Ordenar por Código da Compra ascendente.												
SELECT codigo, SUM(qtd_comprada) AS livros_comprados, SUM(valor) AS valor_total
FROM compras
GROUP BY codigo
ORDER BY codigo

--Consultar o nome da editora e a média de preços dos livros em estoque.
--Ordenar pela Média de Valores ascendente.												
SELECT ed.nome, CAST(AVG(e.valor) AS DECIMAL(7,2)) AS media_precos
FROM estoque e, editora ed
WHERE e.cod_editora = ed.codigo
GROUP BY ed.codigo, ed.nome
ORDER BY media_precos

/*
Consultar o nome do Livro, a quantidade em estoque o nome da editora, o site da editora 
(Caso o site tenha mais de 10 dígitos, remover o www.), 
Criar uma coluna status onde:												
	Caso tenha menos de 5 livros em estoque, escrever Produto em Ponto de Pedido											
	Caso tenha entre 5 e 10 livros em estoque, escrever Produto Acabando											
	Caso tenha mais de 10 livros em estoque, escrever Estoque Suficiente											
A Ordenação deve ser por Quantidade ascendente.
*/
SELECT e.nome, e.quantidade, ed.nome AS nome_editora, 
		CASE WHEN (LEN(ed.site) > 10) 
			THEN 
				SUBSTRING(ed.site, 5, LEN(ed.site))
			ELSE
				ed.site
			END AS site_editora,

		CASE WHEN (e.quantidade < 5)
			THEN
				'Produto em Ponto de Pedido'
			ELSE
				CASE WHEN (e.quantidade < 10)
				THEN
					'Produto Acabando'
				ELSE 
					'Estoque Suficiente'
				END 
		END AS status
FROM estoque e, editora ed
WHERE e.cod_editora = ed.codigo
ORDER BY e.quantidade ASC
											
--Para montar um relatório, é necessário montar uma consulta com a seguinte saída: 
--Código do Livro, Nome do Livro, Nome do Autor, Info Editora (Nome da Editora + Site) de todos os livros												
--Só pode concatenar sites que não são nulos
SELECT e.codigo, e.nome, a.nome, 
		CASE WHEN (ed.site IS NOT NULL)
		THEN  
			ed.nome + ' - ' + ed.site
		ELSE 
			ed.nome
		END AS info_editora
FROM estoque e, editora ed, autor a
WHERE e.cod_editora = ed.codigo
	AND e.cod_autor = a.codigo 
		
--Consultar Codigo da compra, quantos dias da compra até hoje e quantos meses da compra até hoje	
SELECT codigo, DATEDIFF(DAY, data_compra, GETDATE()) AS dif_dias,
		CASE WHEN (DAY(data_compra) > DAY(GETDATE()))
			THEN
				DATEDIFF(MONTH, data_compra, GETDATE()) - 1 
			ELSE
				DATEDIFF(MONTH, data_compra, GETDATE())
			END AS dif_meses
FROM compras
							
--Consultar o código da compra e a soma dos valores gastos das compras que somam mais de 200.00												
SELECT codigo, SUM(valor) AS soma_valores
FROM compras 
GROUP BY codigo 
HAVING SUM(valor) > 200