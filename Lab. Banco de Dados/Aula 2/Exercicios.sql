-- Fazer um algoritmo que calcule a tabuada de um dado número
declare @numero as int 
declare @count as int 
declare @resultado as int 
set @numero = 9
set @count = 0 

while @count <= 10
begin 
	set @resultado = @numero * @count 
	print (convert (char(2), @numero) + ' x ' + convert (char(2), @count) + ' = ' + convert (char(2), @resultado))
	set @count = @count  + 1  
end 


/*Fazer um algoritmo que leia 3 valores e retorne se os valores formam um triângulo e se ele é
isóceles, escaleno ou equilátero.
Condições para formar um triângulo
	Nenhum valor pode ser = 0
	Um lado não pode ser maior que a soma dos outros 2.
*/
declare @lado1 as int 
declare @lado2 as int 
declare @lado3 as int 

if ((@lado1 = 0) or (@lado2 = 0) or (@lado3 = 0))
begin 
	print ('Nenhuma valor pode ser igual a zero') 
end 
else 
begin 
	if ((@lado1 > @lado2 + @lado3) OR (@lado2 > @lado1 + @lado3) OR (@lado3 = @lado2 + @lado1))
		begin 
			print 'Não é um triangulo'
		end 
		else 
		begin
			if (@lado1 != @lado2 AND @lado1 != @lado3 AND @lado3 != @lado2)
			begin
				print 'Triangulo Escaleno'
			end 
			else 
			begin
				if (@lado1 = @lado2 AND @lado1 = @lado3)
				begin 
					print 'Triangulo Equilatero'
				end 
				else 
					print 'Triangulo Isoceles'
				end 
		end 
end 





 -- Fazer um algoritmo que leia 1 número e mostre se são múltiplos de 2,3,5 ou nenhum deles

 -- Fazer um algoritmo que leia 3 número e mostre o maior e o menor
/*
Fazer um algoritmo que calcule os 15 primeiros termos da série
1,1,2,3,5,8,13,21,...
E calcule a soma dos 15 termos
*/


-- Fazer um algorimto que separa uma frase, colocando todas as letras em maiúsculo e em minúsculo


-- Fazer um algoritmo que inverta uma palavra


-- Verificar palindromo