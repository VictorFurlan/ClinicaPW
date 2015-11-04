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

import clinica.dao.PessoaDao;
import clinica.modelo.Pessoa;

@WebServlet("/pessoa")
public class PessoaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// busca writer
		@SuppressWarnings("unused")
		PrintWriter out = response.getWriter();
		
		PessoaDao dao = new PessoaDao();
		
		String action = request.getParameter("action");
		
		if(action != null && action.equals("gravar")){
		//buscando parametros do request
			Integer id = 0;
			
			if(request.getParameter("id") != null && !request.getParameter("id").equals("")){
				id = Integer.parseInt(request.getParameter("id"));
			}
			
			String nome = request.getParameter("nome");
			String senha = request.getParameter("senha");
			int CEP = Integer.parseInt(request.getParameter("CEP"));
			int Numero = Integer.parseInt(request.getParameter("Numero"));
			String complemento = request.getParameter("complemento");
			
			Pessoa pessoa = new Pessoa();
			pessoa.setNome(nome);
			pessoa.setSenha(senha);
			pessoa.setCEP(CEP);
			pessoa.setNumero(Numero);
			pessoa.setComplemento(complemento);
			
			try{
				if(id != null && id > 0){
					pessoa.setId(new Long(id));
					dao.altera(pessoa);
				}else{
					dao.adiciona(pessoa);
				}
				RequestDispatcher dispatcher = request.getRequestDispatcher("pessoa.jsp");
				dispatcher.forward(request, response);
			}catch(SQLException e){
				e.printStackTrace();
				
			}
		}else if(action != null && action.equals("excluir")){
			Integer id = 0;
			
			if(request.getParameter("id") != null && !request.getParameter("id").equals("")){
				id = Integer.parseInt(request.getParameter("id"));
			}
			Pessoa pessoa = new Pessoa();
			
			pessoa.setId(new Long(id));
			
			try{
				dao.deleta(pessoa);
				RequestDispatcher dispatcher = request.getRequestDispatcher("pessoa.jsp");
				dispatcher.forward(request, response);
			}catch(SQLException e){
				e.printStackTrace();
				
			}
		}else if(action != null && action.equals("alterar")){
			
			Integer id = 0;
			
			
			
			String nome = request.getParameter("nome");
			String senha = request.getParameter("senha");
			int CEP = Integer.parseInt(request.getParameter("CEP"));
			int Numero = Integer.parseInt(request.getParameter("Numero"));
			String complemento = request.getParameter("complemento");
			if(request.getParameter("id") != null && !request.getParameter("id").equals("")){
				id = Integer.parseInt(request.getParameter("id"));
			}
			
			Pessoa pessoa = new Pessoa();
			pessoa.setNome(nome);
			pessoa.setSenha(senha);
			pessoa.setCEP(CEP);
			pessoa.setNumero(Numero);
			pessoa.setComplemento(complemento);
			
			try{
				if(id != null && id > 0){
					pessoa.setId(new Long(id));
					dao.altera(pessoa);
				}
				RequestDispatcher dispatcher = request.getRequestDispatcher("Altera.jsp");
				dispatcher.forward(request, response);
			}catch(SQLException e){
				e.printStackTrace();
				
			}
		}
	}
}
