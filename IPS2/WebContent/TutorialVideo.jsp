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
<link rel="stylesheet" href="payer.css" type="text/css"/> 
<LINK REL="shortcut icon" href="http://live.invoicepayment.ca/IPSmain/favicon.ico" type="image/x-icon"/> 


<script type="text/javascript" src="IPS2/html5lightbox/html5lightbox.js"></script>
<script type="text/javascript">var html5lightbox_options = { watermark: "", watermarklink: "http://html5box.com"};</script>



<style type="text/css">
      /* Example CSS class using Quicksand Book Regular */
      b.ips {
        font-family: "Quicksand Bold Regular", Arial; 
        font-size: 9pt; 
        color: #FFFFFF;
      }
    </style>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-44788637-1', 'invoicepayment.ca');
  ga('send', 'pageview');

</script>


<title>Tutorial Video</title>
<script type="text/javascript" src="jslibrary.js"></script>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
  <script src="https://code.jquery.com/jquery-1.9.1.js"></script>
  <script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
  <link rel="stylesheet" href="datepicker.css" />
  
  <script>

  $(function() {
	  $("#GreyHeader").text("Main Menu -> Make a Payment -> Faqs");	
    $( "#datepickerstart" ).datepicker({ dateFormat: "yy-mm-dd" });
    $( "#datepickerend" ).datepicker({ dateFormat: "yy-mm-dd" });

  });

  </script>
</head>
<body>
<%! String driverName = "net.sourceforge.jtds.jdbc.Driver";%>
<%@ include file="connection.jsp" %>
<% String userid="0"; %>
<%@include file='header.jsp'%>
<%@include file='sidebar.jsp'%>

<div STYLE="position:absolute;top:10px;left:250px;z-index:2">

<table border=0 cellpadding=0 cellspacing=0 width=850 >
<tr><td><span style="width=100%;text-align:left;font-size:14pt;font-family:Arial;color:#d06200;font-weight:bold"> eCheque, Make an Online Payment</span></td></tr>
<tr><td>&nbsp;<td><tr><tr><td>&nbsp;<td><tr><tr><td>&nbsp;<td><tr>



<tr><td><span style="width=100%;text-align:left;font-size:10pt;font-family:Arial">
The IPS Make a Payment Online feature is an electronic cheque that allows you, the payer, to conveniently pay invoices from the IPS Online Account Manager.All transactions made through the Make a Payment Online feature are secured through SSL, a cryptographic protocol designed to provide communication security, backed by the Norton Secured Seal, &nbsp;<img valign="bottom" src="norton.jpg" width="40" height="15" alt="#"> the most recognized trust mark on the Internet

</td></tr>

<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td><span style="width=100%;text-align:left;font-size:10pt;font-family:Arial">Thanks to its simplicity, this service will deliver great benefits.</span></td></tr>
<tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>
<tr><td><span style="width=100%;text-align:left;font-size:10pt;font-family:Arial;color:#000000;font-weight:bold"> 100% FREE OF CHARGE SERVICE -</span> <span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">save money on banking and postage fees<span></td></tr>
<tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>
<tr><td><span style="width=100%;text-align:left;font-size:10pt;font-family:Arial;color:#000000;font-weight:bold">CONVENIENT SERVICE -</span> <span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">use it on an "as needed basis" without any sign-up or setup</span></td></tr>
<tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>
<tr><td><span style="width=100%;text-align:left;font-size:10pt;font-family:Arial;color:#000000;font-weight:bold">SPEEDY PAYMENT PROCESS -</span> <span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">handle payments within a few simple clicks </span></td></tr>
<tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>
<tr><td><span style="width=100%;text-align:left;font-size:10pt;font-family:Arial;color:#000000;font-weight:bold">ENHANCED CREDITWORTHINESS -</span> <span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">strengthen your IPS PI (Payment Index) thanks to invoice payable payments received without any postal delays </span></td></tr>
<tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>
<tr><td><span style="width=100%;text-align:left;font-size:10pt;font-family:Arial;color:#000000">*Only available to payers within the Canadian market</span></td></tr>

<tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>
</table></div>

<!-- my video code -->
<!-- <div  STYLE="position:absolute;top:680px;left:400px;z-index:1">
<a href="Nick2.mp4" class="html5lightbox" data-width="480" data-height="320" title="IPS BUSINESS VIDEO" style="text-decoration:none"> 
<img src="Question2.jpg" height="120" width="200"></a> </div> -->



<div  STYLE="position:absolute;top:300px;left:350px;z-index:11">
<table border="0"><tr><td width="190">&nbsp;</td>&nbsp;</td> <td><font face="arial" size="3px">WATCH OUR VIDEO TUTORIAL</font></td></tr></table>
<a href="https://content.jwplatform.com/videos/OWMFwRBw-5BxPibt1.mp4" class="html5lightbox" data-width="720" data-height="460" title="IPS BUSINESS VIDEO" style="text-decoration:none" title="Online Video Tutorial"> 
<img src="VideoThumbnail.jpg" style="border-color:white;" height="338" width="600"/></a>
 </div> 



	<div STYLE="position:absolute;top:805px;left:10px;z-index:2"> <table border="0" width="1150" align="center" style='table-layout:fixed'><tr><td align="center" nowrap="nowrap">  <font face="arial" color="#FFFFF" size="2">©</font> <b class="ips renderedFont"> 2014 IPS Invoice Payment System Corporation. All rights reserved.</font> </td></tr></table></div>
	<div STYLE="position:absolute;top:780px;left:10px;z-index:1"> <table border="0" width="1150" align="center" style='table-layout:fixed'><tr><td align="center"><img src="footer.jpg" width="96%" height="60px"></td></tr></table></div> 

