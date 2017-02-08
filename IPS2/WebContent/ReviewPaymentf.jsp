<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page errorPage="Logout.jsp" %>
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
<%@ page import="com.ips.model.*" %>
<%@ page buffer="16kb"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html>
<head>
 <link rel="stylesheet" href="payer.css" type="text/css"/>
<!--  LINK REL="shortcut icon" href="http://ips-srvv08/IPSmain/favicon.ico" type="image/x-icon" --> 
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
	
<title>Revoir les paiements</title>
<script type="text/javascript" src="jslibrary.js"></script>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />

  
  <script src="https://code.jquery.com/jquery-1.9.1.js"></script>
  <script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript"  src='helper/renderedfont-0.8.min.js#free'></script>
  <link rel="stylesheet" href="datepicker.css" />

  <script>

  $(function() {
	
    $( "#datepicker" ).datepicker({ dateFormat: "yy-mm-dd" });
    $("#GreyHeader").text("Menu principal > Effectuer un paiement > Revoir les paiements");	
  });

  </script>
<script type="text/javascript">
function getQueryStrings() { 
	 /* var assoc  = {};
	  var decode = function (s) { return decodeURIComponent(s.replace(/\+/g, " ")); };
	  var queryString = location.search.substring(1); 
	  var keyValues = queryString.split('&'); 

	  for(var i in keyValues) { 
	    var key = keyValues[i].split('=');
	    if (key.length > 1) {
	      assoc[decode(key[0])] = decode(key[1]);
	    }
	  }*/ 
	  var assoc ='${d}';
	  return assoc; 
	} 
//var qs = getQueryStrings();

//var q = qs["d"]; 
var which;
$(document).ready(function() {	
	var qs =  '<%=(String)request.getAttribute("d") %>';//document.getElementById("delid").value;
	$("input[type='radio']").click(function(){
		 var x = $(this).closest("tr").children().eq(7).html();
		 if ((x.indexOf('Declined')>-1)||(x.indexOf('Approved')>-1))
			 {$('#delete').attr('disabled', 'disabled');
			 }
		 else
			 {$('#delete').removeAttr("disabled"); 
			 }
		//alert(x);
		
	});//alert('a'+qs);
	if ((qs!="null" && qs!="" && qs!="${d}")){
		
		window.open('DisplayDeletedInvoicef.jsp?id='+qs);

	}
	

	   $("input").click(function(){
		   which = $(this).attr("id");
	   });
	   $("#formId").submit(function () {
//	alert(which);
	if ($("#formId input:radio:checked").length == 0)
	  {
	      alert("Veuillez sélectionner un article avant de procéder au traitement.");
	      return false;
	  }
	  else if ( ($("#formId input:radio:checked").length > 1))
	  {
		  alert("Veuillez sélectionner un article avant de procéder au traitement.");
		  return false;
	  }
	
	
	if (which =="details")
	{// alert( $("#formId input:radio:checked").val());
       values ="id=" +  $("#formId input:radio:checked").val();
        $.ajax({
			  url: "GetInvoiceDetailsf.jsp",
			  type: "post",
			  data: values,
			  success: function(response){
			   //   alert("success");
			      var text = response;
			       $("#result").html(text);
			  },
			  error:function(){
			      alert("failure");
			      $("#result").html('there is error while submit');
			  }   
			}); 
		
	   $( "#dialog-modal" ).dialog({

		      height: 300,
              width: 600,  
		      modal: true

		    });

	 return false;
	}else if (which=="delete")
	
		{
		var x = confirm("Souhaitez-vous vraiment faire la suppression?");
		  if (x)
		      return true;
		  else
		    return false;

          	
		}
	else if (which=="deeeeelete"){
		$.ajax({
			   url: "ReviewPaymentf",
			   dataType: 'json',
			   type:POST,
			   success: function(data) {
			      alert("success");	return false;
			   },
			   error: function(jqXHR, textStatus, errorThrown) {
			      alert(jqXHR+" - "+textStatus+" - "+errorThrown);
			   }       
			}); 
		return false;
	}
//	$("#formId input:checkbox:checked").val();
   return true;
//}
  });
});</script>



