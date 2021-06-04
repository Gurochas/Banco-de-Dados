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
body {
    background-color:#DCDCDC; 
}
</style>

<body>
	<!------------ menu das coisa ---------------->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Bem Vindo ao Sistema de nota</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarText">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
      
        <li class="nav-item">
          <a class="nav-link" id=grupo href="http://localhost:8080/SigaBom/insNota.jsp">Insere Notas</a>
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
        feito por: Lucas Guilherme e Gustavo Rocha
      </span>
    </div>
  </div>
</nav>

	<br><br><br><br><br>
	<!------------ botos Principais---------------->
	
</body>
</html>