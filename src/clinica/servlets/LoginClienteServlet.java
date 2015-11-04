package clinica.servlets;

import java.io.IOException;

import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import clinica.dao.PessoaDao;;

@WebServlet("/LoginClienteServlet")
public class LoginClienteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		String n=request.getParameter("username");
		String p=request.getParameter("userpass");
		
		HttpSession session = request.getSession(false);
		if(session!=null)
			session.setAttribute("name", n);
		try {
			if(PessoaDao.validate(n,p)){
				RequestDispatcher rd=request.getRequestDispatcher("welcome.jsp");
				rd.forward(request, response);
			}
			else{
				out.println("<p style=\"color:red\"> Desculpe usuario ou senha incorreto</p>");
				RequestDispatcher rd=request.getRequestDispatcher("loginCliente.jsp");
				rd.include(request, response);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		out.close();
	}
}
