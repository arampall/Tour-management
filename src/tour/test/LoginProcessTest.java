package tour.test;
import tour.connection.DBConnection;
import tour.process.LoginProcess;
import static org.junit.Assert.*;

import java.sql.Connection;

import org.junit.Test;
import java.sql.*;

public class LoginProcessTest {

	@Test
	public void test() {
		int a;
		try {
			Connection con;
			DBConnection db = new DBConnection();
			con = db.ConnectionManager();

			a = LoginProcess.checkLoginDetails("achyut.9316@gmail.com", "1234", con);

			assertEquals(1, a);
		} 
		
		catch (SQLException e) {
			System.out.println("\n Something went wrong in the connection string");
		}

		catch (ClassNotFoundException e) {
			System.out.println("Driver not found");
		}

	}
}
