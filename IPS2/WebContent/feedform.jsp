<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"> 
<%@ page errorPage="Logout.htm" %>
<%@ page language ="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "javax.servlet.http.*" %>
<%@ page import = "javax.servlet.*" %>
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>

<script language="JavaScript" type="text/javascript">
<!--

function checkEmail() {

    var email = document.getElementById('frmEmail');
    var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

    if (!filter.test(email.value)) {
    alert('Please provide a valid email address');
    //email.focus;
	document.forms["sendo"]["frmEmail"].focus();
    return false;
 }
}



function checkform()
{
  // ** START **
  if (document.forms["sendo"]["frmName"].value == "") {
    alert( "Please fill in Name box." );
    //sendo.frmName.focus();
    return false ;
  }
  
  if (document.forms["sendo"]["frmCompany"].value == "") {
    alert( "Please fill in Company box." );
    //sendo.frmComapny.focus();
    return false ;
  }
  
  if (document.forms["sendo"]["frmEmail"].value == "") {
     alert("Please fill in Email box." );
    sendo.frmEmail.focus();
    return false ;
  }
  
  if (document.forms["sendo"]["frmTelephone"].value == "") {
    alert( "Please fill in Telephone box." );
    //sendo.frmTelephone.focus();
    return false ;
  }
  
  if (document.forms["sendo"]["remarks"].value == "") {
    alert( "Please fill in Remarks box." );
    //sendo.remarks.focus();
    return false ;
  } else {

  var t1= 'Name :'.concat(document.forms["sendo"]["frmName"].value);
  var t2= '\n'.concat('Company :'.concat(document.forms["sendo"]["frmCompany"].value));
  var t3= '\n'.concat('Email: '.concat(document.forms["sendo"]["frmEmail"].value));
  var t4= '\n'.concat('Telephone: '.concat(document.forms["sendo"]["frmTelephone"].value));
  var t5= '\n'.concat('Message :'.concat(document.forms["sendo"]["remarks"].value));
  
  sendo.message.value= t1.concat(t2.concat(t3.concat(t4.concat(t5))));
  return true;
  }
  // ** END **
  }
//-->
</script>

<LINK REL="shortcut icon" href="http://linux.invoicepayment.ca/IPSmain/favicon.ico" type="image/x-icon"/> 
<title> Formulaire de commentaires </title>
<!--
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript"  src='http://cdn.renderedfont.com/js/renderedfont-0.8.min.js#free'></script>
-->
<script type = "text/javascript" >
   function preventBack(){window.history.forward();}
    setTimeout("preventBack()", 0);
    window.onunload=function(){null};
</script>

