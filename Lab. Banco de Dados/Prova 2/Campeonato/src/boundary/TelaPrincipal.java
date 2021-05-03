package boundary;

import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.control.Menu;
import javafx.scene.control.MenuBar;
import javafx.scene.control.MenuItem;
import javafx.scene.layout.BorderPane;
import javafx.stage.Stage;

public class TelaPrincipal extends Application 
							implements EventHandler<ActionEvent>{
	BorderPane bpPrincipal = new BorderPane();
	
	TelaSecundaria telaTimes = new TelaTimes();
	TelaSecundaria telaGrupos = new TelaGrupos();
	TelaSecundaria telaJogos = new TelaJogos();
	TelaSecundaria telaData = new TelaData();
	TelaSecundaria telaGols = new TelaGols();
	TelaSecundaria telaPontosG = new TelaGruposComPontos();
	TelaSecundaria telaClassG = new TelaClassGeral();
	TelaSecundaria telaQuartas = new TelaQuartas();
	
	MenuItem menuTimes = new MenuItem("Separar Times");
	MenuItem menuJogos = new MenuItem("Gerar Jogos");
	MenuItem menuGrupos = new MenuItem("Mostrar Grupos");
	MenuItem menuDatas = new MenuItem("Datas dos Jogos");
	MenuItem menuGols = new MenuItem("Preencher Gols");
	MenuItem menuPontosG = new MenuItem("Grupo com Pontos");
	MenuItem menuClassG = new MenuItem("Classificação Geral");
	MenuItem menuQuartas = new MenuItem("Quarta de Finais");

	@Override
	public void start(Stage stage) throws Exception {
		
		Scene scn = new Scene(bpPrincipal, 496, 600);
		
		MenuBar menuBar = new MenuBar();
		Menu menu = new Menu("Telas");
		menu.getItems().addAll(menuTimes, menuJogos, menuGrupos, menuDatas, menuGols, menuPontosG, menuClassG, menuQuartas);
		menuBar.getMenus().addAll(menu);

		menuTimes.setOnAction(this);
		menuJogos.setOnAction(this);
		menuGrupos.setOnAction(this);
		menuDatas.setOnAction(this);
		menuGols.setOnAction(this);
		menuPontosG.setOnAction(this);
		menuClassG.setOnAction(this);
		menuQuartas.setOnAction(this);
		
		bpPrincipal.setTop(menuBar);
		bpPrincipal.setCenter(telaTimes.gerarTela());
		
		stage.setScene(scn);
		stage.setTitle("Campeonato Paulista de Futebol - 2019");
		stage.show();
	}
	
	@Override
	public void handle(ActionEvent e) {
		if (e.getSource() == menuTimes) {
			bpPrincipal.setCenter(telaTimes.gerarTela());
		}
		if (e.getSource() == menuGrupos) {
			bpPrincipal.setCenter(telaGrupos.gerarTela());
		}
		if (e.getSource() == menuJogos) {
			bpPrincipal.setCenter(telaJogos.gerarTela());
		}
		if (e.getSource() == menuDatas) {
			bpPrincipal.setCenter(telaData.gerarTela());
		}
		if (e.getSource() == menuGols) {
			bpPrincipal.setCenter(telaGols.gerarTela());
		}
		if (e.getSource() == menuPontosG) {
			bpPrincipal.setCenter(telaPontosG.gerarTela());
		}
		if (e.getSource() == menuClassG) {
			bpPrincipal.setCenter(telaClassG.gerarTela());
		}
		if (e.getSource() == menuQuartas) {
			bpPrincipal.setCenter(telaQuartas.gerarTela());
		}
	}
	
	public static void main(String[] args) {
		Application.launch(TelaPrincipal.class, args);
	}
}
