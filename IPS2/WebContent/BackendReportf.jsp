<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

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
<LINK REL="shortcut icon" href="http://live.invoicepayment.ca/IPSmain/favicon.ico" type="image/x-icon"/> 
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



<title>Daily Report</title>
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
	<form method="post" action="AdminReportf_M">
		<table border=0 cellpadding=0 cellspacing=0 width=800 >
			<tr><td colspan=2></td></tr>
			<tr>
			<td colspan=2>
			<table border=0 cellpadding=0 cellspacing=10>
<tr><td><h4 style="vertical-align:middle">Start Date</h4></td>
<td style="vertical-align:center;text-align:left;"><input type=hidden name="payerid" id="payerid" value=<%="" %>>
<input type="text" id="datepickerstart" name="datepickerstart" /></td>
<td width=15></td><td><h4 style="vertical-align:middle">End Date</h4></td>
<td style="vertical-align:center;text-align:left;"><input type="text" id="datepickerend" name="datepickerend" /></td>
</tr>
</table>
			
			
			</td>
		</tr>
		<tr>
		<td>
		<table border=0 cellpadding=0 cellspacing=10>

<tr>
<td><h4 style="vertical-align:middle">Filter By</h4></td>
<td width="10px"></td>
<td></td>
</tr>
<tr>
<td></td>
<td width="10px"></td>
<td><input type="checkbox" name="approved" value="ON"><span class="AccountFont">Approved</span></td>
<td></td>
</tr>
<tr>
<td></td>
<td width="10px"></td>
<td><input type="checkbox" name="declined" value="ON"><span class="AccountFont">Declined</span></td>
<td></td>
</tr>
<tr>
<td></td>
<td width="10px"></td>
<td><input type="checkbox" name="deleted" value="ON"><span class="AccountFont">Deleted</span></td>
<td></td>
</tr>
<tr>
<td></td>
<td width="10px"></td>
<td><input type="checkbox" name="submtted" value="ON"><span class="AccountFont">Submitted</span></td>
<td></td>
</tr>
</table>
		</td>
		</tr>
		
<tr><td colspan=2><table border=0 cellpadding=0 cellspacing=10>

<tr><td><h4 style="vertical-align:middle">Sort By</h4></td>
<td width="10px"></td>
<td><select name="sortby">
<option value="byDate">Date</option>
<option value="bySupplier">Supplier</option>
</select>

</td></tr>
		</table>
		
</td></tr>
		
		
		<tr><td colspan=2><table border=0 cellpadding=0 cellspacing=0><tr><td width=400></td><td>
<input type="submit" class="button insert-button" name="act" id="submit" value="submit" style="color:blue" />
</td></tr></table></td></tr>
		
		</table>
		</form>
<%@include file='footerf.jsp'%>
