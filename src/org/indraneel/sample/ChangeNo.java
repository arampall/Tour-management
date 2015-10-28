package org.indraneel.sample;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ChangeNo
 */
@WebServlet("/ChangeNo")
public class ChangeNo extends HttpServlet {
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
					
					long phoneno=Long.parseLong(request.getParameter("phoneno"));
					
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
			          String sqlString3="UPDATE customer set phoneno=? where id=?";
					    pstmt=con.prepareStatement(sqlString3);
					    pstmt.setLong(1, phoneno);
					    pstmt.setInt(2, value);
					    pstmt.executeUpdate();
					    System.out.println("Phone number updated");
					    PrintWriter out=response.getWriter();
						response.setContentType("text/html");
					    		out.println("<html><body background=http://fullhdpictures.com/wp-content/uploads/2015/03/HD-New-York-Pictures.jpg><h1> Welcome back <br> You successfully changed your phone number</h1><a href=view.jsp>View profile </a></body></html>");
					    
		
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


