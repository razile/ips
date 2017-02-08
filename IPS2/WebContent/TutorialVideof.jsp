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

<script type="text/javascript" src="IPS2\html5lightbox/html5lightbox.js"></script>
<script type="text/javascript">var html5lightbox_options = { watermark: "IPSOnly_40px.jpg", watermarklink: "http://html5box.com"};</script>


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


<title>Didacticiel vidéo</title>

<script type="text/javascript" src="jslibrary.js"></script>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
  <script src="https://code.jquery.com/jquery-1.9.1.js"></script>
  <script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
  <link rel="stylesheet" href="datepicker.css" />
  
  <script>

  $(function() {
	  $("#GreyHeader").text("Menu principal > Effectuer un paiement > Didacticiel vidéo");	
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

<table border=0 cellpadding=0 cellspacing=0 width=900 >
<tr><td><span style="width=100%;text-align:left;font-size:14pt;font-family:Arial;color:#d06200;font-weight:bold"> Ch&egrave;que électronique, Faites un paiement en ligne</span></td></tr>
<tr><td>&nbsp;<td><tr><tr><td>&nbsp;<td><tr><tr><td>&nbsp;<td><tr>



<tr><td><span style="width=100%;text-align:left;font-size:10pt;font-family:Arial">
La fonction de paiement en ligne d'IPS est une fonction de chèque électronique qui vous permet, à vous en tant que payeur, de payer vos factures de façon pratique directement à partir du gestionnaire de compte en ligne IPS. Toutes les transactions effectuées à partir de la fonction "Verser un paiement en ligne" sont sécurisées par protocole SSL, un protocole de chiffrement conçu pour protéger les communications et marqué du sceau de sécurité Norton Secured, <img valign= "bas" src= "norton.jpg" width= " 40" height= " 15" alt= " # "> la marque de confiance la plus reconnue dans l'industrie
</td></tr>

<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td><span style="width=100%;text-align:left;font-size:10pt;font-family:Arial">Par sa simplicité même, ce service procure d'excellents avantages.</span></td></tr>
<tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>
<tr><td><span style="width=100%;text-align:left;font-size:10pt;font-family:Arial;color:#000000;font-weight:bold"> 100 % SANS FRAIS DE SERVICE -</span> <span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">faites des économies sur vos frais bancaires et vos frais de poste <span></td></tr>
<tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>
<tr><td><span style="width=100%;text-align:left;font-size:10pt;font-family:Arial;color:#000000;font-weight:bold">SERVICE PRATIQUE -</span> <span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">utilisez le service "au besoin" sans avoir à vous inscrire ou à configurer un compte</span></td></tr>
<tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>
<tr><td><span style="width=100%;text-align:left;font-size:10pt;font-family:Arial;color:#000000;font-weight:bold">PROCESSUS DE PAIEMENT RAPIDE -</span> <span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">quelques clics suffisent pour régler vos paiements </span></td></tr>
<tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>
<tr><td><span style="width=100%;text-align:left;font-size:10pt;font-family:Arial;color:#000000;font-weight:bold">SOLVABILITÉ AMÉLIORÉE  -</span> <span style="width=100%;text-align:left;font-size:9pt;font-family:Arial">    améliorez votre IP IPS (indice de paiement IPS) grâce aux paiements sur factures exigibles reçus sans les retards causés par la poste </span></td></tr>
<tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>
<tr><td><span style="width=100%;text-align:left;font-size:10pt;font-family:Arial;color:#000000">*Offert seulement aux payeurs faisant partie du marché canadien</span></td></tr>

<tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>
</table></div>


<!-- my video code -->
<!-- <div  STYLE="position:absolute;top:680px;left:400px;z-index:1">
<a href="Nick2.mp4" class="html5lightbox" data-width="480" data-height="320" title="IPS BUSINESS VIDEO" style="text-decoration:none"> 
<img src="Question2.jpg" height="120" width="200"></a> </div> -->



<div  STYLE="position:absolute;top:320px;left:350px;z-index:11">
<table border="0"><tr><td width="190">&nbsp;</td>&nbsp;</td> <td><font face="arial" size="3px">Regardez notre tutoriel</font></td></tr></table><br>
<a href="https://content.jwplatform.com/videos/ei6zBpBY-sivrU6HM.mp4" class="html5lightbox" data-width="1280" data-height="720" style="text-decoration:none" target="_blank"> 
<img src="VideoThumbnailFR.jpg" style="border-color:white;" height="338" width="600"/></a>
 </div> 



	<div STYLE="position:absolute;top:805px;left:10px;z-index:2"> <table border="0" width="1150" align="center" style='table-layout:fixed'><tr><td align="center" nowrap="nowrap">  <font face="arial" color="#FFFFF" size="2">©</font> <b class="ips renderedFont"> ©2014 IPS Invoice Payment System Corporation. Tous droits réservés.</font> </td></tr></table></div>
	<div STYLE="position:absolute;top:780px;left:10px;z-index:1"> <table border="0" width="1150" align="center" style='table-layout:fixed'><tr><td align="center"><img src="footer.jpg" width="96%" height="60px"></td></tr></table></div> 

