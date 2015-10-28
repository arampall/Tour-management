package org.indraneel.sample;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
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
		int unique=0;
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
			PrintWriter out=response.getWriter();
			response.setContentType("text/html");	
			out.println("<html>");
            out.println("<title>Invalid login or password</title>");
            out.println("<body background=http://2.bp.blogspot.com/-bpCr9dBLw4Y/Tr1f3pDiqkI/AAAAAAAAA6M/DEihidF19cA/s1600/love+City-Wallpaper-geeksbowl.com-High-Definition-1080p-HD-30.jpg>");
            out.println("<H1 ALIGN=CENTER>TOURISTFEST-ALL IN ONE</H1>");
            out.println("<H2>Invalid login or password</H2>");
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
            String sql1="SELECT id,emailid from customer";
    		ResultSet rs1=stmt.executeQuery(sql1);
    		while(rs1.next())
    		{
    			String use = rs1.getString("emailid");
		         unique = Integer.parseInt(rs1.getString("id"));
		         if(use.equals(username))
		        	 break;
    		}
    		System.out.println(unique);	
    		
    Cookie id = new Cookie("id",Integer.toString(unique)
                    );
    Cookie login=new Cookie("login","1");
    id.setMaxAge(60*60*24);
    login.setMaxAge(60*60*24);
    response.addCookie( id );
    response.addCookie( login );
    
    PrintWriter out=response.getWriter();
	response.setContentType("text/html");
    		out.println("<html><body background=http://fullhdpictures.com/wp-content/uploads/2015/03/HD-New-York-Pictures.jpg><h1> Welcome back</h1><a href=view.jsp>View profile </a></body></html>");
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
