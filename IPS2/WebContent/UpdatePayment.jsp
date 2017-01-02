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
<%@ page buffer="16kb"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html>
<head>
 <link rel="stylesheet" href="payer.css" type="text/css"/>
<LINK REL="shortcut icon" href="http://linux.invoicepayment.ca/IPSmain/favicon.ico" type="image/x-icon"/> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script> 
<script type="text/javascript"  src='http://cdn.renderedfont.com/js/renderedfont-0.8.min.js#free'></script>
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
	
	</script>
	<script>
	$(document).ready(function(){
	  $("#GreyHeader").text("Main Menu -> Make a Payment -> Update Payment");	
	});
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
        $("input[name=totalPayment]").val(sum.toFixed(2));  
	$("#othercurrency").text(val2 );
	$("#currentcurrency").text(val );
	$("#CurrencyInvoice").text(val + " Invoices ");
 	$(".AccountDependent").show();
$("#account").prop("disabled", true);
	//$("#totalPayment").val($("#totalamthidden").val());
	updateFooter(200);
	 }
	};
	
	xreq.open("get","GetAccountInfo.jsp?str="+str +"&pid="+pid,"true");
	xreq.send();


	var xreq2;
	if(str=="")
	{
	document.getElementById("showtext").innerHTML="";
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
	}
	updateFooter(200); 
	}
	};
	
	//xreq2.open("get","GetInvoices.jsp?str="+str+"&pid="+pid,"true");
	//xreq2.send();
	/*var yreq;
	if(window.XMLHttpRequest)
	{
	yreq=new XMLHttpRequest();
	alert("a");
	}
	else
	{
	yreq=new ActiveXObject("Microsoft.XMLHTTP");
	
	}
	yreq.onreadystatechange=function ()
	{
	if( (yreq.readyState==4) && (yreq.status==200) )
	{
		alert("b");
		document.getElementById("showinvoices").innerHTML  =yreq.responseText;
		
	 }
	};
	
	yreq.open("get","GetInvoices.jsp?str="+str,"true");
	yreq.send();
	*/
	 }
	
	</script>
	 <script type="text/javascript">
	var which;
	$(document).ready(function() {	
		var x = $("#account").val();
		var pid = $("#payerId").val();
//alert(x);
		showAccount(x,pid);
		$(".paycheck").click(function() 	 {
    	    var sum = 0;
            $('.pay').each(function() {
            	if($(this).closest('tr').children().eq(6).find(':checkbox').is(":checked")  )
            		sum += Number($(this).val());
             });
      //      sum += Number($('input[name=paymentAmount]').val());      
            $("input[name=totalPayment]").val(sum.toFixed(2)); 	
   });
	
		
		
		$("input[type='checkbox']").click(function() {

		     var sum = 0;
             $('.pay').each(function() {//alert("a");
             	if($(this).closest('tr').children().eq(6).find(':checkbox').is(":checked")  )
                 sum += Number($(this).val());
              });
       //      sum += Number($('input[name=paymentAmount]').val());      
	            $("input[name=totalPayment]").val(sum.toFixed(2));
		  });
		
		
		$("#totalamthidden").change(function(){
			//alert("a");
			$("totalPayment").val($("#totalamthidden").val().toFixed(2));
		});
		 $("input").click(function(){
			   which = $(this).attr("id");
		   });
		 $("#form").submit(function () {
			 if (which=="showothercurrency")
				{//alert("a");
				$("tr.secondarycurrency").toggle();
				updateFooter(200); 
				; return false;}
			 else if (which=="insert")
				 {
				// var parsedDate =$("#datepicker").val();
				//  if(parsedDate == '')
				// {alert("Date is empty.");
				//  return false;
				// }
				 // else if (parsedDate == null) {
				  //  	alert("Date is not valid.");
				  //  	return false
				  //  }
		
				if (( typeof $("#totalPayment").val() == "undefined") || ($("#totalPayment").val()=="") || ($("#totalPayment").val()=="0")  || ($("#totalPayment").val()=="0.00"))
					  {
					   alert("Please input valid amount to pay");
					   return false;
					  }
				  else 
				  {  var stop=false;
					  $('input:checkbox.paycheck').each(function () {
					  
				      if (this.checked)// ? $(this).val() : "");
				          {  var x = $(this).closest('tr').find(".pay").val();
                     if (x==''){
                    	 alert("please enter an amount for each checked invoice.");    
				                stop =true;
				                }
				              }
					  }); //($("#form input:checkbox:checked")
				      if (stop)return false;
				  }
				 }
			 else
				 {return false;}
		 });
		 /*
		 $(".paystatic").keyup(function(){
			  var $this = $(this);
			    $this.val($this.val().replace(/[^\d.]/g, '')); 
			    var x =   $('input[name=amount]').val() -  $('input[name=paymentAmount]').val();
			    var val = $this.val();
				  if (val.indexOf('.')>-1)
					  {
				      if ((val.length)>val.lastIndexOf('.')+2)
					 {
				          val = val-0;
				          $(this).val(val.toFixed(2));
					 }
					 }  
			    var sum = 0;
                $('.pay').each(function() {
                     sum += Number($(this).val());
                     });
              sum += Number($('input[name=paymentAmount]').val());
			    $(this).closest("tr").children().eq(3).html('<h6>'+x.toFixed(2)+'</h6>');
			    $("input[name=totalPayment]").val(sum.toFixed(2));  
		  });
		  */
		  $(".pay2").keyup(function(){
			  var $this = $(this);
			    $this.val($this.val().replace(/[^\d.]/g, ''));        
			  var elm =$(this);
			  var val = $this.val();
			           val = val-0;
			          $(this).val(val.toFixed(2));
			 });
		  
		  $(".pay").keyup(function(){
			  var $this = $(this);
			    $this.val($this.val().replace(/[^\d.]/g, ''));        
			  var elm =$(this);
			  var val = $this.val();
			 // if (val.indexOf('.')>-1)
				  {
			   //   if ((val.length)>val.lastIndexOf('.')+2)
				 {
			          val = val-0;
			          $(this).val(val.toFixed(2));
				 }
				 }
			 /*var x = $(this).closest("tr").children().eq(2).text();
			  var total = x -$(this).val();
			  */
			 	if($(this).closest('tr').children().eq(6).find(':checkbox').is(":checked")  )
		        { 
			//  if ($(this).val()>0)
			//	  $(this).closest('tr').find(':checkbox').attr('checked', true);
			//  $(this).closest("tr").children().eq(3).html('<h6>'+total.toFixed(2)+'</h6>');
	   	 	 var sum = 0;
              $('.pay').each(function() {
                   sum += Number($(this).val());
                   });
          //    sum += Number($('input[name=paymentAmount]').val());      
			 $("input[name=totalPayment]").val(sum.toFixed(2));	
		        }
		  });		  
	});		
	
	</script>
	
	
