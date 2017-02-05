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

		#deltable,#deltable>tr,.button{
        margin-left:auto;
        margin-right:auto;
				margin-top:3em;
				margin-bottom: 3em;
        background-color: #FFFFBB;
        text-align: center;
    }
	</style>

    <script type="text/javascript">  //驗證是否為數字
    function validate() {
        var display = document.getElementById("display");
        var input = document.getElementById("deleteindex");
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
		<table id="deltable">
				<tr>
            <td>請輸入要刪除的ID：</td>
            <td><input type="text" id="deleteindex" oninput="validate()"></td>
            <td><input type="button" id="deletebtn" value="刪除留言"></td>
            <td id="display"></td>
				</tr>
  	</table>

		<script type="text/javascript">
				$("#deletebtn").click(function(e){ //送出表單

					$.ajax({
						type: "POST",
						url: "deletemsg.jsp",
						dataType: "html",
						data: {deleteindex: $("#deleteindex").val()},
						cache: false,
						success: function(response){
							alert("delet succcess");
							location.reload();  //刷新網頁
						},
						error: function(xhr){
							alert(xhr.status);
						}


					});
				});
		</script>

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

		<script type="text/javascript">
				$(document).on('click','.delmbtn',function(){
					
						$.ajax({
							type: "POST",
							url: "deletemsg.jsp",
							dataType: "html",
							data: {deleteindex: +$(this).attr('msgid')}, //傳入該留言id
							cache: false,
							success: function(response){
								location.reload();  //刷新網頁
							},
							error: function(xhr){
								alert(xhr.status);
							}

						});
				});
		</script>

    <div class="button">
        <input type="button" value="回到留言表單" onclick="window.open('index.jsp')">
    </div>
</body>
</html>
