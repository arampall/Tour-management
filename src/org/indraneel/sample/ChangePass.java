package org.indraneel.sample;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ChangePass
 */
@WebServlet("/ChangePass")
public class ChangePass extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			 
		     Class.forName("com.mysql.jdbc.Driver");
		     System.out.println("Driver found");
				
				
				String url="jdbc:mysql://localhost/mydb";
				String user="indra";
				String password="tp123";
				Connection con=null;
				
				
				con=DriverManager.getConnection(url, user, password);
				System.out.println("\n Connected successfully");
				
				String old=request.getParameter("old");
				String new1=request.getParameter("userpass");

				String id;
				int value;
				
				Cookie[] cookies = null;
			    cookies = request.getCookies(); 
			    Cookie cookie1=cookies[1];
			      id=cookie1.getName();
		          value=Integer.parseInt(cookie1.getValue());
		          System.out.println(id);
		          System.out.println(value);
			    
			    PreparedStatement pstmt=null;
				
				
				
				
				
				
				 String sqlString4="SELECT password from customer where id=?";
				    pstmt=con.prepareStatement(sqlString4);
				    pstmt.setInt(1, value);
				    ResultSet rs = pstmt.executeQuery();
				    
				    
				    int flag=1;
				    while(rs.next())
				    {
				    	String pass=rs.getString("password");
				    	System.out.println(pass);
				    	System.out.println(old);
				    	if(pass.equals(old))
				    	{
				    		flag=0;
				    		break;
				    	}
				    }
				    
				    if(flag==1)
				    {
				    	PrintWriter out=response.getWriter();
			    		response.setContentType("text/html");
			    		out.println("<!DOCTYPE html><html><head><meta charset=ISO-8859-1><title>Change Password</title>");
			    		out.println(" </head><body><h1>Password doesnt match the existing one</h1><form action=ChangePass method=post>");
			    		out.println("Existing Password:<input type=password name=old><br><br> ");
			    		out.println("New Password:<input type=password name=userpass><br><br> ");
			    		out.println(" Confirm Password:<input type=password name=confirmpass><br><br>");
			    		out.println("<input type=submit value=Change></form></body></html> ");
				    }
				    
				    else
				    	
				    {
				    	String sqlString5="UPDATE customer set password=? where id=?";
					    pstmt=con.prepareStatement(sqlString5);
					    pstmt.setString(1,new1);
					    pstmt.setInt(2, value);
					    pstmt.executeUpdate();
					    System.out.println("Password updated");
					    
					    String sqlString6="SELECT emailid,firstname from customer where id=?";
					    pstmt=con.prepareStatement(sqlString6);
					    pstmt.setInt(1, value);
					    ResultSet rs1 = pstmt.executeQuery();
					    while(rs1.next())
					    {
					    	
					    	String usermail=rs1.getString("emailid");
					    	System.out.println(usermail);
					    	String sqlString7="UPDATE login set password=? where username=?";
						    pstmt=con.prepareStatement(sqlString7);
						    pstmt.setString(1, new1);
						    pstmt.setString(2, usermail);
						    pstmt.executeUpdate();
					    }
					    PrintWriter out=response.getWriter();
						response.setContentType("text/html");
					    		out.println("<html><body background=http://fullhdpictures.com/wp-content/uploads/2015/03/HD-New-York-Pictures.jpg><h1> Welcome back <br> You successfully changed your password </h1><a href=view.jsp>View profile </a></body></html>");
					    
					    
				    	
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
