<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Payment</title>
</head>
<%@page import  = "java.util.*"%>
<%@page import ="java.io.IOException" %>
<%@page import ="javax.servlet.http.Cookie" %>
<%@page import ="javax.servlet.http.HttpServlet" %>
<%@page import ="javax.servlet.http.HttpServletRequest"  %>
<%@page import ="javax.servlet.http.HttpServletResponse" %>
<%@page import ="javax.servlet.ServletException"  %>
<%@page import ="javax.servlet.annotation.WebServlet"  %>
<%@page session="false" %>
<body>
<%  HttpSession session = request.getSession(false);
    int c;
    int a=(Integer)session.getAttribute("planecost");
    
    int flag=(Integer)session.getAttribute("flag");
    
    if(flag==1)
    {
    
    int b=(Integer)session.getAttribute("roomcost");
     c=a+b;
     
    }
    else
    	c=a;
   
%>
<form action=verify.jsp method=post>
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
</body>
</html>