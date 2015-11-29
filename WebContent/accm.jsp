<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Require Accomodation</title>
</head>
<body>
<%@page import ="java.util.*"%>
<%@page import ="java.io.IOException" %>
<%@page import ="java.io.PrintWriter" %>
<%@page import ="java.sql.Connection"  %>
<%@page import ="java.sql.DriverManager" %>
<%@page import ="java.sql.ResultSet" %>
<%@page import ="java.sql.SQLException"  %>
<%@page import ="java.sql.Statement" %>
<%@page import ="javax.servlet.http.Cookie" %>
<%@page import ="javax.servlet.http.HttpServlet" %>
<%@page import ="javax.servlet.http.HttpServletRequest"  %>
<%@page import ="javax.servlet.http.HttpServletResponse" %>
<%@page import ="javax.servlet.ServletException"  %>
<%@page import ="javax.servlet.annotation.WebServlet"  %>
<%@page import ="java.sql.PreparedStatement" %>
<%@page session="false" %>

<%
try
{
          Class.forName("com.mysql.jdbc.Driver");
          System.out.println("Driver found");
	      String url="jdbc:mysql://localhost/mydb";
	      String user="indra";
	      String password="tp123";
	      Connection con=null;	
		  con=DriverManager.getConnection(url, user, password);
		  System.out.println("\n Connected successfully");
		  HttpSession session = request.getSession(false);
		  int i=(Integer)session.getAttribute("number");
		  int a=1;
		  while(a<=i)
		  {
			  String fn=request.getParameter("fn"+a);
			  String ln=request.getParameter("ln"+a);
			  String age=request.getParameter("age"+a);
			  String gender=request.getParameter("gender"+a);
			  session.setAttribute("fn"+a,fn);
			  session.setAttribute("ln"+a,ln);
			  session.setAttribute("age"+a,age);
			  session.setAttribute("gender"+a,gender);
			  a++;
			  
		  }
		  
}		  

		  catch(SQLException e)
		  {
		   System.out.println(e);
		  }

		  catch(ClassNotFoundException e)
		  {
		   System.out.println("Driver not found");
		  }			
%>

<h1>Do you require accomodation?</h1>
<button><a href="accom.jsp">Yes</a></button>
<button><a href="Confirm.jsp">No</a></button>

</body>
</html>