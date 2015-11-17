package tour.server;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tour.connection.DBConnection;

import java.sql.PreparedStatement;

/**
 * Servlet implementation class Change
 */
@WebServlet("/ChangeFirstName")
public class ChangeFirstName extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			 
			Connection con;
		    DBConnection db= new DBConnection();
			con= db.ConnectionManager();
			
			String firstname=request.getParameter("firstname");
			
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
		    String sqlString1 ="UPDATE Customer set firstname=? where id=? "; 
		    pstmt = con.prepareStatement(sqlString1);
		    pstmt.setString(1, firstname);
		    pstmt.setInt(2, value);
		    pstmt.executeUpdate();
		    
		    System.out.println("Name updated");
			response.setContentType("text/html");
			RequestDispatcher rd = request.getRequestDispatcher("/view.jsp");
		    rd.include(request, response);					
		
	     }
		   catch(SQLException e)
		   {
		       System.out.println(e);
	       }
	
	       catch(ClassNotFoundException e)
	       {
		       System.out.println("Driver not found");
	       }

	}
}
