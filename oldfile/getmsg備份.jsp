<%@page pageEncoding="UTF-8"%>
<%@page import="javax.naming.Context" %>
<%@page import="javax.naming.InitialContext" %>
<%@page import="javax.sql.DataSource" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="org.sqlite.*" %>
<%@page import="org.json.*"%>
<%@include file="conn_f.jsp"%>
<%

response.setContentType("text/html;charset=utf-8");
request.setCharacterEncoding("utf-8");
//讓瀏覽器不要快取網頁
response.setHeader("Pragma","No-cache");           //HTTP/1.0
response.setHeader("Cache-Control","no-cache");    //HTTP/1.1
response.setDateHeader("Expires", 0);

%>
<html>
<head>
	<script src="js/jquery.js"></script>
	<script src="js/angular.js"></script>
	<script src="js/getmsg.js"></script>
	<link rel=stylesheet type="text/css" href="css/messages.css">

	<title>messageboard</title>
</head>
<body>
	<h1>所有留言</h1>
	<hr>
    <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>author</th>
                    <th>title</th>
                    <th>content</th>
										<th>delete</th>
                </tr>
            </thead>
           <tbody>
        <%
        /*取得資料庫連線(固定格式)*/
            Connection conn = null;
            PreparedStatement pstmt=null;
            ResultSet rs = null;

            try{
                conn=getConnection();

                pstmt=conn.prepareStatement("select * from message");
                rs=pstmt.executeQuery();
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("id") + "</td>");
                    out.println("<td>" + rs.getString("author") + "</td>");
                    out.println("<td>" + rs.getString("title") + " </td>");
                    out.println("<td>" + rs.getString("content") + "</td>");
										out.println("<td><input type='button' class='delmbtn' value='刪除' msgid='"+rs.getString("id")+"'</td>");
                    out.println("</tr>");
                }

                rs.close();
                pstmt.close();
            }
            catch( Exception e){
                throw e;

            }
            finally{
                if(conn!=null)conn.close();
            }
            /*---------------------------------*/
            %>
           </tbody>
    </table>

    <div class="button">
        <input type="button" id="return" value="回到留言表單">
    </div>
</body>
</html>
