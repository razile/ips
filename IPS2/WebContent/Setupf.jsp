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
					$("#GreyHeader").text("Menu principal > Effectuer un paiement > Gérer Compte bancaire");		
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
							<td colspan=2 style="text-align:center"><span style="width=100%;text-align:center;font-size:11pt;font-family:Quicksand,Arial"><b>MODALITÉS</b></span></td>
						</tr>
						<tr>
							<td width=20></td>
							<td align=center><table border=0><tr><td><textarea rows="20" cols="80" style="font-size:11pt;font-family:Arial">Termes et Conditions

Autorisation de retrait/dépôt bancaire automatique

1.	Dans la présente autorisation, les mots "nous", "notre" et "nos" font référence au payeur.

2.	Nous convenons de participer au présent plan de débit préautorisé et nous autorisons la société Invoice Payment System (le "bénéficiaire") indiquée sur le retrait/dépôt bancaire automatique et tout successeur ou ayant droit du bénéficiaire à faire un retrait sur papier, sous forme électronique ou sous toute autre forme dans le but de payer les biens et services liés à nos activités commerciales (un "DPA d'entreprise") dans notre compte indiqué sur le retrait/dépôt bancaire automatique (le "compte") à l'établissement bancaire indiqué sur le retrait/dépôt bancaire automatique (l'"établissement bancaire") et nous autorisons l'établissement bancaire à honorer et à payer ces débits. La présente autorisation est fournie au bénéfice du bénéficiaire et de notre établissement bancaire et est remise pour que notre établissement bancaire accepte de traiter les débits faits sur notre compte conformément aux règles de l'Association canadienne des paiements. Nous convenons que tout ordre d'effectuer un DPA d'entreprise, et que tout DPA d'entreprise effectué conformément à la présente autorisation doit être honoré par nous s'il est signé par nous et, en cas de débits sur papier, si les chèques ont été signés. 

3.	Nous pouvons révoquer la présente autorisation en tout temps en remettant au bénéficiaire un préavis écrit 30 jours à l'avance. La présente autorisation ne s'appliquera qu'à la méthode de paiement, et nous convenons que la révocation de la présente autorisation ne résilie d'aucune manière l'entente entre nous et le bénéficiaire et n'a aucune incidence sur celle-ci.
 
4.	Nous convenons que notre établissement bancaire n'est pas tenu de vérifier que tout DPA d'entreprise a été fait conformément à la présente autorisation, y compris le montant, la fréquence et la réalisation des objectifs de tout DPA d'entreprise.

5.	Nous convenons que la remise de la présente autorisation au bénéficiaire constitue la remise par nos soins à notre établissement bancaire. Nous convenons que le bénéficiaire peut remettre la présente autorisation à l'établissement bancaire du bénéficiaire et nous acceptons la divulgation à cet établissement bancaire de tout renseignement que peut contenir la présente autorisation.

6. (a) Nous comprenons que : 
(i)   En ce qui a trait aux DPA d'entreprise à montant fixe, nous recevrons un avis écrit de la part du bénéficiaire sur le montant à débiter et la ou les dates où le débit est exigible au moins dix (10) jours civils avant la date d'exigibilité du premier DPA d'entreprise, et cet avis devra nous parvenir chaque fois qu'un changement est apporté au montant ou aux dates de paiement; 
(ii)  En ce qui a trait aux DPA d'entreprise à montant variable, nous recevrons un avis écrit de la part du bénéficiaire sur le montant à débiter et la ou les dates où le débit est exigible au moins dix (10) jours civils avant la date d'exigibilité de chaque DPA d'entreprise; et
(iii) En ce qui a trait à un plan de DPA d'entreprise qui prévoit la remise d'un DPA d'entreprise en guise de paiement partiel ou total d'une facture que nous avons reçue, nous renonçons au préavis de dix (10) jours.
                                               - OU - 
   (b) Nous convenons de renoncer aux exigences ci-dessus ou de respecter les modifications aux exigences ci-dessus comme convenu avec le bénéficiaire.
7.	Nous avons des droits de recours si un débit n'est pas conforme à la présente entente. Par exemple, nous avons le droit d'obtenir le remboursement de tout débit qui n'est pas autorisé et qui n'est pas conforme à la présente entente. Nous pouvons contester un DPA d'entreprise en remettant une déclaration signée à notre établissement bancaire dans les conditions suivantes : 
(a)	Le DPA d'entreprise n'a pas été fait conformément à la présente autorisation; ou 
(b)	La présente autorisation a été révoquée.
	Nous reconnaissons que pour obtenir de notre établissement bancaire le remboursement d'un DPA d'entreprise contesté, nous devons signer une déclaration à l'effet que les circonstances (a) ou (b) qui précèdent ont eu lieu et remettre cette déclaration à notre établissement bancaire jusqu'à dix (10) jours ouvrables sans plus après la date à laquelle le DPA d'entreprise contesté a été inscrit au compte. Nous reconnaissons qu'après cette période de dix (10) jours ouvrables, nous devrons résoudre la contestation d'un DPA d'entreprise uniquement avec l'aide du bénéficiaire et que notre établissement bancaire n'aura aucune responsabilité à notre égard en ce qui a trait à un tel DPA d'entreprise. Pour obtenir plus d'information sur nos droits de recours, nous pouvons consulter notre établissement bancaire ou le site www.cdnpay.ca.

8.	Nous certifions que l'information fournie en ce qui a trait au compte est exacte et nous convenons d'informer le bénéficiaire, par écrit, de toute modification apportée à l'information sur le compte fournie dans la présente autorisation vingt-quatre (24) heures avant la prochaine date d'un DPA d'entreprise. Advenant une telle modification, la présente autorisation sera maintenue en ce qui a trait à tout nouveau compte devant servir aux DPA d'entreprise.

9.	Nous convenons que le bénéficiaire peut remettre la présente autorisation à son établissement bancaire et nous acceptons la divulgation de tout renseignement personnel que pourrait contenir la présente autorisation à cet établissement bancaire.

10.	Nous confirmons et attestons que les personnes dont la signature est requise pour le compte ont signé la présente autorisation.

11.	Nous comprenons que nous pouvons communiquer avec la société Invoice Payment System par la poste à l'adresse 11 - 1535 Meyerside Drive, Mississauga (Ontario) L5T 1M9; par téléphone au 1-888-503-4528; par télécopieur au 1-905-670-4221.

12.	Nous comprenons et acceptons les modalités et conditions qui précèdent.

13.	Pour la province de Québec seulement : It is the express wish of the parties that this Authorization and any related documents be drawn up and executed in English. Les parties conviennent que la présente autorisation et tous les documents s'y rattachant soient rédigés et signés en anglais.


							

</textarea>
</td></tr>
<tr><td style="text-align:left;font-size:11pt;font-family:Quicksand,Arial"><input type="checkbox" name="chkApprove" id="chkApprove">
<b>J'ai lu ce qui précède et j'accorde mon consentement.</b></td></tr>
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