package boundary;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import entity.Jogos;
import javafx.application.Platform;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Insets;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.control.cell.TextFieldTableCell;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.GridPane;
import javafx.util.StringConverter;
import javafx.util.converter.LocalDateStringConverter;
import persistence.ChamadasDAO;

public class TelaGols implements TelaSecundaria, EventHandler<ActionEvent> {

	BorderPane bp = new BorderPane();

	TableView<Jogos> tblJogos = new TableView<>();
	
	TextField txtData = new TextField();

	@Override
	public BorderPane gerarTela() {

		GridPane gp = new GridPane();

		gp.setPadding(new Insets(60, 105, 10, 70));
		gp.setHgap(3);

		Button btnBuscar = new Button("Buscar");

		gp.add(new Label("Digite a data"), 0, 0);
		gp.add(txtData, 0, 1);
		gp.add(btnBuscar, 1, 1);

		btnBuscar.setOnAction(this);

		dateField(txtData);

		
		bp.setCenter(gp);
		
		bp.setBottom(tblJogos);
		
		
		return bp;
	}

	private void gerarTabela() {
		DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		
		StringConverter<LocalDate> dateConverter = new LocalDateStringConverter(df, df);
		
		TableColumn<Jogos, String> colNomeA = new TableColumn<>("Casa");
		colNomeA.setCellValueFactory(new PropertyValueFactory<Jogos, String>("nome_TimeA"));
		TableColumn<Jogos, String> colGolsA = new TableColumn<>("Gols Casa");
		colGolsA.setCellValueFactory(new PropertyValueFactory<Jogos, String>("gols_TimeA"));
		
		TableColumn<Jogos, String> colNomeB = new TableColumn<>("Visitante");
		colNomeB.setCellValueFactory(new PropertyValueFactory<Jogos, String>("nome_TimeB"));
		TableColumn<Jogos, String> colGolsB = new TableColumn<>("Gols Visitante");
		colGolsB.setCellValueFactory(new PropertyValueFactory<Jogos, String>("gols_TimeB"));
		
		tblJogos.setEditable(true);
		
		colGolsA.setCellFactory(TextFieldTableCell.forTableColumn());
		colGolsA.setOnEditCommit(new EventHandler<TableColumn.CellEditEvent<Jogos, String>>() {
	        @Override
	        public void handle(TableColumn.CellEditEvent<Jogos, String> t) {
	            t.getRowValue().setGols_TimeA(t.getNewValue());
	            registrarJogo(t.getRowValue());
	        }
	    });
		
		colGolsB.setCellFactory(TextFieldTableCell.forTableColumn());
		colGolsB.setOnEditCommit(new EventHandler<TableColumn.CellEditEvent<Jogos, String>>() {
	        @Override
	        public void handle(TableColumn.CellEditEvent<Jogos, String> t) {
	            t.getRowValue().setGols_TimeB(t.getNewValue());
	            registrarJogo(t.getRowValue());
	        }
	    });
		
		colGolsB.setEditable(true);
		
		tblJogos.getColumns().setAll(colNomeA, colGolsA, colNomeB, colGolsB);
		
		
		ObservableList<Jogos> olA = FXCollections.observableArrayList();
		try {
			ChamadasDAO dao = new ChamadasDAO();
			olA.setAll(dao.buscarDatas(regData()));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		tblJogos.setItems(olA);
		
		bp.setBottom(tblJogos);
	}
	
	public void registrarJogo(Jogos j) {
		try {
			ChamadasDAO dao = new ChamadasDAO();
			dao.insereGols(j);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void handle(ActionEvent arg0) {
		gerarTabela();

	}
	
	private LocalDate regData() {
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		LocalDate ld = LocalDate.parse(txtData.getText(), dtf);
		return ld;
	}


	private static void maxField(final TextField textField, final Integer length) {
		textField.textProperty().addListener(new ChangeListener<String>() {
			@Override
			public void changed(ObservableValue<? extends String> observableValue, String oldValue, String newValue) {
				if (newValue.length() > length)
					textField.setText(oldValue);
			}
		});
	}

	private static void positionCaret(final TextField textField) {
		Platform.runLater(new Runnable() {
			@Override
			public void run() {
				textField.positionCaret(textField.getText().length());
			}
		});
	}

	public static void dateField(final TextField textField) {
		maxField(textField, 10);

		textField.lengthProperty().addListener(new ChangeListener<Number>() {
			@Override
			public void changed(ObservableValue<? extends Number> observable, Number oldValue, Number newValue) {
				if (newValue.intValue() < 11) {
					String value = textField.getText();
					value = value.replaceAll("[^0-9]", "");
					value = value.replaceFirst("(\\d{2})(\\d)", "$1/$2");
					value = value.replaceFirst("(\\d{2})\\/(\\d{2})(\\d)", "$1/$2/$3");
					textField.setText(value);
					positionCaret(textField);
				}
			}
		});
	}

}
