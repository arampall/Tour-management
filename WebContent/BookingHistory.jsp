<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Booking History</title>
<script type="text/javascript" src="jquery-min.js"></script>
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
     table{
     height:auto;
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
     
     ul{
     position:absolute;
     left:10%;
     top:15%;
     list-style:none;
     margin:0;
     padding:0;
     z-index:3;
     }
     
     li{ 
     border:2px solid black;
     margin:5px; 
     display:inline;
     border-bottom-width:1px;
     padding:5px;
     background:#BDBDBD;
     padding-bottom:4px;
     cursor:pointer;
     font-family:helvetica;
     font-weight:bold;
     border-radius:3px;
     }
     
     .content{
     border:2px solid black;
     margin-top:5px;
     position:absolute;
     top:18.3%;
     margin:0 115px;
     padding:0;
     }
     #completed{
         display:none;
     }
     #upcoming{
         display:block;
     }
     #cancel{
         padding:5px;
         float:right;
         margin:10px 20px;
         width:100px;
         border:1px solid;
     }
     
</style>
</head>
<body>
<header>
  <nav>
   <ul>
   <li id="tab1">UpComing</li>
   <li id="tab2">Completed</li>
   </ul>
  </nav>
 </header>
<section class="content" id="completed">
    
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
    String status_change="update booking set status=? where CURDATE()>(select departure_date from flight where flightid=booking.flight_id) and customer_id=?";
    pstmt=con.prepareStatement(status_change);
    pstmt.setString(1,"completed");
    pstmt.setInt(2, value);
    pstmt.executeUpdate();
    pstmt.clearParameters();					
	String booking="select * from booking inner join flight on booking.flight_id=flight.flightid where customer_id=? and status=?" ;
	pstmt=con.prepareStatement(booking);
    pstmt.setInt(1, value);
    pstmt.setString(2, "completed");
    ResultSet rs=pstmt.executeQuery();
    
    String booking_id;
    String flight_id;
    String hotel_id;
    String booking_date;
    String source;
    String destination;
    String flight_name;
    String journey_date;
    String departure_time;
    float  price;
    String accomodation;
    String Status;
    int passengers;
 %>
 <table align=center>
    <tr><th>Source</th><th>Destination</th><th>Flight</th><th>Date Of Departure</th><th>Departure Time</th><th>Price</th><th>Accommodation</th><th>Passengers</tr>
  <%	  
  	  while(rs.next())
	      {
  		      flight_name=rs.getString("flightname");
	    	  source=rs.getString("source");
	    	  destination=rs.getString("destination");
	    	  journey_date=rs.getString("departure_date");
	    	  departure_time=rs.getString("departure_time");
	    	  price=rs.getFloat("price");
	    	  accomodation=rs.getString("hotel_id");
	    	  passengers=Integer.parseInt(rs.getString("number_of_passengers"));
	    	  %>

	     <tr>
	     <td> <%out.print(source);%> </td>
	     <td><%out.println(destination);  %></td>
	     <td> <%out.println(flight_name);%> </td>
	     <td> <%out.println(journey_date);%> </td>
	     <td> <%out.println(departure_time);%> </td>
	     <td> <%out.println(price);%> </td>
	     <td> <%out.println(accomodation);%> </td>
	     <td> <%out.println(passengers);%> </td>
	     </tr>
	     
	    
	 
	    	  
	    	  <%
	      }
	      %>
</table>
<br><br>
</section>
<section class="content" id="upcoming">
<form action="BookingHistory.jsp" method="post">
<table align=center>
    <tr><th>Select</th><th>Source</th><th>Destination</th><th>Flight</th><th>Date Of Departure</th><th> Departure Time</th><th>Price</th><th>Accommodation</th><th>Passengers</tr>
  <%
  if(request.getParameter("booking_cancel")!=null){
  	System.out.println("-----"+request.getParameter("booking_cancel"));
  	PreparedStatement pstmt1=null;					
	String booking1="update booking set status=? where customerid=? and booking_id=?" ;
	pstmt1=con.prepareStatement(booking1);
	String value1= request.getParameter("booking_cancel");
	pstmt1.setString(1, "cancelled");
    pstmt1.setInt(2, value);
    pstmt1.setString(3,value1);
    pstmt1.executeUpdate();
  }					
    pstmt.setInt(1, value);
    pstmt.setString(2, "upcoming");
    ResultSet rs_open=pstmt.executeQuery();
  	  while(rs_open.next())
	      {
  		      flight_name=rs_open.getString("flightname");
	    	  source=rs_open.getString("source");
	    	  destination=rs_open.getString("destination");
	    	  journey_date=rs_open.getString("departure_date");
	    	  departure_time=rs_open.getString("departure_time");
	    	  price=rs_open.getFloat("price");
	    	  accomodation=rs_open.getString("hotel_id");
	    	  passengers=Integer.parseInt(rs_open.getString("number_of_passengers"));
	    	  booking_id=rs_open.getString("booking_id");
	    	  %>

	     <tr>
	     <td><input type="radio" value="<%=booking_id%>" name="booking_cancel"></td>
	     <td> <%out.print(source);%> </td>
	     <td><%out.println(destination);  %></td>
	     <td> <%out.println(flight_name);%> </td>
	     <td> <%out.println(journey_date);%> </td>
	     <td> <%out.println(departure_time);%> </td>
	     <td> <%out.println(price);%> </td>
	     <td> <%out.println(accomodation);%> </td>
	     <td> <%out.println(passengers);%> </td>
	     </tr>
	     
	    
	 
	    	  
	    	  <%
	      }
	      %>
</table>
<input type=submit id="cancel" value="Cancel">
</form>
</section>
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

<script>
     $("#tab1").css({"background-color":"white","border-bottom":"none","padding-bottom":"6px"});
     $("li").click(function(){
    	 $("li").css({"background-color":"#BDBDBD","border-bottom-width":"1px","padding-bottom":"4px"});
    	    $(this).css({"background-color":"white","border-bottom":"none","padding-bottom":"6px"});
    	    $("#completed").toggle();
    	    $("#upcoming").toggle();
    	
     })
</script>

</body>
</html>