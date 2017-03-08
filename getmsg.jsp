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
out.clear();
response.setContentType("text/html;charset=utf-8");
request.setCharacterEncoding("utf-8");
//讓瀏覽器不要快取網頁
response.setHeader("Pragma","No-cache");           //HTTP/1.0
response.setHeader("Cache-Control","no-cache");    //HTTP/1.1
response.setDateHeader("Expires", 0);

%>

	      <%
        /*取得資料庫連線(固定格式)*/
            Connection conn = null;
            PreparedStatement pstmt=null;
            ResultSet rs = null;

            try{
							JSONObject jsonResponse = new JSONObject();
							JSONArray data = new JSONArray();



              conn=getConnection();
              pstmt=conn.prepareStatement("select * from message");
              rs=pstmt.executeQuery();

						while (rs.next()){
							JSONObject row = new JSONObject();
							row.put("id",rs.getString("id"));
              row.put("author",rs.getString("author"));
              row.put("title",rs.getString("title"));
              row.put("content",rs.getString("content"));
              data.put(row);
            }

						jsonResponse.put("Responsemsg", data);

						out.clear();
						out.print(jsonResponse);
					  System.out.print(jsonResponse);

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
