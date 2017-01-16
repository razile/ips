
    <%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.io.*" %>
<%@page import="javax.servlet.*" %>
<%@page import="javax.servlet.http.*" %>
<%@page import="ProcessAcctData.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link rel="stylesheet" href="payer.css" type="text/css"/>
<title></title>
</head>
<body>
<%! Connection con; 
    Connection con1; %>
<%! PreparedStatement ps; %>
<%! ResultSet rs; %>
<%@ include file="connection.jsp" %>

<% String accid=request.getParameter("str");
String pid=request.getParameter("pid");

try{
Class.forName(DBProperties.JDBC_SQLSERVER_DRIVER);
con = (Connection) DriverManager.getConnection(DBProperties.CONNECTION_SQLSERVER_URL, DBProperties.USERNAME_SQLSERVER, DBProperties.PASSWORD_SQLSERVER);
con1 = (Connection) DriverManager.getConnection(DBProperties.CONNECTION_SYBASE10_URL, DBProperties.USERNAME_SYBASE10, DBProperties.PASSWORD_SYBASE10);


String sql = "SELECT SysId,TransitNumber,BranchCode,AccountNumber,CurrencyType FROM PayersAccounts pa where pa.SysId="+accid;
ps = con.prepareStatement(sql);
rs = ps.executeQuery(); 
SimpleDateFormat df = new SimpleDateFormat("MMMM dd, yyyy");
String formattedDate = df.format(new java.util.Date());
while(rs.next()){
	//int payerid=Integer.parseInt(session.getAttribute("pyid").toString());;
	  sql = "SELECT Name1, DebtorId,a.street1,a.street2, a.city,a.state,a.zip FROM Debtor d join Address a on a.SysParentId =  d.SysId where a.addressType='Main' and a.ParentTable='Debtor' and d.SysId="+pid;
    ps = con1.prepareStatement(sql);
    ResultSet rs2 = ps.executeQuery();
 %>
<table border=1px style="width:833;height:354"><tr><td>
<table border=0 cellpadding=0 cellspacing=0 style="vertical-align:top;text-align:left;width:833;height:354" id="chktbl">
<tr><td height=188px colspan=3>

<table border=0 cellpadding=0 cellspacing=0><tr><td width=600>
 <% 
    while(rs2.next())    
    { 
    %> 
	<table border=0 width="600" style="text-align:center" >
	<tr><td class="chequeFont"><%=rs2.getString("Name1")%></td></tr>
	<tr><td class="chequeFont"><%=rs2.getString("Street1")%>, <%=rs2.getString("Street2")%> </td></tr>
	<tr><td class="chequeFont"><%=rs2.getString("City")%>,<%=rs2.getString("state")%></td></tr>
	<tr><td class="chequeFont"><%=rs2.getString("Zip")%></td></tr>
	 
	</table>
	<% }
%>
</td><td></td><td class="chequeFont"><%=formattedDate  %></td></tr></table>
</td></tr>
<tr><td width=74px></td><td height=50px width=380 class="chequeFont underline" style="vertical-align:bottom"><span >Faites le paiement &acirc l'ordre de Invoice Payment System Corp.</span></td><td class="chequeFont" style="vertical-align:bottom"> 
$&nbsp;<input type=text width=100px name="totalPayment" id="totalPayment" class="rightJustified" readonly/>&nbsp;<label id="currencyType" name="currencyType"><%= rs.getString(5) %> </label>
</td></tr>
<tr><td height=20></td></tr>
<tr> <td></td><td colspan=2>
 <table border=0px cellpadding=0 cellspacing=0 style="vertical-align:top;text-align:left"> 
         <tr>
         <td style="width:22px"><img src="images/b1.gif" border=0></td>
         <td style="width:60px"><input type=text id="transit" style="width:60px" value=<%= rs.getString(2) %>></td>
         <td style="width:22px"><img src="images/b2.gif" border=0></td>
         <td style="width:60px"><input type=text id="branch" style="width:60px" value=<%= rs.getString(3) %>></td>
         <td style="width:22px"><img src="images/b3.gif" border=0></td>
         <td style="width:60px"><input type=text id="account" style="width:60px" value=<%= rs.getString(4) %>>
        
         </td>
         <td style="width:500px"> <input type="hidden" id="currency" name="currency" value=<%= rs.getString(5) %> /></td>
         </tr>
         <tr>
         <td style="width:22px"></td>
         <td style="width:60px" class="chequeFont"><h5>Numero de transit</h5></td>
         <td style="width:22px"></td>
         <td style="width:60px"><h5>Code bancaire</h5></td>
         <td style="width:22px"></td>
         <td style="width:60px"><h5>Numero de compte</h5></td>
         <td style="width:500px"></td>
         </tr>
         </table>
         </td></tr>
<tr><td height=30></td></tr>
</table>
</td></tr>

</table>
<%}
  }
catch(Exception e){ e.printStackTrace(); }
finally{con.close();
        con1.close();}
 %>
</body>
</html>