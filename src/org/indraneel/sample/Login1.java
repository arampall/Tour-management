package org.indraneel.sample;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SimpleServlet
 */
@WebServlet(description = "A simple servlet example", urlPatterns = { "/Login1" })
public class Login1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("\n Coming Here");
		try {
		     Class.forName("com.mysql.jdbc.Driver");
		     System.out.println("Driver found");
				
				
				String url="jdbc:mysql://localhost/mydb";
				String user="indra";
				String password="tp123";
				Connection con=null;
				
				
					con=DriverManager.getConnection(url, user, password);
					System.out.println("\n Connected successfully");
					Statement stmt = con.createStatement();
					String sql = "SELECT * FROM login";
					ResultSet rs = stmt.executeQuery(sql);
				
				
				
				
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");// TODO Auto-generated method stub
		String username=request.getParameter("username");
		String password1=request.getParameter("password");
		int flag=0;
		
		 
				
				while(rs.next()){
			         //Retrieve by column name
			         
			         String use = rs.getString("username");
			         String pass = rs.getString("password");
			         System.out.println("\n"+use);
			         System.out.println("\n"+pass);
			         if(use.equals(username)&&pass.equals(password1))
			         {
			        	 flag=1;
			        	 break;
			         }
				}
			
			 
		
		if(flag==0)
		{
			out.println("<html>");
            out.println("<title>Invalid login or password</title>");
            out.println("<body>");
            out.println("<H1>Invalid login or password</H1>");
            out.println("<FORM action=Login1>");
            out.println("USERNAME :");
            out.println("<INPUT type= text name= username>");
            out.println("<br>");
            out.println("PASSWORD: <input type=password name=password>");
            out.println("<br>");
            out.println("<INPUT type=submit value=login>");
            out.println("</FORM>");
            out.println("<H2 align=left>Dont have an account,create one</H2><FORM action=signup.html><input type=submit value=Create new account></FORM>");
            out.println("</body>");
            out.println("</html>");
		}
		else
		{
			out.println("<html><body><h1> Welcome back</h1></body></html>");
		}
		
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
