  
    <%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.io.*" %>
<%@page import="javax.servlet.*" %>
<%@page import="javax.servlet.http.*" %>
<%@page import="com.ips.database.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
 <link rel="stylesheet" href="payer.css" type="text/css"/>
   <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script>
var which=null;
$(document).ready({alert("ab");
	 $("input").click(function(){alert("a");
		   which = $(this).attr("id");
	   });
	 $("#updateform").submit(function () {alert(which);
		 
	return false;	 
	 });
	 
});
</script>
</head>
<body>
<form id="updateform" action="UpdateInvoice" method=post>
<table border=0 cellpadding=5 cellspacing=0>
<% String id=request.getParameter("id");
id = id.replace("/","");%>
<tr><td colspan=3><h3>Payment Number : <%=id %></h3></td></tr>
                         <tr>
                         <td><h3>Invoice Number</h3></td>
                         <td><h3>Supplier</h3></td>
                         <td><h3>Amount</h3></td>
                         <td><h3>Discount/Credit</h3></td>
                         <td><h3>Payment Amount</h3></td>
                       </tr>
<%! Connection con; %>
<%! PreparedStatement ps; 
    CallableStatement cs;%>
<%! ResultSet rs; %>

<%  
try{
	
	
con = SqlServerDBService.getInstance().openConnection();
//String sql = "SELECT pa.*,Client.name1 FROM invoicepayment pa left join Client  on Client.sysid = pa.payee where pa.InvoiceTransactionId="+id;
cs = con.prepareCall("{call ipclient(?)}");
cs.setString(1, id);
//ps = con.prepareStatement(sql);
rs = cs.executeQuery(); 

int counter=0;
while(rs.next()){
%>
 
                        <tr>
                         <td><h3><%=rs.getString("InvoiceNumber") %></h3></td>
                         <td><h3><%= (rs.getString("name1")==null)?rs.getString("payee"):rs.getString("name1") %></h3></td>
                         <td><h3>$<%=rs.getString("Amount") %></h3></td>
                         <td><h3><%=rs.getInt("Amount")-rs.getInt("PaymentAmount") %></h3></td>
                         <td><h3>$<input type="text"  style="width:50px" name="paymentamount<%=counter%>" value=<%=rs.getString("PaymentAmount") %>>
                         <input type=hidden name="invoiceid<%=counter%>" value=<%=rs.getString("SysId") %>>
                         </h3></td>
                       </tr>
                       <% 
                       counter+=1; }%><input type=hidden name="counter" value=<%=counter%>><input type=hidden name="transactionid" value=<%=id%>><% 
}catch(Exception e){ e.printStackTrace(); }
finally{SqlServerDBService.getInstance().releaseConnection(con);}
%>
<tr><td colspan=5 style="text-align:right"><input type=submit id="act" name="act" value="update" class="button submit-button" style="color:blue"><input type=submit id="act" name="act" value="cancel" class="button cancel-button" style="color:blue"></td></tr>
                       </table>
                       
</form>
</body>
</html>