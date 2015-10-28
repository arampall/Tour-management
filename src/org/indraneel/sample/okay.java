package org.indraneel.sample;

import static org.junit.Assert.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.junit.Test;

public class okay {

	@Test
	public void testAchyut() {
		int a;
		try {
		     Class.forName("com.mysql.jdbc.Driver");
		     System.out.println("Driver found");
				
				
				String url="jdbc:mysql://localhost/tour";
				String user="root";
				String password="achyut";
				Connection con=null;
				
				
					con=DriverManager.getConnection(url, user, password);
					System.out.println("\n Connected successfully");
					Statement stmt = con.createStatement();
					String sql = "SELECT * FROM login";
					ResultSet rs = stmt.executeQuery(sql);
				   
		            a=Check.achyut("arampall@unc.edu","achyut99",rs);
		            
		            assertEquals(1,a);
	}catch(SQLException e)
	{
		System.out.println("\n Something went wrong in the connection string");
	}
	
	catch(ClassNotFoundException e)
	{
		System.out.println("Driver not found");
	}
	

}
}