<style type="text/css">
 .td { height:1.5em;}
 img { vertical-align:middle; } 
 .thick {border-width: thick }
 .groove {border-style: groove }
 .outset {border-style: outset }
 .text-color { color: #0A70AB; }
 .special    { color: #AB830A; }
 
 
	a:link { 
	font-size: 8pt;
	text-decoration: none;
	}

	a:visited { 
	font-size: 8pt;
	text-decoration: none;
	}

	<!--a:hover{
	background-color:#d06200;
	} -->

	<!--div:hover{
	color:none;
	} -->
	
		
	.box { 
	border: 0px solid #CCC; 
	height: 66px; 
	width: 550px; 
	padding:15px; 
	display:none; 
	position:absolute; 
	} 	
		
	
 </style>


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
textarea {
   font-size: 10pt;
   font-family: Arial;
} 

      /* Example CSS class using Quicksand Book Regular */
      b.ips {
        font-family: Arial; 
        font-size: 10pt; 
        color: #FFFFFF;
      }
    </style>
</head>
<body>
<% 
   String plog = request.getParameter("plog")==null?"":request.getParameter("plog").toString(); 
   String payername = request.getParameter("dbnm")==null?"":request.getParameter("dbnm").toString(); 
   String pass = request.getParameter("dpass")==null?"":request.getParameter("dpass").toString(); 
   //String plog = request.getParameter("dbid")==null?"":request.getParameter("dbid").toString(); 


   // Reading Payer data
	try {    
	    Class.forName("com.mysql.jdbc.Driver");
	  } catch (Exception e) {
	    out.println("Fail to initialize MYSQL JDBC driver: " + e.toString() + "<P>");
	  }
  
	  String dbUser = "appdev";
	  String dbPasswd = "8Ecrespe";
	  String dbURL = "jdbc:mysql://localhost:3306/InsuiteSybaseCoreRep";
	  //String dbURL = "jdbc:mysql://localhost:3306/ScheduleDeposit";


       Connection con;
	Statement s=null;
	ResultSet rs=null;
	con=null;
	
    
	try {
    con = DriverManager.getConnection(dbURL,dbUser,dbPasswd);
    //out.println(" Connection status: " + conn + "<P>");
	} catch(Exception e) {
    out.println("Connection failed: " + e.toString() + "<P>");  
	}

	String sql="call pyrfeedf('"+ plog +"') ";
	s = con.createStatement();
	rs = s.executeQuery(sql);
	String dtid= null;
	String dbnm= null;
	String phon= null;

	while (rs.next()) {  
	dtid = new String(rs.getString("DebtorId"));
	dbnm = new String (rs.getString("DebtorName"));
	phon = new String (rs.getString("PhoneNum"));
       }

       //String payername= dbnm;



   //String plog = (String) session.getAttribute("pyid");
   //String payername = (String)  session.getAttribute("pynm");
%>

 	<form id="mainmenu" method="post" action="debtr.jsp">
	<input type="hidden" name="did" value='<%=plog%>'/>
	<input type="hidden" name="dbnme" value='<%=payername%>'/>
	<input type="hidden" name="plogg" value='<%=pass%>'/>
	</form>

	<table border="0" width="1200" align="left" style='table-layout:fixed'>
	<tr><td align="left"> <img src="ipsban.jpg" width="100%"></td></tr></table>
	
	<div STYLE="position:absolute;top:90px;left:35px;z-index:1"><table border="0" width="1150" style='table-layout:fixed'>
	 <tr>
	 <td width="100" nowrap="nowrap">&nbsp;</td><td width="400px" align="left" colspan="1" nowrap="nowrap"> &nbsp;&nbsp;&nbsp;&nbsp; <font face=""arial" size="2" color="#FFFFFF"> Payer: <%= payername %></font> </td><td width="220px">&nbsp;</td>
	 <td align="left" colspan="1" nowrap="nowrap"> 
	<a href="#" onclick="document.getElementById('mainmenu').submit();"  style="color:#FFFFFF"> <font face="arial" size="2">Menu principal</font></a> <font face="arail" size="3" color="#FFFFF"> |</font>
	<a href="http://invoicepayment.ca/en/contact_ips_invoice_payment_systems.php" style="color:#FFFFFF" target="_blank"> <font face=""arial" size="2">Contactez-nous</font></a> <font face="arail" size="3" color="#FFFFF"> |</font>
	<a href="http://invoicepayment.ca/en/index.php" style="color:#FFFFFF" target="_blank"> <font face=""arial" size="2">Accueil IPS</font></a> <font face="arail" size="3" color="#FFFFF"> |</font>
	<!-- <a href="Payer_Manual.pdf" style="color:#FFFFFF" target="_blank"> <font face=""arial" size="2">Help</font></a> &nbsp;&nbsp;-->
	<a href="Logout.jsp" style="color:#FFFFFF" target="_top"> <font face=""arial" size="2">Ouvrir une session Aide</font></a> </td>
	  </tr></table></div>


<div style="position:absolute;top:260px;left:0px;">
		<center>
		<table align="center" width="1220" border="0" align="center" cellspacing="0" cellpadding="0">
		<tr><td>
		
		
		<table width="600" border="0" align="center" cellspacing="0" cellpadding="0">
		<form name="sendo" action="http://image.invoicepayment.ca/IPSmain/ipspayers/feedmailerpyr.jsp" method="post" target="_blank" onSubmit="javascript:return checkform();"> 
		<tr><td colspan="4" align="center"><img src="passwd.jpg"/></td></tr>
		<tr><td colspan="4">&nbsp;</td></tr>
		<tr><td colspan="4" align="center"><font face="arial" size="3" color="#A0A0A0">Veuillez nous faire part de vos commentaires</font></td></tr>
		<tr><td colspan="4">&nbsp;</td></tr>
		
		<!-- <input type="hidden" name="to" value="ali@invoicepayment.ca"></input>   -->
		<input type="hidden" name="to" value="feedback@invoicepayment.ca"></input>  
		<input type="hidden" name="from" value="webserver@invoicepayment.ca"></input>
		<input type="hidden" name="subject" value="Payer Feedback"></input>
		
		<table width="650" border="1" align="center" cellspacing="0" cellpadding="0"><tr><td>
		<table width="650" border="0" align="center" cellspacing="0" cellpadding="0">
		<tr><td>
		
		<tr>
            <td valign="middle"><font face="arial" size="2" style="font-color=gray'">Nom de la société:</font></td><td valign="middle"><input name="frmCompany" placeholder="Entrez le nom de votre société" type="text" id="frmCompany" size="40" value="<%= dbnm %>"  readonly></td><td colspan="2">&nbsp; </td>
        </tr>
		<tr>
            <td valign="middle"><font face="arial" size="2" style="font-color=gray">*Nom du contact:</font></td><td valign="middle"><input name="frmName"  placeholder="Entrez votre nom!" type="text" id="frmName" size="40"></td><td colspan="2">&nbsp; </td>
        </tr>
        <tr>
            <td valign="middle"><font face="arial" size="2" style="font-color=gray'">*Courriel:</font></td><td valign="middle"><input name="frmEmail" placeholder="Entrez votre adresse e-mail!" type="text" id="frmEmail" size="40" OnBlur="return checkEmail()"></td><td colspan="2">&nbsp; </td>
        </tr>
        <tr>
         	<td valign="middle"><font face="arial" size="2" style="font-color=gray'">Téléphone:</font></td><td valign="middle"><input name="frmTelephone" type="text" placeholder="Entrez votre numéro de Contact!" id="frmTelephone" value="<%= phon %>"  Onblur="return checkEmail()" size="40"></td><td colspan="2">&nbsp; </td>
        </tr>
        <tr><td valign="top"><font face="arial" size="2" style="font-color='gray'">Note:</font></td><td colspan="3">
		<textarea id="remarks" placeholder="Entrez votre comentarios!" name="remarks" cols="70" rows="5" Onblur="return checkEmail()"></textarea></td></tr>
		
		</td></tr></table>
		
		<table border="0" width="550" align="center" cellpadding="0" cellspacing="0">
		<tr><td colspan="3">&nbsp;</td><td align="right"><input type="submit" value="Soumettre"></td></tr>
		</table>
		
		<input type="hidden" name="plgn" value='<%= plog%>'/>
		<input type="hidden" name="pnm" value='<%= payername%>'/>
		<input type="hidden" name="pass" value='<%= pass%>'/>
		
		</td></tr></table>
		<!--<input type="text" id="message" name="message" readonly/>-->
		<table border="0" width="550" align="center" cellpadding="0" cellspacing="0">
		<tr><td valign="top">&nbsp;</td><td colspan="3">
		<textarea id="message" name="message" style="visibility:hidden" cols="60" rows="5"> 
		</textarea></td></tr></table>
		
		</form>
		
			
		</td></tr></table>
		</center>
		</div>


	<div STYLE="position:absolute;top:855px;left:10px;z-index:2"> <table border="0" width="1150" align="center" style='table-layout:fixed'><tr><td align="center" nowrap="nowrap"><font color="white"> <font face="arial" color="#FFFFF" size="2">©2014 IPS Invoice Payment System Corporation. Tous droits réservés.</font> </td></tr></table></div>
	<div STYLE="position:absolute;top:830px;left:10px;z-index:1"> <table border="0" width="1150" align="center" style='table-layout:fixed'><tr><td align="center"><img src="footer.jpg" width="96%" height="60px"></td></tr></table></div> 
</body>
</html>