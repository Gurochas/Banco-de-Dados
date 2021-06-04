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
import model.Notas;
import persistence.DAO_mostraNota;


@WebServlet("/insereNota")
public class Servlet_MostraCampoNota extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Servlet_MostraCampoNota() {
        super();
    }

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String materia  = request.getParameter("materias");
		ArrayList<Alunos> listaAlunos = new ArrayList<>();
		ArrayList<Notas> listaAvaliações = new ArrayList<>();
		
		
		try {
			DAO_mostraNota cDao = new DAO_mostraNota();
			listaAvaliações = cDao.listaProvas(materia);
		} catch (ClassNotFoundException | SQLException e1) {
			e1.printStackTrace();
		}
		
		try {
			DAO_mostraNota cDao = new DAO_mostraNota();
			listaAlunos= cDao.listaAlunos();	
		} catch (ClassNotFoundException | SQLException e) {
			 e.getMessage();
		} finally {
			request.setAttribute("aluno", listaAlunos);
			request.setAttribute("materia", listaAvaliações);
			request.getRequestDispatcher("/insNota.jsp").forward(request, response);
		}
		

		
	}	
	
}
