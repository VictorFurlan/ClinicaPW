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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<title>App Alterar- PW</title>
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
		<div align="left">
			<label id="Operadora">Operadora:</label><input id="Operadora" name="Operadora" type="text" size="45">
		</div>
		<div align="left">
			<label id="CdArea">DDD:</label><input id="CdArea" name="CdArea" type="text" size="10"><label id="Telefone">Telefone:</label><input id="Telefone" name="Telefone" type="text" size="45">
		</div>
			<label id="id">ID:</label><input id="id" name="id" type="text" size="45">
		</div>
		<br>
		
		<div align="left">
			<button id="alterar_subimit" onclick="alterar();" value="alterar">Alterar</button>
			<button id="excluir_subimit" onclick="excluir();" value="excluir">Excluir</button>
			
		</div>
		<br>
	</form>
	<table border="1">
		<%Connection conn; %>
		<%conn = new ConnectionBanc().getConnection();%>
		<%String nome = session.getAttribute("name").toString();%>
		<%String sql = "select * from Pacientes";%>
		<%String sqlTel = "select * from Telefones";%>
		<%String sqlTelTipo = "select * from TiposDeTelefone";%>
		<%PreparedStatement stmt = null, stmtT = null, stmtTT = null;%>
		<%ResultSet rs = null, rsT = null, rsTT = null;%>
		<%stmt = conn.prepareStatement(sql);%>
		<%stmtTT = conn.prepareStatement(sqlTelTipo);%>
		<%stmtT = conn.prepareStatement(sqlTel);%>
		<%rs = stmt.executeQuery();%>
		<%rsT = stmtT.executeQuery();%>
		<%rsTT = stmtTT.executeQuery();%>
		<%Pessoa entidade = null;%>
		<tr>
			<th>ID</th>
			<th>Nome</th>
			<th>Senha</th>
			<th>CEP</th>
			<th>Numero</th>
			<th>Operadora</th>
			<th>Area</th>
			<th>Telefone</th>
			<th>Complemento</th>
		</tr>
			<%while(rs.next()){%>
				<%entidade = new Pessoa();%>
					<tr>
						<td><%=rs.getInt("ID")%></td>
						<td><%=rs.getString("Nome")%></td>
						<td><%=rs.getString("senha")%></td>
						<td><%=rs.getInt("CEP")%></td>
						<td><%=rs.getInt("Numero")%></td>
						<td><%=rsTT.getString("Operadora")%></td>
						<td><%=rsT.getInt("CdArea")%></td>
						<td><%=rsT.getInt("Telefone")%></td>
						<td><%=rs.getString("Complemento")%></td>
					</tr>
				<%rsT.next();
				rsTT.next(); %>
			<%}%>
	</table>
</body>
</html>