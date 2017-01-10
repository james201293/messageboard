<%@page pageEncoding="UTF-8"%>
<%@page import="javax.naming.Context" %>
<%@page import="javax.naming.InitialContext" %>
<%@page import="javax.sql.DataSource" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%!

Connection getConnection(String dn) throws Exception{	

	Context initContext = new InitialContext();
	DataSource ds =null;
	
	try{
		ds = (DataSource) initContext.lookup( dn );   //
	}catch(javax.naming.NameNotFoundException e){
		
		try{
			ds = (DataSource) initContext.lookup( "java:comp/env/"+dn);	  //
		}catch(javax.naming.NameNotFoundException e2){
			throw new Exception(dn + " Data source Name not found!!");
		}
		
		if ( ds == null )
			  throw new Exception(dn + " ds is null : Data source Name not found!!!");  //
		
	}
		
	Connection conn = ds.getConnection();
	return conn;
}


Connection getConnection() throws Exception{
    return getConnection("jdbc/sqlite");   //可以改
}

String trimNull(String value) throws Exception{
    String result="";
    if (value!=null && !value.equals("")){
        result=value;
    }
    return result;
}

%>

<%

response.setContentType("text/html;charset=utf-8");
request.setCharacterEncoding("utf-8");
//讓瀏覽器不要快取網頁
response.setHeader("Pragma","No-cache");           //HTTP/1.0
response.setHeader("Cache-Control","no-cache");    //HTTP/1.1
response.setDateHeader("Expires", 0);


%>

