package tour.process;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import tour.connection.DBConnection;

import java.sql.ResultSet;

public class SeatCheck {
	public int check(String Source,String Destination, String Depdate,int seats_number) {
		int flag = 0;
		try {
			Connection con;
			DBConnection db = new DBConnection();
			con = db.ConnectionManager();

			PreparedStatement pstmt = null;
			String sqlString = "select * from flight where source=? and destination=? and depature_date=? and availability>=?";
			try {
				pstmt = con.prepareStatement(sqlString);
				pstmt.setString(1, Source);
				pstmt.setString(2, Destination);
				pstmt.setString(3, Depdate);
				pstmt.setInt(4, seats_number);
				ResultSet rs = pstmt.executeQuery();
				if (rs.next()) {
					flag = 1;
				}

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} finally {
			return flag;
		}
	}

}
