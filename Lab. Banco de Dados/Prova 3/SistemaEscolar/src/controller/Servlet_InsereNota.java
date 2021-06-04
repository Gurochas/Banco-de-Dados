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

import model.AlunoNota;
import model.Alunos;
import model.Notas;
import persistence.DAO_mostraNota;


@WebServlet("/registraNota")
public class Servlet_InsereNota extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Servlet_InsereNota() {
        super();
    }

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int tamanho = Integer.parseInt(request.getParameter("tamanho"));
		int jTamanho= Integer.parseInt(request.getParameter("jTamanho"));

		int k = 4000;
		int J = 2000;
		
		AlunoNota a = new AlunoNota();
		
		for(int i = 1; i< tamanho; i++){
			String ra  = request.getParameter(Integer.toString(i));
			
			a.setRa(ra);
			
			for (int x = 1;  x<=jTamanho; x++) {
				String codigo = request.getParameter(Integer.toString(J));	
				String nota = request.getParameter(Integer.toString(k));
				
				if ((ra != "" && codigo != "" && nota != "")) {

                    a.setCodigo_avaliacao(codigo);
                    a.setNota(nota);
 
                    
                    try {
                        DAO_mostraNota cDao = new DAO_mostraNota();
                        cDao.insereNotas(a);
                    } catch (ClassNotFoundException | SQLException e) {
                         e.getMessage();
                    }
                }
				
			J++;
			k++;
			}

		}
		
		RequestDispatcher r = request.getRequestDispatcher("insNota.jsp"); 
		r.forward( request, response );

		
	}	
	
}