package br.edu.fateczl.WebServiceExemplo.model.dto;

public class TimesDTO {
	
	private int id;
	private String nome;
	private String cidade;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getCidade() {
		return cidade;
	}
	public void setCidade(String cidade) {
		this.cidade = cidade;
	}

	@Override
	public String toString() {
		return "Times [id=" + id + ", nome=" + nome + ", cidade=" + cidade + "]";
	}
}
