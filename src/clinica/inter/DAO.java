package clinica.inter;

import java.sql.SQLException;
import java.util.List;

public interface DAO <T>{
	
	public void adiciona(T entidade)throws SQLException;
	public void altera(T entidade)throws SQLException;
	public void deleta(T entidade)throws SQLException;
	public T lista(String Pesquisa)throws SQLException;
	public List<T>listaTudo()throws SQLException;
}
