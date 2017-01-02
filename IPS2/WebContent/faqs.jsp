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

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script> 
<script type="text/javascript"  src='https://cdn.renderedfont.com/js/renderedfont-0.8.min.js#free'></script>

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


<title>Faqs</title>

<script type="text/javascript" src="jslibrary.js"></script>
<script type="text/javascript"  src='https://cdn.renderedfont.com/js/renderedfont-0.8.min.js#free'></script>
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
<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial;color:#d06200;font-weight:bold"> eCheque, Make an Online Payment FAQs </span></td></tr>
<tr><td>&nbsp;<td></tr><tr><td>&nbsp;<td></tr>



<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">
The IPS eCheque online payment feature is based on Pre-Authorized Debit, a payment process governed by the Canadian Payments Association (CPA). The Canadian Payments Association is a non-profit organization that operates the payment clearing and settlement system in Canada. Below we share a list of frequently asked questions about PADs as outlined in CPA's website, <a href="http://www.cdnpay.ca/"><span style="color:black">www.cdnpay.ca</span></a>  
</span></td></tr>
<tr><td>&nbsp;<td></tr><tr><td>&nbsp;<td></tr>


<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">
Click on the questions below to link to the detailed answer on www.cdnpay.ca  
</span></td></tr><tr><td>&nbsp;<td></tr><tr><td>&nbsp;<td></tr>

<tr><td>
<span style="width=100%;text-align:left;font-size:9pt;">
<a href="http://www.cdnpay.ca/imis15/eng/FAQs/Pre-Authorized_Debits/eng/faq/Pre-Authorized_Debits.aspx#bm35" target="_blank"><font face="arial" color="5050505">How do I cancel a PAD Agreement?</font></a></span>
</td></tr><tr><td>&nbsp;<td></tr><tr><td>&nbsp;<td></tr>


<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-weight:normal">
<a href="http://www.cdnpay.ca/imis15/eng/FAQs/Pre-Authorized_Debits/eng/faq/Pre-Authorized_Debits.aspx#bm01" target="_blank"><font face="arial" color="#5050505">What is a Pre-Authorized Debit (PAD)?</font></a>
</span></td></tr><tr><td>&nbsp;<td></tr><tr><td>&nbsp;<td></tr>


<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">
<a href="http://www.cdnpay.ca/imis15/eng/FAQs/Pre-Authorized_Debits/eng/faq/Pre-Authorized_Debits.aspx#bm02" target="_blank"><font face="arial" color="5050505">How do PADs work?</font></a>
</span></td></tr><tr><td>&nbsp;<td></tr><tr><td>&nbsp;<td></tr>


<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">
<a href="http://www.cdnpay.ca/imis15/eng/FAQs/Pre-Authorized_Debits/eng/faq/Pre-Authorized_Debits.aspx#bm03" target="_blank"><font face="arial" color="5050505">What is the difference between a Personal PAD, a Funds Transfer PAD, a Business PAD and a Cash Management PAD?</font></a>
</span></td></tr><tr><td>&nbsp;<td></tr><tr><td>&nbsp;<td></tr>


<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">
<a href="http://www.cdnpay.ca/imis15/eng/FAQs/Pre-Authorized_Debits/eng/faq/Pre-Authorized_Debits.aspx#bm04" target="_blank"><font face="arial" color="5050505">If the amount or the timing of a PAD varies, how will I know how much is to be debited from my account and when?</font></a>
</span></td></tr><tr><td>&nbsp;<td></tr><tr><td>&nbsp;<td></tr>


<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">
<a href="http://www.cdnpay.ca/imis15/eng/FAQs/Pre-Authorized_Debits/eng/faq/Pre-Authorized_Debits.aspx#bm05" target="_blank"><font face="arial" color="5050505">If I don't have enough funds in my account to cover a PAD and it is returned NSF, can the biller try to debit my account again? Can they apply NSF charges to the next debit?</font></a>
</span></td></tr><tr><td>&nbsp;<td></tr><tr><td>&nbsp;<td></tr>


<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">
<a href="http://www.cdnpay.ca/imis15/eng/FAQs/Pre-Authorized_Debits/eng/faq/Pre-Authorized_Debits.aspx#bm06" target="_blank"><font face="arial" color="5050505">If an unauthorized or incorrect PAD caused an overdraft in my account at my financial institution, will I be reimbursed for NSF charges?</font></a>
</span></td></tr><tr><td>&nbsp;<td></tr><tr><td>&nbsp;<td></tr>


<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">
<a href="http://www.cdnpay.ca/imis15/eng/FAQs/Pre-Authorized_Debits/eng/faq/Pre-Authorized_Debits.aspx#bm08" target="_blank"><font face="arial" color="5050505">What happens if a PAD is processed to my account incorrectly?</font></a>
</span></td></tr><tr><td>&nbsp;<td></tr><tr><td>&nbsp;<td></tr>


<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">
<a href="http://www.cdnpay.ca/imis15/eng/FAQs/Pre-Authorized_Debits/eng/faq/Pre-Authorized_Debits.aspx#bm09" target="_blank"><font face="arial" color="5050505">Can a Biller change the amount of a PAD?</font></a>
</span></td></tr><tr><td>&nbsp;<td></tr><tr><td>&nbsp;<td></tr>


<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">
<a href="http://www.cdnpay.ca/imis15/eng/FAQs/Pre-Authorized_Debits/eng/faq/Pre-Authorized_Debits.aspx#bm10" target="_blank"><font face="arial" color="5050505">What happens if I want to change the account to which PADs are processed?</font></a>
</span></td></tr><tr><td>&nbsp;<td></tr><tr><td>&nbsp;<td></tr>

</table></div>

	<div STYLE="position:absolute;top:640px;left:10px;z-index:2"> <table border="0" width="1150" align="center" style='table-layout:fixed'><tr><td align="center" nowrap="nowrap">  <font face="arial" color="#FFFFF" size="2">©</font> <b class="ips renderedFont"> 2013 IPS Invoice Payment System Corporation. All rights reserved.</font> </td></tr></table></div>
	<div STYLE="position:absolute;top:615px;left:10px;z-index:1"> <table border="0" width="1150" align="center" style='table-layout:fixed'><tr><td align="center"><img src="footer.jpg" width="96%" height="60px"></td></tr></table></div> 
</body>
</html>