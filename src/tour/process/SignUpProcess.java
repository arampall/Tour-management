package tour.process;
import java.sql.*;

public class SignUpProcess {
         public static int CheckUserName(String Username,Connection con) throws SQLException{
        	 String sql = "SELECT * FROM login";
        	 Statement stmt = con.createStatement();
     		ResultSet rs = stmt.executeQuery(sql);
     		int flag=0;
     		while(rs.next()){
     	         //Retrieve by column name
     	         
     	         String use = rs.getString("username");
     	         String pass = rs.getString("password");
     	         System.out.println("\n"+use);
     	         System.out.println("\n"+pass);
     	         if(use.equals(Username))
     	         {
     	             flag=1;	 
     	        	 break;
     	         }
     		}
     		return flag;
         }
       
}
