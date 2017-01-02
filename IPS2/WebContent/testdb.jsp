<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language ="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.text.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.Locale"%>
<%@ page buffer="16kb"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Test DB</title>
</head>
<body>
                     
<%! Connection con; %>
<%! PreparedStatement ps; 
    CallableStatement cs;%>
<%! ResultSet rs; %>
<%!String url = "jdbc:mysql://localhost:3306/InsuiteSybaseCoreRep";%>
<%!String user = "root";%>
<%!String psw = "password";%>
<%  String driverName = "com.mysql.jdbc.Driver";
try{
	
	
Class.forName(driverName);
con = DriverManager.getConnection(url,user,psw);

//String sql = "SELECT pa.*,Client.name1 FROM invoicepayment pa Left join Client  on Client.sysid = pa.payee where pa.InvoiceTransactionId="+id;
//int pid =Integer.parseInt(String.valueOf(payerid));
ps = con.prepareStatement("Select InvNum from Invoice limit 10");

rs = ps.executeQuery(); 
while(rs.next()){
	%>
	<%=rs.getString(0) %>
	<%}
	con.close();
}
catch(Exception e)
{
   e.printStackTrace();
}

finally
   {
	//con.close();
   }%>

</body>
</html>