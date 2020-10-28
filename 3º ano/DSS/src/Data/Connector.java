package Data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connector {
    private static final String SERVER = "jdbc:mysql://localhost:3306";// + DATABASE; // Windows/Debian/...
    private static final String USERNAME = "root";
    private static final String PASSWORD = "password"; //inserir password da workbench aqui

    public static Connection connect() throws ClassNotFoundException {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(SERVER, USERNAME, PASSWORD);
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Erro na Base de Dados.");
        }
        return connection;
    }

    public static void close(Connection c) {
        try {
            if (c != null && !c.isClosed()) {
                c.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}