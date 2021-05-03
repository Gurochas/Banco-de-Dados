package entity;

public class Time {
	
	private String nome_time; 
	private String grupo;
	private int pontos;
	
	public String getNome_time() {
		return nome_time;
	}
	public void setNome_time(String nome_time) {
		this.nome_time = nome_time;
	}
	public String getGrupo() {
		return grupo;
	}
	public void setGrupo(String grupo) {
		this.grupo = grupo;
	}
	public int getPontos() {
		return pontos;
	}
	public void setPontos(int pontos) {
		this.pontos = pontos;
	}
	@Override
	public String toString() {
		return "Time [nome_time=" + nome_time + ", grupo=" + grupo + ", pontos=" + pontos + "]";
	}

}
