package entity;

public class Jogos {
	
	private int codigo_TimeA;
	private String nome_TimeA;
	private String gols_TimeA;
	
	private int codigo_TimeB;
	private String nome_TimeB;
	private String gols_TimeB;
	
	public int getCodigo_TimeA() {
		return codigo_TimeA;
	}
	public void setCodigo_TimeA(int codigo_TimeA) {
		this.codigo_TimeA = codigo_TimeA;
	}
	public int getCodigo_TimeB() {
		return codigo_TimeB;
	}
	public void setCodigo_TimeB(int codigo_TimeB) {
		this.codigo_TimeB = codigo_TimeB;
	}
	public String getGols_TimeA() {
		return gols_TimeA;
	}
	public void setGols_TimeA(String gols_TimeA) {
		this.gols_TimeA = gols_TimeA;
	}
	public String getGols_TimeB() {
		return gols_TimeB;
	}
	public void setGols_TimeB(String gols_TimeB) {
		this.gols_TimeB = gols_TimeB;
	}
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
		return "Jogos [codigo_TimeA=" + codigo_TimeA + ", nome_TimeA=" + nome_TimeA + ", gols_TimeA=" + gols_TimeA
				+ ", codigo_TimeB=" + codigo_TimeB + ", nome_TimeB=" + nome_TimeB + ", gols_TimeB=" + gols_TimeB + "]";
	}
	
}
