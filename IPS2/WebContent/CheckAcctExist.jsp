
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*,java.sql.*,java.io.*" %>
<%@page import="javax.servlet.*" %>
<%@page import="javax.servlet.http.*" %>
<%@page import="com.ips.database.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%! Connection con; %>
<%! PreparedStatement ps; %>
<%! ResultSet rs; %>


<% String accid=request.getParameter("str"); %>

<%
try{

String acct = request.getParameter("acct");

con = SqlServerDBService.getInstance().openConnection();

if (acct!=null && acct.length()>0){
String sql = "SELECT SysId FROM PayersAccounts pa where  pa.AccountNumber='" + acct + "'";
ps = con.prepareStatement(sql);
rs = ps.executeQuery(); 
if (rs.next()) 
{
     response.setContentType("text/xml");
     response.setHeader("Cache-Control", "no-cache");
     response.getWriter().write("Account already exists."); 
 } else 
   {
     response.setContentType("text/xml");
     response.setHeader("Cache-Control", "no-cache");
     response.getWriter().write(""); 
  } 
}else
{
	response.setContentType("text/xml");
    response.setHeader("Cache-Control", "no-cache");
    response.getWriter().write(""); 
}

}
catch(Exception e)
{ e.printStackTrace();}
finally{
SqlServerDBService.getInstance().releaseConnection(con);
}
%>
</body>
</html>