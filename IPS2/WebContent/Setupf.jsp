<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.Locale"%>
<%@ page buffer="16kb"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	 <html>
<head>
<link rel="stylesheet" href="payer.css" type="text/css" />
<LINK REL="shortcut icon" href="http://live.invoicepayment.ca/IPSmain/favicon.ico"
	type="image/x-icon" />
	 <script src="https://code.jquery.com/jquery-1.9.1.js"></script>
	<script src='helper/renderedfont-0.8.min.js#free'></script>
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
   <script>
	$(document).ready(function(){
					$("#GreyHeader").text("Menu principal > Effectuer un paiement > G�rer Compte bancaire");		
	});
	
	</script>

<script type="text/javascript">

var clicked;
	function checkPolicy()
	{if (clicked=='decline')
		{alert("Please accept the Terms & Conditions to continue.");
		return false;
		}
/*	if((document.getElementById("debtor").value==null)||(document.getElementById("debtor").value==''))
		{
		alert("Please enter a debtor number.");
		return false;
		
		}*/
		if(document.getElementById("chkApprove").checked)
			{
			window.location.href("/ManageAccountsf.jsp?debtor="+document.getElementById("debtor").value );
			return true;
			}
		else
			{
			alert("Please accept the Terms & Conditions to continue.");
			
			return false;

			}
	}
</script>
<style type="text/css">
/* Example CSS class using Quicksand Book Regular */

</style>


<title>Account Policy</title>
<script type="text/javascript" src="jslibrary.js"></script>
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript"
	src='http://cdn.renderedfont.com/js/renderedfont-0.8.min.js#free'></script>
</head>
<body>
<%
String userid= (String)request.getParameter("plog");

//String userid = (String)request.getParameter("pyid");
////userid = CipherData.decipher("01234567",userid);
if (userid==null)
{ userid = (String)request.getAttribute("pyid");
      if (userid==null){
          userid= (String)request.getParameter("plog");
		if (userid==null)
		response.sendRedirect("http://live.invoicepayment.ca/payer_fr_modified/ipspayers/index.htm");
        }
}
%>

<%@include file='headerf.jsp'%>
<form method="post" action="ManageAccountsf.jsp"
		onSubmit="return checkPolicy();">	


<% String driverName = "net.sourceforge.jtds.jdbc.Driver";
boolean exist =false;
	String debtorid = (String) request.getParameter("plog");
	ResultSet rs =null;
	PreparedStatement ps = null;
 Connection con = SqlServerDBService.getInstance().openConnection();
 String sql = "select * from PayersAccounts where payerid ="+debtorid;
try{
 ps = con.prepareStatement(sql);
 rs = ps.executeQuery();
if (rs.next())
{
	exist =true;	
}
}catch(Exception e){
	e.printStackTrace();	
}	finally {
	SqlServerDBService.getInstance().releaseConnection(con);
}
//session.setAttribute( "pyid", debtorid );
//session.setAttribute( "pynm", name );
if (debtorid.equals("14148")||debtorid.equals("0014148"))
{%>	
	<jsp:forward page="BackendReportf.jsp">
	<jsp:param name="pyid" value="<%=14148%>"  /> 
	<jsp:param name="hasAccounts" value="1"  /> 
	</jsp:forward> 
<% }//if (exist){   //session.setAttribute("HasAccounts", "1");
	String pid2 = String.valueOf(debtorid);
	//String x = CipherData.cipher("01234567",pid);
	%>
	
<jsp:forward page="ManageAccountsf.jsp">
<jsp:param name="pyid" value="<%=pid2%>"  /> 
<jsp:param name="hasAccounts" value="1"  /> 
</jsp:forward> 
<% // }
	//session.setAttribute("HasAccounts", "0");
