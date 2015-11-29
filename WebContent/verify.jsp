<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Verification</title>
</head>
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
<body>
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
		  String ccno=request.getParameter("ccno");
		  String cvv=request.getParameter("cvv");
		  String edate=request.getParameter("edate");
		  Cookie[] cookies = null;
		  cookies = request.getCookies(); 
		  Cookie cookie1=cookies[1];
		  String value=cookie1.getValue();
		  String value1=new String(value);
		  int bal=0;
		  HttpSession session = request.getSession(false);
		  int c;
		  int flag1=0;
		  int a=(Integer)session.getAttribute("planecost");
		    
		  int flag=(Integer)session.getAttribute("flag");
		    
		  if(flag==1)
		  {
		    
		   int b=(Integer)session.getAttribute("roomcost");
		   c=a+b;
		     
		  }
		   else
		   c=a;
		  
		  
		  PreparedStatement pstmt=null;
	      String sqlString = "select * from creditcard"; //CreditCard details
	      pstmt = con.prepareStatement(sqlString);
    	  ResultSet rs = pstmt.executeQuery();
          
    	  while(rs.next())
    	  {
    		  if(ccno.equals(rs.getString("ccno"))&&cvv.equals(rs.getString("cvv"))&&edate.equals(rs.getString("edate")))
    		  {
    			  bal=Integer.parseInt(rs.getString("balance"));
    			  flag1=1;
    			  break;
    		  }
    			  
    		  else
    		  {
    			  System.out.println("not equal");
    		      
    		  }   
    	  }
    	  
    	  if(flag1==0)
    	  {%>
    	  <form action=verify.jsp method=post>
    	  <p>
    	  <h1>Invalid CreditcardNo or CVV or ExpiryDate</h1>
           Your bill amount is:<%=c %>
           <p>
           Credit-Card-Number<input type="text" name="ccno">
           </p>
           <p>
           CVV<input type="text" name="cvv">
           </p>
           <p>
           ExpiryDate<input type="date" name="edate">
           </p>
           <input type="submit" value="Pay">
           </form>
    		<%  
    	  }
    	  else
    	  if(c>bal)
    	  {
    	  %>
    	  <form action=verify.jsp method=post>
    	  <p>
    	  <h1>You havent got enough funds to do this transaction</h1>
           Your bill amount is:<%=c %>
           <p>
           Credit-Card-Number<input type="text" name="ccno">
           </p>
           <p>
           CVV<input type="text" name="cvv">
           </p>
           <p>
           ExpiryDate<input type="date" name="edate">
           </p>
           <input type="submit" value="Pay">
           </form>
    	  <%
    	  }
    	  else
    	  {
    		  
    		  String bid=null;
    		  String sqlString1 = "select * from bid"; //Get the bid 
    	      pstmt = con.prepareStatement(sqlString1);
        	  ResultSet rs1 = pstmt.executeQuery();
        	  while(rs1.next())
        		  bid=rs1.getString("id");
    		  value=value.concat(bid);
    		  
    		  
    		  String sqlString2="update bid set id=id+1"; //update the booking id
    		  pstmt=con.prepareStatement(sqlString2);
    		  pstmt.executeUpdate();
    		  
    		  String flightid=(String)session.getAttribute("Flightid");
    		  System.out.println(flightid);
    		  
    		  String sqlString3="insert into bookingflight values(?,?,?)"; //Bookingflight inserted
    		  pstmt = con.prepareStatement(sqlString3);
        	  pstmt.setString(1,value);
        	  pstmt.setString(2,flightid);
        	  pstmt.setString(3,value1);
        	  pstmt.executeUpdate();
        	  
        	  int number=(Integer)session.getAttribute("number");
        	  int cou=1;
        	  while(cou<=number)
        	  {
        	  String fn=(String)session.getAttribute("fn"+cou);
        	  String ln=(String)session.getAttribute("ln"+cou);
        	  String age=(String)session.getAttribute("age"+cou);
        	  String gender=(String)session.getAttribute("gender"+cou);
        	  String sqlString4="insert into bookingpassengers values(?,?,?,?,?,?)";
        	  pstmt=con.prepareStatement(sqlString4);
        	  pstmt.setString(1,value);
        	  pstmt.setString(2,fn);
        	  pstmt.setString(3,ln);
        	  pstmt.setString(4,age);
        	  pstmt.setString(5,gender);
        	  pstmt.setString(6,value1);
        	  pstmt.executeUpdate();
        	  cou++;
        	  }
        	  
        	  int flag3=(Integer)session.getAttribute("flag");
        	  System.out.println(flag3);
        	  if(flag3==1)
        	  {
        		  String[] check=(String[])session.getAttribute("check");
        		  for(String s: check)
        	        {
        			  int roomno=(Integer)session.getAttribute(s+"1");
        			  String sqlString5="insert into bookingaccom values(?,?,?,?)";
                	  pstmt=con.prepareStatement(sqlString5);
                	  pstmt.setString(1,value);
                	  pstmt.setString(2,s);
                	  pstmt.setInt(3,roomno);
                	  pstmt.setString(4,value1);
                      pstmt.executeUpdate();
        	        }
        		  
        	  }
        	  String sqlString6="Update creditcard set balance=balance-? where ccno=?";
        	  pstmt=con.prepareStatement(sqlString6);
        	  pstmt.setInt(1,c);
        	  pstmt.setString(2,ccno);
        	  pstmt.executeUpdate();
    		  
    		  
    		 %>
    		 <h1>Congratulations,You have successfully booked your trip.</h1> 
    		  
    		  
    	  <% }
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