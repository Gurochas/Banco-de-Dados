package br.edu.fateczl.WebServiceExemplo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import br.edu.fateczl.WebServiceExemplo.model.entity.Jogador;

public interface JogadorRepository extends JpaRepository<Jogador, Integer>{
	
	List<Jogador> findJogadoresDataConv();
	Jogador findJogadorDataConv(int codigo);
	
}
