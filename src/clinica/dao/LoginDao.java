package clinica.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDao {
	public static boolean validate(String name, String pass){
		boolean status=false;
		Connection conn = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		
		String url = "jdbc:mysql://179.188.16.24:3306/";
		String dbName = "c_araujo";
		String driver = "com.mysql.jdbc.Driver";
		String userName = "c_araujo";
		String password = "Dilma24@mor";
		try{
			Class.forName(driver).newInstance();
			conn = DriverManager.getConnection(url + dbName, userName, password);
			pst = conn.prepareStatement("select * from Acesso where Login=? and Senha=?");
			pst.setString(1, name);
			pst.setString(2, pass);
			
			rs = pst.executeQuery();
			status = rs.next();
		} catch (Exception e){
			System.out.println(e);
		} finally {
			if (conn != null){
				try {
					conn.close();
				}catch(SQLException e){
					e.printStackTrace();
				}
			}
			if (pst != null){
				try{
					pst.close();
				}catch (SQLException e){
					e.printStackTrace();
				}
			}
			if (rs != null){
				try{
					rs.close();
				}catch(SQLException e){
					e.printStackTrace();
				}
			}
		}
		return status;
	}
	
	public static boolean validatePaciente(String nome, String pass){
		boolean status=false;
		Connection conn = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		
		String url = "jdbc:mysql://179.188.16.24:3306/";
		String dbName = "c_araujo";
		String driver = "com.mysql.jdbc.Driver";
		String userName = "c_araujo";
		String password = "Dilma24@mor";
		try{
			Class.forName(driver).newInstance();
			conn = DriverManager.getConnection(url + dbName, userName, password);
			pst = conn.prepareStatement("select * from Pacientes where Nome=? and Senha=?");
			pst.setString(1, nome);
			pst.setString(2, pass);
			
			rs = pst.executeQuery();
			status = rs.next();
		} catch (Exception e){
			System.out.println(e);
		} finally {
			if (conn != null){
				try {
					conn.close();
				}catch(SQLException e){
					e.printStackTrace();
				}
			}
			if (pst != null){
				try{
					pst.close();
				}catch (SQLException e){
					e.printStackTrace();
				}
			}
			if (rs != null){
				try{
					rs.close();
				}catch(SQLException e){
					e.printStackTrace();
				}
			}
		}
		return status;
	}
}
