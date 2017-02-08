<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="com.ips.database.*" %>

    
<% 
String plog = (String) request.getParameter("pyid");
if (plog == null)plog= request.getParameter("plog");
if (plog == null)plog= (String)request.getAttribute("pyid");
//if (plog==null) plog= userid;
String pnam = "";
String piid = plog;

Connection conH = FactorDBService.getInstance().openConnection();

String sql23 = "select debtorid from Debtor where sysid ='" + piid+"';";
Statement ps3  = conH.createStatement();
ResultSet rs3 = ps3.executeQuery(sql23);
String debtrid = null;
if(rs3.next()){
    debtrid= rs3.getString("debtorid");// + " " + rs.getString("Name2");
}
ps3.close();
rs3.close();
String dtid= null;
String dpass= null;
String dbnm= null;
String isclnt= null;
Statement s=null;
ResultSet rs2 =null;
try{
	//String sql22="SELECT Fac.DebtorId as 'dbid', Fac.Name1 + ' ' + Fac.Name2 as 'dbname',Deb.Password as 'dbpass', isnull(Deb.NewClient,'Y') as 'clnt' FROM dbo.Debtor Deb JOIN Factor.dbo.Debtor Fac ON Deb.OldDebtor_PK = Fac.SysId WHERE Fac.DebtorId =?";
	String sql22="SELECT DebtorId as 'dbid', Name1 as 'dbname', Status FROM Debtor where DebtorId=" + debtrid;
 	s = conH.createStatement();
 	rs2 = s.executeQuery(sql22);
 	while (rs2.next()) {
 		dtid = new String(rs2.getString("dbid"));
 		//dpass = new String (rs2.getString("dbpass"));
 		dbnm = new String (rs2.getString("dbname"));
 		isclnt = new String (rs2.getString("Status"));
	}
 	pnam = dbnm; 
	}catch(Exception e)
	{e.printStackTrace();}
	finally{
		s.close();
 		//rs2.close();
 		FactorDBService.getInstance().releaseConnection(conH);	
 		}
	//=============================================================
 
%>

	<table border="0" width="1200" align="left" style='table-layout:fixed'>
	<tr><td align="left"> <img src="ipsban.jpg" width="100%"></td></tr>
	<tr><td></td></tr>
	</table> 
	
	<div STYLE="position:absolute;top:75px;left:45px;z-index:1"><table border="0" width="1150" style='table-layout:fixed'>
	 <tr>
	 <td width="50" nowrap="nowrap">&nbsp;</td><td width="375px" align="left" colspan="1" nowrap="nowrap"> &nbsp;&nbsp; <font face="arial" size="2" color="#FFFFFF">Payer: <%=pnam %> </font> </td>
        <td width="180px">&nbsp;</td>

	 <td align="left" colspan="1" nowrap="nowrap">  
	   <table border=0 cellpadding=5 cellspacing=15>
        <tr><td>
	 <a href="#"  onclick="javascript:MainMenuForm.submit()" style="color:#FFFFFF"> <font face="arial" size="2" color="#FFFFFF">Main Menu</font></a> 
	 </td><td>
	 <a href="#"  onclick="javascript:feedForm.submit()" style="color:#FFFFFF" > <font face="arial" size="2" color="#FFFFFF">Feedback</font></a> 
     	 </td><td> 
	<a href="http://invoicepayment.ca/en/contact_ips_invoice_payment_systems.php" style="color:#FFFFFF" target="_blank"> <font face="arial" size="2" color="#FFFFFF">Contact Us</font></a>
	</td><td> 
	<a href="http://invoicepayment.ca/en/index.php" style="color:#FFFFFF" target="_blank"> <font face="arial" size="2" color="#FFFFFF">IPS Home</font></a>
        </td><td>  	 <a href="https://live.invoicepayment.ca:8443/ipspayers/Payer_Manual_Web.pdf#zoom=100%" style="color:#FFFFFF" target="_blank"> <font face="arial" size="2" color="#FFFFFF">Help</font></a>&nbsp;&nbsp;
	</td><td><  <a href="http://test.invoicepayment.ca/payerFrLive/Logout.jsp" style="color:#FFFFFF" target="_top"> <font face="arial" size="2" color="#FFFFFF">Log Out </font></a>
         </td></tr></table> 
	</td></tr></table></div>

                
     <!--  for prod: https://live.invoicepayment.ca:8443/ipspayers/debtr.jsp   -->

	<form method=post name="MainMenuForm" action="http://test.invoicepayment.ca/payerFrLive/debtr.jsp"> 
       <input type="hidden" name=did value=<%=dtid%> >
	   <input type="hidden" name=dbnme value="<%=dbnm%>" >
	   <input type="hidden" name=dpass value="<%=dpass%>" >
	</form>

	 
	  <!--  for prod: https://live.invoicepayment.ca:8443/ipspayers/feedform.jsp -->
	 
	 <form method=post name="feedForm" action="http://test.invoicepayment.ca/payerFrLive/feedform.jsp">
	    <input type="hidden" name="plog" value=<%=dtid%> >
           <input type="hidden" name="dbnm" value="<%=dbnm%>" >
           <input type="hidden" name=dpass value="<%=dpass%>" >
	  </form>
