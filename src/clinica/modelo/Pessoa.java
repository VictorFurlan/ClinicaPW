package clinica.modelo;

public class Pessoa {
	protected long id;
	protected String nome;
	protected String senha;
	protected int CEP;
	protected int Numero;
	protected String Operadora;
	protected int CdArea;
	protected int Telefone;
	protected String complemento;
	
	public String getOperadora() {
		return Operadora;
	}
	public void setOperadora(String operadora) {
		Operadora = operadora;
	}
	public int getCdArea() {
		return CdArea;
	}
	public void setCdArea(int cdArea) {
		CdArea = cdArea;
	}
	public int getTelefone() {
		return Telefone;
	}
	public void setTelefone(int telefone) {
		Telefone = telefone;
	}
	public String getSenha() {
		return senha;
	}
	public void setSenha(String senha) {
		this.senha = senha;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public int getCEP() {
		return CEP;
	}
	public void setCEP(int cEP) {
		CEP = cEP;
	}
	public int getNumero() {
		return Numero;
	}
	public void setNumero(int telefone) {
		this.Numero = telefone;
	}
	public String getComplemento() {
		return complemento;
	}
	public void setComplemento(String complemento) {
		this.complemento = complemento;
	}
}