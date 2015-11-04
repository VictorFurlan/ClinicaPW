<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import= "java.sql.PreparedStatement"%>
<%@ page import=  "java.sql.ResultSet" %>
<%@ page import=  "java.sql.Connection" %>
<%@ page import=  "java.sql.SQLException" %>
<%@ page import=   "clinica.modelo.Pessoa" %>
<%@ page import=   "clinica.connection.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript">
	function gravar(){
		document.getElementById("action").value="gravar";
	}
</script>
<head>
<title>App Cadastro - PW</title>
</head>

<body>
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
		<br>
		
		<div align="left">
			<button id="gravar_subimit" onclick="gravar();" value="gravar">Gravar</button>
		</div>
		<br>
	</form>
	
	<table border="1">
		<%Connection conn; %>
		<%conn = new ConnectionBanc().getConnection();%>
		<%String sql = "select * from Pacientes";%>
		<%PreparedStatement stmt = null;%>
		<%ResultSet rs = null;%>
		<%stmt = conn.prepareStatement(sql);%>
		<%rs = stmt.executeQuery();%>
		<%Pessoa entidade = null;%>
		<tr>
			<th>ID</th>
			<th>Nome</th>
			<th>CEP</th>
			<th>Numero</th>
			<th>Complemento</th>
		</tr>
			<%while(rs.next()){%>
				<%entidade = new Pessoa();%>
					<tr>
						<td><%=rs.getLong("id")%></td>
						<td><%=rs.getString("Nome")%></td>
						<td><%=rs.getInt("CEP")%></td>
						<td><%=rs.getInt("Numero")%></td>
						<td><%=rs.getString("Complemento")%></td>
					</tr>
			<%}%>
	</table>
</body>
</html>