package org.indraneel.sample;
import java.sql.ResultSet;
import java.sql.SQLException;
public class Test{

		public static int achyut(String a,String b,ResultSet rs){
			
			
			try {
				int flag=0;
				while(rs.next()){
				     //Retrieve by column name
				     
				     String use = rs.getString("username");
				     String pass = rs.getString("password");
				     System.out.println("\n"+use);
				     System.out.println("\n"+pass);
				     if(use.equals(a)&&pass.equals(b))
				     {
				    	 flag=1;
				    	 break;
				     }
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
			return 0;
			
			
		}
	

}

