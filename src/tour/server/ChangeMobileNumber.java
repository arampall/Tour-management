package tour.server;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ChangeMobileNumber
 */
@WebServlet("/ChangeMobileNumber")
public class ChangeMobileNumber extends HttpServlet {
	private static final long serialVersionUID = 1L;


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			Connection con;
		    DBConnection db= new DBConnection();
			con= db.ConnectionManager();
			long phoneno=Long.parseLong(request.getParameter("mobilenumber"));
					
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


