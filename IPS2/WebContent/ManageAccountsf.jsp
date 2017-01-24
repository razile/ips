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
<html lang="en">
<head>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script  type="text/javascript"  src='helper/renderedfont-0.8.min.js#free'></script>

 <link rel="stylesheet" href="payer.css" type="text/css"/>
<!--  <LINK REL="shortcut icon" href="http://ips-srvv08/IPSmain/favicon.ico" type="image/x-icon"/>--> 
<link rel="stylesheet" href="datepicker.css" />
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
<script type="text/Javascript">

function validate()
{
	
	
	
   var acct = document.getElementById("account");
// alert(acct.value);
   var url = "CheckAcctExist.jsp?acct="+acct.value;
   if (window.XMLHttpRequest)
       req = new XMLHttpRequest();
   else if (window.ActiveXObject)
       req = new ActiveXObject("Microsoft.XMLHTTP");
   req.open("GET", url, true);
   req.onreadystatechange =callback;
   req.send(null);
   var msg1= document.getElementById("msg1");
    msg1.innerHTML="";
}


function callback()
{
     if (req.readyState == 4)
   {
        if (req.status == 200)
       {
         var message = req.responseText;
         var msg1= document.getElementById("msg1");
         
         msg1.innerHTML=message;
         var btn = document.getElementById("insert");
     //   alert(message.search("Account already exists."));
         if (message.search("Account already exists.") <0)
        	 { document.getElementById("insert").disabled =false;}
         else
        	 {document.getElementById("insert").disabled =true;}
       }
    
    }
 }


	var which;
	
	  $(document).ready(function() {
		
		  
		  
		  //$("#dialog").dialog({ autoOpen: false });
	
		  $('input[name=AcctId]').val('');
	           $("input").click(function () {
	                                        which = $(this).attr("id");
	                                        });
	        
              
	$("#form").submit(function () { //alert(which);  
	    if (which == "delete") {
	    	 var val =$('input[name=AcctChk]:checked', '#form').val();
	    	// alert(val);
	    	if(val==null || val=="null")
	    	{  alert("Please select an account to be deleted.");
	    		return false; 
	    	}else
	    		{
	    		$("#AcctId2").val(val);
	    		  $( "#dialog-modal" ).dialog({
	    			   height: 150,
	    	             width: 400,  
	    			      modal: true,
	    			      buttons: {
	                            Yes: function () {
	                                // $(obj).removeAttr('onclick');                                
	                                // $(obj).parents('.Parent').remove();
							
	                            	  $("#form2").submit();
	                            	   $(this).dialog("close");
	                            	   
	                               
	                            },
	                            No: function () {
	                            	 // $("#form2").submit();
	                            	 $("#AcctId2").val("");
	                            	 $("#form2").submit();
	                            	   $(this).dialog("close"); 
	                            	 //$(this).remove();
	                            }
	                        },
	                        close: function (event, ui) {
	                            $(this).remove();
	                        }


	    		    });    
	    		return false;
	    		}}
	    	else if (which=="edit" || which=="select")
	    	{ 
	    	  var val =$('input[name=AcctChk]:checked', '#form').val();
	    	
	    	  if(val==null)
		    	{  alert("Please select one account.");
		    		return false; 
		    	}
	    	/*	else if($(":checkbox:checked").length>1)
	    			{
	    			alert("Please select only one account.");
		    		return false;
	    			}
	    		*/else {
	    			var acctid = val;
	    		 //  alert(acctid);
	    			  $('input[name=AcctId]').val(acctid);
	    			var transit = $('input[name=AcctChk]:checked').closest('tr').find('td:eq(1)').text();
	    			$('input[name=transit]').val(transit.trim());
	    		    var branch = $('input[name=AcctChk]:checked').closest('tr').find('td:eq(2)').text();	
	    		    $('input[name=branch]').val(branch.trim());
	    		    var account = $('input[name=AcctChk]:checked').closest('tr').find('td:eq(3)').text();	
	    		    $('input[name=account]').val(account.trim());
	    		    var $currency = $('input[name=AcctChk]:checked').closest('tr').find('td:eq(4)').text();	
	    		   
	    		    $nam = $currency.trim() ;
	    		  //  alert("1"+$nam+"1");
	    		    if ($nam=="USD"){
	    		    	$nam ="currencyUSA";
	    		    	$nam2= "currencyCAD";
	    		    	}else
	    		    	{$nam="currencyCAD";
	    		    	$nam2= "currencyUSA";
	    		    	}
	    		    $('input:radio[id='+ $nam +']').prop('checked', true);
	    		    $('input:radio[id='+ $nam2 +']').prop('checked', false);
	    		//    alert(currency);
	    		 if (which =="select")
	    			 {
	    			/* $('input[name=transit]').attr('readonly', true);
	    			 $('input[name=branch]').attr('readonly', true);
	    			 $('input[name=account]').attr('readonly', true);
	    			 $('input[name=transit]').attr('readonly', true);
	    			 $('.currency').each(function() {this.disabled = true});
	    			 */}
	    		 else if (which =="edit")
	    			 {
	    			 $('input[name=transit]').attr('readonly', false);
	    			 $('input[name=branch]').attr('readonly', false);
	    			 $('input[name=account]').attr('readonly', false);
	    			 $('input[name=transit]').attr('readonly', false);
	    			 $('.currency').each(function() {this.disabled = false});
	    		//	$('input[name=acctid]').attr('readonly', false);
	    			  $("#insert").attr('value','Mettre à jour');
                      
	    			 
	    			 }return false;
	    		}
	         	}
	    	else if (which =="insert")
	    		{
	    	         if($('input[name=transit]').val()=="")
	    			{alert("Transit Number is required"); return false;};
	    			if($('input[name=branch]').val()=="")
	    			{alert("Branch Code is required"); return false;};
	    			if($('input[name=account]').val()=="")
	    			{alert("Account Number is required"); return false;};
	    			 if (!$('input[name=currency]:checked').length) {
	    				 alert("Currency Type is required"); 
	    				 return false; // stop whatever action would normally happen
	    		      }

	    			return true;
	    			
	    	
	    	    }
	    		
	    	else if (which == "add")
	    		{
	    		/* $('input[name=transit]').attr('readonly', false);
    			$('input[name=branch]').attr('readonly', false);
    			 $('input[name=account]').attr('readonly', false);
    			 $('input[name=transit]').attr('readonly', false);
    			 $('.currency').each(function() {this.disabled = false});
    			 $('input[name=transit]').val("");
    			 $('input[name=branch]').val("");
    			 $('input[name=account]').val("");
    			  $('input[name=AcctId]').val("");
    			  $('.currency').each(function() {this.checked = false});
    		*/	 return false;
	    		}
	    	else if (which == "cancel")
    		{ 
	    		$('input[name=transit]').val("");
   			 $('input[name=branch]').val("");
   			 $('input[name=account]').val("");
   			  $('input[name=AcctId]').val("");
   			 $('input[name=account]').attr('readonly', false);
   			$("#insert").attr('value','Mettre à jour');
   			document.getElementById("insert").disabled =false;
   			$("#msg1").html("");
   			 $('.currency').each(function() {this.checked = false});
	    		return false;
    		}
	    	});
	return false;
	  });
	
	  </script>
