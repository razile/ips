<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page errorPage="Logout.jsp" %>
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

	<style type="text/css">
      /* Example CSS class using Quicksand Book Regular */
      b.ips {
        font-family: "Quicksand Bold Regular", Arial; 
        font-size: 9pt; 
        color: #FFFFFF;
      }
    </style>

	<style type="text/css">
   	.text-color { color: #0A70AB; }
	.special    { color: #AB830A; }
	.outset { border-style:outset; }
	a:link { 
	font-size: 8pt;
	text-decoration: none;
	}

	a:visited { 
	font-size: 8pt;
	text-decoration: none;
	}
	
	a:hover{
	background-color:#d06200;
	}
  </style>
<title> Main Page </title>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript"  src='http://cdn.renderedfont.com/js/renderedfont-0.8.min.js#free'></script>
</head>
<body>

	<%@include file='header.jsp'%>
		
<div STYLE="position:absolute;top:160px;left:10px;z-index:1">
	<table border="0" width="1200" cellspacing="0" align="left" style='table-layout:fixed;background-color:#A0A0A0' ><tr><td>
	 <font face="arial" size="2" color ="white">&nbsp;</font> </td><tr></table></div>
<div  STYLE="position:absolute;top:210px;left:50px;z-index:1;width:100%">

<table border=0 cellpadding=0 cellspacing=0 width=100%>

<tr><td width=200px></td><td  style="vertical-align:top;align:center">
<form>
<%! String driverName = "net.sourceforge.jtds.jdbc.Driver";%>

<%@ include file="connection.jsp" %>

<%
Connection con1 = null;
PreparedStatement ps = null;
try
{
Class.forName(DBProperties.JDBC_SQLSERVER_DRIVER);
//con = (Connection) DriverManager.getConnection(DBProperties.CONNECTION_SQLSERVER_URL, DBProperties.USERNAME_SQLSERVER, DBProperties.PASSWORD_SQLSERVER);
con1 = (Connection) DriverManager.getConnection(DBProperties.CONNECTION_SYBASE10_URL, DBProperties.USERNAME_SYBASE10, DBProperties.PASSWORD_SYBASE10);
int payerId=Integer.parseInt(session.getAttribute("pyid").toString());
String sql = "SELECT Name1,DebtorId,street1,street2,city,state,country,zip from Debtor join Address on Address.SysParentId = Debtor.SysId where Address.ParentTable='DEBTOR' and Debtor.SysId="+payerId;
ps = con1.prepareStatement(sql);
ResultSet rs = ps.executeQuery(); 
%>
<table cellpadding=0 cellspacing=0 style="vertical-align:top;width:400px" border=0> 
<tr><td width=240px colspan=3  style="vertical-align:top;"><h3>Select you Bank Account</h3></td></tr><tr>
<td colspan=2 width=80px></td><td>  
<%           String name=""; 
		     String street1=""; 
		     String street2=""; 
		     String city="";
		     String state="";
		     String country="";
		     String zip="";
		     String debtorId = "DebtorId";
		     if (rs.next())
		     { name=   rs.getString("Name1");
		       debtorId =rs.getString("DebtorId");
		       street1=   rs.getString("street1");
		       street2=   rs.getString("street2");
		       city=   rs.getString("city");
		       state=   rs.getString("state");
		       country=   rs.getString("country");
		       zip=   rs.getString("zip");  
		     }
	          %> 
       <br>
      <h5> <%=name%>
       <br>
       <%=street1%>, <%=street2%><br>
       <%=city%>, <%=state%><Br>
       <%=country%><br>
       <%=zip%><br><br>
       User Id Logged In: <%=debtorId%></h5>
       <%
       } 
finally{
    	   if ( con1 != null )  
    		      con1.close();  
       }
       
       %>     
       <br><br>
</td></tr>
<tr><td height=30px></td></tr>
<tr><td colspan=2></td><td><table border=0 cellpadding=0 cellspacing=0>
<tr><td><input type="submit" class="button previous-button" name="act" id="previous" value="previous"  /></td><td>
	<input type="submit" class="button continue-button" name="act" id="continue" value="continue" 
	onclick="document.forms[0].action = 'MakePayment.jsp'; return true;"  />
</td></tr>
</table>
</td></tr></table>
</td></tr></table>
</form>
<%@include file='footer.jsp'%>