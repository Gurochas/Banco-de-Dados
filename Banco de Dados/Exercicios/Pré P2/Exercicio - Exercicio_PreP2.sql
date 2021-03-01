-- Criar uma database com a estrutura de tabelas conforme o diagrama

CREATE DATABASE exercicio_pre_p2
GO
USE exercicio_pre_p2

CREATE TABLE autores(
cod			INT				NOT NULL,
nome		VARCHAR(100)	NULL,
pais		VARCHAR(100)	NULL,
biografica	VARCHAR(300)	NULL 
PRIMARY KEY (cod)
)
GO
CREATE TABLE clientes (
cod			INT				NOT NULL,
nome		VARCHAR(100)	NULL,
logradouro	VARCHAR(200)	NULL,
numero		INT				NULL,
telefone char(9)			NULL
PRIMARY KEY (cod)
)
GO
CREATE TABLE corredores(
cod  INT			NOT NULL,
tipo VARCHAR(100)	NULL,
PRIMARY KEY (cod)
)
GO
CREATE TABLE livros (
cod				INT				NOT NULL,
cod_autor		INT				NOT NULL,
cod_corredores	INT				NOT NULL,
nome			VARCHAR(100)	NULL,
pag				INT				NULL,
idioma			VARCHAR(100)	NULL
PRIMARY KEY (cod)
FOREIGN KEY (cod_autor) REFERENCES autores(cod),
FOREIGN KEY (cod_corredores) REFERENCES corredores(cod)
)
GO
CREATE TABLE emprestimo( 
cod_cli		INT			NOT NULL,
data		DATETIME	NULL,
cod_livro	INT			NOT NULL
PRIMARY KEY(cod_cli,cod_livro)
FOREIGN KEY (cod_livro) REFERENCES livros(cod),
FOREIGN KEY (cod_cli) REFERENCES clientes(cod)
)

SELECT * FROM clientes 
SELECT * FROM autores
SELECT * FROM corredores
SELECT * FROM emprestimo
SELECT * FROM livros

-- Fazer os seguintes exercícios:
-- Fazer uma consulta que retorne o nome do cliente e a data do empréstimo formatada padrão BR (dd/mm/yyyy)
SELECT c.nome, CONVERT(CHAR(10), e.data, 103) AS data_emprestimo 
FROM clientes c, emprestimo e
WHERE c.cod = e.cod_cli

-- Fazer uma consulta que retorne Nome do autor e Quantos livros foram escritos por Cada autor, 
-- ordenado pelo número de livros. Se o nome do autor tiver mais de 25 caracteres, mostrar só os 13 primeiros.
SELECT 
	CASE WHEN (LEN(a.nome) > 25)
	THEN
		SUBSTRING(a.nome, 1, 13)
	ELSE
		a.nome
	END AS nome_autor,
	COUNT(l.cod) AS livros_escritos
FROM autores a, livros l
WHERE a.cod = l.cod_autor
GROUP BY a.cod, a.nome
ORDER BY livros_escritos

-- Fazer uma consulta que retorne o nome do autor e o país de origem do livro com maior número de páginas cadastrados no sistema
SELECT a.cod, a.nome, a.pais
FROM livros l, autores a 
WHERE l.cod_autor = a.cod
	AND l.pag IN (
		SELECT MAX(l.pag)
		FROM livros l
	)

-- Fazer uma consulta que retorne nome e endereço concatenado dos clientes que tem livros emprestados
SELECT DISTINCT c.nome, c.logradouro + ', nº ' + CAST(c.numero AS CHAR(5)) AS end_completo
FROM clientes c, emprestimo e
WHERE c.cod = e.cod_cli

