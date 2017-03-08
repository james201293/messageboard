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
		<script src="js/index.js"></script>
		<link rel=stylesheet type="text/css" href="css/index.css">

		<title>messageboard</title>
</head>
<body ng-app>

	<h1>留言板</h1>
	<span id="greeting">{{cname || 'Hello'}} 你好!!</span>
	<hr>
			<div>
        <table id="form" width="40%" cellspacing="1" cellpadding="3">
            <tr>
                <td width="20%">留言作者:</td>
                <td width="80%"><input type="text" id="txtauthor" ng-model="cname"></td>
            </tr>
            <tr>
                <td width="20%">留言標題:</td>
                <td width="80%"><input type="text" id="txttitle"></td>
            </tr>
            <tr>
                <td width="20%" colspan="2">留言内容:</td>
            </tr>
            <tr>
                <td width="20%"> </td>
                <td width="80%"><textarea id="content" cols="45" rows="7"></textarea>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div align="center">
                        <input type="button" id="submit" value="添加到留言薄">
                        <input
                            type="button" id="clear" value="重新填寫留言">
                        <input
                            type="button" id="allmessage" value="查看所有留言">
            				</div>
                </td>
            </tr>
        </table>

			</div>

</body>
</html>