%>

	      <input type=hidden name="pyid" value =<%=userid%>>

	<jsp:include page="headerf.jsp" flush="true">
	<jsp:param name="pyid" >
	<jsp:attribute name="value" >  
         <c:out value="${debtorid}"/>  
      </jsp:attribute>
	</jsp:param>
	</jsp:include>
	<%@include file='sidebarf.jsp'%>
	<form method="post" action="ManageAccountsf.jsp"
		onSubmit="return checkPolicy();">
		<table border=0 cellpadding=0 cellspacing=0 width=800 >
			<tr>
				<td width=20></td>
				<td >
					<table border=0 width=100%>
						<tr>
							<td colspan=2 style="text-align:center"><span style="width=100%;text-align:center;font-size:11pt;font-family:Quicksand,Arial"><b>MODALIT�S</b></span></td>
						</tr>
						<tr>
							<td width=20></td>
							<td align=center><table border=0><tr><td><textarea rows="20" cols="80" style="font-size:11pt;font-family:Arial">Termes et Conditions

Autorisation de retrait/d�p�t bancaire automatique

1.	Dans la pr�sente autorisation, les mots "nous", "notre" et "nos" font r�f�rence au payeur.

2.	Nous convenons de participer au pr�sent plan de d�bit pr�autoris� et nous autorisons la soci�t� Invoice Payment System (le "b�n�ficiaire") indiqu�e sur le retrait/d�p�t bancaire automatique et tout successeur ou ayant droit du b�n�ficiaire � faire un retrait sur papier, sous forme �lectronique ou sous toute autre forme dans le but de payer les biens et services li�s � nos activit�s commerciales (un "DPA d'entreprise") dans notre compte indiqu� sur le retrait/d�p�t bancaire automatique (le "compte") � l'�tablissement bancaire indiqu� sur le retrait/d�p�t bancaire automatique (l'"�tablissement bancaire") et nous autorisons l'�tablissement bancaire � honorer et � payer ces d�bits. La pr�sente autorisation est fournie au b�n�fice du b�n�ficiaire et de notre �tablissement bancaire et est remise pour que notre �tablissement bancaire accepte de traiter les d�bits faits sur notre compte conform�ment aux r�gles de l'Association canadienne des paiements. Nous convenons que tout ordre d'effectuer un DPA d'entreprise, et que tout DPA d'entreprise effectu� conform�ment � la pr�sente autorisation doit �tre honor� par nous s'il est sign� par nous et, en cas de d�bits sur papier, si les ch�ques ont �t� sign�s. 

3.	Nous pouvons r�voquer la pr�sente autorisation en tout temps en remettant au b�n�ficiaire un pr�avis �crit 30 jours � l'avance. La pr�sente autorisation ne s'appliquera qu'� la m�thode de paiement, et nous convenons que la r�vocation de la pr�sente autorisation ne r�silie d'aucune mani�re l'entente entre nous et le b�n�ficiaire et n'a aucune incidence sur celle-ci.
 
4.	Nous convenons que notre �tablissement bancaire n'est pas tenu de v�rifier que tout DPA d'entreprise a �t� fait conform�ment � la pr�sente autorisation, y compris le montant, la fr�quence et la r�alisation des objectifs de tout DPA d'entreprise.

5.	Nous convenons que la remise de la pr�sente autorisation au b�n�ficiaire constitue la remise par nos soins � notre �tablissement bancaire. Nous convenons que le b�n�ficiaire peut remettre la pr�sente autorisation � l'�tablissement bancaire du b�n�ficiaire et nous acceptons la divulgation � cet �tablissement bancaire de tout renseignement que peut contenir la pr�sente autorisation.

6. (a) Nous comprenons que : 
(i)   En ce qui a trait aux DPA d'entreprise � montant fixe, nous recevrons un avis �crit de la part du b�n�ficiaire sur le montant � d�biter et la ou les dates o� le d�bit est exigible au moins dix (10) jours civils avant la date d'exigibilit� du premier DPA d'entreprise, et cet avis devra nous parvenir chaque fois qu'un changement est apport� au montant ou aux dates de paiement; 
(ii)  En ce qui a trait aux DPA d'entreprise � montant variable, nous recevrons un avis �crit de la part du b�n�ficiaire sur le montant � d�biter et la ou les dates o� le d�bit est exigible au moins dix (10) jours civils avant la date d'exigibilit� de chaque DPA d'entreprise; et
(iii) En ce qui a trait � un plan de DPA d'entreprise qui pr�voit la remise d'un DPA d'entreprise en guise de paiement partiel ou total d'une facture que nous avons re�ue, nous renon�ons au pr�avis de dix (10) jours.
                                               - OU - 
   (b) Nous convenons de renoncer aux exigences ci-dessus ou de respecter les modifications aux exigences ci-dessus comme convenu avec le b�n�ficiaire.
