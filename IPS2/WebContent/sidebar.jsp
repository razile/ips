

	
<div STYLE="position:absolute;top:160px;left:10px;z-index:1">
	<table border="0" width="1200" cellspacing="0" align="left" style='table-layout:fixed;background-color:#A0A0A0' ><tr>
	<td width="70px"></td>
	<td>
	 <span class="breadcrumbs" id="GreyHeader">&nbsp; </span> </td><tr></table></div>
<div  STYLE="position:absolute;top:210px;left:50px;z-index:1;width:100%">

<table border=0 cellpadding=0 cellspacing=0 width=100%>

<tr><td align="left" width=169 style="vertical-align:top">
<table border=0 cellpadding=0 cellspacing=0 width=200>
<tr><td>
<table border=0 cellpadding=0 cellspacing=0 width=200>
<tr><td width="169" height=12 style="background-color:#A0A0A0" colspan=3></td></tr>
<%
String pid = (String) request.getParameter("pyid");
if (pid == null)pid = request.getParameter("plog");
    if(pid==null)
    	  pid =(String) request.getAttribute("pyid");
    
         // RR -- Commented
    	 //  if (pid==null) pid= userid;
         // RR 
         
   // pid =CipherData.decipher("01234567",pid);
	int payerid2=Integer.parseInt(pid);
	if (payerid2!= 14148){
	%>
<%String hasAccounts ="1"; //request.getParameter("HasAccounts").toString() ;
if (hasAccounts!=null && !hasAccounts.equals("1"))
{ %>

<tr>
<td width="9" height=36 style="background-color:#A0A0A0"></td>
<td width="152" height=36 style="background-color:#2f2f2f" ><span class="sidelink"><a href="Setup.jsp" id="nav1" >Set Up Bank Account</a></span></td>
<td width="8" height=36 style="background-color:#A0A0A0"></td>
</tr>

<tr>
<td width="9" height=1px style="background-color:#A0A0A0"></td>
<td width="152" height=1px style="background-color:#A0A0A0"></td>
<td width="8" height=1px style="background-color:#A0A0A0"></td>
</tr>
<%} %>
<form method=post name="ManageAccountsForm" action="ManageAccounts.jsp"> 
<input type="hidden" name=pyid value=<%=pid %> >
<tr>
<td width="9" height=36 style="background-color:#A0A0A0"></td> 
<td width="152" height=36 style="background-color:#2f2f2f" ><span class="sidelink"><a href="#" onclick="javascript:ManageAccountsForm.submit()" id="nav2">Manage Bank Accounts</a></span></td>
<td width="8" height=36 style="background-color:#A0A0A0"></td>
</tr>
</form>
<tr>
<td width="9" height=1px style="background-color:#A0A0A0"></td>
<td width="152" height=1px style="background-color:#A0A0A0"></td>
<td width="8" height=1px style="background-color:#A0A0A0"></td>
</tr>
<form method=post name="MakeForm" action="MakePayment.jsp"> 
<input type="hidden" name=pyid value=<%=pid %> >
<tr>
<td width="9" height=36 style="background-color:#A0A0A0"></td>
<td width="152" height=36 style="background-color:#2f2f2f"><span class="sidelink"><a href="#" onclick="javascript:MakeForm.submit()">Make a Payment</a></td>
<td width="8" height=36 style="background-color:#A0A0A0"></td>
</tr>
</form>
<tr>
<td width="9" height=2px style="background-color:#A0A0A0"></td>
<td width="152" height=2px style="background-color:#A0A0A0"></td>
<td width="8" height=2px style="background-color:#A0A0A0"></td>
</tr>
<form method=post name="ReviewPaymentForm" action="ReviewPayment.jsp"> 
<input type="hidden" name=pyid value=<%=pid %> >
<tr>
<td width="9" height=36 style="background-color:#A0A0A0"></td>
<td width="152" height=36 style="background-color:#2f2f2f" ><span class="sidelink"><a href="#" onclick="javascript:ReviewPaymentForm.submit()">Review Payments</a></span></td>
<td width="8" height=36 style="background-color:#A0A0A0"></td>
</tr>
</form>
<tr>
<td width="9" height=1px style="background-color:#A0A0A0"></td>
<td width="152" height=1px style="background-color:#A0A0A0"></td>
<td width="8" height=1px style="background-color:#A0A0A0"></td>
</tr>
<form method=post name="ReportsForm" action="Reports.jsp"> 
<input type="hidden" name=pyid value=<%=pid %> >
<tr>
<td width="9" height=36 style="background-color:#A0A0A0"></td>
<td width="152" height=36 style="background-color:#2f2f2f"><span class="sidelink"><a href="#" onclick="javascript:ReportsForm.submit()">Generate Reports</a></span></td>
<td width="8" height=36 style="background-color:#A0A0A0"></td>
</tr>
</form>
<tr>
<td width="9" height=1px style="background-color:#A0A0A0"></td>
<td width="152" height=1px style="background-color:#A0A0A0"></td>
<td width="8" height=1px style="background-color:#A0A0A0"></td>
</tr>
<tr>

<tr>
<td width="9" height=1px style="background-color:#A0A0A0"></td>
<td width="152" height=1px style="background-color:#A0A0A0"></td>
<td width="8" height=1px style="background-color:#A0A0A0"></td>
</tr>

<form method=post name="faqForm" action="faqs.jsp"> 
<input type="hidden" name=pyid value=<%=pid %> >
<tr>
<td width="9" height=36 style="background-color:#A0A0A0"></td>
<td width="152" height=36 style="background-color:#2f2f2f"><span class="sidelink"><a href="#" onclick="javascript:faqForm.submit()">FAQs</a></span></td>
<td width="8" height=36 style="background-color:#A0A0A0"></td>
</tr>
</form>

<tr>
<td width="9" height=1px style="background-color:#A0A0A0"></td>
<td width="152" height=1px style="background-color:#A0A0A0"></td>
<td width="8" height=1px style="background-color:#A0A0A0"></td>
</tr>


<form method=post name="TutForm" action="TutorialVideo.jsp"> 
<input type="hidden" name=pyid value=<%=pid %> >
<tr>
<td width="9" height=36 style="background-color:#A0A0A0"></td>
<td width="152" height=36 style="background-color:#2f2f2f"><span class="sidelink"><a href="#" onclick="javascript:TutForm.submit()">Tutorial Video</a></span></td>
<td width="8" height=36 style="background-color:#A0A0A0"></td>
</tr>
</form>
<tr>
<td width="9" height=1px style="background-color:#A0A0A0"></td>
<td width="152" height=1px style="background-color:#A0A0A0"></td>
<td width="8" height=1px style="background-color:#A0A0A0"></td>
</tr>
<tr>



<%
}if (payerid2== 14148){
%>
<tr>
<td width="9" height=1px style="background-color:#A0A0A0"></td>
<td width="152" height=1px style="background-color:#A0A0A0"></td>
<td width="8" height=1px style="background-color:#A0A0A0"></td>
</tr>
<form method=post name="BackendReportForm" action="BackendReport.jsp"> 
<input type="hidden" name=pyid value=<%=pid %> >

<tr>
<td width="9" height=36 style="background-color:#A0A0A0"></td>
<td width="152" height=36 style="background-color:#2f2f2f"><span class="sidelink"><a href="#" onclick="javascript:BackendReportForm.submit()">Admin Reports</a></span></td>
<td width="8" height=36 style="background-color:#A0A0A0"></td>
</tr>
</form>
<tr>
<td width="9" height=1px style="background-color:#A0A0A0"></td>
<td width="152" height=1px style="background-color:#A0A0A0"></td>
<td width="8" height=1px style="background-color:#A0A0A0"></td>
</tr>
<tr>
<td width="9" height=1px style="background-color:#A0A0A0"></td>
<td width="152" height=1px style="background-color:#A0A0A0"></td>
<td width="8" height=1px style="background-color:#A0A0A0"></td>
</tr>
<form method=post name="BackendReviewForm" action="BackendReview.jsp"> 
<input type="hidden" name=pyid value=<%=pid %> >
<td width="9" height=36 style="background-color:#A0A0A0"></td>
<td width="152" height=36 style="background-color:#2f2f2f"><span class="sidelink"><a href="#" onclick="javascript:BackendReviewForm.submit()">Review Payments</a></span></td>
<td width="8" height=36 style="background-color:#A0A0A0"></td>
</tr>
</form>
<tr>
<td width="9" height=1px style="background-color:#A0A0A0"></td>
<td width="152" height=1px style="background-color:#A0A0A0"></td>
<td width="8" height=1px style="background-color:#A0A0A0"></td>
</tr>
<form method=post name="BackendInvoiceForm" action="BackendInvoice.jsp"> 
<input type="hidden" name=pyid value=<%=pid %> >
<td width="9" height=36 style="background-color:#A0A0A0"></td>
<td width="152" height=36 style="background-color:#2f2f2f"><span class="sidelink"><a href="#" onclick="javascript:BackendInvoiceForm.submit()">Review Invoices</a></span></td>
<td width="8" height=36 style="background-color:#A0A0A0"></td>
</tr>
</form>

<tr>
<td width="9" height=1px style="background-color:#A0A0A0"></td>
<td width="152" height=1px style="background-color:#A0A0A0"></td>
<td width="8" height=1px style="background-color:#A0A0A0"></td>
</tr>


<%} %>
</table>
</td></tr>
<tr><td>
<image src="images/RightNav.jpg" width=200px/>
</td></tr></table>
</td><td style="vertical-align:top">
	
