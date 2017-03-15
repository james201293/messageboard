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
    <title>messsages</title>
    <link rel=stylesheet type="text/css" href="css/viewmsg.css">
    <link rel=stylesheet type="text/css" href="css/jquery-ui.css">
    <script src="js/jquery.js"></script>
    <script src="js/jquery-ui.js"></script>
		<script src="js/angular.js"></script>
    <script src="js/viewmsg.js"></script>
  </head>
  <body>
    <h1>所有留言</h1>
    <hr>
    <div ng-app="myApp" ng-controller="customersCtrl">

          <table>
            <tr>
              <th>id</th>
              <th>author</th>
              <th>title</th>
              <th>content</th>
              <th>刪除</th>
              <!--<th>修改</th>-->
            </tr>
            <tr ng-repeat="x in msg">
              <td>{{x.id}}</td>
              <td>{{x.author}}</td>
              <td>{{x.title}}</td>
              <td>{{x.content}}</td>
              <td><input type="button" ng-click="remove($index,x.id)" value="delete"></td>
              <!--<td><input type="button" ng-click="" value="修改"></td>-->
            </tr>
          </table>

    </div>
  </body>
</html>
