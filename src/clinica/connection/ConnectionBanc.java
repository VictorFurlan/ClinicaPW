package clinica.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionBanc {
	
	public Connection getConnection(){
		
		String url = "jdbc:mysql://179.188.16.24:3306/";
		String dbName = "c_araujo";
		String driver = "com.mysql.jdbc.Driver";
		String userName = "c_araujo";
		String password = "Dilma24@mor";
		try{
			Class.forName(driver);
			return
					 DriverManager.getConnection(url + dbName, userName, password);
			
		}catch(SQLException e){
			throw new RuntimeException(e);
		}catch(ClassNotFoundException e){
			throw new RuntimeException(e); 
		}
	}
}