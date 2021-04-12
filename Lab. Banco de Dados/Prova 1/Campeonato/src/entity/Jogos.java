package entity;

public class Jogos {
	
	private String nome_TimeA;
	private String nome_TimeB;
	
	public String getNome_TimeA() {
		return nome_TimeA;
	}
	public void setNome_TimeA(String nome_TimeA) {
		this.nome_TimeA = nome_TimeA;
	}
	public String getNome_TimeB() {
		return nome_TimeB;
	}
	public void setNome_TimeB(String nome_TimeB) {
		this.nome_TimeB = nome_TimeB;
	}
	@Override
	public String toString() {
		return "Jogos [nome_TimeA=" + nome_TimeA + ", nome_TimeB=" + nome_TimeB + "]";
	}
	
	
}