7.	Nous avons des droits de recours si un d�bit n'est pas conforme � la pr�sente entente. Par exemple, nous avons le droit d'obtenir le remboursement de tout d�bit qui n'est pas autoris� et qui n'est pas conforme � la pr�sente entente. Nous pouvons contester un DPA d'entreprise en remettant une d�claration sign�e � notre �tablissement bancaire dans les conditions suivantes : 
(a)	Le DPA d'entreprise n'a pas �t� fait conform�ment � la pr�sente autorisation; ou 
(b)	La pr�sente autorisation a �t� r�voqu�e.
	Nous reconnaissons que pour obtenir de notre �tablissement bancaire le remboursement d'un DPA d'entreprise contest�, nous devons signer une d�claration � l'effet que les circonstances (a) ou (b) qui pr�c�dent ont eu lieu et remettre cette d�claration � notre �tablissement bancaire jusqu'� dix (10) jours ouvrables sans plus apr�s la date � laquelle le DPA d'entreprise contest� a �t� inscrit au compte. Nous reconnaissons qu'apr�s cette p�riode de dix (10) jours ouvrables, nous devrons r�soudre la contestation d'un DPA d'entreprise uniquement avec l'aide du b�n�ficiaire et que notre �tablissement bancaire n'aura aucune responsabilit� � notre �gard en ce qui a trait � un tel DPA d'entreprise. Pour obtenir plus d'information sur nos droits de recours, nous pouvons consulter notre �tablissement bancaire ou le site www.cdnpay.ca.

8.	Nous certifions que l'information fournie en ce qui a trait au compte est exacte et nous convenons d'informer le b�n�ficiaire, par �crit, de toute modification apport�e � l'information sur le compte fournie dans la pr�sente autorisation vingt-quatre (24) heures avant la prochaine date d'un DPA d'entreprise. Advenant une telle modification, la pr�sente autorisation sera maintenue en ce qui a trait � tout nouveau compte devant servir aux DPA d'entreprise.

9.	Nous convenons que le b�n�ficiaire peut remettre la pr�sente autorisation � son �tablissement bancaire et nous acceptons la divulgation de tout renseignement personnel que pourrait contenir la pr�sente autorisation � cet �tablissement bancaire.

10.	Nous confirmons et attestons que les personnes dont la signature est requise pour le compte ont sign� la pr�sente autorisation.

11.	Nous comprenons que nous pouvons communiquer avec la soci�t� Invoice Payment System par la poste � l'adresse 11 - 1535 Meyerside Drive, Mississauga (Ontario) L5T 1M9; par t�l�phone au 1-888-503-4528; par t�l�copieur au 1-905-670-4221.

12.	Nous comprenons et acceptons les modalit�s et conditions qui pr�c�dent.

13.	Pour la province de Qu�bec seulement : It is the express wish of the parties that this Authorization and any related documents be drawn up and executed in English. Les parties conviennent que la pr�sente autorisation et tous les documents s'y rattachant soient r�dig�s et sign�s en anglais.


							

</textarea>
</td></tr>
<tr><td style="text-align:left;font-size:11pt;font-family:Quicksand,Arial"><input type="checkbox" name="chkApprove" id="chkApprove">
<b>J'ai lu ce qui pr�c�de et j'accorde mon consentement.</b></td></tr>
</table>
</td>
						</tr>
						<tr>
							<td></td>
							<td><h3>
			
								</h3></td>
						</tr>
						<tr><td></td>
							<td >
								<table border=0 cellpadding=0 cellspacing=0 width=85%>
									<tr>
										<td width=70%></td>
										<td>
										<input type="submit" class="button accept-button" value="Accept" onclick="clicked='accept'" style="color:blue"/>
										</td>
										<td><input type="submit" class="button decline-button" value="Decline" onclick="clicked='decline'" style="color:blue"/></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>
	<%@include file='footerf.jsp'%>