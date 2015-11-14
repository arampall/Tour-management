

package tour.process;

import java.sql.*;
public class LoginProcess {
      public static int checkLoginDetails(String Username, String Password, Connection con) throws SQLException{
    	  Statement stmt = con.createStatement();
		    String sql = "SELECT * FROM login";
		    ResultSet rs = stmt.executeQuery(sql);
		    while(rs.next()){
	            //Retrieve by column name
	          
	            String username = rs.getString("username");
	            String password = rs.getString("password");
	            System.out.println("\n"+username);
	            System.out.println("\n"+password);
	            if(username.equals(Username)&&password.equals(Password))
	             {
	        	 return 1;
	             }
		   }	
		    return 0;
      }
}
