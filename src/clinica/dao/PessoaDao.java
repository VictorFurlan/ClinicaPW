package clinica.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JOptionPane;

import clinica.connection.*;
import clinica.inter.DAO;
import clinica.modelo.Pessoa;

public class PessoaDao implements DAO<Pessoa>{
	private static Connection conn;
	
	public PessoaDao(){
		PessoaDao.conn = new ConnectionBanc().getConnection();
	}

	@Override
	public void adiciona(Pessoa entidade) throws SQLException {
		String sql = "insert into Pacientes (Nome,Senha,CEP,Numero,Complemento)values(?,?,?,?,?)";
		String sqlTel = "insert into Telefones (Area,Numero)values(?,?)";
		String sqlTelTipo = "insert into TiposDeTelefone (Nome)values(?)";
		
		PreparedStatement stmt = null;
		PreparedStatement stmtTel = null;
		PreparedStatement stmtTelTipo = null;
		try{
			stmt = conn.prepareStatement(sql);
			stmtTel = conn.prepareStatement(sqlTel);
			stmtTelTipo = conn.prepareStatement(sqlTelTipo);
			
			stmt.setString(1, entidade.getNome());
			stmt.setString(2, entidade.getSenha());
			stmt.setInt(3, entidade.getCEP());
			stmt.setInt(4, entidade.getNumero());
			stmt.setString(5, entidade.getComplemento());
			
			stmtTel.setInt(1, entidade.getCdArea());
			stmtTel.setInt(2, entidade.getTelefone());
			
			stmtTelTipo.setString(1, entidade.getOperadora());
			
			stmt.executeUpdate();
			stmtTel.executeUpdate();
			stmtTelTipo.executeUpdate();
		}catch(SQLException e){
			throw new RuntimeException(e);
		}finally{
			stmt.close();
			stmtTel.close();
			stmtTelTipo.close();
			conn.close();
		}
	}

	@Override
	public void altera(Pessoa entidade) throws SQLException {
		String sql = "update Pacientes set ";
		String sqlTel = "update Telefones set ";
		String sqlTelTipo = "update TiposDeTelefone set ";
		int flag = 0;
		
		if(entidade.getNome() != null && !entidade.getNome().equals("")){
			sql = sql + "Nome=?";
			flag = 1;
		}
		if(entidade.getSenha() != null && !entidade.getSenha().equals("")){
			if(flag==1)
				sql = sql + ",";
			
			sql = sql + "senha=?";
			flag=1;
		}
		if(entidade.getCEP() >0){
			if(flag==1)
				sql = sql + ",";
			
			sql = sql + "CEP=?";
			flag=1;
		}
		if(entidade.getNumero() >0){
			if(flag==1)
				sql = sql + ",";
			
			sql = sql + "Numero=?";
			flag=1;
		}
		if(entidade.getComplemento() != null && !entidade.getComplemento().equals("")){
			if(flag==1)
				sql = sql + ",";
				
			sql = sql + "Complemento=?";
			flag=1;
		}
		if(entidade.getCdArea() != 0 && entidade.getCdArea() > 0){
			sqlTel = sqlTel + "Area=?";
			flag = 1;
		}
		if(entidade.getTelefone() >0){
			if(flag==1)
				sqlTel = sqlTel + ",";
			
			sqlTel = sqlTel + "Numero=?";
			flag=1;
		}
		if(entidade.getOperadora() != null && !entidade.getOperadora().equals("")){
			sqlTelTipo = sqlTelTipo + "Nome=?";
			flag = 1;
		}
		sql = sql + "where id=?";
		
		PreparedStatement stmt = null;
		PreparedStatement stmtTel = null;
		PreparedStatement stmtTelTipo = null;
		try{
			stmt = (PreparedStatement)conn.prepareStatement(sql);
			stmtTel = (PreparedStatement)conn.prepareStatement(sqlTel);
			stmtTelTipo = (PreparedStatement)conn.prepareStatement(sqlTelTipo);
			
			if(entidade.getNome() != null && !entidade.getNome().equals("")){
				stmt.setString(1, entidade.getNome());
			}
			if(entidade.getSenha() != null && !entidade.getSenha().equals("")){
				stmt.setString(2, entidade.getSenha());
			}
			if(entidade.getCEP() >0){
				stmt.setInt(3, entidade.getCEP());
			}
			if(entidade.getNumero() >0){
				stmt.setInt(4, entidade.getNumero());
			}
			if(entidade.getComplemento() != null && !entidade.getComplemento().equals("")){
				stmt.setString(5, entidade.getComplemento());
			}
			if(entidade.getCdArea() >0){
				stmtTel.setInt(1, entidade.getCdArea());
			}
			if(entidade.getTelefone() >0){
				stmtTel.setInt(2, entidade.getTelefone());
			}
			if(entidade.getOperadora() != null && !entidade.getOperadora().equals("")){
				stmtTelTipo.setString(1, entidade.getOperadora());
			}
			stmt.setLong(6, entidade.getId());
			
			stmt.executeUpdate();
			stmtTel.executeUpdate();
			stmtTelTipo.executeUpdate();
			JOptionPane.showMessageDialog(null, "Alterado com sucesso!");
		}catch(SQLException e){
			throw new RuntimeException(e);
		}finally{
			stmt.close();
			stmtTel.close();
			stmtTelTipo.close();
			conn.close();
		}
	}

