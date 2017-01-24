<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<%@ page import="javax.servlet.*"%>


<html>
<head>
 <link rel="stylesheet" href="payer.css" type="text/css"/>
<LINK REL="shortcut icon" href="http://ips-srvv08/IPSmain/favicon.ico" type="image/x-icon"/> 
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
  <script type="text/javascript" src="jslibrary.js"></script>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
  <script src="https://code.jquery.com/jquery-1.9.1.js"></script>
  <script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
  <script type="text/javascript"  src="helper/renderedfont-0.8.min.js#free"></script>
  <link rel="stylesheet" href="datepicker.css" />
  <script>
  $(document).ready(function() {
	$("#GreyHeader").text("Main Menu > Make a Payment > Admin Reports");	
    $( "#datepickerstart" ).datepicker({ dateFormat: "yy-mm-dd" });
    $( "#datepickerend" ).datepicker({ dateFormat: "yy-mm-dd" });

  });
  </script>
<title>Invoices</title>
<style>
a.one:link {color:#ff0000;}
a.one:visited {color:#0000ff;}
a.one:hover {color:#E0E0E0;}
</style>
</head>
<body>

<%
String userid = (String)request.getParameter("pyid");
 if (userid==null)
{
        response.sendRedirect("http://live.invoicepayment.ca/ipspayers/index.htm");
        }
%>

<%@include file='header.jsp'%>
	<%@include file='sidebar.jsp'%>
	<form method="post" action="SearchInvoices">
	<table border=0 cellpadding=0 cellspacing=0 width=800 >
		<tr><td colspan=2></td></tr>
		<tr><td colspan=2>
<table border=0 cellpadding=0 cellspacing=10>
	<tr><td style="font-size:11pt;font-family:Arial">ID - Payer - Date</td></td>
			
<%! String driverName = "net.sourceforge.jtds.jdbc.Driver";%>
<%
Connection con = null;
ResultSet rs =null;
PreparedStatement ps = null;
CallableStatement cs = null;
int payerid=Integer.parseInt(request.getParameter("pyid").toString());
%>
<% 
try
{
	con = SqlServerDBService.getInstance().openConnection();
	String sql = "SELECT t.SysId,pa.payerid,InvoiceDate,t.status FROM invoicetransaction  t inner join PayersAccounts pa on t.SysAcctId = pa.SysId where  t.status ='Pending' or t.status ='Submitted'  order by t.SysId desc;";
	PreparedStatement ps2  = con.prepareStatement(sql);
	//ps2.setInt(1, payerid);
	rs = ps2.executeQuery(); 
	int counter =0;
	while (rs.next()){%>
				<tr><td>
				<a class="one" href=<%="AdminReport?id="+rs.getString("SysId")%>><%=rs.getString("SysId")%> - <%=rs.getString("PayerId")%>- <%=rs.getString("InvoiceDate")%>  </a>
				</td>
							</tr>
	<% }
	String a="b";
	}
	catch(Exception e){
			e.printStackTrace();
		} finally {
			SqlServerDBService.getInstance().releaseConnection(con);
		}
	
	%>
							</table>
		</td></tr>
		<tr><td colspan=2>
						<table border=0 cellpadding=0 cellspacing=0><tr><td width=400></td><td>
							<input type="submit" class="button insert-button" name="act" id="submit" value="submit" style="color:blue" />
						</td></tr></table>
		</td></tr>
	</table>
		</form>

