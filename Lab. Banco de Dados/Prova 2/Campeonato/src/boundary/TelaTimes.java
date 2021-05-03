package boundary;


import java.sql.SQLException;

import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.BorderPane;
import persistence.ChamadasDAO;

public class TelaTimes implements TelaSecundaria,
					EventHandler<ActionEvent>{
	BorderPane bp = new BorderPane();

	@Override
	public BorderPane gerarTela() {
		Button btnGerar = new Button("Separar Times");
		btnGerar.setOnAction(this);
		bp.setCenter(btnGerar);
		return bp;
	}

	@Override
	public void handle(ActionEvent e) {
		try {
			ChamadasDAO cd = new ChamadasDAO();
			cd.separarGrupos();
			Label lblGrupos = new Label("Grupos formados");
			bp.setCenter(lblGrupos);
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
	}

}
