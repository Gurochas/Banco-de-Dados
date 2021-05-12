package br.edu.fateczl.WebServiceExemplo.model.dto;

public class JogadorDTO {
	
	private int codigo;
	private String nomeJogador;
	private String sexo;
	private float altura;
	private String dt_nasc;
	private TimesDTO times;
	private int idade;
	
	public int getIdade() {
		return idade;
	}
	public void setIdade(int idade) {
		this.idade = idade;
	}
	public int getCodigo() {
		return codigo;
	}
	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}
	public String getNomeJogador() {
		return nomeJogador;
	}
	public void setNomeJogador(String nome) {
		this.nomeJogador = nome;
	}
	public String getSexo() {
		return sexo;
	}
	public void setSexo(String sexo) {
		this.sexo = sexo;
	}
	public float getAltura() {
		return altura;
	}
	public void setAltura(float altura) {
		this.altura = altura;
	}
	public String getDt_nasc() {
		return dt_nasc;
	}
	public void setDt_nasc(String dt_nasc) {
		this.dt_nasc = dt_nasc;
	}
	public TimesDTO getTimes() {
		return times;
	}
	public void setTimes(TimesDTO times) {
		this.times = times;
	}
	
	@Override
	public String toString() {
		return "JogadorDTO [codigo=" + codigo + ", nomeJogador=" + nomeJogador + ", sexo=" + sexo + ", altura=" + altura
				+ ", dt_nasc=" + dt_nasc + ", times=" + times + ", idade=" + idade + "]";
	}

}
