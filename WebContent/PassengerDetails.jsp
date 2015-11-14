<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Fill out Passenger Details</title>
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

<%
HttpSession session = request.getSession(false);
int i=(Integer)session.getAttribute("number");
int a=1;
%>

<form>
<table>
<tr>
<th>PassengerNumber</th>
<th>FirstName</th>
<th>LastName</th>
<th>Age</th>
<th>Gender</th>
</tr>

<%
while(a<=i)
{
%>

<tr>
<td>
Passenger no:<%=a%>
</td>
<td>
<input type="text" name="fn<%=a%>">
</td>
<td>
<input type="text" name="ln<%=a%>">
</td>
<td>
<input type="text" name="age<%=a%>">
</td>
<td>
<input type="text" name="gender<%=a%>">
</td>
</tr>

<%
a++;
%>



<%
}

%>

</table>
<input type="submit" value="Save and confirm">
</form>







</body>
</html>