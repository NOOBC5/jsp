<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<style>
section {
	position: fixed;
	top: 40px;
	left: 0;
	width: 100%;
	height: 100%;
}

h1 {
	text-align: center;
}

table {
	text-align: center;
	margin: auto;
}
</style>
<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="nav.jsp"></jsp:include>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	Class.forName("oracle.jdbc.OracleDriver");
	
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "system";
	String pw = "1234";
	
	conn = DriverManager.getConnection(url, user, pw);
	String sql = "select a.artist_id, a.artist_name, sum(p.point), round(sum(p.point) / 3,2), rank() over (order by round(sum(p.point) / 3,2) desc) from tbl_artist_201905 a, tbl_mento_201905 m, tbl_point_201905 p where a.artist_id = p.artist_id and m.mento_id = p.mento_id group by a.artist_id, a.artist_name";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
%>
<section>
	<h1>참가자목록조회</h1>
		<table border=1>
			<tr>
				<td>참가번호</td>
				<td>참가자명</td>
				<td>총점</td>
				<td>평균</td>
				<td>등수</td>
			</tr>
			<%while(rs.next()){ %>
				<tr>
					<td><%=rs.getString(1) %></td>
					<td><%=rs.getString(2) %></td>
					<td><%=rs.getString(3) %></td>
					<td><%=rs.getString(4) %></td>
					<td><%=rs.getString(5) %></td>
				</tr>
			<%} %>
		</table>
</section>
<jsp:include page="footer.jsp"></jsp:include>