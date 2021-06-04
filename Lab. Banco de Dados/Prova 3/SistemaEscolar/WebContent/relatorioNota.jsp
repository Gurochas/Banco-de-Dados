<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<title> SIGA Bom</title>
</head>
<style>

</style>

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
          <a class="nav-link" id=grupo href="http://localhost:8080/SigaBom/index.jsp">Home</a>
        </li>
        
         <li class="nav-item">
          <a class="nav-link" href="http://localhost:8080/SigaBom/insNota.jsp">Insere Nota</a>
        </li>
        
   		<li class="nav-item">
        	<a class="nav-link" href="http://localhost:8080/SigaBom/insFalta.jsp">Insere Faltas</a>
        </li>
        
        <li class="nav-item">
        	<a class="nav-link" href="http://localhost:8080/SigaBom/relatorioFalta.jsp">Gera Relatorio Falta</a>
        </li>

        
      </ul>
      <span class="navbar-text">
        feito por: Lucas Guilherme e Gustavo Rocha
      </span>
    </div>
  </div>
</nav>

	<br><br>
	<!------------ Escolhe Materia ---------------->
	<center>
		<form action="relatorioNota" method="post" target="_blank">
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
	
</body>
</html>