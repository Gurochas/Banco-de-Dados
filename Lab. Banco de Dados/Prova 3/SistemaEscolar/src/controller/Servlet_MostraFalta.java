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

import model.Alunos;
import persistence.DAO_mostraFalta;
import persistence.DAO_mostraNota;



@WebServlet("/mostraFalta")
public class Servlet_MostraFalta extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Servlet_MostraFalta() {
        super();
    }

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String materia  = request.getParameter("materias");
		String dt  = request.getParameter("data");
		ArrayList<Alunos> listaAlunos = new ArrayList<>();
		int aula = 0;
		
		try {
			DAO_mostraFalta cDao = new DAO_mostraFalta();
			aula = cDao.qntAulas(materia);
		} catch (ClassNotFoundException | SQLException e1) {
			e1.printStackTrace();
		}
		
		try {
			DAO_mostraFalta cDao = new DAO_mostraFalta();
			listaAlunos= cDao.listaAlunos();	
		} catch (ClassNotFoundException | SQLException e) {
			 e.getMessage();
		} finally {
			request.setAttribute("aluno", listaAlunos);
			request.setAttribute("data", dt);
			request.setAttribute("materia", materia);
			request.setAttribute("aulas", (aula/20));
			request.getRequestDispatcher("/insFalta.jsp").forward(request, response);
		}
		

		
	}	
	
}