<title> Gérer Compte bancaire </title>
<script type="text/javascript" src="jslibrary.js"></script>
</head>
<body>
<%
String userid = (String)request.getParameter("pyid");
//userid = CipherData.decipher("01234567",userid);
if (userid==null)
{ userid = (String)request.getAttribute("pyid");
      if (userid==null)
        response.sendRedirect("http://live.invoicepayment.ca");
        }
%>
<div id="dialog-modal" title="Confirmation requise "  style="display:none;">
<form name="manageAcct2" id="form2"  action="ProcessAcctf" method="post" >
<input type=hidden id="pyid" name="pyid" value="<%=userid%>">
  <input type=hidden id="AcctId2" name="AcctId2" value="77">
  <input type=hidden id="act" name="act" value="Delete">
</form>  Le compte sera supprimé; cependant, tous les paiements de facture existants seront traités et vous serez en mesure de les retrouver dans l’historique qui fait partie de vos rapports.  
</div>



<%@include file='headerf.jsp'%>
<%@include file='sidebarf.jsp'%>	


<%

Connection con = null;
Connection con1 = null;
ResultSet rs =null;
PreparedStatement ps = null;
int payerid=0;
try{
 payerid= Integer.parseInt(userid);
}
catch(Exception e){e.printStackTrace();}
String debtorid=null;
try
{
con = SqlServerDBService.getInstance().openConnection();
con1 = FactorDBService.getInstance().openConnection();
%>
  
<form name="manageAcct" id="form"  action="ProcessAcctf" method="post" >

  

    <div class="innerbody" style="width:500px;align:left;border=1">

<table border=0>

<%

String sql = "SELECT DebtorId FROM Debtor d where d.SysId="+payerid;
ps = con1.prepareStatement(sql);
rs = ps.executeQuery();
String DebtorId = ""; 
while(rs.next())    
{DebtorId = rs.getString("DebtorId");
}
%> 

	<tr><td style="text-align:right;color:#d06200" class="AccountFontTitle" >Nom d'utilisateur/Numéro de compte:</td><td style="text-align:left;color:#d06200" class="AccountFontTitle"><%=DebtorId%> </td></tr>

</table>
  
	  <table border="0" cellspacing="5" cellpadding="0" id="tblAccts">
     <thead>
     <tr><td><h3>Nom de la société et adresse:</h3></td></tr>
	</thead>
	<tbody>
	</tbody>
	</table>
	<% 
	 sql = "SELECT Name1, DebtorId,a.street1,a.street2, a.city,a.state,a.zip FROM Debtor d join Address a on a.SysParentId =  d.SysId where a.addressType='Main' and a.ParentTable='Debtor' and d.SysId="+payerid;
    ps = con1.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, 
            ResultSet.CONCUR_UPDATABLE);
    rs = ps.executeQuery();
  
    while(rs.next())    
    {%> 
	<table border=0 width="600" style="text-align:center" >
	<tr><td><font face="arial" size="2"><%=rs.getString("Name1")%></font></td></tr>
	<tr><td><font face="arial" size="2"><%=rs.getString("Street1")%>, <%=rs.getString("Street2")%> </font></td></tr>
	<tr><td><font face="arial" size="2"><%=rs.getString("City")%>,<%=rs.getString("state")%> </font></td></tr>
	<tr><td><font face="arial" size="2"><%=rs.getString("Zip")%></font></td></tr>
	 
	</table>
	<% debtorid = rs.getString("DebtorId");
	}
  %>
   <table  width=100% style="text-align:left">
	<tr><td><h3>Veuillez débiter le compte bancaire suivant :</h3></td></tr>
	</table>
	
	
	<table width="600px" border=0 style="text-align:center">
	<tr><td style="text-align:right" class="AccountFont">Numéro de transit</td><td style="text-align:left"><input type=text name="transit" id="transit" style="width:130px;height:12px;"/></td></tr>
	<tr><td style="text-align:right"><font face="arial" size="2" class="AccountFont">Code bancaire</b></td><td style="text-align:left"><input type=text name="branch" id="branch" style="width:130px;height:12px;"/></td></tr>
	<tr><td style="text-align:right"><font face="arial" size="2" class="AccountFont">Numéro de compte</b></td><td style="text-align:left"><input type=text name="account" id="account" onkeyup="validate()" style="width:130px;height:12px;" /><div id="msg1" style="color:red;font-size:10pt;"></div></td></tr>
	<tr><td style="text-align:right"><b></b></td><td style="text-align:left"><input class="currency" type="radio" name="currency" id="currencyUSA" value="USD"> <span class="AccountFont">USD</span>
 <input class="currency" type="radio" name="currency" value="CAD" id="currencyCAD"> <span class="AccountFont">CAD</span></td>
 <td><input type='hidden' name='AcctId'  id='AcctId' value='' /></td>
 <td><input type=hidden name="PayerId" value=<%=payerid%> style="width:90px;height:10px;"/></td>
 </tr>
		
	</table>
	<table width=460px border =0 height="20" style="text-align:right">
	<tr><td>
	<input type="submit" class="button insert-button" name="act" id="insert" value="Mettre à jour"  style="color:blue"/>
	<input type="submit" class="button cancel-button" name="act" id="cancel" value="Annuler"  style="color:blue"/>
