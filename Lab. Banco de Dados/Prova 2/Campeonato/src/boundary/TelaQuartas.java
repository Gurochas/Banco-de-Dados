package boundary;

import java.sql.SQLException;

import entity.Time;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.BorderPane;
import persistence.ChamadasDAO;

public class TelaQuartas implements TelaSecundaria {

	BorderPane bp = new BorderPane();

	TableView<Time> tblTimeA = new TableView<>();

	@Override
	public BorderPane gerarTela() {
		gerarTabelas();
		bp.setCenter(tblTimeA);
		return bp;
	}

	private void gerarTabelas() {
		// Time A
		TableColumn<Time, String> colNomeA = new TableColumn<>("Nome");
		colNomeA.setCellValueFactory(new PropertyValueFactory<Time, String>("nome_time"));
		
		TableColumn<Time, String> colGrupo = new TableColumn<>("Grupo");
		colGrupo.setCellValueFactory(new PropertyValueFactory<Time, String>("grupo"));
		
		TableColumn<Time, Integer> colPontosA = new TableColumn<>("Pontos");
		colPontosA.setCellValueFactory(new PropertyValueFactory<Time, Integer>("pontos"));
		
		tblTimeA.getColumns().addAll(colNomeA, colGrupo, colPontosA);
			
		ObservableList<Time> olA = FXCollections.observableArrayList();
		olA.clear();
		try {
			ChamadasDAO dao = new ChamadasDAO();
			olA.addAll(dao.gerarQuartas());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		tblTimeA.setItems(olA);
	}

}