	@Override
	public void deleta(Pessoa entidade) throws SQLException {
		PreparedStatement stmt = null;
		try{
			stmt = (PreparedStatement)conn.prepareStatement("update Pacientes set Disable=1 where ID =?");
			
			stmt.setLong(1, entidade.getId());
			stmt.executeUpdate();
			JOptionPane.showMessageDialog(null, "Excluido com sucesso!");
		}catch(SQLException e){
			throw new RuntimeException(e);
		}finally{
			stmt.close();
			conn.close();
		}
	}

	@Override
	public Pessoa lista(String Pesquisa) throws SQLException {
		Pessoa entidade = new Pessoa();
		String sql = "select * from Pacientes where id=?";
		String sqlTel = "select * from Telefones";
		String sqlTelTipo = "select * from TiposDeTelefone";
		PreparedStatement stmt = null, stmtTel = null, stmtTelTipo = null;
		ResultSet rs = null, rsTel = null, rsTelTipo = null;
		try{
			stmt = (PreparedStatement)conn.prepareStatement(sql);
			stmtTel = (PreparedStatement)conn.prepareStatement(sqlTel);
			stmtTelTipo = (PreparedStatement)conn.prepareStatement(sqlTelTipo);
			
			stmt.setLong(1, entidade.getId());
			stmtTel.setLong(1, entidade.getTelefone());
			stmtTelTipo.setLong(1, entidade.getId());
			
			rs = stmt.executeQuery();
			rsTel = stmtTel.executeQuery();
			rsTelTipo = stmtTelTipo.executeQuery();
			
			if(rs.next()){
				rsTel.next();
				rsTelTipo.next();
				
				entidade.setId(rs.getLong("id"));
				entidade.setNome(rs.getString("Nome"));
				entidade.setSenha(rs.getString("senha"));
				entidade.setCEP(rs.getInt("CEP"));
				entidade.setCEP(rs.getInt("Numero"));
				entidade.setComplemento(rs.getString("Complemento"));
				
				entidade.setCdArea(rsTel.getInt("Area"));
				entidade.setTelefone(rsTel.getInt("Numero"));
				
				entidade.setOperadora(rsTelTipo.getString("Nome"));
			}
		}catch(SQLException e){
			throw new RuntimeException(e);
		}finally{
			stmt.close();
			stmtTel.close();
			stmtTelTipo.close();
			
			rs.close();
			rsTel.close();
			rsTelTipo.close();
			
			conn.close();
		}
		return entidade;
	}
	
	@SuppressWarnings("null")
	@Override
	public List<Pessoa> listaTudo() throws SQLException {
		List<Pessoa>pessoas = new ArrayList<Pessoa>();
		String sql = "select * from Pacientes";
		String sqlTel = "select * from Telefones";
		String sqlTelTipo = "select * from TiposDeTelefone";
		PreparedStatement stmt = null, stmtTel = null, stmtTelTipo = null;
		ResultSet rs = null, rsTel = null, rsTelTipo = null;
		try{
			stmt = conn.prepareStatement(sql);
			stmtTel = conn.prepareStatement(sqlTel);
			stmtTelTipo = conn.prepareStatement(sqlTelTipo);
			stmt.executeUpdate();
			stmtTel.executeUpdate();
			stmtTelTipo.executeUpdate();
			Pessoa entidade = null;
			
			while(((ResultSet) stmt).next()){
				((ResultSet) stmtTel).next();
				((ResultSet) stmtTelTipo).next();
				entidade = new Pessoa();

				entidade.setId(rs.getLong("id"));
				entidade.setNome(rs.getString("Nome"));
				entidade.setSenha(rs.getString("senha"));
				entidade.setCEP(rs.getInt("CEP"));
				entidade.setNumero(rs.getInt("Numero"));
				entidade.setComplemento(rs.getString("Complemento"));
				
				entidade.setCdArea(rsTel.getInt("Area"));
				entidade.setTelefone(rsTel.getInt("Numero"));
				
				entidade.setOperadora(rsTelTipo.getString("Nome"));
				
				pessoas.add(entidade);
			}
		}catch(SQLException e){
			throw new RuntimeException(e);
		}finally{
			stmt.close();
			stmtTel.close();
			stmtTelTipo.close();
			
			rs.close();
			rsTel.close();
			rsTelTipo.close();
			
			conn.close();
		}
		return pessoas;
	}
}