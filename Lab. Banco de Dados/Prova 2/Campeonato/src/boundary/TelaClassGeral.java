package boundary;

import java.sql.SQLException;

import entity.Grupos;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.BorderPane;
import persistence.ChamadasDAO;

public class TelaClassGeral implements TelaSecundaria {

	BorderPane bp = new BorderPane();

	TableView<Grupos> tblGruposA = new TableView<>();

	@Override
	public BorderPane gerarTela() {
		gerarTabelas();
		bp.setCenter(tblGruposA);
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
		
		tblGruposA.getColumns().addAll(colNomeA, colNumJogosA, colVitoriasA, colEmpatesA, colDerrotasA, colGolsMA, colGolsSA, colSaldoGolsA,
				colPontosA);
			
		ObservableList<Grupos> olA = FXCollections.observableArrayList();
		olA.clear();
		try {
			ChamadasDAO dao = new ChamadasDAO();
			olA.addAll(dao.gerarTabelaGeralComPontos());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		tblGruposA.setItems(olA);

	}

}