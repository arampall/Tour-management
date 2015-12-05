<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Booking History</title>
<style>
     html{
     height:100%;
     width:100%;
     }
     body{
     height:100%;
     width:100%;
     background-size:100% 100%;
     }  
     th{
         height:30px;
         background-color:#BDBDBD;
         font-size:1.2em;
         padding:10px 20px;
     }
     td{
         font-size:1.1em;
         padding:10px 20px;
         text-align:center;
         
     }
     tr{
     background-color:#F5F6CE;
     }

     
</style>
</head>
<body>
<div id="content">
    
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
<%@page import="tour.connection.DBConnection" %>
<%
try {
	Connection con;
    DBConnection db= new DBConnection();
	con= db.ConnectionManager();
	Cookie[] cookies = null;
    cookies = request.getCookies(); 
    Cookie cookie1=cookies[1];
    String customerid;
	int value;
    customerid=cookie1.getName();
    value=Integer.parseInt(cookie1.getValue());
    System.out.println(customerid);
    System.out.println(value);
    PreparedStatement pstmt=null;					
	String booking="select * from booking where customerid=? and status=?" ;
	pstmt=con.prepareStatement(booking);
    pstmt.setInt(1, value);
    pstmt.setString(2, "closed");
    ResultSet rs=pstmt.executeQuery();
    
    int booking_id;
    String flight_name;
    String source;
    String destination;
    String journey_date;
    String departure_time;
    float price;
    String accomodation;
    String Status;
 %>
 <table align=center>
    <tr><th>Source</th><th>Destination</th><th>Flight</th><th>Date Of Departure</th><th>Time Of Travel</th><th>Price</th><th>Accomodation Availed</th><th>Status</tr>
  <%	  
  	  while(rs.next())
	      {
  		      flight_name=rs.getString("flight_name");
	    	  source=rs.getString("source");
	    	  destination=rs.getString("destination");
	    	  journey_date=rs.getString("journeydate");
	    	  departure_time=rs.getString("departuretime");
	    	  price=rs.getFloat("price");
	    	  accomodation=rs.getString("accomodation");
	    	  Status=rs.getString("status");
	    	  System.out.println(flight_name);
	    	  %>

	     <tr>
	     <td> <%out.print(source);%> </td>
	     <td><%out.println(destination);  %></td>
	     <td> <%out.println(flight_name);%> </td>
	     <td> <%out.println(journey_date);%> </td>
	     <td> <%out.println(departure_time);%> </td>
	     <td> <%out.println(price);%> </td>
	     <td> <%out.println(accomodation);%> </td>
	     <td> <%out.println(Status);%> </td>
	     </tr>
	     
	    
	 
	    	  
	    	  <%
	      }
	      %>
</table>
<br><br>
<form action="">
<table align=center>
    <tr><th>Select</th><th>Source</th><th>Destination</th><th>Flight</th><th>Date Of Departure</th><th>Time Of Travel</th><th>Price</th><th>Accomodation Availed</th><th>Status</tr>
  <%
    PreparedStatement pstmt1=null;					
	String booking1="select * from booking where customerid=? and status=?" ;
	pstmt=con.prepareStatement(booking);
    pstmt.setInt(1, value);
    pstmt.setString(2, "open");
    ResultSet rs_open=pstmt.executeQuery();
  	  while(rs_open.next())
	      {
  		      flight_name=rs_open.getString("flight_name");
	    	  source=rs_open.getString("source");
	    	  destination=rs_open.getString("destination");
	    	  journey_date=rs_open.getString("journeydate");
	    	  departure_time=rs_open.getString("departuretime");
	    	  price=rs_open.getFloat("price");
	    	  accomodation=rs_open.getString("accomodation");
	    	  Status=rs_open.getString("status");
	    	  booking_id=rs_open.getInt("booking_id");
	    	  System.out.println(flight_name);
	    	  %>

	     <tr>
	     <td><input type="radio" value="booking_id"></td>
	     <td> <%out.print(source);%> </td>
	     <td><%out.println(destination);  %></td>
	     <td> <%out.println(flight_name);%> </td>
	     <td> <%out.println(journey_date);%> </td>
	     <td> <%out.println(departure_time);%> </td>
	     <td> <%out.println(price);%> </td>
	     <td> <%out.println(accomodation);%> </td>
	     <td> <%out.println(Status);%> </td>
	     </tr>
	     
	    
	 
	    	  
	    	  <%
	      }
	      %>
</table>
<input type=submit id="cancel" value="Cancel">
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

</div>
</body>
</html>