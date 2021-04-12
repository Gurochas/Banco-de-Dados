package persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GenericDAO {

	private static GenericDAO instancia = null;

	private static final String hostName = "127.0.0.1";
	private static final String dbName = "campeonato";
	private static final String USER = "sa";
	private static final String PASS = "SqlServer19";
	private static final String DRIVER = "net.sourceforge.jtds.jdbc.Driver";
	
	private Connection c;

	private GenericDAO() {
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("SQL: Erro ao encontrar a classe");
		}
	}

	public static GenericDAO getInstance() {
		if (instancia == null) {
			instancia = new GenericDAO();
		}
		return instancia;
	}

	public Connection getConnection() throws SQLException {
		if (c == null || c.isClosed()) {
			c = DriverManager.getConnection(String.format(
					"jdbc:jtds:sqlserver://%s:1433;databaseName=%s;user=%s;password=%s;", hostName, dbName, USER, PASS));
		}
		return c;
	}
}