package br.edu.fateczl.WebServiceExemplo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import br.edu.fateczl.WebServiceExemplo.model.entity.JogadorTime;

public interface JogadorTimeRepository extends JpaRepository<JogadorTime, Integer> {

	JogadorTime udfJogadorIdade(int codigo);
	
}
