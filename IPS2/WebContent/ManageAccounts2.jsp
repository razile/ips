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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
 <link rel="stylesheet" href="payer.css" type="text/css"/>
<LINK REL="shortcut icon" href="http://ips-srvv08/IPSmain/favicon.ico" type="image/x-icon"/> 
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
<script type="text/Javascript">
	var which;
	  $(document).ready(function() {
		  $('input[name=AcctId]').val('');
	           $("input").click(function () {
	                    which = $(this).attr("id");
	                   
	                   });
	
	$("#form").submit(function () {
	    if (which == "delete") {
	    	if($(":checkbox:checked").length==0)
	    	{  alert("Please select accounts to be deleted.")
	    		return false; 
	    	}else
	    		{return true;}}
	    	else if (which=="edit" || which=="select")
	    	{
	    		if($(":checkbox:checked").length==0)
		    	{  alert("Please select one account.");
		    		return false; 
		    	}
	    		else if($(":checkbox:checked").length>1)
	    			{
	    			alert("Please select only one account.");
		    		return false;
	    			}
	    		else {
	    			var acctid = $(":checkbox:checked").val().trim();
	    			//alert(acctid);
	    			 
	    			  $('input[name=AcctId]').val(acctid);
	    			var transit = $(":checkbox:checked").closest('tr').find('td:eq(1)').text().trim();
	    			$('input[name=transit]').val(transit);
	    		    var branch = $(":checkbox:checked").closest('tr').find('td:eq(2)').text().trim();	
	    		    $('input[name=branch]').val(branch);
	    		    var account = $(":checkbox:checked").closest('tr').find('td:eq(3)').text().trim();	
	    		    $('input[name=account]').val(account);
	    		    var $currency = $(":checkbox:checked").closest('tr').find('td:eq(4)').text().trim();	
	    		    $('input:radio[value='+ $currency +']').attr('checked', 'checked');
	    		//    alert(currency);
	    		 if (which =="select")
	    			 {$('input[name=transit]').attr('readonly', true);
	    			 $('input[name=branch]').attr('readonly', true);
	    			 $('input[name=account]').attr('readonly', true);
	    			 $('input[name=transit]').attr('readonly', true);
	    			 $('.currency').each(function() {this.disabled = true});
	    			 }
	    		 else if (which =="edit")
	    			 {
	    			 $('input[name=transit]').attr('readonly', false);
	    			 $('input[name=branch]').attr('readonly', false);
	    			 $('input[name=account]').attr('readonly', false);
	    			 $('input[name=transit]').attr('readonly', false);
	    			 $('.currency').each(function() {this.disabled = false});
	    			 
	    			 }return false;
	    		}
	         	}
	    	else if (which =="insert")
	    		{if($('input[name=transit]').val()=="")
	    			{alert("Transit Number is required"); return false;};
	    			if($('input[name=branch]').val()=="")
	    			{alert("Branch Code is required"); return false;};
	    			if($('input[name=account]').val()=="")
	    			{alert("Account Number is required"); return false;};
	    			 if (!$('input[name=currency]:checked').length) {
	    				 alert("Currency Type is required"); 
	    				 return false; // stop whatever action would normally happen
	    		      }

	    			return true;}
	    	else if (which == "add")
	    		{
	    		 $('input[name=transit]').attr('readonly', false);
    			 $('input[name=branch]').attr('readonly', false);
    			 $('input[name=account]').attr('readonly', false);
    			 $('input[name=transit]').attr('readonly', false);
    			 $('.currency').each(function() {this.disabled = false});
    			 $('input[name=transit]').val("");
    			 $('input[name=branch]').val("");
    			 $('input[name=account]').val("");
    			  $('input[name=AcctId]').val("");
    			  $('.currency').each(function() {this.checked = false});
    			 return false;
	    		}
	    	else if (which == "cancel")
    		{ 
	    		$('input[name=transit]').val("");
   			 $('input[name=branch]').val("");
   			 $('input[name=account]').val("");
   			  $('input[name=AcctId]').val("");
   			 $('.currency').each(function() {this.checked = false});
	    		return false;
    		}
	    	});
	
	  });
	
	  </script>
	
	<style type="text/css">
      /* Example CSS class using Quicksand Book Regular */
      b.ips {
        font-family: "Quicksand Bold Regular", Arial; 
        font-size: 9pt; 
        color: #FFFFFF;
      }
    </style>

	<style type="text/css">
   	.text-color { color: #0A70AB; }
	.special    { color: #AB830A; }
	.outset { border-style:outset; }
	a:link { 
	font-size: 8pt;
	text-decoration: none;
	}

	a:visited { 
	font-size: 8pt;
	text-decoration: none;
	}
	
	a:hover{
	background-color:#d06200;
	}
  </style>
<title> Manage Bank Accounts </title>
<script type="text/javascript" src="jslibrary.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript"  src='http://cdn.renderedfont.com/js/renderedfont-0.8.min.js#free'></script>
</head>
<body>


<%
	String plog = (String) session.getAttribute("pyid");
	String pnam = (String)  session.getAttribute("pynm");
	//out.println(plog);

    if(((String) session.getAttribute("pyid")==null)) {  
		response.sendRedirect("index.html");
		}
	%>
<table border="0" width="1200" align="left" style='table-layout:fixed'>
	<tr><td align="left"> <img src="ipsban.jpg" width="100%"></td></tr></table>
	
	<div STYLE="position:absolute;top:98px;left:35px;z-index:1"><table border="0" width="1150" style='table-layout:fixed'>
	 <tr>
	 <td width="50" nowrap="nowrap">&nbsp;</td><td width="370px" align="left" colspan="1" nowrap="nowrap"> &nbsp;&nbsp;&nbsp;&nbsp; <b class="ips renderedFont"> Payer: <%= pnam %></b> </td><td width="220px">&nbsp;</td>
	 <td align="left" colspan="1" nowrap="nowrap"> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; <a href="Logout.jsp" style="color:#FFFFFF" target="_top"> <b class="ips renderedFont">Logout </b></a> &nbsp;&nbsp;
	 <a href="debtr.jsp" style="color:#FFFFFF"> <b class="ips renderedFont">Main Menu</b></a> &nbsp;&nbsp;
	 <a href="feedform.jsp" style="color:#FFFFFF" target="_blank"> <b class="ips renderedFont">Feedback</b></a> &nbsp;&nbsp;
	 <a href="/en/contact_ips_invoice_payment_systems.html" style="color:#FFFFFF" target="_blank"> <b class="ips renderedFont">Contact Us</b></a> &nbsp;&nbsp;
	 <a href="/index.jsp" style="color:#FFFFFF" target="_top"> <b class="ips renderedFont">IPS Home</b></a> &nbsp;&nbsp;
	 <a href="Payer_Manual.pdf" style="color:#FFFFFF" target="_blank"> <b class="ips renderedFont">Help</b></a> </td>
	  </tr></table></div>
	 
	
<div STYLE="position:absolute;top:160px;left:10px;z-index:1">
	<table border="0" width="1200" cellspacing="0" align="left" style='table-layout:fixed;background-color:#A0A0A0' ><tr><td>
	 <font face="arial" size="2" color ="white">&nbsp;</font> </td><tr></table></div>
<div  STYLE="position:absolute;top:210px;left:50px;z-index:1;width:100%">

<table border=0 cellpadding=0 cellspacing=0 width=100%>

<tr><td align="left" width=169 style="vertical-align:top">
<table border=0 cellpadding=0 cellspacing=0 width=200>
<tr><td>
<table border=0 cellpadding=0 cellspacing=0 width=200>
<tr><td width="169" height=12 style="background-color:#A0A0A0" colspan=3></td></tr>
<tr>
<td width="9" height=36 style="background-color:#A0A0A0"></td>
<td width="152" height=36 style="background-color:#2f2f2f" ><a href="Setup.jsp" style="color:#FFFFFF;margin-left:10px;"><b class="ips renderedFont"  id="b1" >Setup Bank Account</b></a></td>
<td width="8" height=36 style="background-color:#A0A0A0"></td>
</tr>
<tr>
<td width="9" height=1px style="background-color:#A0A0A0"></td>
<td width="152" height=1px style="background-color:#A0A0A0"></td>
<td width="8" height=1px style="background-color:#A0A0A0"></td>
</tr>
<tr>
<td width="9" height=36 style="background-color:#A0A0A0"></td> 
<td width="152" height=36 style="background-color:#2f2f2f" ><a href="ManageAccounts.jsp" style="color:#FFFFFF;margin-left:10px;"><b class="ips renderedFont"  id="b2" >Manage Bank Accounts</b></a></td>
<td width="8" height=36 style="background-color:#A0A0A0"></td>
</tr>
<tr>
<td width="9" height=1px style="background-color:#A0A0A0"></td>
<td width="152" height=1px style="background-color:#A0A0A0"></td>
<td width="8" height=1px style="background-color:#A0A0A0"></td>
</tr>
<tr>
<td width="9" height=36 style="background-color:#A0A0A0"></td>
<td width="152" height=36 style="background-color:#2f2f2f"><a href="MakePayment.jsp" style="color:#FFFFFF;margin-left:10px;"><b class="ips renderedFont"  id="b3">Make a Payment</b></a></td>
<td width="8" height=36 style="background-color:#A0A0A0"></td>
</tr>
<tr>
<td width="9" height=1px style="background-color:#A0A0A0"></td>
<td width="152" height=1px style="background-color:#A0A0A0"></td>
<td width="8" height=1px style="background-color:#A0A0A0"></td>
</tr>
<tr>
<td width="9" height=36 style="background-color:#A0A0A0"></td>
<td width="152" height=36 style="background-color:#2f2f2f" ><a href="ReviewPayment.jsp" style="color:#FFFFFF;margin-left:10px;"><b class="ips renderedFont" id="b4">Review Payments</b></a></td>
<td width="8" height=36 style="background-color:#A0A0A0"></td>
</tr>
<tr>
<td width="9" height=1px style="background-color:#A0A0A0"></td>
<td width="152" height=1px style="background-color:#A0A0A0"></td>
<td width="8" height=1px style="background-color:#A0A0A0"></td>
</tr>
<tr>
<td width="9" height=36 style="background-color:#A0A0A0"></td>
<td width="152" height=36 style="background-color:#2f2f2f"><a href="Reports.jsp" style="color:#FFFFFF;margin-left:10px;"><b class="ips renderedFont" id="b5">Reports</b></a></td>
<td width="8" height=36 style="background-color:#A0A0A0"></td>
</tr>
<tr>
<td width="9" height=1px style="background-color:#A0A0A0"></td>
<td width="152" height=1px style="background-color:#A0A0A0"></td>
<td width="8" height=1px style="background-color:#A0A0A0"></td>
</tr>
</table>
</td></tr>
<tr><td>
<image src="images/RightNav.jpg" width=200px/>
</td></tr></table>
</td><td style="vertical-align:top">

<%! String driverName = "com.mysql.jdbc.Driver";%>

<%!String url = "jdbc:mysql://localhost:3306/InsuiteSybaseCoreRep";%>
<%!String user = "root";%>
<%!String psw = "dbaDEV2013-";%>
<%
Connection con = null;
ResultSet rs =null;
PreparedStatement ps = null;
int payerid= Integer.parseInt(session.getAttribute("pyid").toString());
String debtorid=null;
Class.forName(driverName);
con = DriverManager.getConnection(url,user,psw);
 String sql = "SELECT p.SysId,PayerId,TransitNumber,BranchCode,AccountNumber,CurrencyType FROM PayersAccounts p where p.PayerId="+payerid;
ps = con.prepareStatement(sql);
rs = ps.executeQuery();
int rowCount=0;
if(rs.last()){
    rowCount = rs.getRow(); 
    rs.beforeFirst();
}

%>


<form name="manageAcct" id="form" action="ProcessAcct" method="post" onsubmit="return validateForm()">


    <div class="innerbody">
    <%if (rowCount>0){ %>
        <div id="BankAccounts">
        <table border="0" cellspacing="5" cellpadding="0" id="tblAccts">
     <thead>
     <tr><td><h3>Bank Accounts</h3></td></tr>
	</thead>
	<tbody>
	<% while(rs.next()){ %>
	<TR>		
			<TD align="center" >  <font><input type="checkbox" name="AcctChk" value="<%=rs.getString("SysId") %>"></font> </TD> 	
			<TD align="center" > <font face="arial" size="1" color="#666666"> <%= rs.getString("TransitNumber") %> </font> </TD> 				
			<TD align="center" >  <font face="arial" size="1" color="#666666"> <%= rs.getString("BranchCode") %> </font> </TD> 
			<TD align="center" >  <font face="arial" size="1" color="#666666"> <%= rs.getString("AccountNumber") %> </font> </TD> 
		    <TD align="center" >  <font face="arial" size="1" color="#666666"> <%= rs.getString("CurrencyType") %> </font> </TD> 
			</TR>
	<% }
	%>
	<tr>
	<td></td>
	<td><input type="submit" class="button select-button" name="act" id="select" value="select"  />
	</td>
	<td><input type="submit" class="button add-button" name="act" id="add" value="add"  />
	</td>
	<td><input type="submit" class="button edit-button" name="act" id="edit" value="edit"  /></td>
	<td>	<input type="submit" class="button delete-button" name="act" id="delete" value="delete"  /></td>
	</tr>
	</tbody>
	</table>
	</div>
	
	<%}
%>
  
	  <table border="0" cellspacing="5" cellpadding="0" id="tblAccts">
     <thead>
     <tr><td><h3>Setup a Bank Account</h3></td></tr>
	</thead>
	<tbody>
	</tbody>
	</table>
	<%   sql = "SELECT Name1, DebtorId,a.street1,a.street2, a.city,a.state,a.zip FROM Debtor d join Address a on a.SysParentId =  d.SysId where a.addressType='Main' and a.ParentTable='Debtor' and d.SysId="+payerid;
    ps = con.prepareStatement(sql);
    rs = ps.executeQuery();
  
    while(rs.next())    
    {%> 
	<table width=100% style="text-align:center">
	<tr><td><b><%=rs.getString("Name1")%></b></td></tr>
	<tr><td><b><%=rs.getString("Street1")%>, <%=rs.getString("Street2")%> </b></td></tr>
	<tr><td><b><%=rs.getString("City")%>,<%=rs.getString("state")%> </b></td></tr>
	<tr><td><b><%=rs.getString("Zip")%></b></td></tr>
	 
	</table>
	<% debtorid = rs.getString("DebtorId");
	}
  //  }
%>
   <table width=100% style="text-align:left">
	<tr><td><h3>Please debit the following bank account</h3></td></tr>
	</table>
	
	
	<table width=100% style="text-align:center">
	<tr><td style="text-align:right"><b>Transit Number</b></td><td style="text-align:left"><input type=text name="transit" id="transit" style="width:90px;height:12px;"/></td></tr>
	<tr><td style="text-align:right"><b>Branch Code</b></td><td style="text-align:left"><input type=text name="branch" id="branch" style="width:90px;height:12px;"/></td></tr>
	<tr><td style="text-align:right"><b>Account Number</b></td><td style="text-align:left"><input type=text name="account" id="account" style="width:90px;height:12px;"/></td></tr>
	<tr><td style="text-align:right"><b></b></td><td style="text-align:left"><input class="currency" type="radio" name="currency" id="currencyUSA" value="USD"> USD
 <input class="currency" type="radio" name="currency" value="CAD" id="currencyCAD"> CAD<br></td>
 <td><input type='hidden' name='AcctId'  id='AcctId' value='' /></td>
 <td><input type=hidden name="PayerId" value=<%=payerid%> style="width:90px;height:10px;"/></td>
 </tr>
	<tr><td style="text-align:right"><b>Your User Id is:</b></td><td style="text-align:left"><%=debtorid%> </td></tr>
	
	</table>
	<table width=650px height="100" style="text-align:right">
	<tr><td>
	<input type="submit" class="button insert-button" name="act" id="insert" value="insert"  />
	<input type="submit" class="button cancel-button" name="act" id="cancel" value="cancel"  />
</td></tr>
	</table>
	</div>

		
</form>		
		
		
<%@include file='footer.jsp'%>