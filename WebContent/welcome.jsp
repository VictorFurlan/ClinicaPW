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
		<%Connection conn; %>
		<%conn = new ConnectionBanc().getConnection();%>
		<%String nome = session.getAttribute("name").toString();%>
		<%String sql = "select * from Pacientes";%>
		<%String sqlMed = "select * from Funcionarios where Cargo = 1 ";%>
		<%String sqlEsp = "select * from Cargos";%>
		<%String sqlTel = "select * from Telefones";%>
		<%String sqlTelTipo = "select * from TiposDeTelefone";%>
		<%PreparedStatement stmt = null, stmtT = null, stmtTT = null, stmtMed = null, stmtEsp = null;%>
		<%ResultSet rs = null, rsT = null, rsTT = null, rsMed = null, rsEsp = null;%>
		<%stmt = conn.prepareStatement(sql);%>
		<%stmtMed = conn.prepareStatement(sqlMed);%>
		<%stmtEsp = conn.prepareStatement(sqlEsp);%>
		<%stmtTT = conn.prepareStatement(sqlTelTipo);%>
		<%stmtT = conn.prepareStatement(sqlTel);%>
		<%rs = stmt.executeQuery();%>
		<%rsMed = stmtMed.executeQuery();%>
		<%rsEsp = stmtEsp.executeQuery();%>
		<%rsT = stmtT.executeQuery();%>
		<%rsTT = stmtTT.executeQuery();%>
		<%Pessoa entidade = null;%>
    <h3>Login successful!!!</h3>  
    <h4>  
        Hello,  
        <%=session.getAttribute("name")%></h4>
        <h3>Agende sua consulta:</h3>
        <h4>Médicos Disponíveis:</h4>
        <table border="1">
        	<tr>
				<th>Medico</th>
				<th>Especialidade</th>
        	</tr>
        	<%while(rsMed.next()){%>
        	<%rsEsp.next();%>
			<tr>
				<td><%=rsMed.getString("Nome")%></td>
				<td><%=rsEsp.getString("Nome")%></td>
			</tr>
			<%}%>
		</table><br>
		<form action="Agendar" method="post">
			<div align="left">
				<label id="medico">Médico:</label><input id="medico" name="medico" type="text" size="30">
			</div>
			<div align="left">
				<label id="data">Dia:</label><input id="data" name="data" type="date" size="20">
			</div>
			<div align="left">
				<label id="hora">Horario:</label><input id="hora" name="hora" type="time" size="20">
			</div>
			<div align="left">
					<input type="submit" value="Verificar/Agendar">
			</div><br>
		</form>
		
		
       <form action="pessoa" method="post">
		<input type="hidden" id="action" name="action" value="" />
		<div align="left">
			<label id="nome">Nome:</label><input id="nome" name="nome" type="text" size="45">
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
		<div align="left">
			<label id="id">ID:</label><input id="id" name="id" type="text" size="5">
		</div>
		<br>
		
		<div align="left">
			<button id="alterar_subimit" onclick="alterar();" value="alterar">Alterar</button>
			<button id="excluir_subimit" onclick="excluir();" value="excluir">Excluir Conta</button>
			
		</div><br>
	</form>
	<table border="1">
		<tr>
			<th>ID</th>
			<th>Nome</th>
			<th>CEP</th>
			<th>Numero</th>
			<th>Operadora</th>
			<th>Area</th>
			<th>Telefone</th>
			<th>Complemento</th>
		</tr>
			<%while(rs.next()&&rsT.next()&&rsTT.next()){%>
				<%entidade = new Pessoa();%>
				<%if(rs.getString("Nome").equals(nome)){%>
					<tr>
						<td><%=rs.getInt("ID")%></td>
						<td><%=rs.getString("Nome")%></td>
						<td><%=rs.getInt("CEP")%></td>
						<td><%=rs.getInt("Numero")%></td>
						<td><%=rsTT.getString("Nome")%></td>
						<td><%=rsT.getInt("Area")%></td>
						<td><%=rsT.getInt("Numero")%></td>
						<td><%=rs.getString("Complemento")%></td>
					</tr>
					<%}%>
			<%}%>
	</table>
</body>
</html>