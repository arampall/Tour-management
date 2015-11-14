package tour.server;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	private Connection connection;
	public Connection ConnectionManager()throws ClassNotFoundException,SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		System.out.println("Driver found");
		String url="jdbc:mysql://localhost/tour";
		String user="root";
		String password="achyut";
		return this.connection= DriverManager.getConnection(url, user, password);
	}
	public Connection getConnection(){
        return this.connection;
    }

}
