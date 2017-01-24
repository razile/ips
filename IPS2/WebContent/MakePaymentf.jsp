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
<%@page import="com.ips.database.*"%>
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
	
	xreq.open("get","GetAccountInfof.jsp?str="+str+"&pid="+pid,"true");
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
    	$("#showothercurrency").attr("value","Afficher les factures");
	}
	updateFooter(200); 
	}
	};
	
	xreq2.open("get","GetInvoicesf.jsp?str="+str+"&pid="+pid,"true");
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
		var qs = '<%=request.getAttribute("id") %>';//getQueryStrings();
		//var q = qs["id"]; 
		
		if (qs!="null" && qs!="" && qs!="${id}"){
			//alert(qs);
			window.open('DisplayInvoicef.jsp?id='+qs);

		}
		
		
		
		
		
		if ($("#account").val()=="0")
			{showAccount("0","");
			//$("tr.secondarycurrency").show();
			}
		
		$(".AccountDependent").hide();
		 $("input[name=totalPayment]").val("0.00");
		
		$(".paycheck").click(function() 	 {
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
					$("#showothercurrency").attr("value","Afficher les factures");
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
					   alert("Votre eCheque affiche un total de $0 - veuillez saisir le montant de la facture(s) et assurez-vous de sélectionner la case à cocher située à côté de chaque facture vous voulez payer afin d'avoir le montant total apparaissent dans l'eCheque total.");
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
							  { alert("Veuillez sélectionner la case confirmer en regard de chaque facture que vous voulez payer.");
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
					  if ($("#payee").val().length==0||$("#ponumber").val().length==0||$("#invoiceNumber").val().length==0||$("#amount").val().length==0||$("#paymentAmount").val().length==0||$("#comments").val().length==0){
						  alert("Veuillez entrer les informations dans les champs obligatoires avant de le soumettre.");
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
			var r=confirm("Veuillez noter que les paiements datés de la date d'aujourd'hui seront soumis à votre institution financière et crédités sur votre compte IPS le jour ouvrable suivant.  \nVoulez-vous confirmer que vous souhaitez payeur  " + $("#totalPayment").formatCurrency().val() +$("#currency").val()+"?");
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
	
<title> Effectuer un paiement</title>
  <link rel="stylesheet" href="datepicker.css" />
   <script>
	$(document).ready(function(){
					$("#GreyHeader").text("Menu principal > Effectuer un paiement > Setup Compte bancaire");		
	});
	
	</script>
  <script>
	$(document).ready(function() {	
   
   $("#GreyHeader").text("Menu principal > Verser un paiement");	
    $( "#datepicker" ).datepicker({ dateFormat: "yy-mm-dd" });

  });

  </script>



</head>
<body>
<%
String userid = (String)request.getParameter("pyid"); //(String)session.getAttribute("pyid");
 String userid1 = (String)request.getParameter("id"); //(String)session.getAttribute("id");

       if (userid==null){
               userid = (String) request.getAttribute("pyid");
               if (userid==null){
		userid = userid1;}
       // response.sendRedirect("http://live.invoicepayment.ca/payer_fr_modified/ipspayers/index.htm");
       }
%>


<%@include file='headerf.jsp'%>
<%@include file='sidebarf.jsp'%>
<form name="makePayment" id="form" action="InvoicePaymentf" method="post">


<div id="fake_box">
	</div>

<div id="innerbody" class="innerbody">



<table border=0px cellpadding=0 cellspacing=0 width=100% height=200 style="vertical-align:top;text-align:left;">
<tr><td style="vertical-align:top;text-align:left;width:450px;height:50px">
<h3>Veuillez sélectionner un article avant de procéder au traitement.</h3>
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

<select style="width:200px" name="account" id="account"  onchange=<%="showAccount(this.value,"+ payerid  +")"%>  >
<option value="0">Sélectionner compte</option>
<% while(rs.next()){ %>
<option value=<%= rs.getString("SysId")%>> <% String acctName = rs.getString("AccountNumber") + " - " + rs.getString("CurrencyType");%><%=acctName %></option>

<% 
}//while
  }
catch(Exception e){}
finally{
	SqlServerDBService.getInstance().releaseConnection(con);
}
%>
</select></td><td style="height:20px"></td></tr>
</table></td>
</tr>
<tr><td colspan=2 style="font-family:Arial;font-size:12px;color:red">*Lorsque vous remettez un paiement avec succès, vous devriez recevoir une confirmation en format PDF indiquant que la transaction a été complétée.<br/>Si vous ne voyez pas cette confirmation, assurez-vous que votre navigateur est réglé de façon à permettre l'affichage des fenêtres contextuelles (pop-ups).</td></tr>
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
     <tr><td><h3 style="vertical-align:center;text-decoration:underline;">Voudrais payer <!--  <label id="othercurrency" ></label>-->Les factures dans une autre monnaie. <!--<label id="currentcurrency" ></label> account--></h3></td><td>&nbsp;&nbsp;<input type="submit" class="button show-button" name="act" id="showothercurrency" value="Display Invoices"  style="color:blue;width:200px;"/></td></tr>
     </table></div>
     </td></tr>
     <tr><td class="AccountNoSelect">
     <table border=0 cellpadding=0 cellspacing=0 style="width:1000px" >
     <tr><td height="20px"></td></tr>
     <tr><td></td><td colspan=8><h4>Payer une facture qui ne figure pas dans la liste ci-dessus.</h4></td></tr>
     <tr>
      <td style="width:250px"><h6>Fournisseur<span style="color:#FF0000;" >*</span></h6></td>
      <td style="width:150px"><h6>No de bon de commande<span style="color:#FF0000;" >*</span></h6></td>
      <td style="width:150px"><h6>Facture Nombre<span style="color:#FF0000;" >*</span></h6></td>
      <td></td>
      <td></td>
      <td style="width:150px"><h6>Montant<span style="color:#FF0000;" >*</span></h6></td>
     <td style="width:150px"><h6>Montant du paiement<span style="color:#FF0000;" >*</span></h6></td>
     <td style="width:150px"><h6>Commentaires<span style="color:#FF0000;" >*</span></h6></td>
     </tr>
      <tr>
     <td style="width:270px"><h6><input name="payee" id="payee" type=text style="width:250px"></h6></td>     
     <td><input name="ponumber" id="ponumber" type=text style="width:150px"></td>
     <td><h6><input name="invoiceNumber" id="invoiceNumber" type=text style="width:100px"></h6></td>
     <td></td>
     <td></td>
     <td><h6>$<input name="amount" id="amount" type=text style="width:100px"  class="paystatic rightJustified"></h6></td>
     <td><h6>$<input name="paymentAmount" id="paymentAmount"  class="paystatic pay rightJustified" type=text style="width:100px"></h6></td>
     <td><h6><input name="comments" id="comments" type=text style="width:100px"></h6></td>
     <td><h6><input type=checkbox  class="paycheck" id="paycheckextra" name="paycheckextra"></h6></td>
     </tr></table>
     <table border=0 cellpadding=0 cellspacing=0>
     <tr><td height="20px"></td></tr>
     <tr>
	<td>
	
	</td>
	<td style="width:600px"><td>
	<input type="hidden" name="payerid" id="payerid" value=<%=payerid %>>
	<input type="submit" class="button insert-button" name="act" id="insert" value="Soumettre"  style="color:blue"/>
	<input type="submit" class="button cancel-button" name="act" id="cancel" value="Annuler" onclick="history.go(-1);" style="color:blue" />
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

<%@include file='footerf.jsp'%>




</body>
</html>
