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

<input type="button" value="回到留言表單" onclick="window.open('index.jsp')">
<input type="button" name="cmdread" value="查看所有留言" onclick="window.open('messages.jsp')">
<hr>
<%
				String author1=request.getParameter("txtauthor");
        String title1=request.getParameter("txttitle");
        String content1=request.getParameter("content");
        /*取得資料庫連線(固定格式)*/
            Connection conn = null;
            PreparedStatement pstmt=null;
            String sql="insert into message (author,title,content) values (?,?,?)";  //傳入使用者輸入的變數

            try{
                conn=getConnection();

                pstmt=conn.prepareStatement(sql);
								pstmt.setString(1, author1);
								pstmt.setString(2, title1);
								pstmt.setString(3, content1);

                pstmt.executeUpdate();

                out.print("update sucess");

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
