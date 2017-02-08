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
<title> Manage Accounts </title>
<script type="text/javascript" src="jslibrary.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript"  src='http://cdn.renderedfont.com/js/renderedfont-0.8.min.js#free'></script>
</head>
<body>
<%@include file='header.jsp'%>
<%@include file='sidebar.jsp'%>	
<form>
<%! String driverName = "net.sourceforge.jtds.jdbc.Driver";%>


<form action="#">
<%
int payerid =Integer.parseInt(session.getAttribute("pyid").toString());
Connection con = null;
Statement ps = null;
try
{
con = FactorDBService.getInstance().openConnection();
String sql = "SELECT Name1,DebtorId,street1,street2,city,state,country,zip from Debtor join Address on Address.SysParentId = Debtor.SysId where Address.ParentTable='DEBTOR' and Debtor.SysId="+payerid;
ps = con.createStatement();
ResultSet rs = ps.executeQuery(sql); 
}finally{
	FactorDBService.getInstance().releaseConnection(con);
}
%>

</form>
<%@include file='footer.jsp'%>
