package tour.test;

import static org.junit.Assert.*;

import java.sql.Connection;
import java.sql.SQLException;

import org.junit.Test;

import tour.connection.DBConnection;

import tour.process.*;

public class UniqueUsernameTest {

	@Test
	public void test() {
		int a;
		try {
			Connection con;
			DBConnection db = new DBConnection();
			con = db.ConnectionManager();
			a= SignUpProcess.CheckUserName("achyut.9316@gmail.com",con);
			assertEquals(0, a);
		} 
		
		catch (SQLException e) {
			System.out.println("\n Something went wrong in the connection string");
		}

		catch (ClassNotFoundException e) {
			System.out.println("Driver not found");
		}

	}


	}


