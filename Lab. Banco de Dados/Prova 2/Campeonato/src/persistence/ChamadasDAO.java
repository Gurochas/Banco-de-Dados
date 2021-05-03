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
import entity.Grupos;
import entity.Jogos;
import entity.Time;

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
			j.setCodigo_TimeA(rs.getInt("codigo_timeA"));
			j.setNome_TimeA(rs.getString("nome_timeA"));
			j.setGols_TimeA(rs.getString("gols_timeA"));
			if (j.getGols_TimeA() == null) j.setGols_TimeA("0");
			
			j.setCodigo_TimeB(rs.getInt("codigo_timeB"));
			j.setNome_TimeB(rs.getString("nome_timeB"));
			j.setGols_TimeB(rs.getString("gols_timeB"));
			if (j.getGols_TimeB() == null) j.setGols_TimeB("0");
			
			lista.add(j);
		}
		cs.close();
		return lista;
	}
	
	public void insereGols(Jogos j) throws SQLException{
		String sql = "{CALL sp_insereGols (?, ?, ?, ?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setInt(1, Integer.parseInt(j.getGols_TimeA()));
		cs.setInt(2, Integer.parseInt(j.getGols_TimeB()));
		cs.setInt(3, j.getCodigo_TimeA());
		cs.setInt(4, j.getCodigo_TimeB());
		cs.execute();
		cs.close();
	}
	
	public List<Grupos> gerarTabelaGrupoComPontos (String grupo) throws SQLException{
		List<Grupos> lista = new ArrayList<>();
		String sql = "SELECT * FROM fn_gerarTabelaGrupoComPontos ('"+grupo+"') ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC";
		Statement cs = c.createStatement();
	    ResultSet rs = cs.executeQuery(sql);
		while (rs.next()) {
			Grupos g = new Grupos();
			g.setNome_time(rs.getString("nome_time"));
			g.setVitorias(rs.getInt("vitorias"));
			g.setEmpates(rs.getInt("empates"));
			g.setDerrotas(rs.getInt("derrotas"));
			g.setGols_marcados(rs.getInt("gols_marcados"));
			g.setGols_sofridos(rs.getInt("gols_sofridos"));
			g.setSaldo_gols(rs.getInt("saldo_gols"));
			g.setPontos(rs.getInt("pontos"));
			g.setRisco_rebaixado(rs.getString("risco_rebaixado"));
			lista.add(g);
		}
		cs.close();
		return lista;
	}
	
	public List<Grupos> gerarTabelaGeralComPontos () throws SQLException{
		List<Grupos> lista = new ArrayList<>();
		String sql = "SELECT * FROM fn_gerarTabelaGeralComPontos () ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC";
		Statement cs = c.createStatement();
	    ResultSet rs = cs.executeQuery(sql);
		while (rs.next()) {
			Grupos g = new Grupos();
			g.setNome_time(rs.getString("nome_time"));
			g.setVitorias(rs.getInt("vitorias"));
			g.setEmpates(rs.getInt("empates"));
			g.setDerrotas(rs.getInt("derrotas"));
			g.setGols_marcados(rs.getInt("gols_marcados"));
			g.setGols_sofridos(rs.getInt("gols_sofridos"));
			g.setSaldo_gols(rs.getInt("saldo_gols"));
			g.setPontos(rs.getInt("pontos"));
			lista.add(g);
		}
		cs.close();
		return lista;
	}
	
	public List<Time> gerarQuartas () throws SQLException{
		List<Time> lista = new ArrayList<>();
		String sql = "SELECT * FROM fn_gerarQuartas() ORDER BY pontos DESC";
		Statement cs = c.createStatement();
	    ResultSet rs = cs.executeQuery(sql);
		while (rs.next()) {
			Time g = new Time();
			g.setNome_time(rs.getString("nome_time"));
			g.setGrupo(rs.getString("grupo"));
			g.setPontos(rs.getInt("pontos"));
			lista.add(g);
		}
		cs.close();
		return lista;
	}
	
}
