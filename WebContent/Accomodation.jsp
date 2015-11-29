<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Hotels</title>
<style>
.name {
	font-size: 1.2em;
	border: 1px solid black;
}

img {
	height: 300px;
	width: 400px;
}
button{
    height:20px;
    width:100px;
    margin:10px 10px;
}
</style>
</head>
<body>
	<form id="hotel" action="Confirmation.jsp" method="get"></form>
	<table id="Hotels">
		<%@page import="java.util.*"%>
		<%@page import="java.io.IOException"%>
		<%@page import="java.io.PrintWriter"%>
		<%@page import="java.sql.Connection"%>
		<%@page import="java.sql.DriverManager"%>
		<%@page import="java.sql.ResultSet"%>
		<%@page import="java.sql.SQLException"%>
		<%@page import="java.sql.Statement"%>
		<%@page import="javax.servlet.http.Cookie"%>
		<%@page import="javax.servlet.http.HttpServlet"%>
		<%@page import="javax.servlet.http.HttpServletRequest"%>
		<%@page import="javax.servlet.http.HttpServletResponse"%>
		<%@page import="javax.servlet.ServletException"%>
		<%@page import="javax.servlet.annotation.WebServlet"%>
		<%@page import="java.sql.PreparedStatement"%>
		<%@page import="tour.connection.DBConnection"%>
		<%@page session="false"%>
		<%
			try {
				Connection con;
				DBConnection db = new DBConnection();
				con = db.ConnectionManager();
				HttpSession session = request.getSession(false);
				String flight = (String) session.getAttribute("flight");
				int n = (Integer) session.getAttribute("number");
				PreparedStatement pstmt = null;
				String hotel = "select * from accomodation inner join flight on accomodation.Check_in=flight.arrival_date where flightid=? and accomodation.rooms_available>=?";
				pstmt = con.prepareStatement(hotel);
				pstmt.setString(1, flight);
				pstmt.setInt(2, n);
				ResultSet rs = pstmt.executeQuery();

				String hotel_id;
				String hotel_name;
				String destination;
				String checkin_date;
				float price;
				String availability;
				String image_location;
				String roomtype;

				while (rs.next()) {
		%>

		<tr>
			<td><img src="images/Suprabath.jpg">
			<div class="name">
					<p>
						Hotel name:
						<%
						out.println(rs.getString("Hotel_name"));
					%>
					</p>
					<p>
						Type:
						<%
						out.println(rs.getString("Roomtype"));
					%>
					</p>
					<p>
						Destination:
						<%
						out.println(rs.getString("Destination"));
					%>
					</p>
					<p>Distance from airport: 1.5miles</p>
					<button type=submit name="hotelbook"
						value="<%out.println(rs.getString("ID"));%>" form="hotel">Book</button>
				</div></td>

		</tr>
		<%
			}
			} catch (SQLException e) {
				System.out.println(e);
			}

			catch (ClassNotFoundException e) {
				System.out.println("Driver not found");
			}
		%>
	</table>
</body>
</html>