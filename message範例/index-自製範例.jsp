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
	<title>messageboard</title>
   
	<style type="text/css">
		body{
			background-color: #FFEE99
		}
		table,tr,td{
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
	</style>


    
</head>
<body>
	<h1>留言板</h1>
	<hr>
	<form name="form1" method="post" action="alert.jsp">  <!--method:get/post;action:送出目的地-->
        <table id="form" width="40%" cellspacing="1" cellpadding="3" >  
            <tr>  
                <td width="20%">留言作者:</td>  
                <td width="80%"><input type="text" name="txtauthor"></td>  
            </tr>  
            <tr>  
                <td width="20%">留言標題:</td>  
                <td width="80%"><input type="text" name="txttitle"></td>  
            </tr>  
            <tr>  
                <td width="20%" colspan="2">留言内容:</td>  
                 
            </tr>  
            <tr>  
                <td width="20%"> </td>  
                <td width="80%"><textarea name="content" cols="45" rows="7"></textarea>  
                </td>  
            </tr>  
            <tr>  
                <td colspan="2">  
                    <div align="center">  
                        <input type="submit" name="cmdok" value="添加到留言薄">   
                        <input  
                            type="reset" name="cmdreset" value="重新填寫留言">  
                        <input  
                            type="button" name="cmdread" value="查看所有留言"  
                            onclick="window.open('messages.jsp')">
            		</div>  
                </td>  
            </tr>
        </table>  
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
    <form name="form1" id="form1" method="post" action="">
            <input type="text" name="deleteindex">
            <input type="submit" name="delete" value="刪除留言">
    </form>       
</body>
</html>