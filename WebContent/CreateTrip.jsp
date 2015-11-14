<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Start a new Trip</title>
</head>
<body background="https://wallpaperscraft.com/image/eiffel_tower_paris_france_night_hdr_85518_1920x1080.jpg ">

<%@page import  = "java.util.*"%>
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
<%@page import="tour.server.DBConnection" %>
<%@page session="false" %>

<% 
try
{
	      HttpSession session=request.getSession(false);
          Connection con;
          DBConnection db= new DBConnection();
          con= db.ConnectionManager();

		  String Source;
		  String Destination;
          		  
		  PreparedStatement pstmt=null;
	      String sql_String = "select * from source";
	      pstmt = con.prepareStatement(sql_String);
  	      ResultSet rs_source = pstmt.executeQuery();
  	      sql_String="select*from destination";
  	      pstmt=con.prepareStatement(sql_String);
  	      ResultSet rs_destination=pstmt.executeQuery();
  	      
  	      %>
		  <form action=ShowFlights.jsp method=post>
		  <div>Source
		  <select name=source>
		  <%
		  while(rs_source.next())
		  {
			 Source=rs_source.getString("source");
			 %>
			 <option><%out.println(Source); %></option>
	
		  <%
		  System.out.println("hi");
		  }%>
  	      </select>
  	      </div>
  	      <br>
  	      <div>Destination
  	      <select name=destination>
  	      <%
  	      while(rs_destination.next())
  	      {
  	    	  Destination=rs_destination.getString("destination");
  	    	  %>
  	    	 <option ><%out.println(Destination); %>
			 </option>
			 	  
  	      <%} %>
  	      
  	      </select>
  	      </div>
  	      <div>
	      Select the date of your travel:<input type=date name=dot required/>
	      </div>
	      <br/>
	      <div>
	      Enter number of Passengers:<input type=text name=number required/>
	      </div>
	      <br/>
  	      <input type=submit value=next>
  	      </form>
		<% 
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


</body>
</html>