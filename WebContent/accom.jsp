<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Displaying accomodation options</title>
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
          
		  HttpSession session=request.getSession(false);
		  String place1=(String)session.getAttribute("destination");
		  session.setAttribute("flag",1);
		  
		  System.out.println(place1);
		  PreparedStatement pstmt=null;
	      String sqlString = "select distinct hotel from accomodation where place=?";
	      pstmt = con.prepareStatement(sqlString);
    	  pstmt.setString(1,place1);
    	  ResultSet rs = pstmt.executeQuery();
    	 
    	  %>
    	  
    	  <form action=room.jsp method="post">
    		  <table>
    		  <tr>
    		  <th>Place</th>
    		  <th>Hotel</th>
    		  <th>Select your hotel</th>
    		  </tr>
    	  
    	<%  while(rs.next())
    	  {
    		
    		  String hotel=rs.getString("hotel");
    	%>
    	
    	     <tr>
    	     <td><%=place1 %></td>
    	     <td><%=hotel %></td>
    	     <td><input type="radio" name="select"  value=<%=hotel%>> </td>
    	     </tr>
    		  
    		  
    		  <% 
    	  }
             %>
           </table>
           <input type="submit" value="Confirm">
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