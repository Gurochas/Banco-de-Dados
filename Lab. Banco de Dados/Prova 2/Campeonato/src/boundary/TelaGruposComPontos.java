package boundary;

import java.sql.SQLException;

import entity.Grupos;
import entity.Grupos;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.GridPane;
import persistence.ChamadasDAO;

public class TelaGruposComPontos implements TelaSecundaria {

	BorderPane bp = new BorderPane();

	TableView<Grupos> tblGruposA = new TableView<>();
	TableView<Grupos> tblGruposB = new TableView<>();
	TableView<Grupos> tblGruposC = new TableView<>();
	TableView<Grupos> tblGruposD = new TableView<>();

	@Override
	public BorderPane gerarTela() {

		GridPane gp = new GridPane();
		
		gp.add(new Label("Grupos A"), 0, 0);
		gp.add(tblGruposA, 0, 1);
		
		gp.add(new Label("Grupos B"), 1, 0);
		gp.add(tblGruposB, 1, 1);
		
		gp.add(new Label("Grupos C"), 0, 2);
		gp.add(tblGruposC, 0, 3);
		
		gp.add(new Label("Grupos D"), 1, 2);
		gp.add(tblGruposD, 1, 3);

		gerarTabelas();

		bp.setCenter(gp);
		return bp;
	}

	private void gerarTabelas() {
		// Grupos A
		TableColumn<Grupos, String> colNomeA = new TableColumn<>("Nome");
		colNomeA.setCellValueFactory(new PropertyValueFactory<Grupos, String>("nome_time"));

		TableColumn<Grupos, Integer> colNumJogosA = new TableColumn<>("NumJogos");
		colNumJogosA.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("num_jogos_disputados"));
		
