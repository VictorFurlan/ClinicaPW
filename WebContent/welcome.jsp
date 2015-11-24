<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import= "java.sql.PreparedStatement"%>
<%@ page import=  "java.sql.ResultSet" %>
<%@ page import=  "java.sql.Connection" %>
<%@ page import=  "java.sql.SQLException" %>
<%@ page import=   "clinica.modelo.Pessoa" %>
<%@ page import=   "clinica.dao.PessoaDao" %>
<%@ page import=   "clinica.connection.*" %>
<html>  
<script type="text/javascript">
	function alterar(){
		document.getElementById("action").value="alterar";
	}
	function excluir(){
		document.getElementById("action").value="excluir";
	}
</script>
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<title>Welcome Stranger<%=session.getAttribute("name")%></title>  
</head>  
<body>  
    <h3>Login successful!!!</h3>  
    <h4>  
        Hello,  
        <%=session.getAttribute("name")%></h4>
       
       <form action="pessoa" method="post">
		<input type="hidden" id="action" name="action" value="" />
		<div align="left">
			<label id="nome">Nome:</label><input id="nome" name="nome" type="text" size="45">
		</div>
		<div align="left">
			<label id="senha">Senha:</label><input id="senha" name="senha" type="password" size="45">
		</div>
		<div align="left">
			<label id="CEP">CEP:</label><input id="CEP" name="CEP" type="text" size="45">
		</div>
		<div align="left">
			<label id="Numero">Numero:</label><input id="Numero" name="Numero" type="text" size="45">
		</div>
		<div align="left">
			<label id="complemento">Complemento:</label><input id="complemento" name="complemento" type="text" size="45">
		</div>
		<div align="left">
			<label id="id">ID:</label><input id="id" name="id" type="text" size="45">
		</div>
		<br>
		
		<div align="left">
			<button id="alterar_subimit" onclick="alterar();" value="alterar">Alterar</button>
			<button id="excluir_subimit" onclick="excluir();" value="excluir">Excluir Conta</button>
			
		</div><br>
	</form>
	<table border="1">
		<%Connection conn; %>
		<%conn = new ConnectionBanc().getConnection();%>
		<%String nome = session.getAttribute("name").toString();%>
		<%String sql = "select * from Pacientes";%>
		<%PreparedStatement stmt = null;%>
		<%ResultSet rs = null;%>
		<%stmt = conn.prepareStatement(sql);%>
		<%rs = stmt.executeQuery();%>
		<%Pessoa entidade = null;%>
		<tr>
			<th>Nome</th>
			<th>Senha</th>
			<th>CEP</th>
			<th>Numero</th>
			<th>Complemento</th>
		</tr>
			<%while(rs.next()){%>
				<%entidade = new Pessoa();%>
				<%if(rs.getString("Nome").equals(nome)){%>
					<tr>
						<td><%=rs.getString("Nome")%></td>
						<td><%=rs.getString("senha")%></td>
						<td><%=rs.getInt("CEP")%></td>
						<td><%=rs.getInt("Numero")%></td>
						<td><%=rs.getString("Complemento")%></td>
					</tr>
					<%}%>
			<%}%>
	</table>
</body>
</html>