<title> Update Payment </title>
<script type="text/javascript" src="jslibrary.js"></script>
<script type="text/javascript"  src='http://cdn.renderedfont.com/js/renderedfont-0.8.min.js#free'></script>
  <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
  <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
  <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
  <link rel="stylesheet" href="datepicker.css" />

  <script>
	$(document).ready(function() {	
   
	
    $( "#datepicker" ).datepicker({ dateFormat: "yy-mm-dd" });

  });

  </script>



</head>
<body>
<%@include file='header.jsp'%>
<%@include file='sidebar.jsp'%>
<form name="makePayment" id="form" action="InvoicePayment" method="post" >
<%! String driverName = "net.sourceforge.jtds.jdbc.Driver";%>

<%@ include file="connection.jsp" %>



<div id="innerbody"  class="innerbody">
<table border=0px cellpadding=0 cellspacing=0 width=100% height=200 style="vertical-align:top;text-align:left;">
<tr><td style="vertical-align:top;text-align:left;width:350px;height:20px">
<h3>Please select your account to pay from</h3>
</td><td style="vertical-align:top;text-align:left;height:20px">
<table id="uppertbl" border=0 style="vertical-align:top;height:20px">
<tr><td height=2px></td></tr>
<tr><td style="text-align:left;width:600px;height:20px">
<%
Connection con = null;
ResultSet rs =null;
PreparedStatement ps = null;
//ResultSet rs2 =null;
PreparedStatement ps2 = null;
int payerid=Integer.parseInt(session.getAttribute("pyid").toString());
String acc="";
String sql="";
String dt ="";
String amt ="";
String act = "";
try
{
	
Class.forName(driverName);
con = DriverManager.getConnection(url,user,psw);
sql = "SELECT SysId,AccountNumber,CurrencyType FROM PayersAccounts p where p.Active=1 and p.PayerId="+payerid;
ps = con.prepareStatement(sql);
rs = ps.executeQuery(); 
act = request.getAttribute("transId").toString();

if (act!=null)
{
	 sql = "SELECT InvoiceAmount,SysAcctId,InvoicePaymentDate FROM invoicetransaction i where i.SysId="+act;
	ps2 = con.prepareStatement(sql);
	rs2 = ps2.executeQuery(); 
} if(rs2!=null && rs2.next()){
    acc=rs2.getString("SysAcctId");
    dt=rs2.getString("InvoicePaymentDate");
    amt = rs2.getString("InvoiceAmount");
}

%>
<input type="hidden" name="payerId" id="payerId" value=<%=payerid %>>
<input type="hidden" name="transId" id="transId" value=<%=act %>>
<input type="hidden" name="totalamthidden" id="totalamthidden" value=<%=amt %>>
<select style="width:200px" name="account" id="account"  onchange=<%="showAccount(this.value,"+ payerid  +")"%>   >
<option value="0">Select Account</option>
<% while(rs.next()){ %>
<option value=<%= rs.getString("SysId")%> <% if(rs.getString("SysId").equals(acc)){%>selected<% 
}%>><%= rs.getString("AccountNumber") + " - " + rs.getString("CurrencyType") %></option>

<% 
}//while
  %>
</select></td><td></td></tr>

</table></td>
</tr>
<tr><td style="vertical-align:top;text-align:left;" colspan=2>

<table   id="lowertbl" border=0><tr><td >

         <div id="showtext"></div>
        
     </td></tr>
     <tr><td>

<div id="invoices">
 <table border=0 cellpadding=0 cellspacing=0>
     <tr><td style="height:60px"></td></tr>
     <tr>
     <td style="width:150px"><h6>Payee</h6></td>   
     <td style="width:150px"><h6>Invoice Number</h6></td>
     <td></td>
     <td style="width:150px"><h6>Amount</h6></td>
     <td style="width:150px"><h6>Payment Amount</h6></td>
     <td style="width:150px"><h6>Comments</h6></td>
    <td style="width:150px"><h6>Confirm</h6></td>
     </tr>
<% CallableStatement cs=null;
	Class.forName(driverName);
    con = DriverManager.getConnection(url,user,psw);
    cs = con.prepareCall("{call Get_Invoices(?)}");
    //int pid =Integer.parseInt(String.valueOf(payerid));
    cs.setInt(1, payerid);
    //cs.setInt(2, Integer.parseInt(act));

    //cs.registerOutParameter(2, Types.VARCHAR);
    //cs.execute();
    //String str = cs.getString(1);
    DecimalFormat decim = new DecimalFormat("0.00");
        
        rs = cs.executeQuery();
        int counter=0;
        String ids= "";
        while (rs.next()) 
        {
        	String price3="";
        	price3= decim.format(Double.parseDouble(rs.getString(3))); 
            
        %>
          
         
     <tr>   
        <td><h6><%= rs.getString(2)%></h6></td>
        <td><h6><%= rs.getString(1)%></h6></td>
        <td></td>
        <td><h6><%= price3%></h6></td>
        <td><h6>
        <%
        sql =    "select paymentamount,ip.SysId,comments from invoicepayment ip join InsuiteSybaseCoreRep.Invoice i on i.sysid = ip.InvoiceNumber where i.InvId = '"+rs.getString(1)+ "' and ip.InvoiceTransactionId = " + act;
%>
        
<% 
        ps = con.prepareStatement(sql);
        rs2 = ps.executeQuery(); 
         amt = ""; 
         String price2 ="";
         String comment =  "";
         if ((rs2 !=null) && (rs2.next()))
        {amt = rs2.getString("paymentamount");
         price2 = decim.format(Double.parseDouble(amt));
         comment = rs2.getString("comments");
        ids=ids+ rs2.getString("SysId") + ",";
        
        }
        
        %>
        $<input type=text style="width:80px" class="pay rightJustified" name="paymentamount<%=counter%>" value=<%=price2 %>></h6></td>
        <td><h6><input type=text style="width:80px"  name="paymentComment<%=counter%>" value='<%=comment %>'></h6></td>
       
        <td><h6><input type=checkbox  class="paycheck" name="paycheck<%=counter%>" <%if(amt !=null&& amt.length()>0){ %> checked <%} %>></h6></td>
        <td><input type="hidden" name="invoiceid<%=counter%>" id="invoiceid<%=counter%>" value=<%=rs.getString(4) %> ></td>
        <td><input type="hidden" name="clientid<%=counter%>" id="clientid<%=counter%>" value=<%=rs.getString(5) %> >
        <input type="hidden" name="amount<%=counter%>" id="amount<%=counter%>" value=<%=price3%> >
        
        </td>
        </tr>
        <% counter=counter+1;
    }%>
    <input type=hidden id="counter" name="counter" value="<%=counter%>">
    
</table>
</div> 
   </td></tr>
   <tr><td >  <div class="AccountDependent">
 <table border=0 cellpadding=0 cellspacing=0>
    
     <tr><td><h3>Would like to pay <label id="othercurrency" ></label>  invoices with this <label id="currentcurrency" ></label> account</h3></td><td>&nbsp;&nbsp;<input type="submit" class="button show-button" name="act" id="showothercurrency" value="Other Currency Invoices"  style="color:blue;width:200px;"/></td></tr>
     </table></div>
     </td></tr>
     <tr><td  class="AccountDependent">
     <table border=0 cellpadding=0 cellspaing=0>
     <tr><td height="20px"></td></tr>
     <tr><td></td><td colspan=5><h4>Pay for an invoice that does not exist in the list above</h4></td></tr>
     <tr>
     <% if (ids.length()>0) 
    	 ids= ids.substring(0,ids.length()-1);
    	  sql="select * from invoicepayment where InvoiceTransactionId = " + act + " and SysId not in (" + ids + ")";	 
    		 ps = con.prepareStatement(sql);
    	        rs2 = ps.executeQuery(); 
    	         amt = ""; 
    	         String eInvNm ="";
    	         String ePayee = "";
    	         String eAmount="";
    	         String ePaymentAmount="";
    	         String eComments = "";
    	         String eDiscount="";
    	        if ((rs2 !=null) && (rs2.next()))
    	        {
    	        	eInvNm =  rs2.getString("InvoiceNumber");
    	        	ePayee =  rs2.getString("Payee");
    	        	eAmount =  rs2.getString("Amount");
    	        	ePaymentAmount =  rs2.getString("PaymentAmount");
    	        	eComments =  rs2.getString("Comments");
    	        	Double eDiscounti = Double.parseDouble(eAmount) - Double.parseDouble(ePaymentAmount);
    	             eDiscount = eDiscounti.toString();
    	        }
    	        
     %>
     <td style="width:150px"><h6>Payee</h6></td>
      <td style="width:150px"><h6>Invoice Number</h6></td>
      <td></td>
     <td style="width:150px"><h6>Amount</h6></td>
     <td style="width:150px"><h6>Payment Amount</h6></td>
     <td style="width:150px"><h6>Comments</h6></td>
     <td></td>
     </tr>
      <tr>
     <td><h6><input name="payee" id="payee" type=text style="width:180px" value=<%=ePayee %> ></h6></td>
     <td><h6><input name="invoiceNumber" id="invoiceNumber" type=text style="width:100px" value=<%=eInvNm %> ></h6></td>
    <td></td>
     <td><h6>$<input name="amount" id="amount" type=text style="width:100px"  class="pay2  rightJustified" value=<%=eAmount %>></h6></td>
     <td><h6>$<input name="paymentAmount" id="paymentAmount"  class="paystatic pay rightJustified" type=text style="width:100px" value=<%=ePaymentAmount %>></h6></td>
     <td><h6><input name="comments" id="comments" type=text style="width:150px" value='<%=eComments %>'></h6></td>
        <td><h6><input type=checkbox  class="paycheck" name="paycheckextra" <%if(eAmount !=null&& eAmount.length()>0){ %> checked <%} %>></h6></td>
     
     </tr></table>
     <table border=0 cellpadding=0 cellspacing=0>
     <tr><td height="100px"></td></tr>
     <tr>
	<td>
	
	</td>
	<td style="width:600px"><td>
	<input type="submit" class="button insert-button" name="act" id="insert" value="Submit" style="color:blue" />
	<input type="submit" class="button cancel-button" name="act" id="cancel" value="Cancel" style="color:blue" />
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
 <% 
} catch (SQLException e) {e.printStackTrace();
 //   System.err.println("SQLException: " + e.getMessage());
}
finally {
   /* if (cs != null) {
        try {
            cs.close();
        } catch (SQLException e) {
            System.err.println("SQLException: " + e.getMessage());
        }
    }*/
    if (con != null) {
        try {
            con.close();
        } catch (SQLException e) {e.printStackTrace();
  //          System.err.println("SQLException: " + e.getMessage());
        }
    }
}

%>


</form>

<%@include file='footer.jsp'%>
