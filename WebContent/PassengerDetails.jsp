<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Fill out Passenger Details</title>
<style>
     table{
       font-family:helvetica;
       padding:20px 10px;
     }
     input{
        width:220px;
        height:30px;
        border-radius:3px;
        border:1px solid #A4A4A4;
        margin:10px;
     }
     select{
     
     }
     #label{
        font-family:Arial Black;
        color:#424242;
        padding-right:50px;
     }
     th{
        padding-top:30px;
     }
     .smallinput{
        width:80px;
        height:30px;
        border-radius:3px;
        border:1px solid #A4A4A4;
        margin:10px;
     }
     #submit{
        float:right;
        padding:0;
        margin-right:20px;
        width:150px;
     }
     #frame{
        position:absolute;
        background-color:#F2F2F2;
        top:30%;
        left:40%;
        height:150px;
        width:320px;
        border:1px solid black;
        z-index:3;
        display:none;
     }
</style>
</head>
<%@page import="java.util.*"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.servlet.http.Cookie"%>
<%@page import="javax.servlet.http.HttpServlet"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.annotation.WebServlet"%>
<%@page session="false"%>
<body>

	<%
		HttpSession session = request.getSession(false);
	    String flight=request.getParameter("flight");
	    session.setAttribute("flight",flight);
		int i = (Integer) session.getAttribute("number");
		int a = 1;
	%>
    <iframe id="frame" src="" name="choice"></iframe>
	<form id="pass" action="AccommodationChoice.jsp" method="get" target="choice">
		<table align=center>
			<tr>
				<th></th>
				<th>First Name</th>
				<th>Last Name</th>
				<th>Age</th>
				<th>Gender</th>
			</tr>

			<%
				while (a <= i) {
			%>

			<tr>
				<td id="label">Passenger <%=a%>
				</td>
				<td><input type="text" name="fn<%=a %>" required></td>
				<td><input type="text" name="ln<%=a%>" required></td>
				<td><input class="smallinput" type="text" name="age<%=a%>" required></td>
				<td><select class="smallinput" name="gender<%=a%>"><option value=Male>Male</option><option value=Female>Female</option></select></td>
			</tr>

			<%
				a++;
			%>



			<%
				}
			%>

		</table>
		<input id="submit" type="submit" value="Save and Confirm">
		<a href="ShowFlights.jsp"><input id="submit" type="button" value="Cancel"></a> 
	</form>


<script type="text/javascript">

       document.getElementById("pass").onsubmit=function(event){
              document.getElementById("frame").style.display="block";
              document.getElementById("pass").style.opacity="0.2";
       }

</script>
      
</body>
</html>