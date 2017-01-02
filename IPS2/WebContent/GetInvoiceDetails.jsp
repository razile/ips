
    <%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.io.*" %>
<%@page import="javax.servlet.*" %>
<%@page import="javax.servlet.http.*" %>
<%@ page import="java.text.NumberFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<table border=0 cellpadding=5 cellspacing=0 width=100%>
<% String id=request.getParameter("id");
id = id.replace("/","");%>
<tr><td colspan=3><h3>Confirmation Number: <%=id %></h3></td></tr>
                         <tr>
                         <td><h3 style="text-align:center">Invoice Number</h3></td>
                         <td><h3>Supplier</h3></td>
                         <td><h3 style="text-align:right">Amount</h3></td>
                         <td><h3 style="text-align:right">Payment Amount</h3></td>
                       </tr>
<%! Connection con; %>
<%! PreparedStatement ps; 
    CallableStatement cs;%>
<%! ResultSet rs; %>
<%@ include file="connection.jsp" %>

<%  String driverName = "net.sourceforge.jtds.jdbc.Driver";
try{
	
	
Class.forName(driverName);
con = DriverManager.getConnection(url,user,psw);

//String sql = "SELECT pa.*,Client.name1 FROM invoicepayment pa Left join Client  on Client.sysid = pa.payee where pa.InvoiceTransactionId="+id;
//int pid =Integer.parseInt(String.valueOf(payerid));
cs = con.prepareCall("{call ipclient(?)}");
cs.setString(1,id );
rs = cs.executeQuery(); 
while(rs.next()){
	 NumberFormat fmt = NumberFormat.getCurrencyInstance(Locale.US);
     Double d = Double.parseDouble(rs.getString("Amount") ) ;
		   String amt = fmt.format(d);
		   d = Double.parseDouble(rs.getString("PaymentAmount") ) ;
		   String pamt = fmt.format(d);
%>
 
                        <tr>
                         <td style="text-align:center"><h3 style="text-align:center"><%=rs.getString("InvoiceNumber") %></h3></td>
                         <td><h3><%=(rs.getString("name1")==null)?rs.getString("Payeeextra"):rs.getString("name1") %></h3></td>
                         <td class="rightJustified"><h3 style="text-align:right"><%=amt %></h3></td>
                         <td class="rightJustified"><h3 style="text-align:right"><%=pamt %></h3></td>
                       </tr>
                       <% String comment = rs.getString("Comments");
                       if (comment.length()>0){ %>
                       <tr><td></td><td colspan=3><h4><%=comment %></h4></td></tr>
                       
                       <%}
                       }}catch(Exception e){ e.printStackTrace(); }
finally{con.close();}
%>
                       </table>

</body>
</html>
