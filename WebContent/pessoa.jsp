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
		<div align="left">
			<label id="Operadora">Operadora:</label><input id="Operadora" name="Operadora" type="text" size="45">
		</div>
		<div align="left">
			<label id="CdArea">DDD:</label><input id="CdArea" name="CdArea" type="text" size="10"><label id="Telefone">Telefone:</label><input id="Telefone" name="Telefone" type="text" size="45">
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
		<%String sqlTel = "select * from Telefones";%>
		<%String sqlTipoTel = "select * from TiposDeTelefone";%>
		<%PreparedStatement stmt = null, stmtTel = null, stmtTipoTel = null;%>
		<%ResultSet rs = null, rsT = null, rsTT = null;%>
		<%stmt = conn.prepareStatement(sql);%>
		<%stmtTel = conn.prepareStatement(sqlTel);%>
		<%stmtTipoTel = conn.prepareStatement(sqlTipoTel);%>
		<%rs = stmt.executeQuery();%>
		<%rsT = stmtTel.executeQuery();%>
		<%rsTT = stmtTipoTel.executeQuery();%>
		<%Pessoa entidade = null;%>
		<tr>
			<th>ID</th>
			<th>Nome</th>
			<th>CEP</th>
			<th>Numero</th>
			<th>Operadora</th>
			<th>DDD</th>
			<th>Telefone</th>
			<th>Complemento</th>
		</tr>
			<%while(rs.next()&&rsT.next()&&rsTT.next()){%>
				<%entidade = new Pessoa();%>
				<%if (rs.getInt("Disable")==1){%>
				<%rs.next();}%>
					<tr>
						<td><%=rs.getLong("id")%></td>
						<td><%=rs.getString("Nome")%></td>
						<td><%=rs.getInt("CEP")%></td>
						<td><%=rs.getInt("Numero")%></td>
						<%if(rsTT.getString("Nome")!=null)%>
						<td><%=rsTT.getString("Nome")%></td>
						<%if(rsT.getInt("Area")!=0)%>
						<td><%=rsT.getInt("Area")%></td>
						<%if(rsT.getInt("Numero")!=0)%>
						<td><%=rsT.getInt("Numero")%></td>
						<td><%=rs.getString("Complemento")%></td>
					</tr>
			<%}%>
	</table>
</body>
</html>