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
<LINK REL="shortcut icon" href="http://ips-srvv08/IPSmain/favicon.ico"
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
					$("#GreyHeader").text("Main Menu > Make a Payment > Set Up Bank Account");		
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
			window.location.href("/ManageAccounts.jsp?debtor="+document.getElementById("debtor").value );
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
String userid = (String)request.getParameter("pyid");
//userid = CipherData.decipher("01234567",userid);
if (userid==null) userid = (String)request.getAttribute("pyid");
if (userid==null) userid= (String)request.getParameter("plog");
if (userid==null) response.sendRedirect("http://live.invoicepayment.ca/ipspayersLive/index.htm");
        

%>

<%@include file='header.jsp'%>
<form method="post" action="ManageAccounts.jsp"
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
	<jsp:forward page="BackendReport.jsp">
	<jsp:param name="pyid" value="<%=14148%>"  /> 
	<jsp:param name="hasAccounts" value="1"  /> 
	</jsp:forward> 
<% }//if (exist){   //session.setAttribute("HasAccounts", "1");
	String pid2 = String.valueOf(debtorid);
	//String x = CipherData.cipher("01234567",pid);
	%>
	
<jsp:forward page="ManageAccounts.jsp">
<jsp:param name="pyid" value="<%=pid2%>"  /> 
<jsp:param name="hasAccounts" value="1"  /> 
</jsp:forward> 
<% // }
	//session.setAttribute("HasAccounts", "0");
%>

	      <input type=hidden name="pyid" value =<%=userid%>>

	<jsp:include page="header.jsp" flush="true">
	<jsp:param name="pyid" >
	<jsp:attribute name="value" >  
         <c:out value="${debtorid}"/>  
      </jsp:attribute>
	</jsp:param>
	</jsp:include>
	<%@include file='sidebar.jsp'%>
	<form method="post" action="ManageAccounts.jsp"
		onSubmit="return checkPolicy();">
		<table border=0 cellpadding=0 cellspacing=0 width=800 >
			<tr>
				<td width=20></td>
				<td >
					<table border=0 width=100%>
						<tr>
							<td colspan=2 style="text-align:center"><span style="width=100%;text-align:center;font-size:11pt;font-family:Quicksand,Arial"><b>Terms and Conditions Statement</b></span></td>
						</tr>
						<tr>
							<td width=20></td>
							<td align=center><table border=0><tr><td><textarea rows="20" cols="80" style="font-size:11pt;font-family:Arial">Terms and Conditions
Automatic Bank Withdrawal / Deposit Authorization

1.	In this Authorization "we", "us" and "our" refers to the Payer.

2.	We agree to participate in this Business Pre-Authorized Debit Plan and we authorize Invoice Payment System Corporation (the "Payee") indicated on the Automatic Bank Withdrawal/Deposit and any successor or assign of the Payee to draw a debit in paper, electronic or other form for the purpose of making payment for goods or services related to our commercial activities (a "Business PAD") on our account indicated on the Automatic Bank Withdrawal/Deposit (the "Account") at the financial institution indicated on the Automatic Bank Withdrawal/Deposit (the "Financial Institution") and we authorize the Financial Institution to honour and pay such debits. This Authorization is provided for the benefit of the Payee and our Financial Institution and is provided in consideration of our Financial Institution agreeing to process debits against our Account in accordance with the Rules of the Canadian Payments Association. We agree that any direction we may provide to draw a Business PAD, and any Business PAD drawn in accordance with this Authorization, shall be binding on us as if signed by us, and, in the case of paper debits, as if they were cheques signed.

3.	We may revoke this Authorization at any time by delivering 30 days written notice of revocation to the Payee. This Authorization applies only to the method of payment and we agree that revocation of this Authorization does not terminate or otherwise have any bearing on any contract that exists between us and the Payee.

 
4.	We agree that our Financial Institution is not required to verify that any Business PAD has been drawn in accordance with this Authorization, including the amount, frequency and fulfillment of any purpose of any Business PAD.

5.	We agree that delivery of this Authorization to the Payee constitutes delivery by us to our Financial Institution. We agree that the Payee may deliver this Authorization to the Payee's financial institution and agree to the disclosure of any information which may be contained in this Authorization to such financial Institution.

6.	(a) We understand that with respect to: 
(i) fixed amount Business PADs, we shall receive written notice from the Payee of the amount to be debited and the due date(s) of debiting, at least ten (10) calendar days before the due date of the first Business PAD, and such notice shall be received every time there is a change in the amount or payment date(s); 
(ii) variable amount Business PADs, we shall receive written notice from the Payee of the amount to be debited and the due date(s) of debiting, at least ten (10) calendar days before the due date of every Business PAD; and 
(iii) a Business PAD Plan that provides for the issuance of a Business PAD in full or partial payment of a billing received by us, the ten (10) day pre-notification is waived.
                                               - OR - 
(b) We agree to either waive the requirements noted above or to abide by any modification to the above requirements as agreed to with the Payee.
7.	We have certain recourse rights if any debit does not comply with this agreement. For example, we have the right to receive reimbursement for any debit that is not authorized or is inconsistent to this agreement. We may dispute a Business PAD by providing a signed declaration to our Financial Institution under the following conditions: 
(a)	the Business PAD was not drawn in accordance with this
Authorization; or 
(b)	this Authorization was revoked
We acknowledge that, in order to obtain reimbursement from our Financial Institution for the amount of a disputed Business PAD, we must sign a declaration to the effect that either (a) or (b) above took place and present it to our Financial Institution up to and including but not later than then (10) business days after the date on which the disputed Business PAD was posted to the Account. We acknowledge that, after this ten (10) business day period, we shall resolve any dispute regarding a Business PAD solely with the Payee, and that our Financial Institution shall have no liability to us respecting any such Business PAD. To obtain more information regarding our recourse rights we may contact our Financial Institution or visit www.cdnpay.ca.
 
8.	We certify that information provided with respect to the Account is accurate and we agree to inform the payee, in writing, of any change in the Account information provided in this Authorization with twenty-four (24) hours prior to the next date of a Business PAD. In the event of any such change, this Authorization shall continue in respect of any new account to be used for Business PAD.

9.	We agree that the Payee may deliver this Authorization to the Payee's Financial Institution and agree to the disclosure of any personal information which may be contained in the Authorization to such Financial Institution.

10.	We warrant and guarantee that all persons whose signatures are required to sign on the Account have signed this Authorization.

11.	We understand we may contact Invoice Payment System Corporation by mail at 11-1535 Meyerside Drive. Mississauga, Ontario L5T 1M9; telephone 1-888-503-4528; fax 1-905-670-4221.

12.	We understand and agree to the foregoing terms and conditions.

13.	Applicable to the Province of Quebec only: It is the express wish of the parties that this Authorization and any related documents be drawn up and executed in English. Les parties conviennent que la présente autorisation et tous les documents s’y rattachant soient rédigés et signés en anglais.


							

</textarea>
</td></tr>
<tr><td style="text-align:left;font-size:11pt;font-family:Quicksand,Arial"><input type="checkbox" name="chkApprove" id="chkApprove">
<b>I have read and agree to the Terms & Conditions.</b></td></tr>
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
	<%@include file='footer.jsp'%>