</td></tr>
	</table>
	

    <%
     sql = "SELECT p.SysId,PayerId,TransitNumber,BranchCode,AccountNumber,CurrencyType FROM PayersAccounts p where p.Active=1 and p.PayerId="+payerid;
    ps = con.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE, 
            ResultSet.CONCUR_UPDATABLE);
    rs = ps.executeQuery();
    int rowCount=0;
    if(rs.last()){
        rowCount = rs.getRow(); 
        rs.beforeFirst();
    }

    
    if (rowCount>0){ %>
        <div id="BankAccounts">
        <table border="0" cellspacing="5" cellpadding="0" id="tblAccts">
      <tr><td width=200><h3>Comptes bancaires:</h3></td></tr>
	<tbody>
	<% while(rs.next()){ %>
	<TR>		
			<TD align="center" width=10 >  <font><input type="radio" name="AcctChk" value="<%=rs.getString("SysId") %>"></font> </TD> 	
			<TD align="left" width=100> <font face="arial" size="2" color="#666666"> <%= rs.getString("TransitNumber") %> </font> </TD> 				
			<TD align="left" width=100>  <font face="arial" size="2" color="#666666"> <%= rs.getString("BranchCode") %> </font> </TD> 
			<TD align="left" width=100>  <font face="arial" size="2" color="#666666"> <%= rs.getString("AccountNumber") %> </font> </TD> 
		    <TD align="left" width=100>  <font face="arial" size="2" color="#666666"> <%= rs.getString("CurrencyType") %> </font> </TD> 
			</TR>
	<% }
%>	</table>
<table>
	<tr >
	<td colspan=5 style="align:center;width:100%"><table border=0 style="width:100%;align:center"><tr><td width=280px></td><td>
	<input type="submit" class="button edit-button" name="act" id="edit" value="Modifier" style="color:blue" />
		<input type="submit" class="button delete-button" name="act" id="delete" value="Supprimer"  style="color:blue" />
		</td></tr></table></td>
	</tr>
	</table>
</div>
  <%   }
}
    catch(Exception e){e.printStackTrace();}
    finally{try{
    	SqlServerDBService.getInstance().releaseConnection(con);
    	FactorDBService.getInstance().releaseConnection(con1);
    }
    catch(Exception e){e.printStackTrace();}
    } 
	%>
	
	</div>

		
</form>		
		
		
<%@include file='footerf.jsp'%>
