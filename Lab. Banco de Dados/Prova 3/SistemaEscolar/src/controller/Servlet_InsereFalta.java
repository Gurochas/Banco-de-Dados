package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.AlunoFalta;
import model.Alunos;
import persistence.DAO_mostraFalta;
import persistence.DAO_mostraNota;



@WebServlet("/insereFalta")
public class Servlet_InsereFalta extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Servlet_InsereFalta() {
        super();
    }

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		int tamanho  = Integer.parseInt(request.getParameter("tamanho"));
		String dt  = request.getParameter("dt");
		String materia  = request.getParameter("aula");
		
		AlunoFalta af = new AlunoFalta();
		af.setDt(dt);
		af.setMateria(materia);
		
		for (int i= 1; i< tamanho; i++) {
	
			String ra = request.getParameter(Integer.toString(i));	
			String falta = request.getParameter(ra);
			
			af.setRa(ra);
			af.setFalta(falta);
			
            try {
                DAO_mostraFalta cDao = new DAO_mostraFalta();
                cDao.insereFalta(af);
            } catch (ClassNotFoundException | SQLException e) {
                 e.getMessage();
            }
	
	
		}
		
		RequestDispatcher r = request.getRequestDispatcher("insFalta.jsp" ); 
		r.forward( request, response );
		
	}	
	
}