</head>
<body>
<%
String userid = (String)request.getParameter("pyid");
 if (userid==null)
{	 userid = (String)request.getAttribute("pyid");
     if (userid==null)
		response.sendRedirect("http://live.invoicepayment.ca/payer_fr_modified/ipspayers/index.htm");
        }
%>


<div id="dialog-modal" title="Détails de la facture">
<div id="result"></div>

</div>



<%@include file='headerf.jsp'%>
<%@include file='sidebarf.jsp'%>
<div id="innerbody">
<form name="ReviewPayment" id="formId" action="ReviewPaymentf" method="post" >


<input type=hidden id="pyid" name="pyid" value="<%=userid%>">
<table border=0 cellpadding=0 cellspacing=0><tr><td>
<table border=0 cellpadding=0 cellspacing=20>
<tr><td colspan=2 style="margin-left:10px;"><h3>Revoir le paiement</h3></td></tr>
<tr><td colspan=6 style="margin-left:10px;color:red;font-size:2em;">Si vous souhaitez modifier un détail du paiement soumis, veuillez supprimer le paiement et retourner à la fonction Verser un paiement.</td></tr>
<tr>
<td></td>
<td><h3>&#8470; de confirmation</h3></td>
<td><h3>Payeur</h3></td>
<td><h3>Date</h3></td>
<td><h3>Compte bancaire</h3></td>
<td><h3>Devise</h3></td>
<td width=80><h3>Montant du paiement</h3></td>
<td><h3>État</h3></td>
</tr>

<%
Connection con = null;
ResultSet rs =null;
PreparedStatement ps = null;
CallableStatement cs = null;
int payerid=Integer.parseInt(userid);
%>
<% 
try
{
con = SqlServerDBService.getInstance().openConnection();
Map<String, Debtor> debtors = FactorDBService.getInstance().getDebtors();	
Debtor d = debtors.get(String.valueOf(payerid));

cs = con.prepareCall("exec itdebtor_m ?");
cs.setInt(1, payerid);
rs = cs.executeQuery(); 
int counter =0;
while (rs.next()){
%>
<tr><td><input type="radio" name="check" value=<%=rs.getString("SysId") %>></td>
<td><h6><%= rs.getString("SysId") %></h6></td>
<td><h6><%String name= d.getName1() + " " + d.getName2(); 
if (name.length()>32)
{name=name.substring(0,31);}
%><%=name%></h6></td>
<td><h6><%=rs.getString("InvoicePaymentDate") %></h6></td>
<td><h6><%=rs.getString("AccountNumber") %></h6></td>
<td><h6><%=rs.getString("currencyType") %></h6></td>
<%DecimalFormat decim = new DecimalFormat("0.00"); %>
<td class="rightJustified"><h6 class="rightJustified"><%=String.format("%,14.2f",Double.parseDouble(rs.getString("invoiceamount")))%></h6></td>
<td><h6><%= rs.getString("status") %></h6></td>
</tr>
<% 
counter +=1;
}
}
catch(Exception e){e.printStackTrace();}
finally{
	SqlServerDBService.getInstance().releaseConnection(con);
}

%>
<tr><td colspan=2></td><td colspan=5>

<table></table>
</td>
</tr>
</table>
</td></tr>
<tr><td style="text-align:right">	
<input type="hidden" id="transId" name="transId">
<input type="submit" class="button details-button" name="act" id="details" class="act" value="Détails" style="color:blue" />
<!--  <input type="submit" class="button modify-button" name="act" id="modify" value="Modify" class="act" style="color:blue"/>
--><input type="submit" class="button del-button" name="act" id="delete" value="Supprimer"  class="act" style="color:blue"/>
</td></tr>
</table>

</form>
</div>
<%@include file='footerf.jsp'%>

<script>
updateFooter(200);
</script>
</body>
</html>
