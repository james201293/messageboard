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
<%@page import="javax.json.JsonString"%>
<%@page import="javax.json.JsonObject"%>
<%@page import="javax.json.JsonReader"%>
<%@page import="javax.json.Json"%>
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
	/*Query String Parameter方法
	int index = Integer.parseInt(request.getParameter("deleteindex"));*/

	//Payload方法
  // 從 request 取出 JSON
	int index=0;
	String indexstr="";
	JsonObject data=null;
	//實作JsonReader把request丟進去
  JsonReader jsonReader = Json.createReader(request.getReader());
  try {
				data = jsonReader.readObject();  //讀取Object
		    jsonReader.close();
				indexstr=data.getString("deleteindex");  //取得deleteindex字串
      	index=Integer.parseInt(indexstr);  
  }
  catch(Exception e){
				throw e;
  }

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
					json.put("index",index);
					out.print(json); //傳回
        }
        catch( Exception e){
            throw e;

        }
        finally{
            if(conn!=null)conn.close();
        }
            /*---------------------------------*/
						%>
