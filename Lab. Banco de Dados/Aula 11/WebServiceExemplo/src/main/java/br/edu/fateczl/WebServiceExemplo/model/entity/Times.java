package br.edu.fateczl.WebServiceExemplo.model.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedStoredProcedureQuery;
import javax.persistence.ParameterMode;
import javax.persistence.StoredProcedureParameter;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "Times")
@NamedStoredProcedureQuery (
		name = "Times.spCrudTimes",
		procedureName = "sp_crudtimes",
		parameters = {
				@StoredProcedureParameter(mode = ParameterMode.IN, name = "cod", type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = "id", type = Integer.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = "nome", type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = "cidade", type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = "saida", type = String.class)
		}
)

public class Times {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column
	private int id;
	@Column
	private String nome;
	@Column
	private String cidade;
	@Transient
	private String cod;
	@Transient
	private String saida;
	
	public String getCod() {
		return cod;
	}
	public void setCod(String cod) {
		this.cod = cod;
	}
	public String getSaida() {
		return saida;
	}
	public void setSaida(String saida) {
		this.saida = saida;
	}
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
