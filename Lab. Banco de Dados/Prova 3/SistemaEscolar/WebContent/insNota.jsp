<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<title> SIGA Bom</title>
</head>


<body>
	<!------------ menu das coisa ---------------->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="http://localhost:8080/SigaBom/index.jsp">Bem Vindo ao Sistema de nota</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarText">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
      
        <li class="nav-item">
          <a class="nav-link" id=grupo href="http://localhost:8080/SigaBom/index.jsp"> Home</a>
        </li>
        
         <li class="nav-item">
          <a class="nav-link" href="http://localhost:8080/SigaBom/insFalta.jsp">Insere Faltas</a>
        </li>
        
   		<li class="nav-item">
        	<a class="nav-link" href="http://localhost:8080/SigaBom/relatorioFalta.jsp">Gera Relatorio Falta</a>
        </li>
        
        <li class="nav-item">
        	<a class="nav-link" href="http://localhost:8080/SigaBom/relatorioNota.jsp">Gera Relatorio Nota</a>
        </li>

        
      </ul>
      <span class="navbar-text">
        feito por: Lucas Guilherme e Gustavo Rocha (arruma os itens do menu)
      </span>
    </div>
  </div>
</nav>

	<br><br>
	<!------------Escolha da disciplina---------------->
	<center>
		<form action="insereNota" method="post">
			<select name="materias" id="materias">
	  			<option value="4203-010">Arquitetura e Organização de Computadores - tarde  </option>
	  			<option value="4203-020">Arquitetura e Organização de Computadores - noite  </option>
	  			<option value="4208-010">Laboratório de Hardware   </option>
	  			<option value="4226-004">Banco de Dados   </option>
	  			<option value="4213-003">Sistemas Operacionais I - tarde   </option>
	  			<option value="4213-013">Sistemas Operacionais I - noite   </option>
	  			<option value="4233-005">Laboratório de Banco de Dados   </option>
	  			<option value="4203-011">Métodos Para a Produção do Conhecimento   </option>
			</select>
			<input type="submit" name="enviar" id="enviar" value="Mostrar">
		</form>
	</center>

	<br><br>

	<div class="container-fluid">
	<form action="registraNota" method="post">	
		<table class="table table-striped" border=2>
		
		<c:set var ="contt" value="1" scope="page"> </c:set>
		
		<tr align="center"> 
			
			<c:forEach var="materia" items="${materia}">
				<c:if test="${contt == 1}">
					<td> nome </td>
				</c:if>
				
				<td> ${materia.getTipo()} </td>
				
				<c:set var="contt" value="${contt+1}" scope="page"/>
			</c:forEach>
			
				<c:if test="${contt > 1}">
					<td> exame </td>
				</c:if>
				
		</tr>

		
			<c:set var ="contA" value="1" scope="page"> </c:set>
			<c:set var ="contM" value="2000" scope="page"> </c:set>
			<c:set var ="contN" value="4000" scope="page"> </c:set>
			<c:set var ="contJ" value="1" scope="page"> </c:set>
			
			
						
			<c:forEach var="aluno" items="${aluno}">
				<input type="hidden" id="ra" name="${contA}" value="${aluno.getRa()}">
				
				<tr align = "center">
					<td>${aluno.getNome()}</td>		
				
					<c:set var ="contJ" value="1" scope="page"> </c:set>
					
					<c:forEach var="materia" items="${materia}">
						<input type="hidden" id="codigoAv" name="${contM}" value="${materia.getCodigo()}">
						<td><input type="number" id="materia" name="${contN}"></td>

						<c:set var="contM" value="${contM+1}" scope="page"/>
						<c:set var="contN" value="${contN+1}" scope="page"/>
						<c:set var="contJ" value="${contJ+1}" scope="page"/>
					</c:forEach>
					
					<input type="hidden" id="codigoAv" name="${contM}" value="125">
					<td><input type="number" id="materia" name="${contN}"></td>
					
				</tr>
				<c:set var="contM" value="${contM+1}" scope="page"/>
				<c:set var="contN" value="${contN+1}" scope="page"/>
				
					
				<c:set var="contA" value="${contA+1}" scope="page"/>	
			</c:forEach>
			
			<input type="hidden" id="ra" name="tamanho" value="${contA}">
			<input type="hidden" id="ra" name="jTamanho" value="${contJ}">
			
		</table>
		<br>
		<center><input type="submit" name="enviar" id="inviar" value="registrar"></center>
	</form>
	</div>

</body>
</html>
