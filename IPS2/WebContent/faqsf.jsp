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
	  $("#GreyHeader").text("Menu principal > Effectuer un paiement > Faqs");	
    $( "#datepickerstart" ).datepicker({ dateFormat: "yy-mm-dd" });
    $( "#datepickerend" ).datepicker({ dateFormat: "yy-mm-dd" });

  });

  </script>
</head>
<body>
<%! String driverName = "net.sourceforge.jtds.jdbc.Driver";%>

<% String userid="0"; %>
<%@include file='headerf.jsp'%>
<%@include file='sidebarf.jsp'%>


<div STYLE="position:absolute;top:10px;left:250px;z-index:2">

<table border=0 cellpadding=0 cellspacing=0 width=850 >
<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial;color:#d06200;font-weight:bold"> Ch�que �lectronique, Faites un paiement en ligne FAQ </span></td></tr>
<tr><td>&nbsp;<td><tr><tr><td>&nbsp;<td><tr><tr><td>&nbsp;<td><tr>


<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">
Le ch�que �lectronique repose sur le principe du d�bit pr�autoris�, un processus r�gi par l'Association canadienne des paiements (ACP). L'Association canadienne des paiements est une soci�t� � but non lucratif qui exploite le syst�me de chambre de compensation et de r�glement au Canada. Vous trouverez ci-dessous une foire aux questions sur les d�bits pr�autoris�s tels qu'ils sont d�crits dans le site Web de l'ACP, <a href="http://www.cdnpay.ca/"><span style="color:black">www.cdnpay.ca</span></a>  
</span></td></tr><tr><td>&nbsp;<td><tr><tr><td>&nbsp;<td><tr><tr><td>&nbsp;<td><tr>

<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">Cliquez sur une question ci-dessous pour acc�der � la r�ponse d�taill�e � www.cdnpay.ca</span></td></tr><tr><td>&nbsp;<td><tr><tr><td>&nbsp;<td><tr><tr><td>&nbsp;<td><tr>



<tr><td>
<span style="width=100%;text-align:left;font-size:9pt;">
<a href="http://www.cdnpay.ca/imis15/fra/FAQs/Pre-Authorized_Debits/fra/faq/Pre-Authorized_Debits.aspx#bm35"><font face="arial" color="5050505">Comment puis-annuler un accord de d�bit pr�autoris� (DPA)? </font></a></span>
</td></tr><tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>

<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-weight:normal">
<a href="http://www.cdnpay.ca/imis15/fra/FAQs/Pre-Authorized_Debits/fra/faq/Pre-Authorized_Debits.aspx#bm01"><font face="arial" color="#5050505">Qu'est-ce qu'un d�bit pr�autoris� (DPA)?</font></a>
</span></td></tr><tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>

<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">
<a href="http://www.cdnpay.ca/imis15/fra/FAQs/Pre-Authorized_Debits/fra/faq/Pre-Authorized_Debits.aspx#bm02"><font face="arial" color="5050505">Comment fonctionnent les DPA?</font></a>
</span></td></tr><tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>

<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">
<a href="http://www.cdnpay.ca/imis15/fra/FAQs/Pre-Authorized_Debits/fra/faq/Pre-Authorized_Debits.aspx#bm03"><font face="arial" color="5050505">Quelle est la diff�rence entre un DPA personnel, un DPA de transfert de fonds, un DPA d'entreprise et un DPA de gestion de tr�sorerie?</font></a>
</span></td></tr><tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>

<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">
<a href="http://www.cdnpay.ca/imis15/fra/FAQs/Pre-Authorized_Debits/fra/faq/Pre-Authorized_Debits.aspx#bm04"><font face="arial" color="5050505">Si le montant ou l'horaire d'un DPA varient, comment serai-je avis� du montant qui sera port� � mon compte et la date � laquelle il sera retir�?</font></a>
</span></td></tr><tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>

<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">
<a href="http://www.cdnpay.ca/imis15/fra/FAQs/Pre-Authorized_Debits/fra/faq/Pre-Authorized_Debits.aspx#bm05"><font face="arial" color="5050505"> S'il n'y a pas suffisamment de fonds dans mon compte pour couvrir un DPA et qu'il est retourn� pour insuffisance de provisions, est-ce que le b�n�ficiaire peut tenter de d�biter mon compte � nouveau? </font></a>
</span></td></tr><tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>

<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">
<a href="http://www.cdnpay.ca/imis15/fra/FAQs/Pre-Authorized_Debits/fra/faq/Pre-Authorized_Debits.aspx#bm06"><font face="arial" color="5050505">Si un DPA non autoris� ou erron� a provoqu� la mise � d�couvert de mon compte, serai-je rembours� des frais pour provisions insuffisants.</font></a>
</span></td></tr><tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>


<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">
<a href="http://www.cdnpay.ca/imis15/fra/FAQs/Pre-Authorized_Debits/fra/faq/Pre-Authorized_Debits.aspx#bm08"><font face="arial" color="5050505">Qu'arrive-t-il si un DPA est pass� � mon compte par erreur? </font></a>
</span></td></tr><tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>


<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">
<a href="http://www.cdnpay.ca/imis15/fra/FAQs/Pre-Authorized_Debits/fra/faq/Pre-Authorized_Debits.aspx#bm09"><font face="arial" color="5050505">Est-ce qu'un �metteur de facture peut changer le montant d'un accord de DPA?</font></a>
</span></td></tr><tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>


<tr><td><span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">
<a href="http://www.cdnpay.ca/imis15/fra/FAQs/Pre-Authorized_Debits/fra/faq/Pre-Authorized_Debits.aspx#bm10"><font face="arial" color="5050505">Qu'arrive-t-il si je veux changer le compte sur lequel les DPA sont tir�s?</font></a>
</span></td></tr><tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>

</table></div>

	<div STYLE="position:absolute;top:640px;left:10px;z-index:2"> <table border="0" width="1150" align="center" style='table-layout:fixed'><tr><td align="center" nowrap="nowrap">  <font face="arial" color="#FFFFF" size="2"> �2014 IPS Invoice Payment System Corporation. Tous droits r�serv�s.</font> </td></tr></table></div>
	<div STYLE="position:absolute;top:615px;left:10px;z-index:1"> <table border="0" width="1150" align="center" style='table-layout:fixed'><tr><td align="center"><img src="footer.jpg" width="96%" height="60px"></td></tr></table></div> 
</body>
</html>