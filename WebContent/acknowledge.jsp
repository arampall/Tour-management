<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
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
<%@page session="false" %>
<% 
try
{
	      HttpSession session=request.getSession(false);
          Connection con;
          System.out.println("hello");
          DBConnection db= new DBConnection();
          con= db.ConnectionManager();
          String flight_id= (String)session.getAttribute("flight");
          String hotel_id;
          char accomodation;
          int passengerno = (Integer) session.getAttribute("number");
          float totalprice=(Float)session.getAttribute("flight_price");
          if(session.getAttribute("hotel_id")!=null)
          {
        	   hotel_id=(String)session.getAttribute("hotel_id");
        	   totalprice=totalprice+(Float)session.getAttribute("hotel_price");
          }
          else
          {
        	   hotel_id="Not Availed";
          }
          Cookie[] cookies = null;
          cookies = request.getCookies(); 
          Cookie cookie1=cookies[1];
          String customerid;
      	int value;
          customerid=cookie1.getName();
          value=Integer.parseInt(cookie1.getValue());
          System.out.println(customerid);
          System.out.println(value);
		  String Card_number=request.getParameter("cardno");
		  System.out.println(Card_number);
		  String Name_on_the_card=request.getParameter("cardname");
		  String Expiry_date=request.getParameter("expiry");
		  String Cvv=request.getParameter("cvv");
		  
          		  
		  PreparedStatement pstmt=null;
	      String sql_String = "select * from paymentdetails";
	      pstmt = con.prepareStatement(sql_String);
  	      ResultSet rs = pstmt.executeQuery();
          int flag=0;
  	    
	      while(rs.next())
	      {
	    	  if(Card_number.equals(rs.getString("Card_number"))&&Name_on_the_card.equals(rs.getString("name_on_the_card"))&&Expiry_date.equals(rs.getString("expiry_date"))&&Cvv.equals(rs.getString("cvv_number")))
	    	  {
	    		  flag=1;
	    		  break;
	    		  
	    	  }
	    	  
	      } 
	      if(flag==1)
	      {
	    	  %>
	    	  <h1 align="center" style="font-family:helvetica">Booking Successful</h1>
	    	  <%
	      
	      PreparedStatement pstmt1=null;
	      String rowcount= " select * from booking";
	      pstmt1 = con.prepareStatement(rowcount);
	      ResultSet result= pstmt1.executeQuery();
	      int count=0;
	      while(result.next()){
	    	  count++;
	      }
	      count++;
	      String booking_id="TMS"+count; 
	      String sql_String1 = "insert into booking(booking_id,flight_id,price,customer_id,hotel_id,status,bookingdate,number_of_passengers)" + "values(?,?,?,?,?,?,?,? )";
	      pstmt1 = con.prepareStatement(sql_String1);
	      pstmt1.setString(1,booking_id);
	      pstmt1.setString(2,flight_id);
	      pstmt1.setFloat(3, totalprice);
	      pstmt1.setInt(4,value);
	      pstmt1.setString(5,hotel_id);
	      pstmt1.setString(6,"upcoming");
	      pstmt1.setDate(7,java.sql.Date.valueOf(LocalDate.now()));
	      pstmt1.setInt(8,passengerno);
	      
  	      boolean result_insert= pstmt1.execute();
  	      String firstname;
  	      String lastname;
  	      int age;
  	      String gender;
  	      PreparedStatement pstmt2 =null;
	      String sql_String2 = "insert into passengerdetails values(?,?,?,?,?)";
	      pstmt2 = con.prepareStatement(sql_String2);
	      try{
  	      for(int i=1; i<=passengerno;i++)
  	      {
  	    	firstname = (String)session.getAttribute("fn" + i);
			lastname = (String)session.getAttribute("ln" + i);
			age =    Integer.parseInt(session.getAttribute("age" + i).toString());
			gender = (String)session.getAttribute("gender" + i);
			
		      pstmt2.setString(1, firstname);
		      pstmt2.setString(2, lastname);
		      pstmt2.setInt(3,age);
		      pstmt2.setString(4,gender);
		      pstmt2.setString(5, booking_id);
		      pstmt2.addBatch();
		      
		
         
 
}}
	      finally{
	    	  pstmt2.executeBatch();
	      }



}}
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

