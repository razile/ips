<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page errorPage="Logout.htm" %>
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
 <link rel="stylesheet" href="payer.css" type="text/css"/>
<!--  LINK REL="shortcut icon" href="http://ips-srvv08/IPSmain/favicon.ico" type="image/x-icon" --> 
 <script type="text/javascript">
	var _gaq = _gaq || [];
	_gaq.push(['_setAccount', 'UA-33522368-1']);
	_gaq.push(['_trackPageview']);

	(function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	})();
	
    

	
	
	</script>

<title> Générer des rapports</title>

<script type="text/javascript" src="jslibrary.js"></script>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
  <script src="https://code.jquery.com/jquery-1.9.1.js"></script>
  <script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript"  src='helper/renderedfont-0.8.min.js#free'></script>
 
  <link rel="stylesheet" href="datepicker.css" />
  
  <script>

  $(function() {
	  $("#GreyHeader").text("Menu principal > Effectuer un paiement > Générer des rapports");	
    $( "#datepickerstart" ).datepicker({ dateFormat: "yy-mm-dd" });
    $( "#datepickerend" ).datepicker({ dateFormat: "yy-mm-dd" });

  });
	$(document).ready(function() {	
		 $("#form").submit(function () {
		if ($("#datepickerstart").val()=="")
			{alert("Please enter a Start Date");
			 return false; 
			//$("tr.secondarycurrency").show();
			}
		else if ($("#datepickerend").val()=="")
		{alert("Please enter an End Date");
		 return false; 
		//$("tr.secondarycurrency").show();
		}
		//window.open('DisplayReport.jsp');
		//return false;
		 });
	});
  </script>
</head>
<body>
<%
String userid = (String)request.getParameter("pyid");
 if (userid==null)
{
        response.sendRedirect("http://live.invoicepayment.ca/payer_fr_modified/ipspayers/index.htm");
        }
%>

<%@include file='headerf.jsp'%>
<%@include file='sidebarf.jsp'%>	
<form action="ReportGeneratorf" target="_blank" id="form" method=post>



<form action="#">
<%
int payerid=Integer.parseInt(request.getParameter("pyid").toString());
Connection con = null;
PreparedStatement ps = null;
try
{
con = SqlServerDBService.getInstance().openConnection();
String sql = "SELECT SysId, AccountNumber,CurrencyType from PayersAccounts  where PayerId="+payerid;
ps = con.prepareStatement(sql);
ResultSet rs = ps.executeQuery(); 

%>
<table border=0 cellpadding=20 cellspacing=0>
<tr><td style="vertical-align:middle"><h4>Pour quel compte bancaire souhaitez-vous produire un rapport?</h4></td>
<td><select name="chkAccount">
<% while(rs.next()){ %>
<option value=<%= rs.getString("SysId")%>>
<%String acc =rs.getString("AccountNumber")+" - " + rs.getString("CurrencyType");  %>
<%=acc%></option>

<% 
}//while
	
	
%>
</select></td>
</tr>
<tr><td colspan=2 style="vertical-align:top">
<table border=0 cellpadding=0 cellspacing=10>
<tr><td><h4 style="vertical-align:middle">Date de départ</h4></td>
<td style="vertical-align:center;text-align:left;"><input type=hidden name="payerid" id="payerid" value=<%=payerid %>>
<input type="text" id="datepickerstart" name="datepickerstart" /></td>
<td width=15></td><td><h4 style="vertical-align:middle">Date de fin</h4></td>
<td style="vertical-align:center;text-align:left;"><input type="text" id="datepickerend" name="datepickerend" /></td>
</tr>
</table></td>
</tr>


<tr><td colspan=2>
<table border=0 cellpadding=0 cellspacing=10>

<tr>
<td><h4 style="vertical-align:middle">Filtrer par</h4></td>
<td width="10px"></td>
<td></td>
</tr>
<tr>
<td></td>
<td width="10px"></td>
<td><input type="checkbox" name="approved" value="ON"><span class="AccountFont">Approuvé</span></td>
<td></td>
</tr>
<tr>
<td></td>
<td width="10px"></td>
<td><input type="checkbox" name="declined" value="ON"><span class="AccountFont">Refusé</span></td>
<td></td>
</tr>
<tr>
<td></td>
<td width="10px"></td>
<td><input type="checkbox" name="deleted" value="ON"><span class="AccountFont">Supprimé</span></td>
<td></td>
</tr>
<tr>
<td></td>
<td width="10px"></td>
<td><input type="checkbox" name="submtted" value="ON"><span class="AccountFont">Soumis</span></td>
<td></td>
</tr>
</table>
</td></tr>

<tr><td colspan=2><table border=0 cellpadding=0 cellspacing=10>
<tr><td><h4 style="vertical-align:middle">Trier par</h4></td>
<td width="10px"></td>
<td><select name="sortby">
<% 
//sql ="select distinct payee, c.Name1,c.Name2 from invoicepayment ip join invoicetransaction it on it.SysId = ip.InvoiceTransactionId join payersaccounts pa on pa.SysId =it.SysAcctId join client c on c.SysId =payee where pa.PayerId =" + payerid;
//	ps = con.prepareStatement(sql);
//	rs = ps.executeQuery();
//	while (rs.next())
	{
%><option value="byDate">Date</option>
<option value="bySupplier">Supplier</option>
</select>
<% }
}
catch(Exception e){
	response.setContentType("text/html");  
    PrintWriter pw = response.getWriter();  
    pw.println(e);  
	
}
finally{SqlServerDBService.getInstance().releaseConnection(con);}


%>
</td></tr>
</table>
</td></tr>
<tr><td colspan=2><table border=0 cellpadding=0 cellspacing=0><tr><td width=400></td><td>
<input type="submit" class="button insert-button" name="act" id="submit" value="Soumettre" style="color:blue" />
</td></tr></table></td></tr>
</table>
</form>
<%@include file='footerf.jsp'%>
