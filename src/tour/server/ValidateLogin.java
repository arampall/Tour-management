package tour.server;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import tour.process.LoginProcess;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SimpleServlet
 */
@WebServlet(description = "A simple servlet example", urlPatterns = { "/ValidateLogin" })
public class ValidateLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		try{
			int unique=0;
			Connection con;
		    DBConnection db= new DBConnection();
			con= db.ConnectionManager();
		    Statement stmt = con.createStatement();
		    /*String sql = "SELECT * FROM login";
		    ResultSet rs = stmt.executeQuery(sql);*/
				
				
		    String given_username=request.getParameter("username");
		    String given_password=request.getParameter("password");
		    int flag=0;
		    flag= LoginProcess.checkLoginDetails(given_username,given_password,con);
		 
		    /*while(rs.next()){
	            //Retrieve by column name
	          
	            String username = rs.getString("username");
	            String password = rs.getString("password");
	            System.out.println("\n"+username);
	            System.out.println("\n"+password);
	            if(username.equals(given_username)&&password.equals(given_password))
	             {
	        	 flag=1;
	        	 break;
	             }
		   }*/				
			
			 
		
		   if(flag==0)
		     {
		       PrintWriter out=response.getWriter();
			   response.setContentType("text/javascript"); 
			   RequestDispatcher rd = request.getRequestDispatcher("/invalidLogin.html");
			   rd.include(request, response);
			
		     }
		   else
		     {
               String sql1="SELECT id,emailid from customer";
    		   ResultSet rs1=stmt.executeQuery(sql1);
    		   while(rs1.next())
    		     {
    			    String use = rs1.getString("emailid");
		            unique = Integer.parseInt(rs1.getString("id"));
		            if(use.equals(given_username))
		        	   break;
    		     }
    		  System.out.println(unique);	
    		  Cookie id = new Cookie("id",Integer.toString(unique));
              Cookie login=new Cookie("login","1");
              id.setMaxAge(60*60*24);
              login.setMaxAge(60*60*24);
              response.addCookie( id );
              response.addCookie( login );
    
	          response.setContentType("text/html");
	          RequestDispatcher rd = request.getRequestDispatcher("/homepage.html");
	          rd.include(request, response);
		    }
		}  catch(SQLException e)
		     {
			    System.out.println(e);
	 	     }
		
		   catch(ClassNotFoundException e)
		     {
			     System.out.println("Driver not found");
		     }	
		
		 
	}

}
