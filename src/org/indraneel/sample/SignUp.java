package org.indraneel.sample;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SignUp
 */
@WebServlet(description = "Signing up", urlPatterns = { "/SignUp" })
public class SignUp extends HttpServlet {
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
		System.out.println("Inside Signup");
		try {
		     Class.forName("com.mysql.jdbc.Driver");
		     System.out.println("Driver found");
				
				
				String url="jdbc:mysql://localhost/tour";
				String user="root";
				String password="achyut";
				Connection con=null;
				
				
					con=DriverManager.getConnection(url, user, password);
					System.out.println("\n Connected successfully");
					Statement stmt = con.createStatement();
					
				
				
				
				
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");// TODO Auto-generated method stub
		String username=request.getParameter("usermail");
		String password1=request.getParameter("userpass");
		String fname=request.getParameter("firstname");
		String lname=request.getParameter("lastname");
		String no=request.getParameter("mno");
		String address=request.getParameter("address");
		String birth =request.getParameter("dob");
		
		/*SimpleDateFormat formatter=new SimpleDateFormat("yyyy/mm/dd");
		try {
			Date date=formatter.parse(birth);
			 System.out.println(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		
		
       
        System.out.println(no);
				
        String query = "INSERT INTO customer(firstname,lastname,emailid,phoneno,dob,address,password)" + 
		           "VALUES ('" + fname + "', '" + lname + "', '" + username + "','"+no+"','"+birth+"','"+address+"','"+password1+"')";
		
			
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
