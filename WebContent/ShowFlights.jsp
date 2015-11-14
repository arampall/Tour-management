<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Select Your Flight</title>
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
<%@page import="tour.server.DBConnection" %>
<%@page session="false" %>


<% 
try
{
	      Connection con;
	      DBConnection db= new DBConnection();
	      con= db.ConnectionManager();
		  String source=request.getParameter("source");
		  String destination=request.getParameter("destination");
		  int no=Integer.parseInt(request.getParameter("number"));
		  Integer a=new Integer(no);
		  
		  String departure_date=request.getParameter("dot");
		 
		  HttpSession session=request.getSession(false);
		  session.setAttribute("destination", destination);
		  session.setAttribute("number", a);
		  
		  System.out.println(session.getCreationTime());
		  
		  
		  
		  PreparedStatement pstmt=null;
	      String sqlString = "select * from flight where source=? and destination=? and depature_date=? and availability>=?";
	      pstmt = con.prepareStatement(sqlString);
    	  pstmt.setString(1, source);
    	  pstmt.setString(2,destination);
    	  pstmt.setString(3,departure_date);
    	  pstmt.setInt(4,no);
    	  ResultSet rs = pstmt.executeQuery();
    	  System.out.println(source);
    	  System.out.println(destination);
    	  System.out.println(departure_date);
    	  
    	  if(rs.next())
    	  {
    	  
    	  rs.previous();
    	  %>
    	  
    	      <form action=PassengerDetails.jsp method="post">
    		  <table>
    		  <tr>
    		  <th>Flightid</th>
    		  <th>Source</th>
    		  <th>Destination</th>
    		  <th>FlightName</th>
    		  <th>DepartureDate</th>
    		  <th>DepartureTime</th>
    		  <th>ArrivalDate</th>
    		  <th>ArrivalTime</th>
    		  <th>Cost</th>
    		  <th>SeatsAvailable</th>
    		  <th>Select</th>
    		  </tr>
    	  
    	  <% 
    	 
    	  while(rs.next())
      	  { %>
    		 
    		  <tr>
    		  <td><% out.println(rs.getString("flightid")); %></td>
    		  <td><% out.println(rs.getString("source")); %></td>
    		  <td><% out.println(rs.getString("destination")); %></td>
    		  <td><% out.println(rs.getString("flightname")); %></td>
    		  <td><% out.println(rs.getString("depature_date")); %></td>
    		  <td><% out.println(rs.getString("departure_time")); %></td>
    		  <td><% out.println(rs.getString("arrival_date")); %></td>
    		  <td><% out.println(rs.getString("arrival_time")); %></td>
    		  <td><% out.println(rs.getString("price")); %></td>
    		  <td><%out.println(rs.getString("availability"));%></td>
    		  <td><input type="radio" name="select"  value=<% out.println(rs.getString("flightid")); %>  ></td>
    		  </tr> 		  
    	<% 	  
    	  }
          %>
          </table>
          <input type="submit" value="Confirm">
           </form>
           <%         
    	  }
    	  
    	  else
    	  {
    		  %>
    		  There are no flights available for this selected date.Please try at a later date.
    		  <a href=CreateTrip.jsp><button>Go Back</button></a>
    <% 		  
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





</body>
</html>