package boundary;

import java.sql.SQLException;

import entity.Grupo;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.GridPane;
import persistence.ChamadasDAO;

public class TelaGrupos implements TelaSecundaria {

	BorderPane bp = new BorderPane();

	TableView<Grupo> tblGrupoA = new TableView<>();
	TableView<Grupo> tblGrupoB = new TableView<>();
	TableView<Grupo> tblGrupoC = new TableView<>();
	TableView<Grupo> tblGrupoD = new TableView<>();

	@Override
	public BorderPane gerarTela() {

		GridPane gp = new GridPane();
		
		gp.add(new Label("Grupo A"), 0, 0);
		gp.add(tblGrupoA, 0, 1);
		
		gp.add(new Label("Grupo B"), 1, 0);
		gp.add(tblGrupoB, 1, 1);
		
		gp.add(new Label("Grupo C"), 0, 2);
		gp.add(tblGrupoC, 0, 3);
		
		gp.add(new Label("Grupo D"), 1, 2);
		gp.add(tblGrupoD, 1, 3);

		gerarTabelas();

		bp.setCenter(gp);
		return bp;
	}

	private void gerarTabelas() {
		// Grupo A
		TableColumn<Grupo, Integer> colCodigoA = new TableColumn<>("Codigo");
		colCodigoA.setCellValueFactory(new PropertyValueFactory<Grupo, Integer>("codigo"));
		TableColumn<Grupo, String> colNomeA = new TableColumn<>("Nome");
		colNomeA.setCellValueFactory(new PropertyValueFactory<Grupo, String>("nome"));
		tblGrupoA.getColumns().addAll(colCodigoA, colNomeA);

		ObservableList<Grupo> olA = FXCollections.observableArrayList();
		olA.clear();
		try {
			ChamadasDAO dao = new ChamadasDAO();
			olA.addAll(dao.gerarTabelaGrupo("A"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		tblGrupoA.setItems(olA);

		// Grupo B
		TableColumn<Grupo, Integer> colCodigoB = new TableColumn<>("Codigo");
		colCodigoB.setCellValueFactory(new PropertyValueFactory<Grupo, Integer>("codigo"));
		TableColumn<Grupo, String> colNomeB = new TableColumn<>("Nome");
		colNomeB.setCellValueFactory(new PropertyValueFactory<Grupo, String>("nome"));
		tblGrupoB.getColumns().addAll(colCodigoB, colNomeB);

		ObservableList<Grupo> olB = FXCollections.observableArrayList();
		olB.clear();
		try {
			ChamadasDAO dao = new ChamadasDAO();
			olB.addAll(dao.gerarTabelaGrupo("B"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		tblGrupoB.setItems(olB);

		// Grupo C
		TableColumn<Grupo, Integer> colCodigoC = new TableColumn<>("Codigo");
		colCodigoC.setCellValueFactory(new PropertyValueFactory<Grupo, Integer>("codigo"));
		TableColumn<Grupo, String> colNomeC = new TableColumn<>("Nome");
		colNomeC.setCellValueFactory(new PropertyValueFactory<Grupo, String>("nome"));
		tblGrupoC.getColumns().addAll(colCodigoC, colNomeC);

		ObservableList<Grupo> olC = FXCollections.observableArrayList();
		olC.clear();
		try {
			ChamadasDAO dao = new ChamadasDAO();
			olC.addAll(dao.gerarTabelaGrupo("C"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		tblGrupoC.setItems(olC);

		// Grupo D
		TableColumn<Grupo, Integer> colCodigoD = new TableColumn<>("Codigo");
		colCodigoD.setCellValueFactory(new PropertyValueFactory<Grupo, Integer>("codigo"));
		TableColumn<Grupo, String> colNomeD = new TableColumn<>("Nome");
		colNomeD.setCellValueFactory(new PropertyValueFactory<Grupo, String>("nome"));
		tblGrupoD.getColumns().addAll(colCodigoD, colNomeD);

		ObservableList<Grupo> olD = FXCollections.observableArrayList();
		olD.clear();
		try {
			ChamadasDAO dao = new ChamadasDAO();
			olD.addAll(dao.gerarTabelaGrupo("D"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		tblGrupoD.setItems(olD);

	}

}