/*
Nome dos Clientes, sem repetir e, concatenados como
enderço_telefone (o logradouro, o numero e o telefone) dos
clientes que Não pegaram livros. 
Se o logradouro e o número forem nulos e o telefone não for nulo, mostrar só o telefone. 
	Se o telefone for nulo e o logradouro e o número não forem nulos, mostrar só logradouro e número. 
	Se os três existirem, mostrar os três.
	O telefone deve estar mascarado XXXXX-XXXX
*/
SELECT DISTINCT c.nome, 
	CASE WHEN ( ( (c.logradouro IS NULL) AND (c.numero IS NULL) ) AND (c.telefone IS NOT NULL) ) 
	THEN 
		SUBSTRING(c.telefone, 1, 5) + '-' + SUBSTRING(c.telefone, 6, 9)
	ELSE
		CASE WHEN ( ( (c.logradouro IS NOT NULL) AND (c.numero IS NOT NULL) ) AND (c.telefone IS NULL) )
		THEN
			c.logradouro + ', nº ' + CAST(c.numero AS CHAR(5))
		ELSE 
			c.logradouro + ', nº ' + CAST(c.numero AS CHAR(5)) + ' - TEL: ' + SUBSTRING(c.telefone, 1, 5) + '-' + SUBSTRING(c.telefone, 6, 9)
		END 
	END AS endereco_telefone
FROM clientes c LEFT OUTER JOIN emprestimo e
ON c.cod = e.cod_cli
WHERE e.cod_cli IS NULL 


-- Fazer uma consulta que retorne Quantos livros não foram emprestados
SELECT COUNT (l.cod) AS livros_nao_emprestados
FROM livros l LEFT OUTER JOIN emprestimo e
ON l.cod = e.cod_livro
WHERE e.cod_livro IS NULL 

-- Fazer uma consulta que retorne Nome do Autor, Tipo do corredor e quantos livros, ordenados por quantidade de livro
SELECT a.nome, c.tipo, COUNT(l.cod) AS qtd_livros
FROM autores a, corredores c, livros l
WHERE a.cod = l.cod_autor
	AND l.cod_corredores = c.cod
GROUP BY c.cod, c.tipo, a.nome
ORDER BY qtd_livros

-- Considere que hoje é dia 18/05/2012, faça uma consulta que apresente o nome do cliente, o nome do livro, 
-- O total de dias que cada um está com o livro e,
-- Uma coluna que apresente:
	-- Caso o número de dias seja superior a 4, Apresente 'Atrasado', 
	-- Caso contrário, apresente 'No Prazo'
SELECT c.nome, l.nome, DATEDIFF(DAY, e.data, '2012-05-18') AS dias_emprestimo,
	CASE WHEN ((DATEDIFF(DAY, e.data, '2012-05-18')) > 4)
	THEN
		'Atrasado'
	ELSE 
		'No Prazo'
	END AS status_emprestimo
FROM clientes c, livros l, emprestimo e
WHERE c.cod = e.cod_cli
	AND e.cod_livro = l.cod
	AND e.data <=  '2012-05-18'

-- Fazer uma consulta que retorne cod de corredores, tipo de corredores e quantos livros tem em cada corredor
SELECT c.cod, c.tipo, COUNT(l.cod) AS qtd_livros
FROM corredores c, livros l
WHERE c.cod = l.cod_corredores
GROUP BY c.cod, c.tipo

-- Fazer uma consulta que retorne o Nome dos autores cuja quantidade de livros cadastrado é maior ou igual a 2.
SELECT a.nome
FROM autores a, livros l
WHERE a.cod = l.cod_autor
GROUP BY a.cod, a.nome
HAVING COUNT(l.cod) >= 2

-- Considere que hoje é dia 18/05/2012, faça uma consulta que apresente o nome do cliente, 
-- o nome do livro dos empréstimos que tem 7 dias ou mais
SELECT c.nome, l.nome
FROM clientes c, livros l, emprestimo e
WHERE c.cod = e.cod_cli
	AND e.cod_livro = l.cod
	AND e.data <=  '2012-05-18'
GROUP BY c.nome, l.nome, e.data
HAVING (DATEDIFF(DAY, e.data, '2012-05-18')) >= 7