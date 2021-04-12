package boundary;

import java.sql.SQLException;

import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.BorderPane;
import persistence.ChamadasDAO;

public class TelaJogos implements TelaSecundaria, EventHandler<ActionEvent> {
	
	BorderPane bp = new BorderPane();

	@Override
	public BorderPane gerarTela() {
		Button btnGerar = new Button("Gerar Rodadas");
		btnGerar.setOnAction(this);
		bp.setCenter(btnGerar);
		return bp;
	}

	@Override
	public void handle(ActionEvent e) {
		try {
			ChamadasDAO cd = new ChamadasDAO();
			cd.gerarRodadas();
			Label lblRodadas = new Label("Rodadas Geradas");
			bp.setCenter(lblRodadas);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}

}