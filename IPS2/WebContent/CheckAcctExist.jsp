
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*,java.sql.*,java.io.*" %>
<%@page import="javax.servlet.*" %>
<%@page import="javax.servlet.http.*" %>

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
<%@ include file="connection.jsp" %>

<% String accid=request.getParameter("str");%>
<%  String driverName = "net.sourceforge.jtds.jdbc.Driver";
try{
Class.forName(driverName);
String acct = request.getParameter("acct");
con = DriverManager.getConnection(url,user,psw);
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
con.close();
}
%>
</body>
</html>