		TableColumn<Grupos, Integer> colVitoriasA = new TableColumn<>("Vitórias");
		colVitoriasA.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("vitorias"));
		
		TableColumn<Grupos, Integer> colEmpatesA = new TableColumn<>("Empates");
		colEmpatesA.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("empates"));
		
		TableColumn<Grupos, Integer> colDerrotasA = new TableColumn<>("Derrotas");
		colDerrotasA.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("derrotas"));
		
		TableColumn<Grupos, Integer> colGolsMA = new TableColumn<>("Gols Marcados");
		colGolsMA.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("gols_marcados"));
		
		TableColumn<Grupos, Integer> colGolsSA = new TableColumn<>("Gols Sofridos");
		colGolsSA.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("gols_sofridos"));
		
		TableColumn<Grupos, Integer> colSaldoGolsA = new TableColumn<>("Saldo Gols");
		colSaldoGolsA.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("saldo_gols"));
		
		TableColumn<Grupos, Integer> colPontosA = new TableColumn<>("Pontos");
		colPontosA.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("pontos"));
		
		TableColumn<Grupos, Integer> colRebaixadoA = new TableColumn<>("Risco de Rebaixamento");
		colRebaixadoA.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("risco_rebaixado"));
		
		tblGruposA.getColumns().addAll(colNomeA, colNumJogosA, colVitoriasA, colEmpatesA, colDerrotasA, colGolsMA, colGolsSA, colSaldoGolsA,
				colPontosA, colRebaixadoA);
		
		
		ObservableList<Grupos> olA = FXCollections.observableArrayList();
		olA.clear();
		try {
			ChamadasDAO dao = new ChamadasDAO();
			olA.addAll(dao.gerarTabelaGrupoComPontos("A"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		tblGruposA.setItems(olA);

		// Grupos B
		TableColumn<Grupos, String> colNomeB = new TableColumn<>("Nome");
		colNomeB.setCellValueFactory(new PropertyValueFactory<Grupos, String>("nome_time"));

		TableColumn<Grupos, Integer> colNumJogosB = new TableColumn<>("NumJogos");
		colNumJogosB.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("num_jogos_disputados"));
		
		TableColumn<Grupos, Integer> colVitoriasB = new TableColumn<>("Vitórias");
		colVitoriasB.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("vitorias"));
		
		TableColumn<Grupos, Integer> colEmpatesB = new TableColumn<>("Empates");
		colEmpatesB.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("empates"));
		
		TableColumn<Grupos, Integer> colDerrotasB = new TableColumn<>("Derrotas");
		colDerrotasB.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("derrotas"));
		
		TableColumn<Grupos, Integer> colGolsMB = new TableColumn<>("Gols Marcados");
		colGolsMB.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("gols_marcados"));
		
		TableColumn<Grupos, Integer> colGolsSB = new TableColumn<>("Gols Sofridos");
		colGolsSB.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("gols_sofridos"));
		
		TableColumn<Grupos, Integer> colSaldoGolsB = new TableColumn<>("Saldo Gols");
		colSaldoGolsB.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("saldo_gols"));
		
		TableColumn<Grupos, Integer> colPontosB = new TableColumn<>("Pontos");
		colPontosB.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("pontos"));
		
		TableColumn<Grupos, Integer> colRebaixadoB = new TableColumn<>("Risco de Rebaixamento");
		colRebaixadoB.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("risco_rebaixado"));
		
		tblGruposB.getColumns().addAll(colNomeB, colNumJogosB, colVitoriasB, colEmpatesB, colDerrotasB, colGolsMB, colGolsSB, colSaldoGolsB,
				colPontosB, colRebaixadoB);
		

		ObservableList<Grupos> olB = FXCollections.observableArrayList();
		olB.clear();
		try {
			ChamadasDAO dao = new ChamadasDAO();
			olB.addAll(dao.gerarTabelaGrupoComPontos("B"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		tblGruposB.setItems(olB);

		// Grupos C
		TableColumn<Grupos, String> colNomeC = new TableColumn<>("Nome");
		colNomeC.setCellValueFactory(new PropertyValueFactory<Grupos, String>("nome_time"));

		TableColumn<Grupos, Integer> colNumJogosC = new TableColumn<>("NumJogos");
		colNumJogosC.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("num_jogos_disputados"));
		
		TableColumn<Grupos, Integer> colVitoriasC = new TableColumn<>("Vitórias");
		colVitoriasC.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("vitorias"));
		
		TableColumn<Grupos, Integer> colEmpatesC = new TableColumn<>("Empates");
		colEmpatesC.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("empates"));
		
		TableColumn<Grupos, Integer> colDerrotasC = new TableColumn<>("Derrotas");
		colDerrotasC.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("derrotas"));
		
		TableColumn<Grupos, Integer> colGolsMC = new TableColumn<>("Gols Marcados");
		colGolsMC.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("gols_marcados"));
		
		TableColumn<Grupos, Integer> colGolsSC = new TableColumn<>("Gols Sofridos");
		colGolsSC.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("gols_sofridos"));
		
		TableColumn<Grupos, Integer> colSaldoGolsC = new TableColumn<>("Saldo Gols");
		colSaldoGolsC.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("saldo_gols"));
		
		TableColumn<Grupos, Integer> colPontosC = new TableColumn<>("Pontos");
		colPontosC.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("pontos"));
		
		TableColumn<Grupos, Integer> colRebaixadoC = new TableColumn<>("Risco de Rebaixamento");
		colRebaixadoC.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("risco_rebaixado"));
		
		
		tblGruposC.getColumns().addAll(colNomeC, colNumJogosC, colVitoriasC, colEmpatesC, colDerrotasC, colGolsMC, colGolsSC, colSaldoGolsC,
				colPontosC, colRebaixadoC);
		

		ObservableList<Grupos> olC = FXCollections.observableArrayList();
		olC.clear();
		try {
			ChamadasDAO dao = new ChamadasDAO();
			olC.addAll(dao.gerarTabelaGrupoComPontos("C"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		tblGruposC.setItems(olC);

		// Grupos D
		TableColumn<Grupos, String> colNomeD = new TableColumn<>("Nome");
		colNomeD.setCellValueFactory(new PropertyValueFactory<Grupos, String>("nome_time"));

		TableColumn<Grupos, Integer> colNumJogosD = new TableColumn<>("NumJogos");
		colNumJogosD.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("num_jogos_disputados"));
		
		TableColumn<Grupos, Integer> colVitoriasD = new TableColumn<>("Vitórias");
		colVitoriasD.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("vitorias"));
		
		TableColumn<Grupos, Integer> colEmpatesD = new TableColumn<>("Empates");
		colEmpatesD.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("empates"));
		
		TableColumn<Grupos, Integer> colDerrotasD = new TableColumn<>("Derrotas");
		colDerrotasD.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("derrotas"));
		
		TableColumn<Grupos, Integer> colGolsMD = new TableColumn<>("Gols Marcados");
		colGolsMD.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("gols_marcados"));
		
		TableColumn<Grupos, Integer> colGolsSD = new TableColumn<>("Gols Sofridos");
		colGolsSD.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("gols_sofridos"));
		
		TableColumn<Grupos, Integer> colSaldoGolsD = new TableColumn<>("Saldo Gols");
		colSaldoGolsD.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("saldo_gols"));
		
		TableColumn<Grupos, Integer> colPontosD = new TableColumn<>("Pontos");
		colPontosD.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("pontos"));
		
		TableColumn<Grupos, Integer> colRebaixadoD = new TableColumn<>("Risco de Rebaixamento");
		colRebaixadoD.setCellValueFactory(new PropertyValueFactory<Grupos, Integer>("risco_rebaixado"));
		
		tblGruposD.getColumns().addAll(colNomeD, colNumJogosD, colVitoriasD, colEmpatesD, colDerrotasD, colGolsMD, colGolsSD, colSaldoGolsD,
				colPontosD, colRebaixadoD);

		ObservableList<Grupos> olD = FXCollections.observableArrayList();
		olD.clear();
		try {
			ChamadasDAO dao = new ChamadasDAO();
			olD.addAll(dao.gerarTabelaGrupoComPontos("D"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		tblGruposD.setItems(olD);

	}

}