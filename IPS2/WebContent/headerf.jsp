<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="ProcessAcctData.*" %>

    
<% 
String plog = (String) request.getParameter("pyid");
if (plog == null)plog= request.getParameter("plog");
if (plog == null)plog= (String)request.getAttribute("pyid");
if (plog==null) plog= userid;
String pnam = "";
String piid = plog;
Connection con2 = null;
String driverName2 = "com.sybase.jdbc3.jdbc.SybDriver";
Class.forName(driverName2);
// String url1 = "jdbc:sybase:Tds:ips-srvsb6.ips-corporation.net:2638/factorsql_dbserver";
// String user1= "dba"; 
// String psw1 = "dscsql";
String url2= "jdbc:jtds:sqlserver://192.168.1.41/ips";
Connection  con22 = DriverManager.getConnection(url1,user1,psw1);
Connection consyb =  DriverManager.getConnection(url11,user11,psw11);
String sql23 = "select debtorid from Debtor where sysid ='" + piid+"'";
PreparedStatement ps3  = con22.prepareStatement(sql23);
ResultSet rs3 = ps3.executeQuery();
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
PreparedStatement s=null;
ResultSet rs2 =null;
try{
	//String sql22="SELECT Fac.DebtorId as 'dbid', Fac.Name1 + ' ' + Fac.Name2 as 'dbname',Deb.Password as 'dbpass', isnull(Deb.NewClient,'Y') as 'clnt' FROM dbo.Debtor Deb JOIN Factor.dbo.Debtor Fac ON Deb.OldDebtor_PK = Fac.SysId WHERE Fac.DebtorId =?";
	String sql22="SELECT DebtorId as 'dbid', Name1 as 'dbname', Status FROM DBA.Debtor where DebtorId=?;";
 	s = consyb.prepareStatement(sql22);
 	s.setString(1,debtrid);
 	rs2 = s.executeQuery();
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
 		con22.close();
 		//con33.close();	
 		}
	//=============================================================
 
%>

	<table border="0" width="1200" align="left" style='table-layout:fixed'>
	<tr><td align="left"> <img src="ipsban_french.jpg" width="100%"></td></tr>
	<tr><td></td></tr>
	</table> 
	
	<div STYLE="position:absolute;top:80px;left:45px;z-index:1"><table border="0" width="1160" style='table-layout:fixed'>
	 <tr>
	 <td width="50" nowrap="nowrap">&nbsp;</td><td width="375px" align="left" colspan="1" nowrap="nowrap"> &nbsp;&nbsp; <font face="arial" size="2" color="#FFFFFF">Payeur: <%=pnam %> </font> </td>
        <td width="182px">&nbsp;</td>

	 <td align="left" colspan="1" nowrap="nowrap">  
	   <table border=0 cellpadding=7 cellspacing=2>
        <tr><td>
	 <a href="#"  onclick="javascript:MainMenuForm.submit()" style="color:#FFFFFF"> <font face="arial" size="2" color="#FFFFFF">Menu principal</font></a> 
	 </td><td>
	 <a href="#"  onclick="javascript:feedForm.submit()" style="color:#FFFFFF" > <font face="arial" size="2" color="#FFFFFF">Commentaires</font></a> 
     	 </td><td> 
	<a href="https://invoicepayment.ca:8443/fr/contact_ips_invoice_payment_systems.php" style="color:#FFFFFF" target="_blank"> <font face="arial" size="2" color="#FFFFFF">Contactez-nous</font></a>
	</td>
	<!-- <td> <a href="http://invoicepayment.ca/fr/index.php" style="color:#FFFFFF" target="_blank"> <font face="arial" size="2" color="#FFFFFF">Accueil IPS</font></a> </td> -->
	<td><a href="https://live.invoicepayment.ca:8443/ipspayers/IPS2/Payer_Manual_Web_FR.pdf" style="color:#FFFFFF" target="_blank"> <font face="arial" size="2" color="#FFFFFF">Aide</font></a>&nbsp;&nbsp;	</td> 
		<td><  <a href="https://live.invoicepayment.ca:8443/fr/index.php" style="color:#FFFFFF" target="_top"> <font face="arial" size="2" color="#FFFFFF">Fermeture de session</font></a>
         </td></tr></table> 
	</td></tr></table></div>

                

	<!-- <form method=post name="MainMenuForm" action="http://live.invoicepayment.ca/ipspayers/debtr.jsp">  -->
	<form method=post name="MainMenuForm" action="https://live.invoicepayment.ca:8443/payer_fr_modified/ipspayers/debtr.jsp">  
       <input type="hidden" name=did value=<%=dtid%> >
	   <input type="hidden" name=dbnme value="<%=dbnm%>" >
	   <input type="hidden" name=dpass value="<%=dpass%>" >
	</form>

	 
	<!-- <form method=post name="feedForm" action="http://live.invoicepayment.ca/ipspayers/feedform.jsp"> -->
	<form method=post name="feedForm" action="https://live.invoicepayment.ca:8443/payer_fr_modified/ipspayers/feedform.jsp">
	    <input type="hidden" name="plog" value=<%=dtid%> >
           <input type="hidden" name="dbnm" value="<%=dbnm%>" >
           <input type="hidden" name=dpass value="<%=dpass%>" >
	  </form>
