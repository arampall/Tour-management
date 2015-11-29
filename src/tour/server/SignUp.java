package tour.server;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tour.connection.DBConnection;
import tour.process.SignUpProcess;

/**
 * Servlet implementation class SignUp
 */
@WebServlet(description = "Signing up", urlPatterns = { "/SignUp" })
public class SignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Inside Signup");
		try {
			 int unique=0;
			 Connection con;
			 DBConnection db= new DBConnection();
			 con= db.ConnectionManager();
			 Statement stmt = con.createStatement();
					
					
								
		// TODO Auto-generated method stub
		String username=request.getParameter("usermail");
		String password1=request.getParameter("userpass");
		String fname=request.getParameter("firstname");
		String lname=request.getParameter("lastname");
		String no=request.getParameter("mno");
		String address=request.getParameter("address");
		String birth =request.getParameter("dob");
		
		System.out.println(birth);		
       
        System.out.println(no);
        int flag=0;
				
        /*String sql = "SELECT * FROM login";
		ResultSet rs = stmt.executeQuery(sql);
		
        int flag=0;
		while(rs.next()){
	         //Retrieve by column name
	         
	         String use = rs.getString("username");
	         String pass = rs.getString("password");
	         System.out.println("\n"+use);
	         System.out.println("\n"+pass);
	         if(use.equals(username))
	         {
	        	 flag=1;
	        	 break;
	         }
		}*/
		flag= SignUpProcess.CheckUserName(username, con);
        if(flag==0)
        {
        	
        String query = "INSERT INTO customer(firstname,lastname,emailid,phoneno,dob,address,password,id)" + 
		           "VALUES ('" + fname + "', '" + lname + "', '" + username + "','"+no+"','"+birth+"','"+address+"','"+password1+"','"+unique+"')";
		
			
        int i = stmt.executeUpdate(query);
        if (i != 0) {
        System.out.println("Record has been inserted successfully in Customer table");
        } else {
        System.out.println("Inserting record get failure");
        }	 

		String query1="INSERT INTO login (username,password) " + 
		           "VALUES ('" + username + "', '" + password1 + "')";
		
        int a = stmt.executeUpdate(query1);
        if (a != 0) {
        System.out.println("Record has been inserted successfully in Login Table");
        } else {
        System.out.println("Inserting record get failure");
        }
        //----------------------------------------------------------
        /*String sql1="SELECT * from id";
		
		ResultSet rs1=stmt.executeQuery(sql1);
		while(rs1.next())
		{
		unique=Integer.parseInt(rs1.getString("no"));
		unique=unique+1;
		}
		
		String query2="UPDATE id set no=no+1" ;
		stmt.executeUpdate(query2);*/
        //-------------------------------------------------------------
          PreparedStatement pstmt=null;
	      String sqlString = "select id from customer where emailid=?";
	      pstmt = con.prepareStatement(sqlString);
  	      pstmt.setString(1, username);
  	      ResultSet rs1 = pstmt.executeQuery();
  	      while(rs1.next())
		  {
		     unique=Integer.parseInt(rs1.getString("id"));
		   }
          Cookie id = new Cookie("id",Integer.toString(unique) );
          Cookie login=new Cookie("login","1");
          id.setMaxAge(60*60*24);
          login.setMaxAge(60*60*24);
          System.out.println(unique);
          response.addCookie( id );
          response.addCookie( login );
          
          
          
          
          
          
  		  response.setContentType("text/html");
  		  response.sendRedirect("homepage.html");
       // out.println("<html><body background=http://fullhdpictures.com/wp-content/uploads/2015/03/HD-New-York-Pictures.jpg><h1> Welcome back</h1><a href=view.jsp>View profile </a></body></html>");
         		
        }
        else
        {
        	PrintWriter out=response.getWriter();
    		response.setContentType("text/html");
        	out.println("<html><head><meta charset=ISO-8859-1><title>Insert title here</title></head><body background=http://www.hdwallpapersnew.net/wp-content/uploads/2015/05/singapore-city-night-widescreen-hd-wallpaper-pictures-free-desktop-background-download.jpg >");
        	out.println("<h1> Account Creation!! </h1><h2>You entered an existing username,please enter a new one</h2><form action=SignUp method=post >");
        	out.println("First Name:<input type=text name=firstname><br><br> ");
        	out.println("Last Name:<input type=text name=lastname><br><br> ");
        	out.println("Mobile Contact number:<input type=text name=mno><br><br> ");
        	out.println("Email id:(Also will be your username)<input type=email name=usermail><br><br> ");
        	out.println("Date of Birth:<input type=date name=dob><br><br> ");
        	out.println("Address:<input type=text name=address><br><br> ");
        	out.println("Password:<input type=password name=userpass><br><br> ");
        	out.println("Confirm Password:<input type=password name=confirmpass><br><br> ");
        	out.println("<input type=submit value=Create Account></form></body></html> ");
        	
        }
        
		}catch(SQLException e)
		{
			System.out.println(e);
		}
		
		catch(ClassNotFoundException e)
		{
			System.out.println("Driver not found");
		}
		

		
	}

}
