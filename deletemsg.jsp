<%@page pageEncoding="UTF-8"%>
<%@page import="javax.naming.Context" %>
<%@page import="javax.naming.InitialContext" %>
<%@page import="javax.sql.DataSource" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="org.sqlite.*" %>
<%@include file="conn_f.jsp"%>
<%@page import="org.json.*"%>
<%
out.clear();
response.setContentType("application/json");
request.setCharacterEncoding("utf-8");
//讓瀏覽器不要快取網頁
response.setHeader("Pragma","No-cache");           //HTTP/1.0
response.setHeader("Cache-Control","no-cache");    //HTTP/1.1
response.setDateHeader("Expires", 0);

%>

<%
	int index = Integer.parseInt(request.getParameter("deleteindex"));

    /*取得資料庫連線(固定格式)*/
    Connection conn = null;
    PreparedStatement pstmt=null;
    String deletesql="delete from message where id=?"; //sql請求

    		try{
          conn=getConnection();
          pstmt=conn.prepareStatement(deletesql);

          pstmt.setInt(1, index); //傳入第1個參數index

		    //execute(執行) delete SQL statement
		    pstmt.executeUpdate();
      	pstmt.close();

				JSONObject json = new JSONObject();
  				json.put("exe_status", "delete success");
					out.print(json);
        }
        catch( Exception e){
            throw e;

        }
        finally{
            if(conn!=null)conn.close();
        }
            /*---------------------------------*/
						%>
