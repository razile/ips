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
	
<title> Review Payment </title>
<script type="text/javascript" src="jslibrary.js"></script>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />

  
  <script src="https://code.jquery.com/jquery-1.9.1.js"></script>
  <script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript"  src='helper/renderedfont-0.8.min.js#free'></script>
 
  <link rel="stylesheet" href="datepicker.css" />
<style>
.dialogStyle.ui-dialog {
    font-size: 100%;
    background-color: red;
}</style>
  <script>

  $(function() {
	
    $( "#datepicker" ).datepicker({ dateFormat: "yy-mm-dd" });
    $("#GreyHeader").text("Main Menu > Make a Payment > Review Payments");	
  });

  </script>
<script type="text/javascript">
function getQueryStrings() { 
	  var assoc  = {};
	  var decode = function (s) { return decodeURIComponent(s.replace(/\+/g, " ")); };
	  var queryString = location.search.substring(1); 
	  var keyValues = queryString.split('&'); 

	  for(var i in keyValues) { 
	    var key = keyValues[i].split('=');
	    if (key.length > 1) {
	      assoc[decode(key[0])] = decode(key[1]);
	    }
	  } 

	  return assoc; 
	} 
var qs = getQueryStrings();
var q = qs["d"]; 
var which;
$(document).ready(function() {	
	
	if (q!=undefined){
		//alert(q);
		//$('input[id="approveh"]').val("off");
		//$('input[id="declineh"]').val("off");
		window.open('DisplayDeletedInvoice.jsp?id='+q);

	}
	
	$("#decline2").click(function(){
        
		//alert("b");
		$('input[id="declineh"]').val("on");
		$('input[id="approveh"]').val("off");
		$('input[id="cm"]').val($("#comment2").val());
		//alert($("#comment2").val());
		$("#formId").submit();
		//$( this ).dialog( "close" );
		
	});
	$("#approve2").click(function(){
                $("#approve2").attr('disabled','disabled');     
		//alert("b");
		$('input[id="declineh"]').val("off");
		$('input[id="approveh"]').val("on");
		//$('input[id="cm"]').val($("#comment2").val());
		//alert($("#comment2").val());
		$("#formId").submit();
		//$( this ).dialog( "close" );
		
	});
	   $("input").click(function(){
		   which = $(this).attr("id");
	   });
	   $("#formId").submit(function () {
	     if ($('input[id="declineh"]').val()=="on")
	     { return true;}
	     if ($('input[id="approveh"]').val()=="on")
	     { return true;}
		//var x = $("#declineh").val();
		//	alert("aa"+x);
	if ($("#formId input:radio:checked").length == 0)
	  {
	      alert("Please select one item before you proceed.");
	      return false;
	  }
	  else if ( ($("#formId input:radio:checked").length > 1))
	  {
		  alert("Please select only one item before you proceed.");
		  return false;
	  }
	
	
	if (which =="details")
	{// alert( $("#formId input:radio:checked").val());
       values ="id=" +  $("#formId input:radio:checked").val();
        $.ajax({
			  url: "GetInvoiceDetails.jsp",
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
	}else if (which=="deleteAdmin")
	
		{
		$('input[id="declineh"]').val("off");
		$('input[id="approveh"]').val("off");
		 $('input[id="deleteadminh"]').val("on");
		var x = confirm("Are you sure you want to delete?");
		  if (x)
		      return true;
		  else
		    return false;

          	
		}
	else if (which=="decline"){
		
		 $('#divId').css('display','block');
		 $('#divId').dialog({
				 title: 'Decline Invoice',
		            modal: true,
		            resizable: false,
		            width: 500,
		            maxHeight: 400,
		            closeText: 'fechar',
		            draggable: true,
		            show: 'fade',
		            hide: 'fade',
		            dialogClass: 'main-dialog-class'
		 });
          return false;
	}
	else if (which=="approve"){
		
		 $('#divhiddenApprove').css('display','block');
		 $('#divhiddenApprove').dialog({
				 title: 'Approve Invoice',
		            modal: true,
		            resizable: false,
		            width: 500,
		            maxHeight: 400,
		            closeText: 'fechar',
		            draggable: true,
		            show: 'fade',
		            hide: 'fade',
		            dialogClass: 'main-dialog-class'
		 });
         return false;
	}
//	$("#formId input:checkbox:checked").val();
   return true;
//}
  });
});

</script>



</head>
<body>
<%
 String userid = (String)request.getParameter("pyid");
 if (userid==null)
 {   userid= (String)request.getAttribute("pyid");
     if (userid==null)        
        response.sendRedirect("http://live.invoicepayment.ca/ipspayers/index.htm");
        }
%>
<div id="dialog-modal" title="Invoice Details">
<div id="result"></div>

</div>



<%@include file='header.jsp'%>
<%@include file='sidebar.jsp'%>
<form name="ReviewPayment" id="formId" action="ReviewPayment" method="post" >
<input type="hidden" id="declineh" name="declineh" value="off"> 
<input type="hidden" id="approveh" name="approveh" value="off"> 
<input type="hidden" id="deleteadminh" name="deleteadminh" value="off">

<input type="hidden" id="cm" name="cm" value=""> 
<input type="hidden" id="pyid" name="pyid" value=<%=userid%>> 
<div id="divId" style="display:none;width:400">
		<table border=0 ><tr><td>
		<h3>Please enter a comment to decline:</h3>
		</td></tr>
		<tr><td><textarea class="main-dialog-class" name="comment2" id="comment2" style="width: 300px; height: 40px;"></textarea></td></tr>
		<tr><td>
		<input type="submit" class="button del-button main-dialog-class" name="act" id="decline2" value="Decline"  style="color:blue"/>
		</td></tr>
		</table>
		</div>

<div id="innerbody">

<div id="divhiddenApprove" style="display:none;width:400">
		<table border=0 ><tr><td>
		<h3>Please press the button to approve</h3>
		</td></tr>
		<!--  <tr><td><textarea class="main-dialog-class" name="comment2" id="comment2" style="width: 300px; height: 40px;"></textarea></td></tr>
		--><tr><td>
		<input type="submit" class="button approve-button main-dialog-class" name="act" id="approve2" value="Approve"  style="color:blue"/>
		</td></tr>
		</table>
		</div>

<div id="innerbody">
<table border=0 cellpadding=0 cellspacing=0><tr><td>
<table border=0 cellpadding=0 cellspacing=20>
<tr><td colspan=2 style="margin-left:10px;"><h3>Payment Review</h3></td></tr>
<!--  <tr><td colspan=6 style="margin-left:10px;color:red;font-size:2em;">If you need to change any of the details of your payment, please delete it and go back to Make a Payment.</td></tr>
-->
<tr>
<td></td>
<td><h3>Confirmation No.</h3></td>
<td><h3>Payer</h3></td>
<td><h3>Date</h3></td>
<td><h3>Bank Account</h3></td>
<td><h3>Currency</h3></td>
<td width=60><h3>Payment Amount</h3></td>
<td><h3>Status</h3></td>
</tr>

<%! String driverName = "net.sourceforge.jtds.jdbc.Driver";%>


<%
Connection con = null;
ResultSet rs =null;
PreparedStatement ps = null;
CallableStatement cs = null;
int payerid=Integer.parseInt(request.getParameter("pyid").toString());
%>
<% 
try
{
	
	con = SqlServerDBService.getInstance().openConnection();
	
	// FACTOR-DEBTOR
	Map<String, Debtor> debtors = FactorDBService.getInstance().getDebtors();
	
	PreparedStatement ps2  = con.prepareStatement("SELECT t.SysId,InvoiceDate,AccountNumber,a.currencyType,invoiceamount,t.status,t.newEmail,a.payerId FROM invoicetransaction  t join PayersAccounts a on a.sysid = t.sysacctid where  t.status ='Pending' or t.status ='Submitted'  order by t.SysId desc;");
	//ps2.setInt(1, payerid);
	rs = ps2.executeQuery(); 
	int counter =0;
	while (rs.next()){
		String txnId = rs.getString("sysId");
		String email1="";
		String email2="";
		String spayerid = rs.getString("payerId");
		
		Debtor d = debtors.get(spayerid);
		
		
		Debtor dcont = FactorDBService.getInstance().getEmails(spayerid);
		email1 = d.getContactEmail();
		email2 = d.getContact2Email();
				
			%>
		<tr>
<%        String newEmail = rs.getString("newEmail");
	   	if (email2.equalsIgnoreCase(newEmail)){       			
%>
			<td><input type="radio" name="check" value=<%=rs.getString("SysId") %>></td>
<% 		}else{%>
			<td><h3>Change email to:&nbsp;<%=rs.getString("newEmail")%> </h3></td>
	<% 	}%>
<td><h6><%= rs.getString("SysId") %></h6></td>
<td><h6><%String name= d.getName1() + " " + d.getName2() ; 
if (name.length()>32)
{name=name.substring(0,31);}
%><%=name%></h6></td>
<td><h6><%
Date date2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("InvoiceDate"));
SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm");
String datep = simpleDateFormat.format(date2);

%>
<%=datep%></h6></td>
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
<input type="submit" class="button details-button" name="act" id="details" class="act" value="Details" style="color:blue" />
<input type="submit" class="button delete-button" name="act" id="deleteAdmin" value="Delete" class="act" style="color:blue"/>
<input type="submit" class="button modify-button" name="act" id="decline" value="Decline" class="act" style="color:blue"/>
<input type="submit" class="button approvel-button" name="act" id="approve" value="Approve"  class="act" style="color:blue"/>
</td></tr>
</table>

</form>
</div>
<%@include file='footer.jsp'%>

<script>
updateFooter(200);
</script>
</body>
</html>
