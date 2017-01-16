<%@page pageEncoding="UTF-8"%>
<%@page import="javax.naming.Context" %>
<%@page import="javax.naming.InitialContext" %>
<%@page import="javax.sql.DataSource" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="org.sqlite.*" %>
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
	<script src="jquery.js"></script>
	<title>messageboard</title>

	<style type="text/css">
		body{
			background-color: #FFEE99
		}
		table,tr,td,th{
			 border: 1px solid black;
			 border-collapse: collapse;
			 font-weight:bold;
		}
		table{
			/*真正的表格置中*/
			margin-left:auto;
			margin-right:auto;
			background-color: #FFFFBB
		}
		h1{
			text-align: center;
			color: red;
		}
        #form1,.button{
            margin-left:auto;
            margin-right:auto;
            background-color: #FFFFBB;
            text-align: center;
        }
	</style>

    <script>
    function validate() {
        var display = document.getElementById("display");
        var input = document.getElementById("input");
        var number = /\d/;
        if (number.test(input.value)) {
            display.innerHTML = "Right!"
            document.getElementById('deletebtn').disabled=false;
        }
        else {
            display.innerHTML = "Wrong!!!!!"
            document.getElementById('deletebtn').disabled=true;
        }
    }
    </script>

</head>
<body>
	<h1>所有留言</h1>
	<hr>
	<form name="form1" id="form1" method="post" action="deletemsg.jsp">
            請輸入要刪除的ID：
            <input type="text" id="input" name="deleteindex" oninput="validate()">
            <input type="submit" id="deletebtn" name="delete" value="刪除留言">
            <div id="display"></div>
    </form>

    <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>author</th>
                    <th>title</th>
                    <th>content</th>
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
        <input type="button" value="回到留言表單" onclick="window.open('index.jsp')">
    </div>
</body>
</html>
