package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import entity.Grupo;
import entity.Jogos;

public class ChamadasDAO {

	
	private Connection c;
	
	public ChamadasDAO() throws SQLException {
		GenericDAO gDAO = GenericDAO.getInstance();
		c = gDAO.getConnection();
	}
	
	public void separarGrupos() throws SQLException {
		String sql = "{CALL sp_gerarGrupos}";
		CallableStatement cs = c.prepareCall(sql);
		cs.execute();
		cs.close();
		
	}
	
	public void gerarRodadas() throws SQLException {
		String sql = "{CALL sp_gerarJogos}";
		CallableStatement cs = c.prepareCall(sql);
		cs.execute();
		cs.close();
	}
	
	public List<Grupo> gerarTabelaGrupo (String grupo) throws SQLException{
		List<Grupo> lista = new ArrayList<>();
		String sql = "SELECT * FROM fn_gerarTabelaGrupo('"+grupo+"')";
		Statement cs = c.createStatement();
	    ResultSet rs = cs.executeQuery(sql);
		
		while (rs.next()) {
			Grupo g = new Grupo();
			g.setCodigo(rs.getInt("cod_time"));
			g.setNome(rs.getString("nome_time"));
			lista.add(g);
		}
		cs.close();
		return lista;
	}
	
	public List<Jogos> buscarDatas(LocalDate dato) throws SQLException{
		List<Jogos> lista = new ArrayList<>();
		String sql = "SELECT * FROM fn_consultarData('"+dato.toString()+"')";
		Statement cs = c.createStatement();
	    ResultSet rs = cs.executeQuery(sql);
		while (rs.next()) {
			Jogos j = new Jogos();
			j.setNome_TimeA(rs.getString("nome_timeA"));
			j.setNome_TimeB(rs.getString("nome_timeB"));
			lista.add(j);
		}
		Jogos a = lista.get(1);
		cs.close();
		return lista;
	}
}
