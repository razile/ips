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
<%@ page import="com.ips.model.*" %>
<%@ page buffer="16kb"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html>
<head>
 <link rel="stylesheet" href="payer.css" type="text/css"/>
<!--  LINK REL="shortcut icon" href="http://linux.invoicepayment.ca/IPSmain/favicon.ico" type="image/x-icon" --> 
<!--  <script  type="text/javascript"  src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>-->
 <!--  <script  type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
 -->
<script type="text/javascript" src="jslibrary.js"></script>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
      <script src="https://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript"  src="helper/renderedfont-0.8.min.js#free"></script>

<!--  <script src="helper/jquery.currency.js"></script>-->
<script type="text/javascript" src="helper/jquery.formatCurrency.js"></script>
<style type="text/css">
div#fake_box{
	position: absolute;
	top: 100px;
	left: 200px;
	height: 88px;
	width: 200px;
	border: solid black 2px;
	background-color: gray;
	color: black;
	text-align:center;
	display:none;
}
</style>
<script type="text/javascript">
function show_box()
{
    document.getElementById("fake_box").style.display = "block";
}

</script>

<style type="text/css">
      /* Example CSS class using Quicksand Book Regular */
      b.ips {
        font-family: "Quicksand Bold Regular", Arial; 
        font-size: 9pt; 
        color: #FFFFFF;
      }
    </style>

 <script type="text/javascript">
 
	var _gaq = _gaq || [];
	_gaq.push(['_setAccount', 'UA-33522368-1']);
	_gaq.push(['_trackPageview']);

	(function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	})();
	function removeDollar( x){
		return x.replace('$','');  
	}
	</script>
	<script>
	function showAccount(str,pid)
	{ //alert(str);
	//if (str!="0"){
		//$("input[id=refreshData]").val("");
	//}else{
		
	//}
	var xreq;
	var xreq2;
	if(str=="")
	{
	document.getElementById("showtext").innerHTML="";
	return;
	}
	if(window.XMLHttpRequest)
	{
	xreq=new XMLHttpRequest();
	}
	else
	{
	xreq=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xreq.onreadystatechange=function ()
	{
	if( (xreq.readyState==4) && (xreq.status==200) )
	{
	document.getElementById("showtext").innerHTML  =xreq.responseText;
    var val=	$('input[type=hidden]', '#showtext').eq(0).val();
	$("#currencyType").text(val);
     var val2 = (val=="CAD")?"USD":"CAD";
	 var sum = 0;
     $('.pay').each(function() {
          sum += Number($(this).val());
          });
     sum += Number($('input[name=paymentAmount]').val());
    $("input[name=totalPayment]").val(sum.toFixed(2));  
 	$("#othercurrency").text(val2 );
	$("#currentcurrency").text(val );
 	$("#CurrencyInvoice").text(val + " Invoices ");
 	$(".AccountDependent").show();
 
	 }
	};
	
	xreq.open("get","GetAccountInfo.jsp?str="+str+"&pid="+pid,"true");
	xreq.send();
	
	var xreq2;
	if(str=="")
	{
	document.getElementById("showtext").innerHTML="";
	return;
	}else if(str=="0")
		{//alert("a");
		$(".AccountNoSelect").hide();
	      return;
		}
	
	if(window.XMLHttpRequest)
	{
	xreq2=new XMLHttpRequest();
	}
	else
	{
	xreq2=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xreq2.onreadystatechange=function ()
	{
	if( (xreq2.readyState==4) && (xreq2.status==200) )
	{
	document.getElementById("invoices").innerHTML  =xreq2.responseText;
	$("tr.secondarycurrency").hide();
	 $("input[name=totalPayment]").val("0.00");
	if ($("#account").val()=="0")
	{
	$("tr.secondarycurrency").show();
//	$("#showothercurrency").attr("value","Hide Invoices");
// 		$(".AccountNoSelect").hide();
    	}
    else{//alert("a");
    	$(".AccountNoSelect").show();
    	$("tr.secondarycurrency").hide();
    	$("#showothercurrency").attr("value","Show Invoices");
	}
	updateFooter(200); 
	}
	};
	
	xreq2.open("get","GetInvoices.jsp?str="+str+"&pid="+pid,"true");
	xreq2.send();
	 }
	
	
	</script>
	<script>
	function getQueryStrings() { 
		  /*var assoc  = {};
		  var decode = function (s) { return decodeURIComponent(s.replace(/\+/g, " ")); };
		  var queryString = location.search.substring(1); 
		  var keyValues = queryString.split('&'); 

		  for(var i in keyValues) { 
		    var key = keyValues[i].split('=');
		    if (key.length > 1) {
		      assoc[decode(key[0])] = decode(key[1]);
		    }
		  } 
		*/
		var assoc ='${id}';
		//alert(assoc);
		  return assoc; 
		} 
	</script>
	
	 <script type="text/javascript">
	var which;
	
	$(document).ready(function() {	
		
		$("#GreyHeader").text("Main Menu > Make a Payment > Setup Bank Account");
		$("#GreyHeader").text("Main Menu > Make a Payment");	
	    $( "#datepicker" ).datepicker({ dateFormat: "yy-mm-dd" });
	    $("input[name=refreshData]").val('');
	    $("#refreshData").attr('value', '');
	    
	    var qs = '<%=request.getAttribute("id") %>';//getQueryStrings();
		var c = '${id}';
			if (qs && (qs.indexOf("ip")==0)){
				qs =qs.substring(2);
			    window.open('DisplayInvoice.jsp?id='+qs);
			}
		if ($("#account").val()=="0")
			{showAccount("0","");
			//$("tr.secondarycurrency").show();
			}
		
		$(".AccountDependent").hide();
		 $("input[name=totalPayment]").val("0.00");
		
		$(".paycheck").click(function() 	 {
	    	    var sum = 0;
	    	    
	    	    //$("#refreshData").val('Set');
	    	    $('.pay').each(function() {
                	if($(this).closest('tr').children().eq(8).find(':checkbox').is(":checked")){
                		sum += Number($(this).val().replace('$','').replace(',',''));
                	}
                	else{
                		$(this).closest('tr').children().eq(6).find(':input').val('');
                		$(this).closest('tr').children().eq(7).find(':input').val('');
                		}
                 });
               
          //      sum += Number($('input[name=paymentAmount]').val());      
	            $("input[name=totalPayment]").val(sum.toFixed(2)); 
	            $("input[name=totalPayment]").val($("input[name=totalPayment]").formatCurrency().val());
	    	//    $("input[name=totalPayment]").val(sum.formatCurrency().val());
	   });
		
		
		$("#invoices").on("click", "input[type='checkbox']", function() 	 {

		    	{
		            //tr.find('td:eq(3)').text("");
		            var sum = 0;
                    $('.pay').each(function() {
                    	if($(this).closest('tr').children().eq(8).find(':checkbox').is(":checked")){
                    		sum += Number($(this).val().replace('$','').replace(',',''));
                    	}
                    	else{
                    		$(this).closest('tr').children().eq(6).find(':input').val('');
                    		$(this).closest('tr').children().eq(7).find(':input').val('');	
                    	}
                     });
                    //alert($(this.val());
              //      sum += Number($('input[name=paymentAmount]').val());
               $("input[name=totalPayment]").val(sum.toFixed(2)); 
               $("input[name=totalPayment]").val($("input[name=totalPayment]").formatCurrency().val());
		         //   $("input[name=totalPayment]").val(sum.formatCurrency().val());
		            //$("#totalPayment").
		    	}
		   });


		
		 $("input").click(function(){
			   which = $(this).attr("id");
		   });
		 $("#form").submit(function () {
			 
			if (which=="showothercurrency")
				{//alert("a");
				$("tr.secondarycurrency").toggle();
				if ($("tr.secondarycurrency").is(':hidden'))
					{
					$("#showothercurrency").attr("value","Show Invoices");
					}
				else{
					$("#showothercurrency").attr("value","Hide Invoices");
				    }

				updateFooter(200); 
				; return false;}
			else if (which=="insert")
				 {
			
				// var parsedDate =$("#datepicker").val();
				//  if(parsedDate == '')
				// {alert("Date is empty.");
				 // return false;
				// }
				 // else if (parsedDate == null) {
				 //   	alert("Date is not valid.");
				  //  	return false
				  //  }
				//alert($("#totalPayment").val());
				  if (( typeof $("#totalPayment").val() == "undefined") || ($("#totalPayment").val()=="") || ($("#totalPayment").val()=="0")  || ($("#totalPayment").val()=="0.00") || ($("#totalPayment").val()=="$0.00"))
					  {
					   alert("Your eCheque displays a total of $0 - please enter the invoice amount(s) and make sure to select the checkbox beside each invoice you would like to pay in order to have the total amount appear in the eCheque total.");
					   return false;
					  }
				 
					  else 
				  {     var x=0;
						  $('.pay').each(function() {
							     
			                	if($(this).val().length>0 )
			                		if(!$(this).closest('tr').children().eq(8).find(':checkbox').is(":checked")) 
			                		{ 
			                	       x=true;
			                		
			                           }
			                	});
						  if (x)
							  { alert("Please select the confirm checkbox beside each invoice that you would like to pay.");
							  return false;
							  }
						  var stop=false;
					     $('input:checkbox.paycheck').each(function () {
					  		if (this.checked){// ? $(this).val() : "");
				          		var x = $(this).closest('tr').find(".pay").val();
                     			if (x==''){
                    	 			alert("please enter an amount for each checked invoice.");    
				            		stop =true;
                     			}
				          	}
					  }); //($("#form input:checkbox:checked")
				      if (stop)return false;
				  }
				  if ($("#paycheckextra").is(":checked")){
					  if ($("#payee").val().trim().length==0||$("#ponumber").val().trim().length==0||$("#invoiceNumber").val().trim().length==0||$("#amount").val().trim().length==0||$("#paymentAmount").val().trim().length==0||$("#comments").val().trim().length==0){
						  alert("Please enter information in the mandatory fields before submitting.");
						  return false;
					  }
				  }
				 }
			 else
				 {return false;}
			//document.getElementById("fake_box").style.display = "block";
			//return false;
			
	/*show_box();		
	$('#insert').dialog({
				  title: 'Confirm?',
				  width: 500,
				  height: 200,
				  modal: false,
				  resizable: false,
				  draggable: false,
				  buttons: [{
				  text: 'Confirm Amount',
				  click: function(){
				      //delete it
				    $("#form").submit();
				    }
				  },
				  {
				  text: 'Cancel Amount',
				  click: function() {
				      $(this).dialog('close');
				    }
				  }]
				});
				
				return false;
				
		
			*/
			$("input[name=refreshData]").val("Set");  
			var r=confirm("Please note that payments dated with today's date will be submitted to your financial institution and credited to your IPS account the next business day.\nAre you confirming you would like to pay " + $("#totalPayment").formatCurrency().val() +$("#currency").val() + " dollars?");
			 if (r==true)
			   {
			   return true;
			   }
			 else
			   {
			   return false;
			   }
			 
		 });
		/* $(".paystatic").keyup(function(){
			  var $this = $(this);
			    $this.val($this.val().replace(/[^\d.]/g, ''));
			    var val = $this.val();
				  if (val.indexOf('.')>-1)
					  {
				      if ((val.length)>val.lastIndexOf('.')+2)
					 {
				          val = val-0;
				          $(this).val(val.toFixed(2));
					 }
					 }  
			//    var x =   $('input[name=amount]').val() -  $('input[name=paymentAmount]').val();
			 	if($(this).closest('tr').children().eq(6).find(':checkbox').is(":checked")  )
        { 
			var sum = 0;
                $('.pay').each(function() {
                     sum += Number($(this).val());
                     });
              sum += Number($('input[name=paymentAmount]').val());
                      { $("input[name=totalPayment]").val(sum.toFixed(2));}
		//	    $(this).closest("tr").children().eq(3).html('<h6>'+x.toFixed(2)+'</h6>');
        }    
		       
		 
		 });
		 */
		 $("#invoices").on("focusout","input[type='text']", function(){
			 if ($(this).hasClass('pay')){
			 		$(this).val($(this).formatCurrency().val().replace('$',''));
				}
			});	
		 $(".AccountNoSelect").on("focusout","input[type='text']", function(){
			 if ($(this).hasClass('paystatic')){
				 	$(this).val($(this).formatCurrency().val().replace('$',''));
				 }
			});
		 $("#invoices").on("keyup", "input[type='text']", function(){
               var $this = $(this);
			  if ($this.attr('name').match(/paymentamount[^\s]+/g).length>0){ 
				   $this.val($this.val().replace(/[^\d.]/g, ''));        
			      var elm =$(this);
			      var val = $this.val();
			      if (val.indexOf('.')>-1)
				  {
			        if ((val.length)>val.lastIndexOf('.')+2)
				      {
			            val = val-0;
			             $(this).val(val.toFixed(2));
				     }
				 }
			 	 if($(this).closest('tr').children().eq(8).find(':checkbox').is(":checked")  )
		            { 
			          var sum = 0;
                    $('.pay').each(function() {
                       sum += Number($(this).val().replace('$','').replace(',',''));
                      });    
			        $("input[name=totalPayment]").val(sum.toFixed(2));	
			       //alert(sum.formatCurrency().val());
			        $("input[name=totalPayment]").val($("input[name=totalPayment]").formatCurrency().val());
		            
		            }
			 
               }
		  }); 
		  $(".paystatic").keyup(function(){
				  var $this = $(this);
			    $this.val($this.val().replace(/[^\d.]/g, ''));        
			  var elm =$(this);
			  var val = $this.val();
			  if (val.indexOf('.')>-1)
				  {
			      if ((val.length)>val.lastIndexOf('.')+2)
				 {
			          val = val-0;
			          $(this).val(val.toFixed(2));
			      //    $(this).val($(this).formatCurrency().val());
				 }
				 }
			 	if($(this).closest('tr').children().eq(8).find(':checkbox').is(":checked")  )
		        { 
			      var sum = 0;
                  $('.pay').each(function() {
                      sum += Number($(this).val().replace('$','').replace(',',''));
                     });    
			     $("input[name=totalPayment]").val(sum.toFixed(2));	
			     $("input[name=totalPayment]").val($("input[name=totalPayment]").formatCurrency().val());
			     //alert("bbb2");
			     //$("input[name=totalPayment]").val(sum.formatCurrency().val());
		        }
		  });
	  
	});		
	
	</script>
	
<title> Make Payment </title>
  <link rel="stylesheet" href="datepicker.css" />




</head>
<body>
<%
String userid = (String)request.getParameter("pyid"); //(String)session.getAttribute("pyid");
String userid1 = (String)request.getParameter("id"); //(String)session.getAttribute("id");

if (userid==null) userid = (String) request.getAttribute("pyid");
if (userid==null) userid = userid1;
    
       // response.sendRedirect("https://payer.secure.invoicepayment.ca:8443/ipspayers/index.htm");
       
%>


<%@include file='header.jsp'%>
<%@include file='sidebar.jsp'%>
<form name="makePayment" id="form" action="InvoicePayment_M" method="post">



<div id="fake_box">
	</div>

<div id="innerbody" class="innerbody">



<table border=0px cellpadding=0 cellspacing=0 width=100% height=200 style="vertical-align:top;text-align:left;">
<tr><td style="vertical-align:top;text-align:left;width:350px;height:50px">
<h3>Please select your account to pay from</h3>
</td><td style="vertical-align:top;text-align:left;height:20px">
<table height=20px id="uppertbl" border=0 style="vertical-align:top;height:20px">
<tr><td style="height:2px"></td></tr>
<tr><td style="text-align:left;vertical-align:top;width:600px;height:20px" >
<%
Connection con = null;
ResultSet rs =null;
PreparedStatement ps = null;
//int  payerid=Integer.parseInt(session.getAttribute("pyid").toString());
int  payerid=Integer.parseInt(userid);

try
{
	
con = SqlServerDBService.getInstance().openConnection();
String sql = "SELECT SysId,AccountNumber,CurrencyType FROM PayersAccounts p where p.Active=1 and p.PayerId="+payerid;
ps = con.prepareStatement(sql);
rs = ps.executeQuery(); 
String act = request.getParameter("check");
%>

<select style="width:200px" name="account" id="account"  onchange=<%="showAccount(this.value,"+ payerid  +")"%>>
<option value="0">Select Account</option>
<% 
while (rs.next()) {
	String acctName = rs.getString("AccountName") + " - " + rs.getString("CurrencyType");
	String sysId = rs.getString("SysId");
%>


<option value=<%=sysId%>><%=acctName%></option>

<% 
}
	String email1="";
	String email2="";
	String spayerid = Integer.toString(payerid);
	Debtor dcont = FactorDBService.getInstance().getEmails(spayerid);
	email1 = dcont.getContactEmail();
	email2 = dcont.getContact2Email();
	} catch (Exception e) {
		System.err.print(e.getMessage());
	} finally {
		SqlServerDBService.getInstance().releaseConnection(con);
	}
%>
</select></td><td style="height:20px"></td></tr>
</table></td>
</tr>
<tr><td  style="font-family:Arial;font-size:12px;">Email:<input type=text id="newEmail" name="newEmail" value="" style="width:250px"></td></tr>
<tr><td colspan=2 style="font-family:Arial;font-size:12px;color:red">*When you successfully submit a payment, you should get a Transaction Complete PDF confirmation. If you do not
see this confirmation, please make sure to allow<br> pop-ups within your browser.</td></tr>
<tr><td height=10px></td></tr>
<tr><td style="vertical-align:top;text-align:left;" colspan=2>

<table   id="lowertbl" border=0><tr><td >
   <!--  <table border=0px cellpadding=0 cellspacing=0 style="vertical-align:top;text-align:left;width:100%"><tr style="height:10px"><td style="height:10px">
        <h4>Pay to the order of Invoice Payment Systems</h4>
         </td><td style="height:10px"><h4>$<input type=text width=100px name="totalPayment2" id="totalPayment2" readonly/><label id="currencyType2" name="currencyType2"/></h4></td></tr>
         <tr><td colspan=2 style="vertical-align:top"><hr width=100%></td></tr>
         </table>
         --> 
         
         <div id="showtext"  ></div>
       
     </td></tr>
     
     <tr><td>

<div id="invoices" class="AccountNoSelect"></div>
     </td></tr>
     <tr><td >
     <div class="AccountNoSelect">
     <table border=0 cellpadding=0 cellspacing=0>
     <tr><td><h3 style="vertical-align:center;text-decoration:underline;">Would like to pay <!--  <label id="othercurrency" ></label>-->invoices in another currency. <!--<label id="currentcurrency" ></label> account--></h3></td><td>&nbsp;&nbsp;<input type="submit" class="button show-button" name="act" id="showothercurrency" value="Display Invoices"  style="color:blue;width:200px;"/></td></tr>
     </table></div>
     </td></tr>
     <tr><td class="AccountNoSelect">
     <table border=0 cellpadding=0 cellspacing=0 style="width:1000px" >
     <tr><td height="20px"></td></tr>
     <tr><td></td><td colspan=8><h4>Pay for an invoice that does not exist in the list above</h4></td></tr>
     <tr>
      <td style="width:250px"><h6>Supplier<span style="color:#FF0000;" >*</span></h6></td>
      <td style="width:150px"><h6>PO Number<span style="color:#FF0000;" >*</span></h6></td>
      <td style="width:150px"><h6>Invoice Number<span style="color:#FF0000;" >*</span></h6></td>
      <td></td>
      <td></td>
      <td style="width:150px"><h6>Amount<span style="color:#FF0000;" >*</span></h6></td>
     <td style="width:150px"><h6>Payment Amount<span style="color:#FF0000;" >*</span></h6></td>
     <td style="width:150px"><h6>Comments<span style="color:#FF0000;" >*</span></h6></td>
     </tr>
      <tr>
     <td style="width:270px"><h6>
     
     <select name=payee id=payee>
    <% 
    
    	Connection sybconn = FactorDBService.getInstance().openConnection();
   	    String sql22="SELECT Cli.Name1, Cli.SysId FROM Debtor Deb JOIN Account Acc ON Acc.SysDtrId = Deb.Sysid JOIN Relation Rel ON Rel.Sysid = Acc.SysRelId JOIN Client Cli ON Cli.SysId = Rel.SysClientId WHERE Deb.SysId = " + payerid + " ORDER BY 1";
 	 	try {
   	    	Statement st = sybconn.createStatement();
 			String id ="";
 			String clientName = "";
 			ResultSet rsf = st.executeQuery(sql22);
 			while (rsf.next()) {
 			id = new String(rsf.getString("SysId"));
 			clientName = new String (rsf.getString("Name1"));
 		
     %>
     <option value="<%=id.trim()%>"><%=clientName%></option>
     <%
     	}
     
     } catch (Exception e) {
     	e.printStackTrace();
     } finally {
    	 FactorDBService.getInstance().releaseConnection(sybconn);
     }
     %>
     </select>
     <!--<input name="payee" id="payee" type=text style="width:250px">
     -->
     </h6></td>     
     <td><input name="ponumber" id="ponumber" type=text style="width:150px"></td>
     <td><h6><input name="invoiceNumber" id="invoiceNumber" type=text style="width:100px"></h6></td>
     <td></td>
     <td></td>
     <td><h6>$<input name="amount" id="amount" type=text style="width:100px"  class="paystatic rightJustified"></h6></td>
     <td><h6>$<input name="paymentAmount" id="paymentAmount"  class="paystatic pay rightJustified" type=text style="width:100px"></h6></td>
     <td><h6><input name="comments" id="comments" type=text style="width:100px"></h6></td>
     <td><h6><input type=checkbox  class="paycheck" id="paycheckextra" name="paycheckextra"></h6></td>
     
     </tr></table>
     <input type=hidden name="refreshData" id="refreshData" value="">
     
     <table border=0 cellpadding=0 cellspacing=0>
     <tr><td height="20px"></td></tr>
     <tr>
	<td>
	
	</td>
	<td style="width:600px"><td>
	<input type="hidden" name="payerid" id="payerid" value=<%=payerid %>>
	<input type="submit" class="button insert-button" name="act" id="insert" value="Submit"  style="color:blue"/>
	<input type="submit" class="button cancel-button" name="act" id="cancel" value="Cancel" onclick="history.go(-1);" style="color:blue" />
</td>
	</tr>
     </table>
     </td>
     </tr>
 </table>
     </td>
     </tr>
 </table>
</div>
</form>


<%@include file='footer.jsp'%>




</body>
</html>
